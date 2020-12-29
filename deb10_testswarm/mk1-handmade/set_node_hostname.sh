#!/bin/bash

echo "setting hostname to new node ..."
nodename=$1

# узнали ip новой ноды
newnode_ip=$(head -1 /var/log/dnsmasq.leases | cut -d " " -f 3)
echo "new node ip = "$newnode_ip

# у нас в образе ноды уже есть ssh ключ для рута.
# делаем ноде новый hostname

# oldfashnwae
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null root@$newnode_ip "echo $nodename.debswarm.local > /etc/hostname; hostname $nodename.debswarm.local"
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null root@$newnode_ip "cat /etc/hosts | grep -v 127.0.1.1 >> /tmp/hosts.tmp; cat /tmp/hosts.tmp > /etc/hosts; echo \"127.0.1.1 $nodename.debswarm.local $nodename\" >> /etc/hosts; rm /tmp/hosts.tmp"
# StylishYouthFashn
#ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null root@$newnode_ip "hostnamectl set-hostname $nodename.debswarm.local"

ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null root@$newnode_ip "reboot"

echo "...node sent to reboot"
exit
