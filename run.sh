#!/bin/bash
set -e
clear

echo "###########################################"
echo "#         LICENCESBUY OVPN ACTIVATOR      #"
echo "###########################################"
echo ""

read -rp "Enter your Client ID: " cid </dev/tty
if [[ -z "$cid" ]]; then
    echo "Error: Client ID cannot be empty"
    exit 1
fi

echo ""
echo "Detecting Server IP..."
srv_ip=$(curl -s --max-time 5 ifconfig.me 2>/dev/null) || \
srv_ip=$(curl -s --max-time 5 api.ipify.org 2>/dev/null) || \
srv_ip=$(hostname -I 2>/dev/null | awk '{print $1}')

if [[ -z "$srv_ip" ]]; then
    echo "Error: Unable to detect server IP"
    exit 1
fi
echo "Server IP: $srv_ip"
echo ""
echo "Verifying license..."

api_url="https://my.hostserverbd.com/modules/servers/license_ovpn/validate.php"
res=$(curl -s --max-time 15 "${api_url}?client_id=${cid}&ip=${srv_ip}" 2>/dev/null)
res=$(echo "$res" | tr -d '\r\n' | xargs)

if [[ "$res" == "SUCCESS" ]]; then
    echo ""
    echo "License Validated Successfully!"
    echo "Starting OpenVPN Installer..."
    sleep 2
    curl -sL https://raw.githubusercontent.com/firozsarkar/ovpn/main/firoz.sh -o /tmp/firoz.sh
    sed -i 's/\r$//' /tmp/firoz.sh
    bash /tmp/firoz.sh
else
    echo ""
    echo "License Verification Failed!"
    echo "Server Response: $res"
    exit 1
fi
