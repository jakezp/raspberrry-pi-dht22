#!/bin/sh

while :
do
	climate=`python fetch.py`
	if [ $? -eq 0 ]
	then
		temp=`echo $climate | jq -r '.temperature.value'`
                humidity=`echo $climate | jq -r '.humidity.value'`
		echo "T: $temp"
		echo "H: $humidity"
		mosquitto_pub -h $MQTT_HOST -p 1883 -u $MQTT_USER -P $MQTT_PASS -t monitor/$MQTT_TOPIC_PREFIX/env/temperature -m $temp
		mosquitto_pub -h $MQTT_HOST -p 1883 -u $MQTT_USER -P $MQTT_PASS -t monitor/$MQTT_TOPIC_PREFIX/env/humidity -m $humidity
        else
		$?
	fi


	sleep 10s
done
