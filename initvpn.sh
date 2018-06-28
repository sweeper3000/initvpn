#!/bin/bash
# InitVPN
# This script will install the following VPN servers: Algo and Outline
# It will do the following:
#
# 1. Ask user if they want to install both Algo and Outline or just one of them
# 2. Install all needed software and open firewalls if needed
#
# THIS SCRIPT IS INTENDED FOR USE ON AN APT BASED DISTRO ON A SUDO USER (NOT ROOT)

# DEFINE VARIABLES #
####################
user="$USER"

installOutline() {
    echo "Installing docker..."
    curl -sS https://get.docker.com/ | sh

    echo "Downloading Outline..."
    wget https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh

    echo "Adding current user to docker group"
    sudo usermod -aG docker $USER

    echo "Making Outline install script executable..."
    chmod +x install_server.sh

    sudo ufw allow 1024:65535/udp
    sudo ufw allow 1024:65535/tcp

    ./install_server.sh

    echo "MAKE SURE TO PUT THE OUTPUT OF THE OUTLINE SCRIPT INTO THE MANAGER"
}

installAlgo() {

    echo Downloading Algo...
    git clone https://github.com/trailofbits/algo.git

    cd algo

    echo "Installing Algo dependancies..."
    sudo apt-get install build-essential libssl-dev libffi-dev python-dev python-pip python-setuptools python-virtualenv -y
    python -m virtualenv --python=`which python2` env && source env/bin/activate && python -m pip install -U pip && python -m pip install -r requirements.txt

    echo "Enter the users for Algo in this file"
    vim config.cfg
    echo "Executing algo install script..."
    sudo ./algo

    # Deactivate virtualenv
    deactivate

    # Make configs owned by current user
    cd ~/algo/configs/
    sudo chown -R $user:$user *
    
    cd ~
}

installOpenVPN() {
    wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh
}

echo "THIS SCRIPT SHOULD NOT BE RUN ON MOSH AS DATA FROM THE INSTALLATION OUTPUTS WILL BE LOST. DO NOT CONTINUE ON MOSH UNLESS YOU KNOW WHAT YOU ARE DOING. PRESS ANY KEY TO CONTINUE."
read -n 1 s

echo "(1) Install Outline, Algo and OpenVPN"
echo "(2) Install Outline only"
echo "(3) Install Algo only"
echo "(4) Install OpenVPN only"
read install

if [ $install == 1 ]; then
    installOutline
    installAlgo
    installOpenVPN
elif [ $install == 2 ]; then
    installOutline
elif [ $install == 3 ]; then
    installAlgo
elif [ $install == 4 ]; then
    installOpenVPN
else
    echo "Invalid input"
fi
