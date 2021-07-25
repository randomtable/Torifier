#!/bin/bash
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolv.conf'
gsettings set org.gnome.system.proxy.socks host '127.0.0.1'
gsettings set org.gnome.system.proxy.socks port 9150
gsettings set org.gnome.system.proxy mode 'manual'
sudo bash -c 'systemctl stop NetworkManager.service'
sudo bash -c 'systemctl start NetworkManager.service'
sudo bash -c 'systemctl restart NetworkManager.service'
echo ""
echo "You are now torified! Test for connection and DNS leaks before intensive use!"
