FROM base/archlinux
MAINTAINER justin@dray.be

# Setup a build environment
RUN pacman -Sy --noprogressbar --noconfirm base-devel git && rm -rf /var/cache/pacman/pkg/*
RUN useradd -m -d /build build-user && \
    echo 'build-user ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/build-user
USER build-user
RUN cd /build && \
    curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/prelink.tar.gz && \
    tar xf prelink.tar.gz && \
    cd prelink && \
    makepkg -rcfs --noconfirm && \
    sudo pacman -U --noconfirm prelink*pkg*
RUN cd /build && \
    curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/plex-media-server.tar.gz && \
    tar xf plex-media-server.tar.gz && \
    cd plex-media-server && \
    makepkg -rcfs --noconfirm && \
    sudo pacman -U --noconfirm plex-media-server*pkg*
USER root
RUN pacman -Q plex-media-server | awk '{print $2}' > /version

RUN sed -i 's|PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR.*|PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/config"|' /etc/conf.d/plexmediaserver

RUN sed -i 's/^/export /g' /etc/conf.d/plexmediaserver

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
