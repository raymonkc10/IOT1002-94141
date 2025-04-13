#!/bin/bash

# This script creates a new folder structure under ~/EmployeeData
# with specific permissions and ownership for each department.

# To create the main directory named ~/EmployeeData
mkdir -p ~/EmployeeData

# it inititalize a counter to keep track of the number of folders created
folder_count=0

# it creates HR folder and set permissions and ownership
mkdir ~/EmployeeData/HR
chmod 770 -R ~/EmployeeData/HR
groupadd HR
chown :HR -R ~/EmployeeData/HR
((folder_count++))

# it creates IT folder and set permissions and ownership
mkdir ~/EmployeeData/IT
chmod 774 -R ~/EmployeeData/IT
groupadd IT
chown :IT -R ~/EmployeeData/IT
((folder_count++))

# it creates Finance folder and set permissions and ownership
mkdir ~/EmployeeData/Finance
chmod 774 -R ~/EmployeeData/Finance
groupadd Finance
chown :Finance -R ~/EmployeeData/Finance
((folder_count++))

# it creates Executive folder and set special permissions and ownership
mkdir ~/EmployeeData/Executive
chmod 770 -R ~/EmployeeData/Executive
groupadd Executive
chown :Executive -R ~/EmployeeData/Executive
((folder_count++))

# it creates Administrative folder and set permissions and ownership
mkdir ~/EmployeeData/Administrative
chmod 774 -R ~/EmployeeData/Administrative
groupadd Administrative
chown :Administrative -R ~/EmployeeData/Administrative
((folder_count++))

# Create Call_Centre folder and set permissions and ownership
mkdir ~/EmployeeData/Call\ Centre
chmod 774 -R ~/EmployeeData/Call\ Centre
groupadd Call_Centre
chown :Call_Centre -R ~/EmployeeData/Call\ Centre
((folder_count++))

# Set the current user as the owner of the ~/EmployeeData directory
chown "$(whoami)" ~/EmployeeData

# Display a final message showing the number of folders created
echo "Total folders created: $folder_count"
