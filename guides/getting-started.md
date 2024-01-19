# Getting started

### Table of contents
1. [Getting started](getting-started.md)
2. [Building](building.md)
3. [Configuration](configuration.md)

### Pre-requisites

- Linux operating system
  - at the time of writing I'm using Ubuntu 22.04 LTS.
- Docker and docker-compose installed.
- TRaSH Guides folder structure in place (there are commands on the next page), read more [here](https://trash-guides.info/Hardlinks/How-to-setup-for/Docker/#folder-structure), this is what I will use but it can be expanded:
  ```
    storage
    ├── downloads
    │   └──torrents
    │     ├── movies-anime
    │     └── tv-anime
    ├── drop        # I will explain this folder later, it's very useful for Shoko Server.
    │   ├── movies-anime
    │   └── tv-anime
    └── medialibrary
        ├── movies-anime
        └── tv-anime
  ```

- **Optional (_but encouraged_)**: **secret management option**. In my case, I use [**Infisical Cloud**](https://infisical.com/).

Move on to the [Building](building.md) section.