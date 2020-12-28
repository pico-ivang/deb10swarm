#!/bin/bash
# скрипт отправляет телеметрию хоста - больше чтоб держать руку на пульсу шлюза
# если жив - то по какому адресу виден

# load global vars
source /srv/mqtt.vars

echo " "
echo " "
echo " mqtt_topic = "$mqtt_topic


# get IP addr
ip_address=`hostname -i | head -1`
if [ ${#ip_address} -lt 3 ]; then ip_address="none"; fi
echo " ip_address = "$ip_address

# get hostname
#nodename=$(hostname -f)
echo " nodename   = "$nodename

# get uptime
uptime=`uptime -p`
echo " uptime     = "$uptime


# send dataset
mosquitto_pub -d \
 -i $nodename \
 -h $mqtt_host \
 -p $mqtt_port \
 -u $mqtt_user \
 -P $mqtt_pass \
 -t $mqtt_topic \
 -m "{\"ip_addr\":\"$ip_address\",\"nodename\":\"$nodename\",\"uptime\":\"$uptime\",\"alive\":\"alive\"}"

exit
