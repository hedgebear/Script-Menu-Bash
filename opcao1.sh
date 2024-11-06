#!/bin/bash

CURRENT=$(pwd)

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
    echo -e "${YELLOW}Escolha uma opção para o gerenciamento de arquivos e diretórios:${NC}"
    echo -e "${WHITE}1. Criar um diretório em um local de sua preferência"
    echo "2. Criar um arquivo em um local de sua preferência"
    echo "3. Listar o conteúdo de um diretório"
    echo "4. Excluir um arquivo ou diretório"
    echo "5. Renomear um arquivo ou diretório"
    echo -e "6. Sair${NC}"
}

# Cria um loop principal
while true; do
    exibir_menu_opcao_1
    read -p "Digite o número da opção desejada: " opcao

    case $opcao in
        1)
            # Criar um diretório em um local de preferência
            read -p "Digite o caminho onde deseja criar o diretório (pressione Enter para usar o diretório home '$CURRENT'): " DIR_PATH
            DIR_PATH=${DIR_PATH:-$HOME}  # Define o padrão como $HOME
            if [ -d "$DIR_PATH" ]; then
                read -p "Digite o nome do diretório a ser criado: " DIR_NAME
                mkdir -p "$DIR_PATH/$DIR_NAME"
                echo "O diretório '$DIR_NAME' foi criado em '$DIR_PATH'."
            else
                echo "Erro: O caminho '$DIR_PATH' não existe. Por favor, tente novamente com um caminho válido."
            fi
            ;;
        2)
            # Criar um arquivo em um local de preferência, seja arquivo regular, zip ou .tar
            read -p "Digite o caminho onde deseja criar o arquivo (pressione Enter para usar o diretório home): " FILE_PATH
            FILE_PATH=${FILE_PATH:-$HOME}  # Define o padrão como $HOME
            if [ -d "$FILE_PATH" ]; then
                echo "Escolha o tipo de arquivo que deseja criar:"
                echo "1. Arquivo normal"
                echo "2. Arquivo GZIP"
                echo "3. Arquivo TAR (backup)"
                read -p "Digite o número da opção desejada: " file_type

                read -p "Digite o nome do arquivo a ser criado (sem extensão): " FILE_NAME

                case $file_type in
                    1)
                        touch "$FILE_PATH/$FILE_NAME"
                        echo "O arquivo '$FILE_NAME' foi criado em '$FILE_PATH'."
                        ;;
                    2)
                        # Compactando com GZIP
                        touch "$FILE_PATH/$FILE_NAME"  # Cria o arquivo primeiro
                        gzip "$FILE_PATH/$FILE_NAME"
                        echo "O arquivo GZIP '$FILE_NAME.gz' foi criado em '$FILE_PATH'."
                        ;;
                    3)
                        read -p "Digite o caminho do arquivo ou diretório a ser incluído no backup TAR: " BACKUP_PATH
                        if [ -e "$BACKUP_PATH" ]; then
                            tar -cvf "$FILE_PATH/$FILE_NAME.tar" "$BACKUP_PATH"
                            echo "O arquivo TAR '$FILE_NAME.tar' foi criado em '$FILE_PATH', contendo '$BACKUP_PATH'."
                        else
                            echo "Erro: O arquivo ou diretório '$BACKUP_PATH' não existe."
                        fi
                        ;;
                    *)
                        echo "Opção inválida para o tipo de arquivo. Voltando ao menu principal."
                        ;;
                esac
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
            if [ "$DELETE_PATH" == "$HOME" ]; then
                echo -e "${RED}Erro: O diretório '$HOME' não pode ser excluído por segurança.${NC}"
            elif [ -e "$DELETE_PATH" ]; then
                rm -r "$DELETE_PATH"
                echo "O arquivo ou diretório em '$DELETE_PATH' foi excluído."
            else
                echo "Erro: O arquivo ou diretório '$DELETE_PATH' não existe."
            fi
            ;;
        5)
            # Renomear um arquivo ou diretório
            read -p "Digite o caminho do arquivo ou diretório que deseja renomear: " OLD_PATH
            if [ "$OLD_PATH" == "$HOME" ]; then
                echo -e "${RED}Erro: O diretório '$HOME' não pode ser renomeado por segurança.${NC}"
            elif [ -e "$OLD_PATH" ]; then
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
    #Transformar em minúsculo o input
    continuar=${continuar,,}
    if [[ $continuar != "s" ]]; then
        echo "Encerrando o script."
        break
    fi
done
