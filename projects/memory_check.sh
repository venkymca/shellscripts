#/bin/bash

# create a shell script to check available free memory on the system and alert the user if it falls below a threshold (e.g 10%)

TTHRESHOLD=10

# Get available memory percentage

available=$(free | awk '/Mem/{printf("%.0f"), $7/$2*100}')

# Compare the threshold with available memory

if [ "$available" -lt "$THRESHOLD" ]; then
    echo "Warning: Free memory is below ${THRESHOLD}%! Current free memory: ${available}%"
else
    echo "Free memory is sufficient. Current free memory: ${available}%"
fi
