FROM justin8/archlinux
MAINTAINER justin@dray.be

RUN pacman -Sy --noprogressbar --noconfirm plex-media-server avahi && pacman -Scc --noconfirm
# This has moved to /usr/bin/plexmediaserver.sh maybe?
#RUN sed -i 's|cd ${PLEX_MEDIA_SERVER_HOME}.*|cd ${PLEX_MEDIA_SERVER_HOME}; "${PLEX_MEDIA_SERVER_HOME}/Plex Media Server"|g' /opt/plexmediaserver/start_pms

#ADD plexmediaserver.conf /etc/conf.d/plexmediaserver
RUN sed -i 's|PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR.*|PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/config/Library/Application Support"|' /etc/conf.d/plexmediaserver

VOLUME /config
VOLUME /media

# Ports:
# 32400: webui
# 32469: DLNA
# 5353: mDNS/avahi/zeroconf discovery; This may conflict with mDNS on your host.
# 1900: uPNP discovery

EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp

ADD start.sh /start.sh
RUN chmod +x /start.sh
CMD /start.sh
