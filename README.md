docker-steamcmd
=====

A base Docker image for Valve's [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD) based on [debian](https://hub.docker.com/_/debian/):[buster-slim](https://hub.docker.com/_/debian/?tab=tags&page=1&name=buster-slim).



## Introduction 

This image can be considered a fork of [CM2Walki](https://github.com/CM2Walki)'s [steamcmd](https://github.com/CM2Walki/steamcmd) image with some modifications and fixes:

- A default `gameserver` folder (located in `/home/steam`) has been added to keep all server files instead of using a different folder for each game.
- An issue involving the `steamclient.so` library has been fixed by creating a symbolic link to the corresponding file.
- An issue concerning the `setlocale` function has been fixed by installing and configuring the missing package.
- The image doesn't use a volume by default.



## Variants

The `steamcmd` image come in two variants:

- :__[latest](https://github.com/K4rian/docker-steamcmd/tree/master)__ — the default and the most bug-free image. You probably want to use this one.
- :[min](https://github.com/K4rian/docker-steamcmd/tree/min) — the minimal version of the image that doesn't contain the language locale fix and, thus, is about 20% smaller. Used to save space on testing environments.



## Example uses

Whilst this image *should* be used as a base image for any supported SteamCMD game server, it can also be used directly for testing purposes.

__Example 1:__                                 
Create a new container and get access to the `SteamCMD` console:
```
$ docker run -it --name=steamcmd -i k4rian/steamcmd bash
```


__Example 2:__                                  
Create a ephemeral container and use `SteamCMD` to download the *Left 4 Dead 2 Dedicated Server* files then quit:
```
$ docker run --rm -i k4rian/steamcmd \
             +login anonymous \
             +force_install_dir /home/steam/gameserver \
             +app_update 222860 \
             +quit
```



## Manual build

__Requirements__:                               
— Docker >= __18.03.1__                         
— Git *(optional)*

Like any Docker image the building process is pretty straightforward: 

- Clone (or download) the GitHub repository to an empty folder on your local machine:
```
$ git clone https://github.com/K4rian/docker-steamcmd.git .
```

- Then run the following command inside the newly created folder:
```
$ docker build --no-cache -t steamcmd .
```



## See also

* __[docker-srcds](https://github.com/K4rian/docker-srcds)__ — A Docker image used to run any *Source Dedicated Server* games *(Counter-Strike: Source/GO, Left 4 Dead 1/2, Team Fortress 2, etc.)* which use this image as base.



## License

[MIT](LICENSE)