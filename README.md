# Plexfix (read/write) Bash Script

This script is designed to help set up read/write and group permissions for a Plex media server by requested media paths on a Linux machine. It automates the process of setting ownership and permissions for media files and directories, making it easier to manage your media library.

I created this after having these issues myself and needing a fix I can replicate especially when restoring a library after a fresh install.

## Requirements
This script must be run as root in order to change ownership and permissions.
Plex Media Server must be installed and running on the system.
Media files must be stored on a local drive or a network drive that allows permission changes.

## Usage
Download or copy the plex-setup.sh script to your Linux machine.
Open a terminal and navigate to the directory containing the script.
Run the script with the following command:

**bash**

`sudo ./plex-setup.sh`

Follow the prompts to specify the paths to your media directories. You can either provide a single path or a list of paths.
Once you've specified all the paths, the script will set ownership and permissions for the media files and directories.
After the script completes, Plex Media Server should be able to access your media files and add them to your library.

## Disclaimer
Use this script at your own risk. It is provided as-is and without any warranty or guarantee of its suitability for any particular purpose. Be sure to backup your media files and system before running this script, and review the script code to ensure it meets your needs before running it.
