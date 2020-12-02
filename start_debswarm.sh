#!/bin/bash

nodecount=10

systemctl start dnsmasq

`pwd`\/nat4debswarm.sh

virsh start ansible
sleep 10

for i in $(seq 1 $nodecount); do
    virsh start deb10node$i
    sleep 10
done
