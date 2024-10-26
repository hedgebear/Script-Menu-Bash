#!/bin/bash

while true; do
    # Cria arquivos com mensagens aleatórias
    mkdir -p textos
    for i in {1..5}; do
        ARQ_NAME="textos/arquivo_$RANDOM.txt"
        echo "Mensagem divertida $RANDOM" > "$ARQ_NAME"
    done
    echo "Cinco arquivos de texto com mensagens aleatórias foram criados na pasta 'textos'."

    # Opção para repetir ou voltar ao menu
    read -p "Deseja criar mais arquivos de texto? (s/n): " escolha
    if [[ $escolha != "s" ]]; then
        break
    fi
done
