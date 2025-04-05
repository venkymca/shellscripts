#/bin/bash

# write a shell script to monitor the network connectivity of a server and log the results if it is unreachable

SERVER_IP="8.8.8.8" 
LOG_FILE="/var/log/network_monitor.log"
PING_COUNT=5

sudo touch "$LOG_FILE" # Create log file if it doesn't exist

timestamp=$(date "+%Y-%m-%d %H:%M:%S")

ping -c $PING_COUNT $SERVER_IP > /dev/null 2>&1

if [ $? -ne 0 ]; then

echo "$timestamp - ERROR: $SERVER_IP is unreachable" >> $LOG_FILE

else
    # If the server is reachable, print success (optional)
    echo "$timestamp - SUCCESS: $SERVER_IP is reachable"
fi

