#!/bin/bash

# Definição de cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' 


DATA=$(date +"%d de %B de %Y")
HORA=$(date +"%H Horas e %M Minutos")

# Informações estáticas
echo -e "${CYAN}############################################################"
echo "# IBMEC                                                    #"
echo "# Sistemas Operacionais                 Semestre N de 2024 #"
echo "# Código: IBM8940                              Turma: 8001 #"
echo "# Professor: Luiz Fernando T. de Farias                    #"
echo "############################################################"
echo "# Equipe Desenvolvedora:                                   #"
echo "# Aluno: Lucas Fernandes Mosqueira   202203369016          #"
echo "# Aluna: Beatriz Turi Pinto de Araújo   202203795211       #"
echo "# Aluno: Lucas José Silva Serejo       202202714356        #"
echo "------------------------------------------------------------"
printf "# Rio de Janeiro, %-40s #\n" "$DATA"
printf "# Hora do Sistema: %-39s #\n" "$HORA"
echo -e "############################################################${NC}"
echo ""

exibir_menu_principal(){
    echo -e "${YELLOW}Menu de Escolhas:${NC}"
    echo -e "${WHITE}1) Gerenciamento de Diretórios e Arquivos"
    echo "2) Gerencimento de Disco"
    echo "3) Gerenciamento de Usuários"
    echo "4) Gerenciamento de Processos"
    echo -e "5) Finalizar o programa${NC}"
    echo ""
}

# Função para finalizar o programa
finalizar_programa() {
    echo -e "${RED}Finalizando o programa...${NC}"
    exit 0
}

# Loop para opções
while true; do
    exibir_menu_principal
    read -p  "$(echo -e ${GREEN}Selecione uma opção do menu principal: ${NC})" opcao
    case $opcao in
        1) ./opcao1.sh ;;
        2) ./opcao2.sh ;;
        3) ./opcao3.sh ;;
        4) ./opcao4.sh ;;
        5) finalizar_programa ;;
        *) echo "Opção inválida, por favor escolha entre 1 e 5." ;;
    esac
done
