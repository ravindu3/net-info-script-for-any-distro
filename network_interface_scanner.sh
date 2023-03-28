#!/bin/bash

echo "Scanning network interfaces..."
echo ""

# Get list of network interfaces
interfaces=$(ls /sys/class/net)

# Loop through network interfaces
for interface in $interfaces; do
    # Get IP address
    ip_address=$(ip addr show $interface | grep "inet " | awk '{print $2}' | cut -d'/' -f1)
    
    # Get interface MAC address
    mac_address=$(cat /sys/class/net/$interface/address)
    
    # Get default gateway IP
    if [ -x "$(command -v ip)" ]; then
        gateway_ip=$(ip route | grep default | awk '{print $3}')
    elif [ -x "$(command -v netstat)" ]; then
        gateway_ip=$(netstat -rn | grep "^0.0.0.0" | awk '{print $2}')
    else
        gateway_ip="Unknown"
    fi
    
    # Get DNS servers
    if [ -f "/etc/resolv.conf" ]; then
        dns_servers=$(cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}')
    else
        dns_servers="Unknown"
    fi
    
    # Check if IP is static or DHCP
    if [ -f "/etc/network/interfaces" ]; then
        ip_config_type=$(grep "iface $interface" -A 1 /etc/network/interfaces | grep "dhcp" | awk '{print "DHCP"}')
        if [ -z "$ip_config_type" ]; then
            ip_config_type=$(grep "iface $interface" -A 1 /etc/network/interfaces | grep "static" | awk '{print "Static"}')
        fi
    elif [ -d "/etc/netctl" ]; then
        ip_config_type=$(grep "Interface=$interface" /etc/netctl/* | awk -F "=" '{print $NF}' | sort -u)
    elif [ -f "/etc/sysconfig/network-scripts/ifcfg-$interface" ]; then
        ip_config_type=$(grep "BOOTPROTO" /etc/sysconfig/network-scripts/ifcfg-$interface | awk -F "=" '{print $2}')
    else
        ip_config_type="Unknown"
    fi
    
    # Print interface details
    echo "Interface: $interface"
    echo "IP Address: $ip_address"
    echo "MAC Address: $mac_address"
    echo "Gateway IP: $gateway_ip"
    echo "DNS Servers: $dns_servers"
    echo "IP Configuration Type: $ip_config_type"
    echo ""
done
