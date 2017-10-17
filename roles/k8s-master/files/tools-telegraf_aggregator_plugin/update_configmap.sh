#!/bin/bash
#option 1: autoshift namespace
#option 2: user id
#option 3: app id
DefaultNameSpace=autoshift
NAMESPACE=${1:-$DefaultNameSpace}   # Default namespace is autoshift.
DefaultUserID=1
UserID=${2:-$DefaultUserID}
DefaultAppID=1
AppID=${3:-$DefaultAppID}
REDID=$(( AppID%16 ))
DIGIT1=${AppID:0:1}
DIGIT2=${AppID:1:1}

sed -e "s/APPID/$AppID/g; s/USERID/$UserID/g; s/DIGIT1/$DIGIT1/g; s/DIGIT2/$DIGIT2/g" telegraf-differentiate-template.conf > telegraf-differentiate.conf
sed -e "s/APPID/$AppID/g; s/USERID/$UserID/g; s/REDID/$REDID/g" telegraf-statistics-template.conf > telegraf-statistics.conf

# delete configmap
kubectl delete configmap telegraf-differentiate-config -n $NAMESPACE
kubectl delete configmap telegraf-statistics-config -n $NAMESPACE


# create configmap
kubectl create configmap telegraf-differentiate-config --from-file=telegraf-differentiate.conf -n $NAMESPACE
kubectl create configmap telegraf-statistics-config  --from-file=telegraf-statistics.conf -n $NAMESPACE

# check configmap
kubectl get configmap telegraf-differentiate-config -n $NAMESPACE -o yaml
kubectl get configmap telegraf-statistics-config -n $NAMESPACE -o yaml


# Delete Telegraf-stat, Telegraf-diff pods
kubectl get po -n $NAMESPACE |grep telegraf > a.txt
kubectl delete po $(awk '{print $1}' a.txt) -n $NAMESPACE
rm ./a.txt

