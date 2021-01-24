#!/bin/bash

read -p "how many nodes spawn for you -> " node_count

nodes_exist=$(virsh list --all --name | grep deb10node | wc -l )
echo "nodes exist="$nodes_exist
read -p "spawning "$node_count" more"

for i in $(seq $(expr $nodes_exist + 1) $(expr $nodes_exist + $node_count)); do
    $(pwd)/spawn_deb10_1node.sh $i
done

exit
