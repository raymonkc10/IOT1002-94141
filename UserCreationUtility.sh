#!/bin/bash

# This function is used to create user account
create_user() {
    local first_name="$1"
    local last_name="$2"
    local department="$3"

    #To generate username
    local username="$(echo "${first_name:0:1}${last_name:0:7}" | tr '[:upper:]' '[:lower:]')"

    if id "$username" &>/dev/null; then
        echo "User $username already exists. Skipping."
    else
        #Create user
        sudo useradd -m -s /bin/bash -g "$department" "$username"
        echo "User $username created."
        ((new_users++))
    fi
}

# Check if group exists
create_group() {
    local department="$1"

    if grep -q "^$department:" /etc/group; then
        echo "Group $department already exists. Skipping."
    else
        #Create group
        sudo groupadd "$department"
        echo "Group $department created."
        ((new_groups++))
    fi
}

#Check if filename is provided as argument

new_users=0
new_groups=0

# Read the input file line by line
while IFS=, read -r first_name last_name department; do
    # Skip header line
    if [[ "$first_name" == "FIRSTNAME" ]]; then
        continue
    fi

    # Remove leading and trailing whitespace from department
    department=$(echo "$department" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

    # Check if user exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists. Skipping."
        continue
    fi

    # Create user account
    create_user "$first_name" "$last_name" "$department"

    # This will create group if it doesn't exist
    create_group "$department"

    # This will add user to department group
    sudo usermod -aG "$department" "$username"
done < EmployeeNames.csv

#The output final counts
echo "Total new users added: $new_users"
echo "Total new groups added: $new_groups"

