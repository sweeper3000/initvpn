#!/bin/bash
# InitVPN
# This script will give the choice to install the following VPN Servers: Outline, Algo or OpenVPN 
#
# It will do the following:
#
# 1. Ask user if they want to install all of the VPN servers or just one individual one
# 2. Install all needed software and open firewalls if needed
#
# THIS SCRIPT ONLY SUPPORTS APT BASED DISTROS
public_ip=$(wget -qO - https://ipv4.icanhazip.com/)

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
    sudo chown -R $USER:$USER *
    
    cd ~
}

installOpenVPN() {
    wget https://raw.githubusercontent.com/Nyr/openvpn-install/master/openvpn-install.sh && chmod +x openvpn-install.sh && sudo ./openvpn-install.sh
}

echo "THIS SCRIPT SHOULD NOT BE RUN ON MOSH AS DATA FROM THE INSTALLATION OUTPUTS WILL BE LOST. DO NOT CONTINUE ON MOSH UNLESS YOU KNOW WHAT YOU ARE DOING. PRESS ANY KEY TO CONTINUE."
read -n 1 s

echo "(1) Install Outline, Algo and OpenVPN"
echo "(2) Install Outline only"
echo "(3) Install Algo only"
echo "(4) Install OpenVPN only"
read install

if [ $install == 1 ]; then
    installOpenVPN
    installOutline
    installAlgo

    echo "=== NOTES ==="
    echo "OpenVPN: your .ovpn file is in this directory. Run the script openvpn-install.sh as root to add or revoke users or to uninstall OpenVPN."
    echo "Outline: If you cannot see the secret highlighted in green, the secret for the manager is stored in shadowbox/access.txt. You will have to format it correctly."
    echo "Algo VPN: The configurations are stored in algo/configs/$public_ip/. Record the password that Algo has given you as you will need it to install certain configurations."
elif [ $install == 2 ]; then
    installOutline
elif [ $install == 3 ]; then
    installAlgo
elif [ $install == 4 ]; then
    installOpenVPN
else
    echo "Invalid input"
fi
