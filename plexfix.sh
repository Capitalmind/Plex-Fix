#!/bin/bash

echo -e "\e[32mThis script was tested on Ubuntu 22.04 / Linux Mint 21.1 Vera.\e[0m"
echo -e "\e[32mMost media drives were mounted to '/media/\$USER' but should accept drives mounted elsewhere.\e[0m"
echo -e "\e[33mCloud mounted drives will likely not permit their permissions being changed.\e[0m"
echo -e "\e[33mDrives mounted with rclone --allow-other --vfs-cache-mode writes will read correctly.\e[0m"
echo -e "\e[31mScript must be run as root due to use of chmod/chown and group permission changes.\e[0m"

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Stop plexmediaserver service
echo "Stopping plexmediaserver service..."
sudo service plexmediaserver stop

# Initialize an empty array to store the paths
paths=()

# Function to prompt the user for a path
get_path() {
  read -p "\e[33mEnter path to multimedia dir or dir list file: \e[0m" path
  paths+=("$path")
}

# Prompt the user for the first path
get_path

# Loop until the user chooses to continue
while true; do
  read -p "Enter another path? [y/n]: " answer
  case $answer in
    [Yy]* ) get_path;;
    [Nn]* ) break;;
    * ) echo "Please answer y or n.";;
  esac
done
# Ask the user to enter Y or N to continue adding paths

# Set variable MYGROUP to the current user
MYGROUP="$USER"

# Add plex user to the current user's group
echo "Adding plex user to $MYGROUP group..."
sudo usermod -a -G $MYGROUP plex

# Set ownership and permissions for each path
for path in "${paths[@]}"; do
  echo "Setting ownership and permissions for $path..."
  sudo chown $USER:$MYGROUP "$path"
  sudo chmod 750 "$path"
  sudo setfacl -m g:$MYGROUP:rwx "$path"
done

# Restart plexmediaserver service
echo "Restarting plexmediaserver service..."
sudo service plexmediaserver restart

# Check if the service was restarted successfully
if [[ $? -eq 0 ]]; then
   echo "\e[32mSuccess: All read/write access has been set for plexmediaserver\e[0m"
else
   echo "\e[31mError: Failed to add paths to plexmediaserver\e[0m"
fi

