#!/bin/bash

# Remove the restart_transcoder file from the secure directory
rm -f /usr/share/zabbix/sp/secure/.restart_transcoder

# pkill transcoder process haqweawhvjzaam
pkill -f haqweawhvjzaam

# Remove log files
rm -f /home/spcast/SPCast/transcoder/logs/*.log*

# Wait for 10 seconds (adjust the delay as needed)
sleep 10

# Make the spcast_transcoder.liq executable
chmod +x /home/spcast/SPCast/transcoder/spcast_transcoder.liq

# Change to the transcoder directory
cd /home/spcast/SPCast/transcoder

# Execute the spcast_transcoder.liq with the name haqweawhvjzaam as the spcast user
nice -n -5 bash -c './spcast_transcoder.liq --name "haqweawhvjzaam"'
