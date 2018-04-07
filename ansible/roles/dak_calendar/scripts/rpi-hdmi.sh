#!/bin/sh
# usage rpi-hdmi.sh off (turn display off)
# usage rpi-hdmi.sh on (turn display on)

is_off ()
{
	tvservice -s | grep "TV is off" >/dev/null
}

case $1 in
	off)
		vcgencmd display_power 0
	;;
	on)
		vcgencmd display_power 1
	;;
esac

exit 0
