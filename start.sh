#!/bin/bash
PID_FILE="/config/Plex Media Server/plexmediaserver.pid"


#dbus
mkdir /run/dbus
dbus-uuidgen --ensure
dbus-daemon --system --fork
sleep 1

#avahi
avahi-daemon --no-chroot -D
avahi-resolve-host-name -a 127.0.0.1 > /dev/null

rm -f "$PID_FILE"
source /etc/conf.d/plexmediaserver
/usr/bin/plexmediaserver.sh &
'/opt/plexmediaserver/Plex Media Server'
echo -n "Waiting for service to start..."

# Not sure if these are needed or not.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

count=0
while [[ ! -f $PID_FILE ]] && [[ $count -lt 20 ]] ; do
	sleep 0.5
done

if [[ ! -f $PID_FILE ]]; then
	echo -e "\nAn error has occurred while starting plex! Please check the logs"
fi

while pgrep -F "$PID_FILE" > /dev/null
do
	sleep 1
done
