#!/bin/bash

	nodes_count=$(docker ps | grep deb10dcnode | wc -l )
	if [ -z $nodes_count ]; then nodes_count=0; fi
	echo "щас есть "$nodes_count

case $1 in
    add)
	if [ -z $2 ]; then
	    read -p "how many nodes to spawn -> " new_nodes
	else
	    new_nodes=$2
	 fi

	new_nodes_index=`expr $nodes_count + $new_nodes`
	new_nodes_start=`expr $nodes_count + 1`

	echo "сделаю ноды номерами от "$new_nodes_start" до "$new_nodes_index

	for i in $(seq $new_nodes_start $new_nodes_index); do
	    docker run -it -d --rm --name deb10dcnode$i --hostname deb10dcnode$i -v /home/kvm/docker/tools:/srv deb10dcnode
	done
    ;;
    telemetry)
	for j in $(docker ps -a | grep deb10dcnode | cut -d " " -f1); do
	    docker exec -it $j /srv/telemetry.sh
	done
    ;;
    vsens)
	for j in $(docker ps -a | grep deb10dcnode | cut -d " " -f1); do
	    docker exec -it $j /srv/vsens.sh
	done
    ;;
    killall)
	docker stop $(docker ps -a | grep deb10dcnode | cut -d " " -f1)
    ;;
    *)
	echo "usage deb1dcswarm.sh add | telemetry | vsens | killall"
    ;;
esac
exit
