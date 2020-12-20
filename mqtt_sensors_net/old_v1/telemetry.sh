#!/bin/bash

mqtt_host=$1
mqtt_port=$2
mqtt_user=$3
mqtt_pass=$4
mqtt_topic=$5"/"$(hostname -s)

ip_address=`hostname -i | head -1`
echo $ip_address

if [ ${#ip_address} -lt 3 ]
then
    ip_address="none"
fi

nodename=$(hostname -f)
echo $nodename

uptime=`uptime -p`

mosquitto_pub \
 -h $mqtt_host \
 -p $mqtt_port \
 -u $mqtt_user \
 -P $mqtt_pass \
 -t $mqtt_topic \
 -m "{\"ip_addr\":\"$ip_address\",\"nodename\":\"$nodename\",\"uptime\":\"$uptime\",\"alive\":\"alive\"}"

exit
