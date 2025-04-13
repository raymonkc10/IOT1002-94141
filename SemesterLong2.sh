#!/bin/bash

# Script to find and kill the top 5 processes currently running on the system by CPU usage.

# Finding the top 5 processes by CPU usage
top_processes=$(ps -eo pid,user,%cpu --sort=-%cpu | head -6)

# Displaying the top processes to the user and requesting confirmation before killing them
echo "Top 5 processes by CPU usage:"
echo "$top_processes"
read -p "Do you want to kill these processes? (y/n): " response

# Exiting if the user chooses not to kill the processes
if [ "$response" != "y" ]; then
    echo "Exiting without killing any processes."
    exit 0
fi

# Sending a SIGKILL signal to non-root processes
while read -r pid _ _ _; do
    if [ "$pid" != "PID" ]; then
        if [ "$(ps -p $pid -o user=)" != "root" ]; then
            kill -9 "$pid"
            echo "Process with PID $pid killed."
        fi
    fi
done <<< "$top_processes"

# Logging the details of the killed processes
log_file="~/ProcessUsageReport-$(date +%Y-%m-%d).log"
echo "Logging details to $log_file"

while read -r pid username _ _; do
    if [ "$pid" != "PID" ]; then
        if [ "$username" != "root" ]; then
            start_time=$(ps -p $pid -o lstart=)
            kill_time=$(date +"%Y-%m-%d %H:%M:%S")
            primary_group=$(id -gn "$username")
            echo "Username: $username | Start Time: $start_time | Kill Time: $kill_time | Department: $primary_group" >> "$log_file"
        fi
    fi
done <<< "$top_processes"

# Displaying the number of processes killed
killed_processes=$(echo "$top_processes" | wc -l)
echo "$killed_processes processes were killed."

exit 0
