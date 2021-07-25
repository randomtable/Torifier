#!/bin/bash
echo "Rolling back configurations..."
sudo rm /etc/NetworkManager/NetworkManager.conf
sudo rm /etc/resolv.conf
sudo cp /etc/NetworkManager/NetworkManager.conf.torifier /etc/NetworkManager/NetworkManager.conf
sudo cp /etc/resolv.conf.torifier /etc/resolv.conf
gsettings set org.gnome.system.proxy mode 'none'
rm tor-browser-linux64-10.5.2_en-US.tar.xz
rm -rf tor-browser_en-US/*
rm -rf tor-browser_en-US
sudo bash -c 'systemctl stop NetworkManager.service'
sudo bash -c 'systemctl start NetworkManager.service'
sudo bash -c 'systemctl restart NetworkManager.service'
echo ""
echo "All done... Restored previous configurations"
