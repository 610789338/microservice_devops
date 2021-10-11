#!/bin/bash

cmd=""
cmd+="sed -i 's/LISTENPORT/$LISTENPORT/g' /root/bin/config.json;"
cmd+="sed -i 's/ETCDADDR/$ETCDADDR/g' /root/bin/config.json;"
cmd+="sed -i 's/REDIS1ADDR/$REDIS1ADDR/g' /root/bin/config.json;"
cmd+="sed -i 's/REDIS2ADDR/$REDIS2ADDR/g' /root/bin/config.json;"
eval $cmd

nohup /root/bin/ms_gate -c /root/bin/config.json > /root/bin/ms_gate.log &

