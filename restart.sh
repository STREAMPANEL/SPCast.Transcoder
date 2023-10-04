#!/bin/bash

# Remove the restart_transcoder file from the secure directory
rm -f /usr/share/zabbix/sp/secure/.restart_transcoder

# Kill the process with the name haqweawhvjzaam
pkill -f haqweawhvjzaam

# Remove Logfiles
rm -f /home/spcast/SPCast/transcoder/logs/*.log*

# Wait for 3 seconds
sleep 3

# Make the spcast_transcoder.liq executable
chmod +x /home/spcast/SPCast/transcoder/spcast_transcoder.liq

# Change to the transcoder directory
cd /home/spcast/SPCast/transcoder

# Execute the spcast_transcoder.liq with the name haqweawhvjzaam
nice -n -5 bash -c './spcast_transcoder.liq --name "haqweawhvjzaam"'
