#!/bin/bash

mqtt_host=$1
mqtt_port=$2
mqtt_user=$3
mqtt_pass=$4
mqtt_topic=$5"/"$(hostname -s)

vtemp=`shuf --input-range=15-30 --head-count=1`
vhumi=$((25 + $RANDOM % 30))
vsleep=$((15 + $RANDOM % 30))

mosquitto_pub \
 -h $mqtt_host \
 -p $mqtt_port \
 -u $mqtt_user \
 -P $mqtt_pass \
 -t $mqtt_topic \
 -m "{\"vtemp\":\"$vtemp\"}"

echo "temp="$vtemp
echo "sleeping "$vsleep
sleep $vsleep
echo "humi="$vhumi

mosquitto_pub \
 -h $mqtt_host \
 -p $mqtt_port \
 -u $mqtt_user \
 -P $mqtt_pass \
 -t $mqtt_topic \
 -m "{\"vhumi\":\"$vhumi\"}"


exit
