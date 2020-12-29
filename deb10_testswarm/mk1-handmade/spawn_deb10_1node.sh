#!/bin/bash

source $(pwd)/deb10swarm.vars

i=$1
    echo "creating node "$i

    echo "copying from template ..."
    dd if=$deb10swarm_path/deb10template.img of=$deb10swarm_path/deb10node$i.img bs=1M

    echo "launching node "$i
    virt-install \
	--name deb10node$i \
	--memory 1024 \
	--vcpus 1 \
	--disk $deb10swarm_path/deb10node$i.img \
	--boot hd \
	--os-variant debian9 \
	--network bridge=$debswarm_bridge \
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

$(pwd)\/set_node_hostname.sh deb10node$i

exit
