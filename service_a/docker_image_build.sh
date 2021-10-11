#!/bin/bash

if [ $# -eq 0 ]
then
    echo "usage:   ./docker_app_start.sh containerName"
    echo "example: ./docker_app_start.sh ms_gate"
    exit 0
fi

containerName=$1
docker image build -f Dockerfile -t $containerName ./source

