#!/bin/bash

while true; do
    # Exibe o uso do disco
    echo "Relatório de uso do disco:"
    df -h

    # Opção para repetir ou voltar ao menu
    read -p "Deseja ver o relatório de uso do disco novamente? (s/n): " escolha
    if [[ $escolha != "s" ]]; then
        break
    fi
done
