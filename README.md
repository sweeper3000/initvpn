# initvpn
A bash script that downloads and installs Algo VPN and Outline VPN

## Usage
**THIS SCRIPT IS INTENDED FOR USE WITH A NON-ROOT SUDO USER ON AN SSH SESSION. USING MOSH IS NOT RECOMMENDED UNLESS YOU ARE USING A TERMINAL THAT SAVES THE FULL OUTPUT!**

Run the following command to download it and execute it:

```wget https://raw.githubusercontent.com/sweeper3000/initvpn/master/initvpn.sh && chmod +x initvpn.sh && ./initvpn.sh```

## Issues
- Docker refuses to work in the same shell session it was installed in, so the Outline install script will have to be executed manually after a logout and relogin
