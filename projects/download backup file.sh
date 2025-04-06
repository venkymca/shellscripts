#/bin/bash

## Write a shell script that downloads the latest backup file from a remote server and logs the download time.

## before execute this script you should access to remote server from your server

# Set the remote server details
REMOTE_USER="ubuntu"
REMOTE_HOST="server ip address"
REMOTE_DIR="/home/ubuntu"
LOCAL_DIR="/home/ubuntu"
LOG_FILE="/home/ubuntu/backuplg.log"

# create a log file if it's not available 

touch "$LOG_FILE"


# Check if the remote backup directory exists

ssh $REMOTE_USER@$REMOTE_HOST "test -d $REMOTE_DIR" || { echo "Remote directory $REMOTE_DIR does not exist"; exit 1; }

# Get the latest backup file from the remote server

LATEST_BACKUP=$(ssh $REMOTE_USER@$REMOTE_HOST "ls -t $REMOTE_DIR/*.tar.gz | head -n 1")


if [ -z "$LATEST_BACKUP" ]; then
  echo "No backup files found in the directory $REMOTE_DIR"
  exit 1
fi

# Extract the file name
FILE_NAME=$(basename $LATEST_BACKUP)

# Define the local path where you want to store the backup
LOCAL_FILE="$LOCAL_DIR/$FILE_NAME"

echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting download of $FILE_NAME" >> $LOG_FILE


scp $REMOTE_USER@$REMOTE_HOST:$LATEST_BACKUP $LOCAL_FILE

# Check if the download was successful
if [ $? -eq 0 ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Successfully downloaded $FILE_NAME to $LOCAL_FILE" >> $LOG_FILE
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Failed to download $FILE_NAME" >> $LOG_FILE
fi
