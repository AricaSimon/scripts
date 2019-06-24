#!/bin/bash
#basic setup script for setting up a centos 7 minimal box, will update as needed

#update packages and clear cached files after update
yum update -y
yum clean all

#install useful packages not installed by default
yum install htop tmux git -y

# gets director that the bash script is in, taken from https://stackoverflow.com/questions/59895/get-the-source-directory-of-a-bash-script-from-within-the-script-itself
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#change grub background
chmod u+x $DIR"change_GRUB2_background/change_GRUB2_background.sh"
$DIR"change_GRUB2_background/change_GRUB2_background.sh"
