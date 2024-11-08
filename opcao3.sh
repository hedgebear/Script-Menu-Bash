#!/bin/bash

# Definição de cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' 

exibir_menu_opcao_3(){
    echo -e "${YELLOW}Escolha uma opção para o gerenciamento de usuários:${NC}"
    echo -e "${WHITE}1. Adicionar novo usuário"
    echo "2. Remover um usuário"
    echo "3. Listar todos os usuários"
    echo -e "4. Sair${NC}"
}

while true; do
    exibir_menu_opcao_3
    read -p "Digite o número da opção desejada: " opcao
    case $opcao in
        1)
            # Adicionar novo usuário
            read -p "Digite o nome do novo usuário: " novo_usuario
            sudo useradd "$novo_usuario" && echo "Usuário '$novo_usuario' adicionado com sucesso!" || echo "Erro ao adicionar o usuário."
            read -p "Digite a senha do novo usuário: " senha_novo_usuario
            echo "$novo_usuario:$senha_novo_usuario" | sudo chpasswd
            sudo mkdir -p /home/"$novo_usuario"
            sudo chown "$novo_usuario":"$novo_usuario" /home/"$novo_usuario"
            sudo chmod 700 /home/"$novo_usuario"
            ;;
        2)
            # Remover um usuário
            read -p "Digite o nome do usuário a ser removido: " usuario_remover
            sudo userdel "$usuario_remover" && echo "Usuário '$usuario_remover' removido com sucesso!" || echo "Erro ao remover o usuário."
            ;;
        3)
            # Listar todos os usuários
            echo "Lista de usuários do sistema:"
            cut -d: -f1 /etc/passwd
            ;;

        4) 
            #  Sair do Script
            echo "Saindo..."
            break
            ;;
        *)
            # Opção inválida
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
