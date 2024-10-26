#!/bin/bash

while true; do
    # Exibe uma lista dos cinco primeiros processos
    echo "Lista dos cinco primeiros processos em execução:"
    ps -e | head -n 6

    # Opção para repetir ou voltar ao menu
    read -p "Deseja ver a lista de processos novamente? (s/n): " escolha
    if [[ $escolha != "s" ]]; then
        break
    fi
done
