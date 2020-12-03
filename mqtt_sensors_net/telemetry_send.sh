#!/bin/bash

mqtt_serv=imc-global.ru
mqtt_port=1357
mqtt_user=gonya
mqtt_pass=GonyaUberHaka90
mqtt_topic=vMon-RA1

# send self telemetry
#/srv/telemetry.sh $mqtt_serv $mqtt_port $mqtt_user $mqtt_pass $mqtt_topic
bash telemetry.sh $mqtt_serv $mqtt_port $mqtt_user $mqtt_pass $mqtt_topic
# send sensors data
#/srv/vsens.sh $mqtt_serv $mqtt_port $mqtt_user $mqtt_pass $mqtt_topic
bash vsens.sh $mqtt_serv $mqtt_port $mqtt_user $mqtt_pass $mqtt_topic

exit
