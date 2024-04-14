#!/bin/bash

# Remove the restart_transcoder file from the secure directory
echo "Removing restart_transcoder file..."
rm -f /usr/share/zabbix/sp/secure/.restart_transcoder

# pkill transcoder process haqweawhvjzaam
echo "Killing transcoder process..."
pkill -f haqweawhvjzaam

# Remove PID file
echo "Removing PID file..."
rm -f /home/spcast/SPCast/transcoder/spcast_transcoder.pid

# Remove log files
echo "Removing log files..."
rm -f /home/spcast/SPCast/transcoder/logs/*.log*

# Wait for 10 seconds (adjust the delay as needed)
echo "Waiting for 10 seconds..."
sleep 10

# Make the spcast_transcoder.liq executable
echo "Making spcast_transcoder.liq executable..."
chmod +x /home/spcast/SPCast/transcoder/spcast_transcoder.liq

# Change to the transcoder directory
echo "Changing directory to transcoder..."
cd /home/spcast/SPCast/transcoder

# Execute the spcast_transcoder.liq with the name haqweawhvjzaam as the spcast user
if [ ! -e "/home/spcast/SPCast/transcoder/spcast_transcoder.pid" ]; then
    echo "Executing spcast_transcoder.liq..."
    nice -n -5 bash -c '/home/spcast/SPCast/transcoder/spcast_transcoder.liq --name "haqweawhvjzaam"'
fi
