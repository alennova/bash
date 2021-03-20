#!/bin/bash

clear
lightgreen=`echo -en "\e[92m"`
lightblue=`echo -en "\e[1;34m"`
green=`echo -en "\e[32m"`
red=`echo -en "\e[31m"`
normal=`echo -en "\e[0m"`
echo "${lightblue}"

echo "##########################"
echo "# Menu                   # A"                  
echo "# [1] Install            # L"
echo "# [2] Uninstall          # E"
echo "# [3] Update && Upgrade  # N"
echo "#------------------------#"
echo "# [s] Edit this Script   # N"
echo "# [i] vi installed.txt   # O"
echo "# [u] vi uninstalled.txt # V"
echo "# [x] Exit!              # A"
echo "##########################"
echo "${green}"
read -p "> " inp

# [1] Install
if [ $inp = 1 ]
then
    clear
    cat .x/installed.txt
    echo
    cat .x/uninstalled.txt
    echo
    echo
    read -p "[x] Cancel! | [?] | Install: " i
    if  [ $i = X ] || [ $i = x ]
    then
        bash install.sh   
    elif [ $i = ? ] 
    then
        echo
        echo
        read -p "[x] | Input: " i
        if [ $i = X ] || [ $i = x ]
        then
            bash install.sh
        else
            $i && echo "$i `date`" >> .x/installed.txt
            echo
            echo
            read -p "Back? [Y/n] " i
            if [ $i = Y ] || [ $i = y ]
            then
                bash install.sh
            fi
        fi
    else
        pkg install $i && echo "$i `date`" >> .x/installed.txt
        echo
        echo
        read -p "Back? [Y/n] " i
        if [ $i = Y ] || [ $i = y ]
        then
            bash install.sh
        fi
    fi

# [2] Uninstall
elif [ $inp = 2 ]
then
    clear
    cat .x/installed.txt
    echo
    cat .x/uninstalled.txt
    echo
    echo
    read -p "[x] Cancel! | Uninstall: " i
    if  [ $i = X ] || [ $i = x ]
    then
        bash install.sh
    else
        pkg uninstall $i && echo "$i `date`" >> .x/uninstalled.txt
        echo
        echo
        read -p "Back? [Y/n] " i
        if [ $i = Y ] || [ $i = y ]
        then
            bash install.sh
        fi
    fi

# [3] Update && Upgrade
elif [ $inp = 3 ]
then
    cat .x/last-updated.txt
    echo
    read -p "Update? [Y/n] " i
    if [ $i = Y ] || [ $i = y ]
    then
        pkg update
        echo "Last Updated - `date`" > .x/last-updated.txt  
        echo
        echo
        read -p "Do you want to Upgrade? [Y/n] " i
        if [ $i = Y ] || [ $i = y ]
        then
            pkg upgrade
            echo "Last Updated && Upgraded - `date`" > .x/last-updated.txt
            echo
            echo
            read -p "Back? [Y/n] " i
            if [ $i = Y ] || [ $i = y ]
            then
                bash install.sh
            fi  
        else 
            bash install.sh
        fi
    else 
        bash install.sh
    fi

# [s] vi This Script
elif [ $inp = S ] || [ $inp = s ]
then
    vi install.sh 
    bash install.sh

# [i] vi Installed.txt
elif [ $inp = I ] || [ $inp = i ]
then
    vi .x/installed.txt
    bash install.sh

# [u] vi Uninstall.txt
elif [ $inp = U ] || [ $inp = u ]
then
    vi .x/uninstalled.txt
    bash install.sh

# [x] Exit
elif [ $inp = X ] || [ $inp = x ]
then
    exit

# Invalid Input!
elif [ $inp = "" ]
then
    echo "${red}Invalid Input!${normal}" && sleep 2
    bash install.sh

# Invalid Input!
else
    echo "${red}Invalid Input!${normal}" && sleep 2
    bash install.sh
fi
