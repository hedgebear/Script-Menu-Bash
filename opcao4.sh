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

# Função para listar processos
listar_processos() {
    # Exibe os 10 processos com maior uso de CPU
    echo "Processos em execução (PID, USER, %CPU, %MEM, COMMAND):"
    # Lista os processos com base no uso de CPU
    ps aux --sort=-%cpu | awk '{print $2, $1, $3, $4, $11}' | head -10
}

# Função para filtrar processos pelo nome
filtrar_processos() {
    echo "Digite o nome do processo que deseja filtrar:"
    read processo
    echo "Processos com o nome '$processo' (PID, USER, %CPU, %MEM, COMMAND):"
    # Filtra os processos com base no nome fornecido
    ps aux | grep $processo | grep -v grep | awk '{print $2, $1, $3, $4, $11}'
}

# Função para matar um processo específico
matar_processo() {
    echo "Digite o ID do processo que deseja finalizar:"
    read pid
    # Verifica se o processo com o PID fornecido está em execução
    if ps -p $pid > /dev/null; then
        # Finaliza o processo com o PID fornecido
        kill $pid && echo "Processo $pid finalizado com sucesso!" || echo "Falha ao finalizar o processo $pid."
    else
        echo "Processo com PID $pid não encontrado."
    fi
}

# Função para matar todos os processos de um usuário
matar_processos_usuario() {
    echo "Digite o nome do usuário cujos processos você quer finalizar:"
    read usuario
    echo "Finalizando todos os processos do usuário '$usuario'..."
    # Filtra os processos com base no nome do usuário e finaliza-os
    ps aux | grep "^$usuario" | awk '{print $2}' | xargs kill -9
    echo "Todos os processos do usuário '$usuario' foram finalizados."
}

# Função para sair do script
sair() {
    echo "Saindo..."
    exit 0
}

# Cria um loop principal
while true; do
    exibir_menu_opcao_1
    read -p "Digite o número da opção desejada: " opcao

    # Verifica a opção escolhida e chama a função correspondente
    case $opcao in
        1) listar_processos;;
        2) filtrar_processos;;
        3) matar_processo;;
        4) matar_processos_usuario;;
        5) sair;;
        *) echo "Opção inválida. Tente novamente."
        continue;;
    esac

    read -p "Deseja realizar outra ação? (s/n): " continuar
    # Transforma o input em minúsculo
    continuar=${continuar,,}
    # Verifica se o usuário deseja continuar ou encerrar o script
    if [[ $continuar != "s" ]]; then
        echo "Encerrando o script."
        break
    fi
done
