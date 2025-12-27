#!/bin/bash

cd /home/xp/lc/pdk/ossutil
./generate_bsp_txt.bash '${pdk_sdk_version}'
echo "--------------------------"
cat bsp_version.txt | head -5 > pdk_version.txt
echo "--------------------------"
