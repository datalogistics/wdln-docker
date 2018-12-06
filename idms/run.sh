#!/bin/bash

git -C libdlt pull
git -C wildfire-dln pull
git -C IDMS pull
git -C unisrt pull

sudo -E /etc/init.d/supervisor start

echo "idms IP : `hostname --ip-address`"
sleep 1
tail -f /var/log/idms.log
