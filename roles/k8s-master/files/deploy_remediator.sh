#!/bin/bash

DefaultAppID=1
AppID=${1:-$DefaultAppID}
if [ -n "$APPID" ]; then 
	kubectl delete -f telegraf.yaml -n autoshift
	sleep 10
	remediator_exist=`kubectl get rc -n helper-app$APPID | grep autoremediator`
	if [ -z "$remediator_exist" ]; then
	    kubectl create -f auto-remediator.yaml -n helper-app$APPID
	fi
	cd tools-telegraf_aggregator_plugin
	./update_configmap.sh autoshift 1 $APPID
	cd ..
	kubectl create -f telegraf.yaml -n autoshift
else
	echo "Please specify APPID as \$1."
fi
