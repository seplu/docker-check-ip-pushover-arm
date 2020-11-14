#!/bin/bash

while true; do

IP=$(curl -s ipinfo.io/ip)

ls -lha | grep $IP

if [ $? -ne 1 ]; then
    echo "IP match"
else
        echo "New IP"
    if [ "$PUSHOVER_TOKEN" = "" ] || [ "$PUSHOVER_USER" = "" ]; then
        echo "Pushover not configured"
    else
        find . -type f -exec rm -f {} \;
        touch $IP
	    curl -s \
  		    --form-string "token=$PUSHOVER_TOKEN" \
  		    --form-string "user=$PUSHOVER_USER" \
  		    --form-string "message=New IP address! $IP" \
            --form-string "priority=1" \
  		    https://api.pushover.net/1/messages.json    
    fi
fi
sleep $INTERVAL
done
