#!/bin/bash

docker stack rm noti
sleep 1;
docker stack deploy -c docker-compose.yml noti