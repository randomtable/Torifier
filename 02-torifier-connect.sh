#!/bin/bash
echo "Changing NetworkManager to not update dns"
sudo bash -c 'echo "[main]" > /etc/NetworkManager/NetworkManager.conf'
sudo bash -c 'echo "dns=none" >> /etc/NetworkManager/NetworkManager.conf'
sudo bash -c 'echo "nameserver 9.9.9.9" > /etc/resolv.conf'
sudo bash -c 'systemctl stop NetworkManager.service'
sudo bash -c 'systemctl start NetworkManager.service'
sudo bash -c 'systemctl restart NetworkManager.service'
echo "Now open Tor browser and connect through SnowFlake, then run the system proxy script"
