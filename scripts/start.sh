#!/bin/sh

if [ ! -z "$TZ" ]; then
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
fi
if [ -z "$CONFIG_FILE" ]
then
    /app/mikrotik-exporter -device $DEVICE -address $ADDRESS -user $USER -password $PASSWORD
else
    /app/mikrotik-exporter -config $CONFIG_FILE
fi
