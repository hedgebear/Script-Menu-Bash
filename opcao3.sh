#!/bin/bash

# Definição de cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' 

# Função para exibir o menu de opções
exibir_menu_opcao_3() {
    echo -e "${YELLOW}Escolha uma opção para o gerenciamento de usuários:${NC}"
    echo -e "${WHITE}1. Adicionar novo usuário"
    echo "2. Remover um usuário"
    echo "3. Listar todos os usuários"
    echo -e "4. Sair${NC}"
}

# Função para adicionar um novo usuário
adicionar_usuario() {
    read -p "Digite o nome do novo usuário: " novo_usuario
    # Adiciona o usuário, cria o diretório home e define o shell padrão
    sudo useradd -m -s /bin/bash "$novo_usuario" && echo "Usuário '$novo_usuario' adicionado com sucesso!" || echo "Erro ao adicionar o usuário."
    
    # Define a senha para o novo usuário
    read -p "Digite a senha do novo usuário: " senha_novo_usuario
    echo "$novo_usuario:$senha_novo_usuario" | sudo chpasswd

    # Garante que o usuário tenha a propriedade do diretório home
    sudo chown "$novo_usuario":"$novo_usuario" /home/"$novo_usuario"

    # Define as permissões corretas para o diretório home
    sudo chmod 700 /home/"$novo_usuario"
}

# Função para remover um usuário
remover_usuario() {
    read -p "Digite o nome do usuário a ser removido: " usuario_remover
    # Remove o usuário e seu diretório home
    sudo userdel "$usuario_remover" && echo "Usuário '$usuario_remover' removido com sucesso!" || echo "Erro ao remover o usuário."
}

# Função para listar todos os usuários
listar_usuarios() {
    echo "Lista de usuários do sistema:"
    # Extrai o nome dos usuários do arquivo /etc/passwd
    cut -d: -f1 /etc/passwd
}

# Função para sair do script
sair() {
    echo "Saindo..."
    exit 0
}

# Loop principal
while true; do
    exibir_menu_opcao_3
    read -p "Digite o número da opção desejada: " opcao
    case $opcao in
        1) adicionar_usuario ;;
        2) remover_usuario ;;
        3) listar_usuarios ;;
        4) sair ;;
        *) echo "Opção inválida. Tente novamente."
        continue ;;
    esac

    # Pergunta ao usuário se ele quer continuar
    read -p "Deseja realizar outra ação? (s/n): " continuar
    # Converte a resposta para minúsculas
    continuar=${continuar,,}
    # Verifica se o usuário deseja continuar ou encerrar o script
    if [[ $continuar != "s" ]]; then
        echo "Encerrando o script."
        break
    fi
done
