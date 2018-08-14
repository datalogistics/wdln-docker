#!/bin/bash

docker build --no-cache -t "wdln-base" base/
docker build -t "wdln-ferry" ferry/
docker build -t "wdln-idms" idms/
docker build -t "wdln-uploader" uploader/

docker network create wdln
