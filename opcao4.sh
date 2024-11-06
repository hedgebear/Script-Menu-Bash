#!/bin/bash

# Função para exibir o menu de opções
exibir_menu_opcao_1() {
    echo "### Gerenciamento de Processos ###"
    echo "1) Listar todos os processos"
    echo "2) Filtrar processos pelo nome"
    echo "3) Simular 'Matar' um processo"
    echo "4) Monitorar uso de CPU e Memória dos processos"
    echo "5) Simular 'Matar' todos os processos de um usuário"
    echo "6) Monitoramento contínuo (live update)"
    echo "7) Sair"
}

# Cria um loop principal
while true; do
    exibir_menu_opcao_1
    read -p "Digite o número da opção desejada: " opcao

    case $opcao in
        1)
            echo "Processos em execução:"
            ps aux
            ;;
        2)
            echo "Digite o nome do processo que deseja filtrar:"
            read processo
            echo "Processos com o nome '$processo':"
            ps aux | grep $processo | grep -v grep
            ;;
        3)
            echo "Digite o ID do processo que deseja finalizar:"
            read pid
            if ps -p $pid > /dev/null; then
                echo "Processo $pid finalizado com sucesso! (simulação)"
            else
                echo "Processo com PID $pid não encontrado."
            fi
            ;;
        4)
            echo "Monitoramento de uso de CPU e Memória dos processos:"
            ps aux --sort=-%cpu | head -10
            ;;
        5)
            echo "Digite o nome do usuário cujos processos você quer finalizar:"
            read usuario
            echo "Finalizando todos os processos do usuário '$usuario' (simulação)..."
            ps aux | grep "^$usuario" | awk '{print $2}' | xargs echo "Simulado: kill"
            ;;
        6)
            echo "Monitoramento de processos em tempo real. Pressione Ctrl+C para parar."
            while true; do
                clear
                ps aux --sort=-%mem | head -10
                sleep 5
            done
            ;;
        7)
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
    if [[ $continuar != "s" ]]; then
        echo "Encerrando o script."
        break
    fi
done
