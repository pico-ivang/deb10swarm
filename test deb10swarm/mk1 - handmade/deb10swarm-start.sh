#!/bin/bash

nodecount=20

systemctl start dnsmasq

iptables -t nat -A POSTROUTING -o kvmbr0 -j MASQUERADE

sleep 3

echo "starting ansible"
virsh start ansible
sleep 5
read -p "Ansible started. Deb10nodes good to go?"
sleep 5


echo "launching out the swarm"
for i in $(seq 1 $nodecount); do
    virsh start deb10node$i
    sleep 10
done
