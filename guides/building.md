# Building

### Table of contents
1. [Getting started](getting-started.md)
2. [Building](building.md)
3. [Configuration](configuration.md)

## Folder structure

Create the folders with these commands, the structure will be created _under the home folder of the current user_ in this case:

```
mkdir -p ~/storage/downloads/torrents/movies-anime
mkdir -p ~/storage/downloads/torrents/tv-anime
mkdir -p ~/storage/drop/movies-anime
mkdir -p ~/storage/drop/tv-anime
mkdir -p ~/storage/medialibrary/movies-anime
mkdir -p ~/storage/medialibrary/tv-anime
```

The folder structure is restricted and varies a bit from the one used in TRaSH Guides, but always make sure it uses the same logic.

**Make sure to set the correct [permissions](https://trash-guides.info/Hardlinks/How-to-setup-for/Docker/#permissions).**


## Compose section

This is a **sample** `.env` configuration to get started. Feel free to customize it and/or replace it with whatever secret management alternative you want to use.

```
PGID=1000
PUID=1000
TZ=Europe/Rome
DOCKERSTORAGEDIR=/storage
```

This is a **sample** compose that will work provided that you have the folder structure in place. I make use of yaml anchors to avoid repeating code where possible.

```yaml
version: "3.8"

x-default-conf: &default_conf
  restart: unless-stopped
  networks:
    - downloadNetwork

x-default-conf-jelly: &default_conf_jelly
  restart: unless-stopped
  networks:
    - jellyNetwork

x-environment: &environment
  PGID: ${PGID}
  PUID: ${PUID}
  TZ: ${TZ}

services:
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittorrent
    environment:
      <<: *environment
    <<: *default_conf
    volumes:
      - qbittorrent:/config
      - ${DOCKERSTORAGEDIR}:/storage
    ports:
      - 8080:8080

  autobrr:
    container_name: autobrr
    image: ghcr.io/autobrr/autobrr:latest
    environment:
      <<: *environment
    <<: *default_conf
    volumes:
      - autobrr:/config
    ports:
      - 7474:7474

  shoko_server:
    shm_size: 256m
    container_name: shokoserver
    image: shokoanime/server:daily    # I personally use the 'daily' tag, but it is unstable so use the 'stable' tag if you want.
    environment:
      <<: *environment
    <<: *default_conf_jelly
    volumes:
      - shoko:/home/shoko/.shoko
      - ${DOCKERSTORAGEDIR}:/mnt
    ports:
      - 8111:8111

  jellyfin:
    container_name: jellyfin
    image: lscr.io/linuxserver/jellyfin:latest
    environment:
      <<: *environment
    <<: *default_conf_jelly
    volumes:
      - jellyfin:/config
      - ${DOCKERSTORAGEDIR}/medialibrary:/data
    ports:
      - 8096:8096

volumes:
  jellyfin:
    external: false
    name: jellyfin-volume
  autobrr:
    external: false
    name: autobrr-volume
  qbittorrent:
    external: false
    name: qbittorrent-volume
  shoko:
    external: false
    name: shoko-volume

networks:
  downloadNetwork:
    name: downloadNetwork
    driver: bridge
  jellyNetwork:
    name: jellyNetwork
    driver: bridge
```

This will get you started and get your containers up and running, but we have to **configure** them for the magic to work.

Let's move to the [Configuration](configuration.md) guide.