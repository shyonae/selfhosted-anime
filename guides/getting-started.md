## Actual pre-requisites

- Linux operating system, at the time of writing I use Ubuntu 22.04 LTS.
- Docker and docker-compose installed.
- TRaSH Guides folder structure in place, read more [here](https://trash-guides.info/Hardlinks/How-to-setup-for/Docker/#folder-structure), this is what I use:
  - **NOTE**: only the _\*-anime_ folders are really needed, this is just an overview as I have the complete TRaSH Guides setup but it's adjusted for anime.
  - ```
    data            # I called this 'storage'
    ├── torrents
    │   ├── movies
    │   ├── movies-anime
    │   ├── music
    │   ├── tv-anime
    │   └── tv
    ├── drop        # I will explain this folder later, it's very useful for Shoko Server.
    │   ├── movies-anime
    │   └── tv-anime
    └── media
        ├── movies
        ├── movies-anime
        ├── music
        ├── tv-anime
        └── tv
    ```
- **Optional (_but encouraged_)**: **secret management option**. In my case, I use [**Infisical Cloud**](https://infisical.com/).
