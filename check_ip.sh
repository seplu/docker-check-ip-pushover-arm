#!/bin/sh

if [ ! -f /opt/logs/ip_logs.log ]; then
    touch /opt/logs/ip_logs.log
fi

if [ -w /opt/logs/ip_logs.log ]; then
    echo "/opt/logs/ip_logs.log - Writable"
else
    echo "/opt/logs/ip_logs.log - Not Writable"
    exit 1
fi

while true; do

IP=$(curl -s ipinfo.io/ip)
tail -1 /opt/logs/ip_logs.log | grep $IP
if [ $? -ne 1 ]; then
    echo "[CHECK_IP] IP match"
else
    echo "[CHECK_IP] New IP - $IP"
    DATA=$(date)
    echo "$DATA -- $IP" >> /opt/logs/ip_logs.log
    if [ "$PUSHOVER_TOKEN" = "" ] || [ "$PUSHOVER_USER" = "" ]; then
        echo "[CHECK_IP] Pushover not configured"
    else
        if [ "$PUSHOVER_PRIORITY" = "" ]; then
            PUSHOVER_PRIORITY=1
        fi
        curl -s \
            --form-string "token=$PUSHOVER_TOKEN" \
            --form-string "user=$PUSHOVER_USER" \
            --form-string "message=New IP address! $IP" \
            --form-string "priority=$PUSHOVER_PRIORITY" \
            https://api.pushover.net/1/messages.json
    fi
fi
if [ "$INTERVAL" = "" ]; then
    sleep 1800
else
    sleep $INTERVAL
fi
done
