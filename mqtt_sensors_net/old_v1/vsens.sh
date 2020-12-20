#!/bin/bash

mqtt_host=$1
mqtt_port=$2
mqtt_user=$3
mqtt_pass=$4
mqtt_topic=$5"/"$(hostname -s)


# thermal for insindeous - from -25C to -10C is good conditions
t_in_min=-25
t_in_max=-10

# thermal for motor - it can be good from +20C to +65C
t_mot_min=20
t_mot_max=65

# for the start - leak - false
leak=0
echo $leak > /tmp/leak.txt


t_in_prev=`cat 
t_mot_prev=rnd
leak=`cat /tmp/leak.txt`





vtemp=`shuf --input-range=15-30 --head-count=1`
vhumi=$((25 + $RANDOM % 30))
vsleep=$((15 + $RANDOM % 30))

mosquitto_pub \
 -h $mqtt_host \
 -p $mqtt_port \
 -u $mqtt_user \
 -P $mqtt_pass \
 -t $mqtt_topic \
 -m "{\"vtemp\":$vtemp}"

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
 -m "{\"vhumi\":$vhumi}"


exit
