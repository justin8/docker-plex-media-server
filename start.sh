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
sed -i 's/^/export /g' /etc/conf.d/plexmediaserver
source /etc/conf.d/plexmediaserver
/usr/bin/plexmediaserver.sh &
echo -n "Waiting for service to start..."

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
