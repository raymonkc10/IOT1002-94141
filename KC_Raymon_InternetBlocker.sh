#!/bin/bash

# The script below will block HTTP and HTTPS traffic than run on the users computer.
# Only IT team access to the internet (HTTP and HTTPS).

# Performs retrieve the list of IT group
IT_Group=$(getent group IT | cut -d: -f4)

# It will initialize counter for IT users
IT_Users_Count=0

# It will use loop for each user in the IT group
for User in $IT_Group; do
    # It will create a new iptables rule which allow incoming HTTPS packets
    sudo iptables -A OUTPUT -p tcp --dport 443 -m owner --uid-owner $User -j ACCEPT
    IT_Users_Count=$((IT_Users_Count + 1))
done

# The below Command allow the local server to accept
sudo iptables -A OUTPUT -p tcp --dport 443 -d 192.168.2.3 -j ACCEPT

# The below commands block the special ports for accessing using following rules.
sudo iptables -t filter -A OUTPUT -p tcp --dport 8003 -j DROP
sudo iptables -t filter -A OUTPUT -p tcp --dport 1979 -j DROP

# It will show the message to the user and how many users are granted the internet access.
echo " $IT_Users_Count users granted the internet access in the IT group."
