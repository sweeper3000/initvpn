# initvpn
A bash script that downloads and installs Algo VPN and Outline VPN

## Usage
**THIS SCRIPT IS INTENDED FOR USE WITH A NON-ROOT SUDO USER ON AN SSH SESSION. USING MOSH IS NOT RECOMMENDED UNLESS YOU ARE USING A TERMINAL THAT SAVES THE FULL OUTPUT!**

You can clone the repo:

```git clone https://github.com/sweeper3000/initvpn.git```

cd into it and execute:

```cd initvpn && ./initvpn.sh```

You may need to give the script execute permissions.

Or you can download the script and pass it directly into the shell:

```curl -sS https://raw.githubusercontent.com/sweeper3000/initvpn/master/initvpn.sh | sh```

## Issues
- Docker refuses to work in the same shell session it was installed in, so the Outline install script will have to be executed manually after a logout and relogin
