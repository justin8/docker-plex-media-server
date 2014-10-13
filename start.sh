#!/bin/bash

/opt/plexmediaserver/start_pms &
while [[ ! -f '/config/Library/Application Support/Plex Media Server/Logs/Plex Media Server.log' ]]
do
	sleep 0.5
done

tail -fn0 '/config/Library/Application Support/Plex Media Server/Logs/'*.log
