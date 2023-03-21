#!/bin/bash

pkill -f haqweawhvjzaam
sleep 3
chmod +x /home/spcast/SPCast/transcoder/spcast_transcoder.liq
cd /home/spcast/SPCast/transcoder
bash -c './spcast_transcoder.liq --name "haqweawhvjzaam"'
