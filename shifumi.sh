#!/usr/bin/bash

#Déclarations
J1=0 ;
J2=0 ;

function winner() {
if [[ $J1 == $scoreMax ]] || [[ $J2 == $scoreMax ]] ; then
    echo;
    echo "Score final : $J1 - $J2" ;
    echo;
	echo "Fin du match !" ;
    exit ;
fi
}

function victoryJ1() {
    echo ;
    echo "Joueur 1 gagne la manche !" ;
    ((J1++)) ;
    winner ;
} 

function victoryJ2() {
    echo ;
    echo "Joueur 2 gagne la manche !" ;
    ((J2++)) ;
    winner ;
} 

function randomChoice() {
    choiceCom=$(( RANDOM % 3 )) ;
    case "$choiceCom" in
        0) choice2=p ;; 1) choice2=r ;; 2) choice2=s ;;
    esac
}

function players() {
    read -s -n1 -p "Nombre de joueurs (1 ou 2) : " nbPlayers ;
if [[ $nbPlayers != 1 ]] && [[ $nbPlayers != 2 ]]
                then       
                echo "Mauvais input" ;
                exit ;
fi
echo ; 
}

function displayMenu() {
    echo "Nombre de joueurs : "$nbPlayers ;
    echo "Nombre de manches gagnantes : "$scoreMax ;
    echo "Score J1 :" $J1 ;
    echo "Score J2 :" $J2 ;
    echo ; 
}

function casesVictory() {
    case "$choice1$choice2" in
        pr ) victoryJ1 ;;
        rp ) victoryJ2 ;;
        sp ) victoryJ1 ;;
        ps ) victoryJ2 ;;
        rs ) victoryJ1 ;;
        sr ) victoryJ2 ;;
        * ) echo "Mauvais input" ;;
        esac 
}

function roundsMax() {
    read -s -n1 -p "Nombre de manches gagnantes : " scoreMax ;
    if [[ $scoreMax =~ ^[0-9]+$ ]]; then
    echo "Nombre de manches : $scoreMax"
    else
    echo "Mauvais input"
    exit ;
    fi
}

#Options selector
players;
roundsMax;

#Game
while [ true ] ; 
do 
displayMenu;

#Input for Player 1
    echo "Choix du Joueur 1 :"
    read -s -n1 -p "(p)aper (r)ock (s)cissors " choice1 ;

#Input for Player 2 or Computer
    if [[ $nbPlayers == 1 ]]
        then       
        randomChoice ;
        else 
        echo ;
        echo "Choix du Joueur 2 :"
        read -s -n1 -p "(p)aper (r)ock (s)cissors " choice2 ;
    fi

#Check Results
    if [[ $choice1 == $choice2 ]]
        then
        echo ;
        echo "Egalité !" ;
        else
        casesVictory;
    fi
    sleep 1 ;
    clear ;
done ; 
exit 0;