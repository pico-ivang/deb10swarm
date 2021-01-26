#!/bin/bash
# скрипт для симуляции отправки телеметрии об холодильник.
# t_in - температура внутри холодильника
# t_mot - темп мотора
# leak - датчик протечки

cd /srv

function telegram_alert (){
    $(pwd)/telegram_send.sh "Alerta!!!   xolodilnik $nodename - $1 detected!"
}

source $(pwd)/mqtt.vars

source $(pwd)/vsens.vars

# reading prev values
leak=`cat /tmp/leak.txt`
t_in_prev=`cat /tmp/t_in_prev.txt`
t_mot_prev=`cat /tmp/t_mot_prev.txt`


# what if no prev values
if [ -z $leak ]; then leak=0; fi
if [ -z $t_in_prev ]; then t_in_prev=-10; fi
if [ -z $t_mot_prev ]; then t_mot_prev=25; fi


# coin flip shows us the way - increase or decreace t_in
if [ $t_in_prev -gt $t_in_thr ];
 then t_in_sign=-1
 else t_in_sign=1
fi

# coin flip shows us the way - increase or decreace t_mot
if [ $t_mot_prev -gt $t_mot_thr ];
 then t_mot_sign=-1
 else t_mot_sign=1
fi


# doing maths - how far will be the next step
t_in=`shuf --input-range=$t_in_step --head-count=1`
echo "t_in * t_in_sign + t_in_prev = " $t_in" * "$t_in_sign" + "$t_in_prev
t_in=`expr  $t_in \* $t_in_sign + $t_in_prev`
echo "new t_in = "$t_in
echo $t_in > /tmp/t_in_prev.txt

# alerting
if [ $t_in -ge $t_in_alert ]; then telegram_alert "inner OVERHEATING"; fi


t_mot=`shuf --input-range=$t_mot_step --head-count=1`
echo "t_mot * mod_sign + t_mot_prev = " $t_mot" * "$t_mot_sign" + "$t_mot_prev
t_mot=`expr  $t_mot \* $t_mot_sign + $t_mot_prev`
echo "new t_mot = "$t_mot
echo $t_mot > /tmp/t_mot_prev.txt

# alerting
if [ $t_mot -ge $t_mot_alert ]; then telegram_alert "MOTOR OVERHEAT"; fi

# alerting
if [ $leak -eq "1" ]; then telegram_alert "LEAKAGE"; fi

mosquitto_pub -d \
 -i $nodename \
 -h $mqtt_host \
 -p $mqtt_port \
 -u $mqtt_user \
 -P $mqtt_pass \
 -t $mqtt_topic \
 -m "{\"t_in\":$t_in,\"t_mot\":$t_mot,\"leak\":$leak}"


exit
