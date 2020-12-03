#!/bin/bash

read -p "name of node -> " nodename
read -p "memory MB -> " nodemem
read -p "vcpus -> " nodevcpus

    echo "creating node "$nodename

    echo "copying from template ..."
    dd if=deb10template.img of=$nodename.img bs=1M

    echo "launching node "$nodename
    virt-install \
	--name $nodename \
	--memory $nodemem \
	--vcpus $nodevcpus \
	--disk /home/kvm/vms/debswarm/$nodename.img \
	--boot hd \
	--os-variant debian9 \
	--network bridge=kvmbr-debswarm \
	--graphics vnc,password=p0rn0 \
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

`pwd`\/set_node_hostname.sh $nodename

exit
