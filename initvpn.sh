#!/bin/bash
# InitVPN
# This script will install the following VPN servers: Algo and Outline
# It will do the following:
#
# 1. Install docker
# 2. Download Outline and Algo
# 3. Add current user to the docker group
# 4. Make Outline install script executable
# 5. Go into algo directory, enter a virtualenv, and install dependancies
# 6. Open algo user config file to add users
# 7. Execute algo install script on exit on user config file
# 8. Open ports 1024 - 65535 in both TCP and UDP
# 9. Tell user to logout of ssh and login again and execute the Outline script
#
# THIS SCRIPT IS INTENDED FOR USE ON AN APT BASED DISTRO ON A SUDO USER (NOT ROOT)

    echo "THIS SCRIPT SHOULD NOT BE RUN ON MOSH AS DATA FROM THE INSTALLATION OUTPUTS WILL BE LOST. DO NOT CONTINUE ON MOSH UNLESS YOU KNOW WHAT YOU ARE DOING. PRESS ANY KEY TO CONTINUE."
    read -n 1 s
installOutline() {
    echo "Installing docker..."
    curl -sS https://get.docker.com/ | sh

    echo "Downloading Outline..."
    wget https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh

    echo "Adding current user to docker group"
sudo usermod -aG docker $USER

    echo "Making Outline install script executable..."
    chmod +x install_server.sh

    echo "MAKE SURE TO PUT THE OUTPUT OF THE OUTLINE SCRIPT INTO THE MANAGER"

    echo "UNFORTUNATELY, THE OUTLINE SCRIPT CANNOT BE RUN IN THIS CURRENT SESSION WITHOUT DOCKER COMPLAINING. PLEASE EXIT THIS SESSION AND START A NEW ONE, THEN EXECUTE IT"

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

    sudo ufw allow 1024:65535/udp
    sudo ufw allow 1024:65535/tcp

    cd ~

    # Deactivate virtualenv
    deactivate
}

echo "(1) Install both Outline and Algo\n(2) Install Outline only\n(3) Install Algo only"
read install
if [ $install == 1 ]; then
    installOutline
    installAlgo
elif [ $install == 2 ]; then
    installOutline
elif [ $install == 3 ]; then
    installAlgo
else 
    echo "Invalid input"
fi
