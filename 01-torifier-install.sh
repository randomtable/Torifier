#!/bin/bash
echo "Changing NetworkManager to not update dns"
sudo bash -c 'echo "[main]" > /etc/NetworkManager/NetworkManager.conf'
sudo bash -c 'echo "dns=none" >> /etc/NetworkManager/NetworkManager.conf'
sudo bash -c 'echo "nameserver 9.9.9.9" > /etc/resolv.conf'
sudo bash -c 'systemctl stop NetworkManager.service'
sudo bash -c 'systemctl start NetworkManager.service'
sudo bash -c 'systemctl restart NetworkManager.service'
wget "https://dist.torproject.org/torbrowser/10.5.2/tor-browser-linux64-10.5.2_en-US.tar.xz"
tar -xvf tor-browser-linux64-10.5.2_en-US.tar.xz
chmod +x tor-browser_en-US/start-tor-browser.desktop
echo "DNSPort 127.0.0.1:53" >> tor-browser_en-US/Browser/TorBrowser/Data/Tor/torrc
echo "Now open the connect script"
