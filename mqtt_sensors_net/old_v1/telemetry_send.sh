#!/bin/bash

mqtt_serv=imc-global.ru
mqtt_port=1357
mqtt_user=gonya
mqtt_pass=GonyaUberHaka90
mqtt_topic=vMon-RA1
mqtt_request=$1

bash $mqtt_request $mqtt_serv $mqtt_port $mqtt_user $mqtt_pass $mqtt_topic

exit
