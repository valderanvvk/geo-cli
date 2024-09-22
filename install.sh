#!/bin/bash

set -e

#define variables

#name alias for script: get IP address
alias_name_ip='ip-info'
if command -v $alias_name_ip >/dev/null 2>&1; then
  echo -e " ${alias_name_ip} already exists"
  alias_name_ip='2ip-info'
  echo -e " change alias name to ${alias_name_ip}"
fi

#name alias for script: get IP and geo information
alias_name_location='location-info'
if command -v $alias_name_location >/dev/null 2>&1; then
    echo -e " ${alias_name_location} already exists"
  alias_name_location='2location-info'
  echo -e " change alias name to ${alias_name_location}"
fi

#path to this script
script_path=$(readlink -f "$0")
#path to working directory
script_dir=$(dirname "$script_path")

get_ip_file=$script_dir/get-ip.sh
get_location_file=$script_dir/get-location.sh
bashalias_file=$HOME/.bash_aliases
clear

# Reset
NC='\033[0m'              # No Color
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
BBlue='\033[1;34m'        # Blue Bold
BPurple='\033[1;35m'      # Purple Bold
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
BWhite='\033[1;37m'       # White Bold
BYellow='\033[1;33m'      # Yellow Bold
BCyan='\033[1;36m'        # Cyan Bold
UYellow='\033[4;33m'      # Yellow Underline
BRed='\033[1;31m'         # Red Bold

modules="beautifulsoup4==4.12.3
bs4==0.0.2
certifi==2024.8.30
charset-normalizer==3.3.2
idna==3.10
lxml==5.3.0
requests==2.32.3
soupsieve==2.6
urllib3==2.2.3"

echo -e "${BCyan}Check requirements file ${NC}"

if [ -f "requirements.txt" ]; then
     echo -e "${Green} - File requirements.txt found.${NC}"
 else
     echo -e "${Red} - File requirements.txt not found.${NC}"
     touch requirements.txt
     echo "$modules" >> requirements.txt
     echo -e "${Green} - File requirements.txt created.${NC}"
 fi

echo -e "\n${BRed}IMPORTANT: ${BWhite}the user can install dependencies himself using virtualenv, condo or any other package management system, or agree to an automatic installation using venv${NC}"

echo -e "\n${BYellow}Installation venv guide:${NC}"
echo -e " ${Yellow}Please install and activate virtualenv:${NC}"
echo " - sudo apt install python3-venv (python3.12-venv)"
echo " - python3 -m venv venv"
echo " - source venv/bin/activate"
echo -e " ${Yellow}Please install python packages:${NC}"
echo " - pip install -r requirements.txt"
echo -e " ${Yellow}Please add aliases into ${BWhite}${bashalias_file}:${NC}"
echo -e " - alias $alias_name_ip='bash $get_ip_file'"
echo -e " - alias $alias_name_location='bash $get_location_file'"

echo -e "\n${BCyan}Check pip and venv installation${NC}"
pipCheck=0
venvCheck=0
installStatus=0

if command -v pip3 &>/dev/null; then
  echo -e " - pip3 ${Green}install${NC}"
  pipCheck=1
else
  echo -e " - pip3 ${Red}NOT install${NC}"
fi

if python3 -m venv --help &>/dev/null; then
  venvCheck=1
  echo -e " - Python3 venv ${Green}install${NC}"
else
  echo -e " - Python3 venv ${Red}NOT install${NC}"
fi

if [ $pipCheck -eq 1 ] && [ $venvCheck -eq 1 ]; then
    installStatus=1
fi

if [ $pipCheck -eq 1 ] && [ $venvCheck -eq 1 ]; then
    installStatus=1
fi

if [ $installStatus -eq 1 ]; then

  printf "\n${BWhite}Do you want to install the script automatically? (Y/N):${NC} "
  read choice

  if [ "$choice" = 'Y' ] || [ "$choice" = 'y' ]; then
    echo -e "${White}automatically installation:${NC}"
    echo -e "${White} - check venv directory and delete if exist${NC}"
    echo -e "${White} - create virtual environment${NC}"
    python3 -m venv venv
    sleep 2
    echo -e "${White} - activate virtual environment${NC}"
    source venv/bin/activate
    echo -e "${White} - install dependencies${NC}:\n"
    pip install -r requirements.txt
    echo -e "\n${BWhite} - installation completed.${NC}\n"
  fi


  printf "\n${BWhite}Do you want add aliases into ${bashalias_file}? (Y/N):${NC} "
  read choice

  if [ "$choice" = 'Y' ] || [ "$choice" = 'y' ]; then
    echo -e "\n${BCyan}Adding aliases${NC}:"
    echo -e "${Cyan}Check file: ${BWhite}${bashalias_file} ${NC}"

    if [ ! -f "$bashalias_file" ]; then

      echo -e "\n${Red}file not found: ${White}$bashalias_file${NC}"
      printf "${Yellow}create file ${White}${bashalias_file}? ${NC}(Y/N): "
      read isAliasFileCreate

      if [ "$isAliasFileCreate" = 'Y' ] || [ "$isAliasFileCreate" = 'y' ]; then
        touch "$bashalias_file"
        echo -e "${Green}file created: ${Yellow}$bashalias_file${NC}"
      fi

    fi

    if [ -f "$bashalias_file" ]; then
      echo -e "${Cyan}Add aliases($bashalias_file):${NC} \n - '${alias_name_ip}' (show ip) -> get-ip.sh \n - '${alias_name_location}' (show ip,country,region,city) -> get-location.sh"
      echo -e "alias $alias_name_ip='bash $get_ip_file'" >> "$bashalias_file"
      echo -e "alias $alias_name_location='bash $get_location_file'" >>"$bashalias_file"
      echo -e "${Green}Alias was added.${NC}"
      echo -e "\n${UYellow}run:${NC} ${BWhite}source ${bashalias_file}${NC} ${UYellow}or restart${NC} the terminal${NC}"
    else
      echo -e "${Red}File $bashalias_file not found${NC}"
      echo -e "${BYellow}Create file $bashalias_file(or your aliases file) and add alias for files get-ip.sh and get-location.sh${NC}"
    fi
  fi

fi

echo -e "\n${BPurple}End of installation.${NC}"
echo -e "\n${BBlue}Uninstallation:${NC}"
echo -e "${White} - delete aliases '${alias_name_ip}' and '${alias_name_location}' from $bashalias_file$ or your aliases file${NC}"
echo -e "${White} - delete work directory with files ${script_dir}${NC}"
echo -e "${BBlue}Congratulations, you have finished deleting.${NC}"
echo -e "\n${BYellow}Thanks for using this script${NC}"

