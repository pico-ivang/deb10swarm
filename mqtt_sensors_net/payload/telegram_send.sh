#!/bin/bash

source $(pwd)/conf/telegram.vars

SendText=$1

curl -s -X POST https://api.telegram.org/bot$telega_token/sendMessage -d chat_id=$telega_chat_id -d text="$SendText"
echo " "

exit
