#!/bin/bash

source $(pwd)/deb10swarm.vars

for i in $(virsh list --all --name | grep deb10node); do
    virsh destroy $i
    virsh undefine $i
    rm $deb10swarm_path/$i.img
done

exit
