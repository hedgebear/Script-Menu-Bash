#!/bin/bash

# Definição de cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' 

# Função para exibir o menu de opções
exibir_menu_opcao_1() {
    echo -e "${YELLOW}Escolha uma opção para o gerenciamento de processos:${NC}"
    echo -e "${WHITE}1. Listar todos os processos"
    echo "2. Filtrar processos pelo nome"
    echo "3. Matar um processo"
    echo "4. Matar todos os processos de um usuário"
    echo -e "5. Sair${NC}"
}

# Cria um loop principal
while true; do
    exibir_menu_opcao_1
    read -p "Digite o número da opção desejada: " opcao

    case $opcao in
        1)
            echo "Processos em execução (PID, USER, %CPU, %MEM, COMMAND):"
            ps aux --sort=-%cpu | awk '{print $2, $1, $3, $4, $11}' | head -10
            ;;
        2)
            echo "Digite o nome do processo que deseja filtrar:"
            read processo
            echo "Processos com o nome '$processo' (PID, USER, %CPU, %MEM, COMMAND):"
            ps aux | grep $processo | grep -v grep | awk '{print $2, $1, $3, $4, $11}'
            ;;
        3)
            echo "Digite o ID do processo que deseja finalizar:"
            read pid
            if ps -p $pid > /dev/null; then
                kill $pid && echo "Processo $pid finalizado com sucesso!" || echo "Falha ao finalizar o processo $pid."
            else
                echo "Processo com PID $pid não encontrado."
            fi
        4)
            echo "Digite o nome do usuário cujos processos você quer finalizar:"
            read usuario
            echo "Finalizando todos os processos do usuário '$usuario'..."
            ps aux | grep "^$usuario" | awk '{print $2}' | xargs kill -9
            echo "Todos os processos do usuário '$usuario' foram finalizados."
            ;;
        5)
            # Sair do loop
            echo "Saindo..."
            break
            ;;
        *)
            echo "Opção inválida. Tente novamente."
            ;;
    esac

    # Pergunta ao usuário se ele quer continuar
    read -p "Deseja realizar outra ação? (s/n): " continuar
    #Transformar em minúsculo o input
    continuar=${continuar,,}
    if [[ $continuar != "s" ]]; then
        echo "Encerrando o script."
        break
    fi
done
