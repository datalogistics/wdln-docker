#!/bin/bash

docker run --name wdln-base --network wdln -p 42424:42424  -p 9000:9000 --hostname wdln-base -it -d wdln-base
docker run --name wdln-ferry-00 -v /home/jemusser/open/wildfire-dln/ferry:/home/wdln/wildfire-dln/ferry --network wdln --hostname wdln-ferry-00 -it -d wdln-ferry
docker run --name wdln-ferry-01 --network wdln  -p 80:80 --hostname wdln-ferry-01 -it -d wdln-ferry
docker run --name wdln-idms --network wdln -p 9001:9001 --hostname wdln-idms -it -d wdln-idms

echo
echo

docker network inspect --format='{{range .Containers}}{{.IPv4Address}} {{println .Name}}{{end}}' wdln | sed 's/\/16//g'
