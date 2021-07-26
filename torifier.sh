#!/bin/bash
while true; do
echo ' #######'                                        
echo '    #     ####  #####  # ###### # ###### #####'  
echo '    #    #    # #    # # #      # #      #    #' 
echo '    #    #    # #    # # #####  # #####  #    #' 
echo '    #    #    # #####  # #      # #      #####'  
echo '    #    #    # #   #  # #      # #      #   #'  
echo '    #     ####  #    # # #      # ###### #    #' 
echo ''                                                
echo 'Welcome to Torifier'
echo ''
echo 'Wizard will guide you to torify your system'
echo ''
echo 'What would you like to do?'
echo ''
PS3='Please enter your choice: '
options=("Install Tor" "Fix connection parameters" "Setup system wide Proxy" "Rollback" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install Tor")
            echo "Cleanup older backups..."
            echo ""
            sudo rm /etc/NetworkManager/NetworkManager.conf.torifier
            sudo rm /etc/resolv.conf /etc/resolv.conf.torifier
            echo "Backup Network Manager config..."
            sudo cp /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf.torifier
            echo "Backup DNS Configuration..."
            sudo cp /etc/resolv.conf /etc/resolv.conf.torifier
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
            echo ""
            echo "Now run 'Fix connection parameters'"
            break
            ;;
        "Fix connection parameters")
            echo "Changing NetworkManager to not update dns"
            echo ""
            sudo bash -c 'echo "[main]" > /etc/NetworkManager/NetworkManager.conf'
            sudo bash -c 'echo "dns=none" >> /etc/NetworkManager/NetworkManager.conf'
            sudo bash -c 'echo "nameserver 9.9.9.9" > /etc/resolv.conf'
            sudo bash -c 'systemctl stop NetworkManager.service'
            sudo bash -c 'systemctl start NetworkManager.service'
            sudo bash -c 'systemctl restart NetworkManager.service'
            echo ""
            echo "Now open Tor browser and connect through SnowFlake, then run the 'Setup system wide Proxy' option"
            break
            ;;
        "Setup system wide Proxy")
            echo "Setting system wide proxy..."
            echo ""
            sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolv.conf'
            gsettings set org.gnome.system.proxy.socks host '127.0.0.1'
            gsettings set org.gnome.system.proxy.socks port 9150
            gsettings set org.gnome.system.proxy mode 'manual'
            sudo bash -c 'systemctl stop NetworkManager.service'
            sudo bash -c 'systemctl start NetworkManager.service'
            sudo bash -c 'systemctl restart NetworkManager.service'
            echo ""
            echo "You are now torified! Test for connection and DNS leaks before intensive use!"
            break
            ;;
        "Rollback")
            echo "Rolling back configurations..."
            echo ""
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
            break
            ;;
        "Quit")
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
done
