# Welcome to the selfhosted-anime guide!

This project uses **Docker** for its infrastructure and **Ubuntu Linux** as its operating system, so anything else is out of my scope (_unless contributed_). This will give you a **stable and reliable** solution to manage your anime movies and tv-shows while having **proper metadata**.

### NOTE (01/20/2024): This guide doesn't include every container you might need, you could add Bazarr for subtitles for example, I'll just show you the basics and maybe update it in the future.

- **I will NOT be using Sonarr and Radarr... but why?**
  - Two simple reasons, really: Sonarr/Radarr's integration with **TheTVDB** and the fact that you **can't change** it as a metadata source.
  - I like them as products, I use them daily, but with anime, TheTVDB doesn't offer as much as AniDB does. It may work for some shows, but some are going to be divided in "seasons" instead of aknowledging each "season" of said anime as its own being (Ex. Sailor Moon, Pokémon).

### If you don't like this decision and you're not okay to download some stuff manually, that's fine. Otherwise, happy reading!

Along the way I'll explain how I did things **_my way_**, of course a lot of stuff can be changed and improved, that's up to you.

The containers that will be used are the following:

- qBittorrent (qBittorrentVPN as alternative)
- Autobrr
- Shoko-Server
- Jellyfin (Plex as alternative)

## Important considerations

- Shoko-server **REQUIRES** you to install **Shoko Desktop** to set up some important features, currently it's a **Windows only** application that requires a GUI. (you can install it on a different machine and on Linux, but more on it later)

- You will have **some** automated downloads with Autobrr, but _it's not like the \*arrs_.

- This guide will make **HEAVY** use of how TRaSH Guides sets up [hardlinks](https://trash-guides.info/), you should really give it a read **beforehand**.

</br>

To dive in, read the [wiki](https://github.com/shyonae/selfhosted-anime/wiki).
