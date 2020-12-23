#!/bin/bash

echo "setting hostname to new node ..."
nodename=$1

# узнали ip новой ноды
newnode_ip=$(head -1 /var/log/dnsmasq.leases | cut -d " " -f 3)
echo "new node ip = "$newnode_ip

# у нас в образе ноды уже есть ssh ключ для рута.
# делаем новый hostname ноде

ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null root@$newnode_ip "echo $nodename.debswarm.local > /etc/hostname"
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null root@$newnode_ip "hostname $nodename.debswarm.local"
#ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null root@$newnode_ip "rm -v /etc/ssh/ssh_host_*"
#ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null root@$newnode_ip "dpkg-reconfigure openssh-server"
#sleep 15
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null root@$newnode_ip "reboot"

echo "...node sent to reboot"
exit
