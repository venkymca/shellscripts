#/bin/bash

# Write a shell script that monitors the status of a list of process and restarts them if they are not running.


# List of processes to monitor (replace these with your actual process names)
processes=("nginx" "mysql" "apache2")

# Function to check if a service is installed
is_installed() {
    # Check if the service is installed by checking its systemd service or binary location
    # Using systemctl for services
    if systemctl list-units --type=service | grep -q "$1"; then
        return 0  # Service is either active are not active 
    elif which "$1" > /dev/null; then
        return 0  # Binary is installed
    else
        return 1  # Service or binary is not installed
    fi
}

# Function to check and restart processes
check_and_restart() {
    for process in "${processes[@]}"; do
        # First, check if the process is installed
        if is_installed "$process"; then
            echo "$process is installed."

            # Check if the process is running
            if ! pgrep -x "$process" > /dev/null; then
                echo "$process is not running. Attempting to restart..."

                # Restart the process (you can adjust this line to suit the way the process should be started)
                case "$process" in
                    "nginx")
                        # Restart nginx
                        sudo systemctl restart nginx
                        echo "$process restarted."
                        ;;
                    "mysql")
                        # Restart MySQL
                        sudo systemctl restart mysql
                        echo "$process restarted."
                        ;;
                    "apache2")
                        # Restart Apache
                        sudo systemctl restart apache2
                        echo "$process restarted."
                        ;;
                    *)
                        echo "No restart command configured for $process"
                        ;;
                esac
            else
                echo "$process is running."
            fi
        else
            echo "$process is not installed."
        fi
    done
}

# Run the check and restart function
check_and_restart
