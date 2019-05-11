#!/bin/bash

echo "Starting change_GRUB_background.sh"

# gets director that the bash script is in, taken from https://stackoverflow.com/questions/59895/get-the-source-directory-of-a-bash-script-from-within-the-script-itself
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "directory of png to set as GRUB2 background? (hit enter to use default)"
read location
if [ -z "$location" ]
then
	path=$DIR"/default.png"
else
	path=$location
fi

echo "For the below prompts, hit enter to use default"
echo "Black as a background color will be transparent"
echo "Colors able to be used: black, blue, brown, cyan, dark-gray, green, light-cyan, light-blue, light-green, light-gray, light-magenta, light-red, magenta, red, white, yellow"

read -p "menu color highlight foreground (white): " menu_highlightF
: ${menu_highlightF:="white"}

read -p "menu color highlight background (light-gray): " menu_highlightB
: ${menu_highlightB:="light-gray"}

menu_highlight="set menu_color_highlight="$menu_highlightF"/"$menu_highlightB

read -p "menu color foreground (white): " menu_normalF
: ${menu_normalF:="white"}

read -p "menu color background (black): " menu_normalB
: ${menu_normalB:="black"}

menu_normal="set menu_color_normal="$menu_normalF"/"$menu_normalB

read -p "text color foreground (white): " normalF
: ${normalF:="white"}

read -p "text color background (black): " normalB
: ${normalB:="black"}

normal="set color_normal="$normalF"/"$normalB

sed -i '/### start menu ###/,/### end menu ###/d' /etc/grub.d/40_custom

echo '### start menu ###' >> /etc/grub.d/40_custom
echo $menu_highlight >> /etc/grub.d/40_custom
echo $menu_normal >> /etc/grub.d/40_custom
echo $normal >> /etc/grub.d/40_custom
echo '### end menu ###' >> /etc/grub.d/40_custom


cp $path "/boot/grub/splash1.png"
update-grub
