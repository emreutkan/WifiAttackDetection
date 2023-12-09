#!/bin/bash

get_default_gateway() {
    /sbin/ip route | awk '/default/ { print $3 }'
}

get_gateway_mac() {
    arp -a | grep "($1)" | awk '{print $4}'
}

gateway=$(get_default_gateway)

echo "Current default gateway: $gateway"

read -p "Is this the correct gateway? (Y/N): " user_confirm

if [ "$user_confirm" = "N" ] || [ "$user_confirm" = "n" ]; then
    read -p "Enter the correct default gateway: " current_gateway
fi

original_gateway_mac=$(get_gateway_mac $gateway)
echo "Current Gateway IP: " $gateway " MAC: " $original_gateway_mac

echo "Monitoring ARP. Press [CTRL+C] to stop..."

get_ip_by_mac() {
    local target_mac=$1
    arp -a | awk -v mac="$target_mac" '$4 == mac {gsub(/[()]/,"",$2); print $2}'
}

find_suspicious_ips() {
    local target_mac=$1
    local gateway_ip=$2
    arp -a | grep -v "($gateway_ip)" | awk -v mac="$target_mac" '$4 == mac {gsub(/[()]/,"",$2); print $2}'
}

# Infinite loop to monitor ARP
while true; do
    new_gateway_mac=$(get_gateway_mac $gateway)

    if [ "$original_gateway_mac" != "$new_gateway_mac" ]; then
        echo "ARP poisoning attack detected!"
        echo "Gateway IP: " $current_gateway " MAC Changed from: " $original_gateway_mac to $new_gateway_mac
      
      # attacker_ip=$(get_ip_by_mac $new_gateway_mac)
       
       # echo "Potential attacker's IP address is: $attacker_ip"
            suspicious_ips=$(find_suspicious_ips $new_gateway_mac $gateway)

        if [ -n "$suspicious_ips" ]; then
            echo "Potential attacker's IP address(es):"
            echo "$suspicious_ips"
            break
        else
            echo "No suspicious IPs found with the attackers MAC address."
            break
        fi
    fi
done
