FROM justin8/archlinux
MAINTAINER justin@dray.be

RUN pacman -Syq --noprogressbar --noconfirm plexmediaserver
RUN sed -i 's|cd ${PLEX_MEDIA_SERVER_HOME}.*|cd ${PLEX_MEDIA_SERVER_HOME}; "${PLEX_MEDIA_SERVER_HOME}/Plex Media Server"|g' /opt/plexmediaserver/start_pms

ADD plexmediaserver.conf /etc/conf.d/plexmediaserver

VOLUME /config
VOLUME /media

EXPOSE 32400
CMD /opt/plexmediaserver/start_pms
