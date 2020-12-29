#!/bin/bash

for i in $(virsh list --all --name | grep deb10node); do
    virsh destroy $i
done

exit
