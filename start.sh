#!/bin/bash
PID_FILE="/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"

#dbus
mkdir /run/dbus
dbus-uuidgen --ensure
dbus-daemon --system --fork
sleep 1

#avahi
avahi-daemon --no-chroot -D
avahi-resolve-host-name -a 127.0.0.1 > /dev/null

rm -f '/config/Library/Application Support/Plex Media Server/plexmediaserver.pid'
/opt/plexmediaserver/start_pms &
echo -n "Waiting for service to start..."

count=0
while [[ ! -f '/config/Library/Application Support/Plex Media Server/Logs/Plex Media Server.log' ]]
do
	echo -n .
	sleep 0.5
	(( count++ ))
	if [[ $count -gt 30 ]]
	then
		echo -e "\nAn error has occurred while starting plex! Please check the logs"
		break
	fi
	if [[ $count -gt 4 ]]
	then
		if ! pgrep -F "$PID_FILE" > /dev/null
		then
			echo -e "\nAn error has occurred while starting plex! Please check the logs"
			exit 1
		fi
	fi
done
echo ""

tail -fn0 '/config/Library/Application Support/Plex Media Server/Logs/'*.log &

while pgrep -F "$PID_FILE" > /dev/null
do
	sleep 1
done
