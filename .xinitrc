#!/bin/sh

# Author: Enan Ajmain
# Email : 3nan.ajmain@gmail.com
# Github: https://github.com/3N4N


DESKTOP="xfce"
# DESKTOP="dwm"

# setup keyboard mappings
setxkbmap -option ''
setxkbmap -option 'caps:ctrl_modifier'
setxkbmap -option 'shift:both_capslock'
setxkbmap -option 'numpad:microsoft'

# setup natural scrolling in touchpad
xinput set-prop 'DELL0767:00 06CB:7E92 Touchpad' 'libinput Tapping Enabled' 1
xinput set-prop 'DELL0767:00 06CB:7E92 Touchpad' 'libinput Natural Scrolling Enabled' 1

# setup compositor
compton -b

if [ $DESKTOP = "xfce" ]; then

	exec startxfce4

elif [ $DESKTOP = "dwm" ]; then

	# setup background
	hsetroot -fill /home/enan/Pictures/backgrounds/quay.jpg

	# setup notification widget
	dunst &> /dev/null &

	# fix broken java applications
	export _JAVA_AWT_WM_NONREPARENTING=1

	# setup status bar
	dwm_status &> /dev/null &

	while true; do
		# Log stderror to a file
		#dwm 2> ~/.dwm.log
		# No error logging
		dwm >/dev/null 2>&1
	done

fi
