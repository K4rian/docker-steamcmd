FROM debian:buster-slim

LABEL maintainer="contact@k4rian.com"

ENV USER steam
ENV USERHOME /home/$USER
ENV STEAMCMDDIR $USERHOME/steamcmd
ENV SERVERDIR $USERHOME/gameserver

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        lib32stdc++6=8.3.0-6 \
        lib32gcc1=1:8.3.0-6 \
        ca-certificates=20190110 \
        wget=1.20.1-1.1 \
    && useradd -m $USER \
    && su $USER -c \
        "mkdir -p ${STEAMCMDDIR} \
        && cd ${STEAMCMDDIR} \
        && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - \
        && chmod 755 ./steamcmd.sh \
        && mkdir -p ${USERHOME}/.steam/sdk32 \
        && ln -sf ${STEAMCMDDIR}/linux32/steamclient.so ${USERHOME}/.steam/sdk32/steamclient.so \
        && mkdir -p ${SERVERDIR}" \
    && apt-get remove --purge -y \
        wget \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $USER
WORKDIR $STEAMCMDDIR

ENTRYPOINT ["./steamcmd.sh"]