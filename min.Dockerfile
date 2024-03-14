FROM debian:bookworm-slim

ARG PUID=1000
ARG PGID=1000

ENV USERNAME steam
ENV USERGROUP steam
ENV USERHOME /home/$USERNAME
ENV STEAMCMDDIR $USERHOME/steamcmd
ENV SERVERDIR $USERHOME/gameserver

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        lib32stdc++6=12.2.0-14 \
        lib32gcc-s1=12.2.0-14 \
        ca-certificates=20230311 \
        wget=1.21.3-1+b2 \
    && groupadd -g "${PGID}" $USERGROUP \
    && useradd -u "${PUID}" -g "${PGID}" -m $USERNAME \
    && su $USERNAME -c \
        "mkdir -p ${STEAMCMDDIR} \
        && cd ${STEAMCMDDIR} \
        && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - \
        && chmod +x ./steamcmd.sh \
        && mkdir -p ${USERHOME}/.steam/sdk32 ${USERHOME}/.steam/sdk64 ${STEAMCMDDIR}/linux32 ${STEAMCMDDIR}/linux64 \
        && ln -s ${STEAMCMDDIR}/linux32/steamclient.so ${USERHOME}/.steam/sdk32/steamclient.so \
        && ln -s ${STEAMCMDDIR}/linux32/steamcmd ${STEAMCMDDIR}/linux32/steam \
        && ln -s ${STEAMCMDDIR}/linux64/steamclient.so ${USERHOME}/.steam/sdk64/steamclient.so \
        && ln -s ${STEAMCMDDIR}/linux64/steamcmd ${STEAMCMDDIR}/linux64/steam \
        && ln -s ${STEAMCMDDIR}/steamcmd.sh ${STEAMCMDDIR}/steam.sh \
        && mkdir -p ${SERVERDIR}" \
    && ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so" \
    && apt-get remove --purge -y \
        wget \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $USERNAME
WORKDIR $STEAMCMDDIR

ENTRYPOINT ["./steamcmd.sh"]