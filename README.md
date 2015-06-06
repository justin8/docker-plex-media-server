This is a docker image for Plex mediaserver stable running on an Arch linux container

All features should be possible. Some ports/folders must be mapped for it to work correctly.

All ports except the webui are UDP only, webui is TCP only.

Required ports:

    32400: webui
    32469: DLNA
    5353: mDNS/avahi/zeroconf discovery; This may conflict with mDNS on your host.
    1900: uPNP discovery

Required volume bindings:


    /config - For configuration files/thumbnails/cache/etc

    /media - All your media files. If you have them in disparate places you could mount say /tv to /media/tv and /foo/movies to /media/movies individually; or bind mount them to a folder on the host first.
