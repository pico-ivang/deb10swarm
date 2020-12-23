#!/bin/bash


while [ true ]; do
    /home/kvm/docker/deb10dcswarm.sh telemetry
    /home/kvm/docker/deb10dcswarm.sh vsens
    echo "sleeping 600 secs"
    sleep 600
done