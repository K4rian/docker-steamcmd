<p align="center">
 <img alt="docker-steamcmd logo" src="https://raw.githubusercontent.com/K4rian/docker-steamcmd/assets/icons/logo-docker-steamcmd.svg" width="25%" align="center">
</p>

A base Docker image for Valve's [SteamCMD][1] based on [Debian][2] (bookworm-slim).

---
<div align="center">

Docker Tag  | Version | Platform | Description
---         | ---     | ---      | ---
[latest][3] | 1.1     | amd64    | The default and the most bug-free image. You probably want to use this one.
[min][4]    | 1.1     | amd64    | The minimal version of the image that doesn't contain the language locale fix and, thus, is about 20% smaller.
</div>
<p align="center"><a href="#introduction">Introduction</a> &bull; <a href="#usage">Usage</a> &bull; <a href="#manual-build">Manual build</a> &bull; <a href="#see-also">See also</a> &bull; <a href="#license">License</a></p>

## Introduction 
This image can be considered a fork of [CM2Walki][5]'s [steamcmd][6] image with some modifications and fixes:

- A default `gameserver` folder (located in `/home/steam`) has been added to keep all server files instead of using a different folder for each game.
- An issue involving the `steamclient.so` library has been fixed by creating a symbolic link to the corresponding file.
- An issue concerning the `setlocale` function has been fixed by installing and configuring the missing package.
- The image doesn't use a volume by default.

## Usage
Whilst this image *should* be used as a base image for any supported SteamCMD game server, it can also be used directly for testing purposes.

__Example 1:__<br>
Create a new container and get access to the `SteamCMD` console:
```bash
docker run --name steamcmd -it k4rian/steamcmd
```

__Example 2:__<br>
Create a ephemeral container and use `SteamCMD` to download the *Left 4 Dead 2 Dedicated Server* files in the current directory then quit:
```bash
docker run --rm \
  -v $(pwd):/home/steam/gameserver \
  k4rian/steamcmd \
  +force_install_dir /home/steam/gameserver \
  +login anonymous \
  +app_update 222860 \
  +quit
```

## Manual build
__Requirements__:<br>
— Docker >= __18.03.1__<br>
— Git *(optional)*

Like any Docker image the building process is pretty straightforward: 

- Clone (or download) the GitHub repository to an empty folder on your local machine:
```bash
git clone https://github.com/K4rian/docker-steamcmd.git .
```

- Then run the following commands inside the newly created folder:
```bash
docker build --no-cache -f Dockerfile -t k4rian/steamcmd:latest
```
```bash
docker build --no-cache -f min.Dockerfile -t k4rian/steamcmd:min
```

## See also
* __[docker-srcds][7]__ — A Docker image used to run any *Source Dedicated Server* games *(Counter-Strike: Source, Left 4 Dead 1/2, Team Fortress 2, etc.)* which use this image as base.

## License
[MIT][8]

[1]: https://developer.valvesoftware.com/wiki/SteamCMD "SteamCMD (Valve Developer Wiki)"
[2]: https://hub.docker.com/_/debian "Debian Docker Image on Docker Hub"
[3]: https://github.com/K4rian/docker-srcds/tree/master/Dockerfile "Latest Dockerfile (Base)"
[4]: https://github.com/K4rian/docker-srcds/tree/master/min.Dockerfile "Latest Dockerfile (Minimal)"
[5]: https://github.com/CM2Walki
[6]: https://github.com/CM2Walki/steamcmd
[7]: https://github.com/K4rian/docker-srcds
[8]: https://github.com/K4rian/docker-srcds/blob/master/LICENSE