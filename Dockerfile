FROM justin8/archlinux
MAINTAINER justin@dray.be

RUN pacman -Syq --noprogressbar --noconfirm plexmediaserver
RUN sed -i 's/export LD_LIBRARY_PATH.*/export LD_LIBRARY_PATH=\/opt\/plexmediaserver/' '/opt/plexmediaserver/start_pms'
RUN sed -i 's/^PLEX_MEDIA_SERVER_HOME.*/PLEX_MEDIA_SERVER_HOME=\/config/' /etc/conf.d/plexmediaserver

VOLUME "/config"

EXPOSE 32400
CMD /opt/plexmediaserver/start_pms
