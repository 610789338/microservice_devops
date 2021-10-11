#!/bin/bash

if [ $# -eq 0 ]
then
    echo "usage:   ./docker_app_start.sh containerName listenport"
    echo "example: ./docker_app_start.sh ms_gate 6666"
    exit 0
fi

if [ $# -eq 2 ]
then
    listenport=$2
    r=0
else
    listenport=0
    r=1
fi

while [ $r -ne 0 ]
do
    let listenport=$RANDOM+32767
    r=`netstat -anp|grep LISTEN|grep -c $listenport`
done

containerName=$1
name=$containerName"_"$listenport
echo $listenport, $name

dockerContainerID=`docker container run --name=$name --network=host --env LISTENPORT=$listenport --env-file env.list --cpus=1 --memory=1G -itd $containerName`
docker container exec -d ${dockerContainerID} /bin/bash /root/launch.sh

