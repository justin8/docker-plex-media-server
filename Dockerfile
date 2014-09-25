FROM dock0/arch
MAINTAINER justin@dray.be

# Using this repo for both nzbdrone-torrents and currently mono 3.8 to fix issues in extra/mono-3.4
RUN curl -sO https://repo.dray.be/dray-repo-0.7-1-any.pkg.tar.xz
RUN pacman -U --noconfirm dray-repo-0.7-1-any.pkg.tar.xz
RUN pacman -Syq --noprogressbar --noconfirm plexmediaserver
RUN sed -i 's/export LD_LIBRARY_PATH.*/export LD_LIBRARY_PATH=\/opt\/plexmediaserver/' '/opt/plexmediaserver/start_pms'
RUN sed -i 's/^PLEX_MEDIA_SERVER_HOME.*/PLEX_MEDIA_SERVER_HOME=\/config/' /etc/conf.d/plexmediaserver

VOLUME "/config"

EXPOSE 32400
CMD /opt/plexmediaserver/start_pms
