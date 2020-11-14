#!/bin/bash

IP=$(curl -s ipinfo.io/ip)

while true; do

IP_CHECK=$(curl -s ipinfo.io/ip)

if [ "$IP" == "$IP_CHECK" ]; then
    echo "IP match"
else
    echo "New IP"
    if [ "$PUSHOVER_TOKEN" = "" ] || [ "$PUSHOVER_USER" = "" ]; then
        echo "Pushover not configured"
    else
        $IP=$IP_CHECK
        curl -s \
  		    --form-string "token=$PUSHOVER_TOKEN" \
  		    --form-string "user=$PUSHOVER_USER" \
  		    --form-string "message=New IP address! $IP" \
            --form-string "priority=1" \
  		    https://api.pushover.net/1/messages.json    
    fi
fi
if [ "$INTERVAL" = "" ]; then
    sleep 1800
else
    sleep $INTERVAL
fi
done
