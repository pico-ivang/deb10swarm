#!/bin/bash

read -p "how many nodes spawn for you -> " node_count
read -p "start number for node -> " node_startnumber


for i in $(seq $node_startnumber $(expr $node_startnumber + $node_count - 1)); do
    `pwd`\/spawn_deb10_1node.sh $i
done

exit
