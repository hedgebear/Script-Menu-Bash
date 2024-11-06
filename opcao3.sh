#!/bin/bash

exibir_menu_opcao_3(){
    echo "Gerenciamento de Usuários - Escolha uma opção:"
    echo "1. Adicionar novo usuário"
    echo "2. Remover um usuário"
    echo "3. Listar todos os usuários"
    echo "4. Sair"
}

while true; do
    exibir_menu_opcao_3
    read -p "Digite o número da opção desejada: " opcao
    case $opcao in
        1)
            # Adicionar novo usuário
            read -p "Digite o nome do novo usuário: " novo_usuario
            sudo useradd "$novo_usuario" && echo "Usuário '$novo_usuario' adicionado com sucesso!" || echo "Erro ao adicionar o usuário."
            #  TODO adicionar senha para usuário
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

    # Pergunta se o usuário deseja voltar ao menu principal
    read -p "Deseja voltar ao menu principal? (s/n): " voltar
    if [[ $voltar != "n" ]]; then
        echo "Encerrando o script."
        break
    fi
done
