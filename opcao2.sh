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

exibir_menu_opcao_2(){
    echo -e "${YELLOW}Escolha uma opção para relatórios de uso do disco ou CPU:${NC}"
    echo -e "${WHITE}1. Visão Geral do uso do disco"
    echo "2. Visão Geral do uso da CPU"
    echo "3. Salvar relatório em arquivo"
    echo -e "4. Sair${NC}"
}
# Exibe visão geral do uso do disco
visao_geral_disco(){
    echo "Visão Geral do Uso do Disco:"
    df -h --output=source,size,used,avail,pcent
}

# Exibe visão geral da CPU
visao_geral_CPU(){
    echo "Uso da CPU (Usuário, Sistema, Geral):"
    top -bn1 | grep "Cpu(s)" | awk '{print "Uso da CPU pelo usuário:", $2, "%", "\nUso da CPU pelo sistema:", $4, "%", "\nUso da CPU geral:", $2 + $4, "%"}'

}

# Salva o relatório em um arquivo
salvamento_relatorios(){
    
    echo "O seu diretório atual é '$CURRENT'"
    read -p "Digite o diretório onde deseja salvar o relatório a partir do Home (pressione Enter para salvar no diretório Home '$HOME'): " DIR_PATH
    DIR_PATH=${DIR_PATH:-$HOME}
    echo ""
    echo "Escolha o tipo de relatório para salvar:"
    echo "1. Relatório do uso do disco"
    echo "2. Relatório de uso da CPU"
    
    while true; do
        read -p "Digite o número da opção: " tipo_relatorio
        if [[ "$tipo_relatorio" -eq 1 || "$tipo_relatorio" -eq 2 ]]; then
            break
        else
            echo "Opção inválida. Tente novamente."
        fi
    done

    if [[ "$DIR_PATH" == "$HOME"* ]]; then

        if [[ $tipo_relatorio -eq 1 ]]; then
            NOME_ARQ="relatorio_disco_$(date +%Y%m%d_%H%M%S).txt"
            visao_geral_disco > "$DIR_PATH/$NOME_ARQ"
            echo -e "\nRelatório do disco salvo em '$DIR_PATH/$NOME_ARQ'"

        elif [[ $tipo_relatorio -eq 2 ]]; then
            NOME_ARQ="relatorio_CPU_$(date +%Y%m%d_%H%M%S).txt"
            visao_geral_CPU > "$DIR_PATH/$NOME_ARQ"
            echo -e "\nRelatório da CPU salvo em '$DIR_PATH/$NOME_ARQ'"

        else
            echo "Opção inválida. Nenhum relatório foi salvo."
        fi

    else
        echo "Erro: O caminho '$DIR_PATH' não é permitido acessar. Por favor, tente novamente com um caminho válido."
    fi
}

# Sair do script
sair() {
    echo "Saindo..."
    exit 0
}

while true; do
    exibir_menu_opcao_2
    read -p "Digite o número da opção desejada: " opcao
    case $opcao in
        1) visao_geral_disco;;
        2) visao_geral_CPU;;
        3) salvamento_relatorios;;
        4) sair;;
        *) echo "Opção inválida. Tente novamente." 
        continue;;
    esac

    # Pergunta se o usuário deseja voltar ao menu principal
    read -p "Deseja voltar ao menu principal? (s/n): " voltar
    if [[ $voltar != "n" ]]; then
        echo "Encerrando o script."
        break
    fi
done
