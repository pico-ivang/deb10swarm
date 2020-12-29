#!/bin/bash

source $(pwd)/deb10swarm.vars

systemctl start dnsmasq

iptables -t nat -A POSTROUTING -o $inet_iface -j MASQUERADE

read -p "launching vms? "

echo "starting ansible"
virsh start ansible
sleep 5
read -p "Ansible started. Deb10nodes good to go?"


nodes_exist=$(virsh list --all --name | grep deb10node | wc -l )
echo "nodes exist="$nodes_exist

if [ $nodes_exist -ne 0 ]; then
    echo "launching out all the kraft swarm"
    for i in $(virsh list --all --name | grep deb10node); do
	virsh start $i
	sleep 10
    done
else echo "no nodes - nothing to do, exiting."
fi

exit
