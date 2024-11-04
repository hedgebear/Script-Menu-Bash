#!/bin/bash

exibir_menu_opcao_2(){
    echo "Relatório de uso do disco - Escolha uma opção:"
    echo "1. Visão Geral do uso do disco"
    echo "2. Uso detalhado (incluindo inodes)"
    echo "3. Salvar relatório em arquivo"
    echo "4. Sair"
}

while true; do
    exibir_menu_opcao_2
    read -p "Digite o número da opção desejada: " opcao
    case $opcao in
        1)
            # Exibe visão geral do uso do disco
            df -h
            ;;

        2)
            # Exibe uso detalhado com inodes
            df -hi
            ;;

        3)
            # Salva o relatório em um arquivo
            df -h > "relatorio_disco_$(date +%Y%m%d_%H%M%S).txt"
            echo "Relatório salvo em relatorio_disco_$(date +%Y%m%d_%H%M%S).txt"
            ;;

        4)
            # Sair do script
            echo "Saindo do relatório de uso do disco."
            break
            ;;

        *)
            # Opção inválida
            echo "Opção inválida. Tente novamente."
            ;;
    esac

    # Pergunta se o usuário deseja voltar ao menu principal
    read -p "Deseja voltar ao menu principal? (s/n): " voltar
    if [[ $voltar != "n" ]]; then
        echo "Encerrando o script."
        break
    fi
done
