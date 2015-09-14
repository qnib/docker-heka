#!/bin/bash

now=$(date +%s)
for con in $(netstat -tapn|egrep "9092.*ESTABLISHED"|awk '{print $5}'|sort |uniq -c|egrep -o "[0-9]+.*"|sed -e 's/ /:/');do
    cnt=$(echo ${con}|awk -F\: '{print $1}')
    ip=$(echo ${con}|awk -F\: '{print $2}')
    host=$(dig +short -x ${ip}|awk -F\. '{print $1}')
    msg="kafka.stats.$(hostname).connections.established.${host} ${cnt} ${now}"
    echo ${msg}
    echo ${msg}|nc -w1 carbon.service.consul 2003
done
for con in $(netstat -tapn|egrep "9092.*CLOSE_WAIT"|awk '{print $5}'|sort |uniq -c|egrep -o "[0-9]+.*"|sed -e 's/ /:/');do
    cnt=$(echo ${con}|awk -F\: '{print $1}')
    ip=$(echo ${con}|awk -F\: '{print $2}')
    host=$(echo ${ip}|sed -e 's/\./_/g')
    msg="kafka.stats.$(hostname).connections.close_wait.${host} ${cnt} ${now}"
    echo ${msg}
    echo ${msg}|nc -w1 carbon.service.consul 2003
done
