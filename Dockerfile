FROM justin8/archlinux
MAINTAINER justin@dray.be

RUN pacman -Sy --noprogressbar --noconfirm plexmediaserver avahi && pacman -Scc --noconfirm
RUN sed -i 's|cd ${PLEX_MEDIA_SERVER_HOME}.*|cd ${PLEX_MEDIA_SERVER_HOME}; "${PLEX_MEDIA_SERVER_HOME}/Plex Media Server"|g' /opt/plexmediaserver/start_pms

ADD plexmediaserver.conf /etc/conf.d/plexmediaserver

VOLUME /config
VOLUME /media

EXPOSE 32400

ADD start.sh /start.sh
RUN chmod +x /start.sh
CMD /start.sh
