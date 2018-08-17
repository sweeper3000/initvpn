# initvpn
A bash script that gives you the choice to install [Outline](https://getoutline.org/en/home), [Algo](https://github.com/trailofbits/algo), [Wireguard](https://www.wireguard.com/) or [OpenVPN via this script](https://github.com/Nyr/openvpn-install). Or, you can install them all if you want.

## Usage
**THIS SCRIPT IS INTENDED FOR USE WITH A NON-ROOT SUDO USER ON AN SSH SESSION. USING MOSH IS NOT RECOMMENDED UNLESS YOU ARE USING A TERMINAL THAT SAVES THE FULL OUTPUT!**

Run the following command to download it and execute it:

```bash
$ wget https://raw.githubusercontent.com/sweeper3000/initvpn/master/initvpn.sh && chmod +x initvpn.sh && ./initvpn.sh
```

## Choosing a VPN
Each of the VPNs here have their own advantages and disadvantages.

### Outline
Outline is developed by Google's Jigsaw labs and is aimed at news organizations to give journalists a secure way to connect to the internet by using servers controlled by the news organizations.

#### Highlights
- Uses Shadowsocks as its protocol
- Has clients for every OS
- Has a nice management console that runs only on desktop (for now) that allows you to add keys, remove keys and rename keys
- Windows client doesn't currently support whole-device tunneling

### Algo
Algo is a set of scripts that deploy an IKEv2/IPSec VPN running on StrongSwan on a server. It's designed to be so simple to use, that its disposable, as in you can destroy the server and set another up with ease.

#### Highlights
- Only uses secure protocols
- Uses DNS over HTTPS on Cloudflare's [1.1.1.1](https://1.1.1.1) DNS service
- Can deploy to an assortment of servers, but in this script, only use the `Deploy to Current Server` option
- Setting up VPN connections on the client side uses only built in tools if possible
- Android client connections use [Wireguard](https://www.wireguard.com/), a very fast, kernel-based protocol

### Wireguard
Wireguard is a new VPN protocol that's designed to be more efficient than other VPN software such as OpenVPN or IPSec.

**Please note the following: Wireguard is installed as part of Algo, and therefore the standalone Wireguard won't be installed on the install everything option. Wireguard is also under very active development, so the protocol could see major changes. Use at your own risk. The only platforms with offical clients are Android and Linux**

#### Highlights
- Very efficient
- Low impact on battery life in my experience
- Setup is easy, it's almost like SSH: just exchange keys and tell it where to go
- Quiet protocol: while many VPN clients transmit keepalives constantly, Wireguard does not. It will only transmit data if it needs to.

### OpenVPN
OpenVPN is the most famous VPN of the three, and it's become the de-facto VPN of choice. 

#### Highlights
- Has software for every device
- Uses TLS for data transport, encryption and integrity
- Supports TCP or UDP
- Can be heavy on device battery compared to the other options
