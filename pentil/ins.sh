#!/bin/bash

#install
apt update && apt upgrade
apt install python3 python3-pip unzip
mkdir -p wsc
cd wsc
wget https://github.com/Afdhan/tetek/blob/main/pentil/susu/upil.zip
rm -rf upil.zip
pip3 install -r wsc/requirements.txt
pip3 install pillow

mkdir -p /usr/local/bin/wsc_panel
touch /usr/local/bin/wsc_panel/info.txt
mv wsc /usr/local/bin/wsc_panel
echo ""
read -e -p "[*] Input Your Bot Token : " token
read -e -p "[*] Input Port Nginx VPS : " nginx
if [ -z $nginx ]; then
nginx=81
fi
read -e -p "[*] Input Your Id Telegram :" admin
read -e -p "[*] Input Your Domain :" domain
echo -e BOT_TOKEN='"'$token'"' >> /usr/local/bin/wsc_panel/info.txt
echo -e PORT_NGINX='"'$nginx'"' >> /usr/local/bin/wsc_panel/info.txt
echo -e ADMIN='"'$admin'"' >> /usr/local/bin/wsc_panel/info.txt
echo -e DOMAIN='"'$domain'"' >> /usr/local/bin/wsc_panel/info.txt
clear
echo "Done"
echo -e "==============================="
echo "BOT TOKEN         : $token"
echo "E-Mail          : $admin"
echo "Domain        : $domain"
echo -e "==============================="
echo "Setting done"
sleep 1
cat > /etc/systemd/system/wsc_panel.service << END
[Unit]
Description=WSC_Panel By DhanZaa Group
After=network.target

[Service]
WorkingDirectory=/usr/local/bin
ExecStart=/usr/bin/python3 -m /usr/local/bin/wsc_panel
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable wsc_panel
systemctl start wsc_panel 


clear

echo " Installations complete, type /menu on your bot"
