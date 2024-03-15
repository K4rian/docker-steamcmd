# Common Issues

### ERROR! Failed to install app '(...)' (No subscription)
The application you are trying to download either requires a login or that you have purchased the game.<br>
See the [Dedicated Servers List][1] on the Valve Developer Wiki for more information about each server requirement.

### Fatal Error: Steamcmd needs to be online to update. Please confirm your network connection and try again.
1. Your network may be misconfigured. Try the following command to make sure the container can reach the internet and ping `media.steampowered.com`:
```bash
docker run --rm --name steamcmd-test \
  --entrypoint "/bin/bash" \
  --user root \
  -it k4rian/steamcmd -c "apt update && apt install -y iputils-ping && ping -c 1 media.steampowered.com"
```

2. Check your domain name resolver configuration, typically  `/etc/resolv.conf` on a Debian-based distro.<br>
The `search` field can cause a lot of issues with SteamCMD in some environments.

3. Add a custom host for `client-download.steampowered.com` using the IP from the domain `media.steampowered.com`.<br>
* __Docker CLI:__
```bash
docker run --rm --name steamcmd-fix \
  --add-host=client-download.steampowered.com:$(ping -c 1 media.steampowered.com | egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -n 1) \
  -it k4rian/steamcmd
```

[1]: https://developer.valvesoftware.com/wiki/Dedicated_Servers_List "Dedicated Servers List (Valve Developer Wiki)"