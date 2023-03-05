#!/bin/bash

pkill -f spcast_transcoder.liq
sleep 3
chmod +x /home/spcast/SPCast/transcoder/spcast_transcoder.liq
cd /home/spcast/SPCast/transcoder
./spcast_transcoder.liq
