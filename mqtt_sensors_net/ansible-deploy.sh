#!/bin/bash

export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i mqtt_swarm_hosts.yml --key-file=/home/egi/.ssh/pupko  mqtt_telemetry_deploy.yml

