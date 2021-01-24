#!/bin/bash

source $(pwd)/deb10swarm.vars

read -p "name of node -> " nodename
read -p "memory MB -> " nodemem
read -p "vcpus -> " nodevcpus

    echo "creating node "$nodename

    echo "copying from template ..."
    dd if=$deb10swarm_path/deb10template.img of=$deb10swarm_path/$nodename.img bs=1M

    echo "launching node "$nodename
    virt-install \
	--name $nodename \
	--memory $nodemem \
	--vcpus $nodevcpus \
	--disk $deb10swarm_path/$nodename.img \
	--boot hd \
	--os-variant debian9 \
	--network bridge=$deb10swarm_bridge \
	--graphics vnc,password=p0ssw@rt \
	--memballoon model=virtio \
	--noautoconsole

echo "sleep 60 - waiting node to start"
echo "[          ]"
sleep 6
echo "[#         ]"
sleep 6
echo "[##        ]"
sleep 6
echo "[###       ]"
sleep 6
echo "[####      ]"
sleep 6
echo "[#####     ]"
sleep 6
echo "[######    ]"
sleep 6
echo "[#######   ]"
sleep 6
echo "[########  ]"
sleep 6
echo "[######### ]"
sleep 6
echo "[##########]"

$(pwd)/set_node_hostname.sh $nodename

exit
