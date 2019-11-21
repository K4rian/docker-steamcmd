docker-steamcmd
=====

A base Docker image for Valve's [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD) with minimal footprint.



## Introduction 

This image can be considered a fork of [CM2Walki](https://github.com/CM2Walki)'s [steamcmd](https://github.com/CM2Walki/steamcmd) image with some modifications and fixes:

- A default `gameserver` folder (located in `/home/steam`) has been added to keep all server files instead of using a different folder for each game.
- A bug involving the `steamclient.so` library on GoldSrc-based games has been fixed.
- The image doesn't use a volume by default.

The image is based on [debian](https://hub.docker.com/_/debian/):[buster-slim](https://hub.docker.com/_/debian/?tab=tags&page=1&name=buster-slim).



## Example uses

Whilst this image *should* be used as a base image for any supported SteamCMD game server, it can also be used directly for testing purposes.

__Example 1:__ Create a new container and get access to the `SteamCMD` console:
```
$ docker run -it --name=steamcmd -i k4rian/steamcmd bash
```

__Example 2:__ Create a new (and ephemeral) container and use `SteamCMD` to download the *Left 4 Dead 2 Dedicated Server* files then quit:
```
$ docker run --rm -i k4rian/steamcmd \
             +login anonymous \
             +force_install_dir /home/steam/gameserver \
             +app_update 222860 \
             +quit
```



## See also

* __[docker-srcds](https://github.com/k4rian/docker-srcds)__ — A Docker image used to run any *Source Dedicated Server* games *(like Counter-Strike: Source/GO, Left 4 Dead 1/2, Team Fortress 2, etc.)* who use __[steamcmd](#)__ image as base.



## License

[MIT](LICENSE)