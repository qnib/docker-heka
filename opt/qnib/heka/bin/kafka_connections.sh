#!/bin/bash

for con in $(netstat -tapn|egrep "9092.*ESTABLISHED"|awk '{print $5}'|sort |uniq -c|egrep -o "[0-9]+.*"|sed -e 's/ /:/');do
    cnt=$(echo ${con}|awk -F\: '{print $1}')
    ip=$(echo ${con}|awk -F\: '{print $2}')
    host=$(dig +short -x ${ip}|awk -F\. '{print $1}')
    msg="kafka.stats.$(hostname).connections.${host} ${cnt} ${now}"
    echo ${msg}
    echo ${msg}|nc -w1 carbon.service.consul 2003
done
