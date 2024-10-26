#!/bin/bash

# Informações estáticas
echo "############################################################"
echo "# IBMEC                                                    #"
echo "# Sistemas Operacionais                 Semestre N de 2024 #"
echo "# Código: IBM8940                              Turma: 8001 #"
echo "# Professor: Luiz Fernando T. de Farias                    #"
echo "############################################################"
echo "# Equipe Desenvolvedora:                                   #"
echo "# Aluno: Lucas Fernandes Mosqueira 202203369016            #"
echo "# Aluna: Beatriz Turi Pinto de Araújo 202203795211         #"
echo "# Aluno: Lucas José Silva Serejo 202202714356              #"
echo "------------------------------------------------------------"
echo "# Rio de Janeiro, $(date +"%d de %B de %Y")                #"
echo "# Hora do Sistema: $(date +"%H Horas e %M Minutos")        #"
echo "############################################################"
echo ""
echo "Menu de Escolhas:"
echo "1) Opção interativa 1"
echo "2) Opção interativa 2"
echo "3) Opção interativa 3"
echo "4) Opção interativa 4"
echo "5) Finalizar o programa"
echo ""

# Loop para opções
while true; do
    read -p "Selecione uma opção: " opcao
    case $opcao in
        1) ./opcao1.sh ;;
        2) ./opcao2.sh ;;
        3) ./opcao3.sh ;;
        4) ./opcao4.sh ;;
        5) echo "Finalizando o programa..."; exit 0 ;;
        *) echo "Opção inválida, por favor escolha entre 1 e 5." ;;
    esac
done
