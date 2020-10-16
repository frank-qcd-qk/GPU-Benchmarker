#!/bin/bash

sudo docker pull frank1chude1qian/dlbt_3090:latest
docker tag frank1chude1qian/dlbt_3090 gimel12/dlbt_public
chmod +x dlbt_launcher
./dlbt_launcher
