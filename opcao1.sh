#!/bin/bash

while true; do
    # Cria uma pasta chamada 'diversao' e diretórios aleatórios dentro dela
    mkdir -p diversao
    for i in {1..5}; do
        DIR_NAME=$(echo $RANDOM | md5sum | head -c 6)
        mkdir "diversao/$DIR_NAME"
    done
    echo "Cinco diretórios com nomes aleatórios foram criados na pasta 'diversao'."

    # Opção para repetir ou voltar ao menu
    read -p "Deseja criar mais diretórios aleatórios? (s/n): " escolha
    if [[ $escolha != "s" ]]; then
        break
    fi
done
