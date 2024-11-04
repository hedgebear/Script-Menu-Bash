#!/bin/bash

# Função para exibir o menu de opções
exibir_menu_opcao_1() {
    echo "Escolha uma opção para o gerenciamento de arquivos e diretórios:"
    echo "1. Criar um diretório em um local de sua preferência"
    echo "2. Criar um arquivo em um local de sua preferência"
    echo "3. Listar o conteúdo de um diretório"
    echo "4. Excluir um arquivo ou diretório"
    echo "5. Renomear um arquivo ou diretório"
    echo "6. Sair"
}

# Cria um loop principal
while true; do
    exibir_menu_opcao_1
    read -p "Digite o número da opção desejada: " opcao

    case $opcao in
        1)
            # Criar um diretório em um local de preferência
            read -p "Digite o caminho onde deseja criar o diretório: " DIR_PATH
            if [ -d "$DIR_PATH" ]; then
                read -p "Digite o nome do diretório a ser criado: " DIR_NAME
                mkdir -p "$DIR_PATH/$DIR_NAME"
                echo "O diretório '$DIR_NAME' foi criado em '$DIR_PATH'."
            else
                echo "Erro: O caminho '$DIR_PATH' não existe. Por favor, tente novamente com um caminho válido."
            fi
            ;;
        2)
            # Criar um arquivo em um local de preferência
            read -p "Digite o caminho onde deseja criar o arquivo: " FILE_PATH
            if [ -d "$FILE_PATH" ]; then
                read -p "Digite o nome do arquivo a ser criado: " FILE_NAME
                touch "$FILE_PATH/$FILE_NAME"
                #TODO Criar arquivo zip ou de backup (usar comando tar)
                echo "O arquivo '$FILE_NAME' foi criado em '$FILE_PATH'."
            else
                echo "Erro: O caminho '$FILE_PATH' não existe. Por favor, tente novamente com um caminho válido."
            fi
            ;;
        3)
            # Listar o conteúdo de um diretório
            read -p "Digite o caminho do diretório que deseja listar: " LIST_PATH
            if [ -d "$LIST_PATH" ]; then
                echo "Conteúdo do diretório '$LIST_PATH':"
                ls -l "$LIST_PATH"
            else
                echo "Erro: O diretório '$LIST_PATH' não existe."
            fi
            ;;
        4)
            # Excluir um arquivo ou diretório
            read -p "Digite o caminho do arquivo ou diretório a ser excluído: " DELETE_PATH
            if [ -e "$DELETE_PATH" ]; then
                rm -r "$DELETE_PATH"
                echo "O arquivo ou diretório em '$DELETE_PATH' foi excluído."
            else
                echo "Erro: O arquivo ou diretório '$DELETE_PATH' não existe."
            fi
            ;;
        5)
            # Renomear um arquivo ou diretório
            read -p "Digite o caminho do arquivo ou diretório que deseja renomear: " OLD_PATH
            if [ -e "$OLD_PATH" ]; then
                read -p "Digite o novo nome (com caminho completo): " NEW_PATH
                mv "$OLD_PATH" "$NEW_PATH"
                echo "Renomeado para '$NEW_PATH'."
            else
                echo "Erro: O arquivo ou diretório '$OLD_PATH' não existe."
            fi
            ;;
        6)
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
