#!/bin/bash

for i in $(seq 1 100); do
    virsh destroy deb10node$i
    virsh undefine deb10node$i
    rm deb10node$i.img
done

exit
