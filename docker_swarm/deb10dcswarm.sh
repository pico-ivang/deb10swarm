#!/bin/bash

	nodes_count=$(docker ps | grep deb10dcnode | wc -l )
	if [ -z $nodes_count ]; then nodes_count=0; fi
	echo "щас есть "$nodes_count

case $1 in
    add)
	read -p "how many nodes to spawn -> " new_nodes

	new_nodes_index=`expr $nodes_count + $new_nodes`
	new_nodes_start=`expr $nodes_count + 1`

	echo "сделаю ноды номерами от "$new_nodes_start" до "$new_nodes_index

	for i in $(seq $new_nodes_start $new_nodes_index); do
	    docker run -it -d --name deb10dcnode$i --hostname deb10dcnode$i -v /home/kvm/docker/tools:/srv deb10dcnode
	done
    ;;
    telemetry)
#	node_count=$(docker ps | grep deb10dcnode | wc -l )
	for i in $(seq 1 $nodes_count); do
	    docker exec -it deb10dcnode$i /srv/telemetry.sh
	done
    ;;
    vsens)
#	node_count=$(docker ps | grep deb10dcnode | wc -l )
	for i in $(seq 1 $nodes_count); do
	    docker exec -it deb10dcnode$i /srv/vsens.sh
	done
    ;;
    killall)
	for i in $(seq 1 $nodes_count); do
	    docker stop deb10dcnode$i
	    docker rm deb10dcnode$i
	done
    ;;
    *)
	echo "usage deb1dcswarm.sh add | telemetry | vsens | killall"
    ;;
esac
exit
