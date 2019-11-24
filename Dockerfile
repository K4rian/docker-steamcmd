FROM debian:buster-slim

LABEL maintainer="contact@k4rian.com"

ENV USERNAME steam
ENV USERHOME /home/$USERNAME
ENV STEAMCMDDIR $USERHOME/steamcmd
ENV SERVERDIR $USERHOME/gameserver

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        lib32stdc++6=8.3.0-6 \
        lib32gcc1=1:8.3.0-6 \
        ca-certificates=20190110 \
        locales=2.28-10 \
        wget=1.20.1-1.1 \
    && sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen \
    && useradd -m $USERNAME \
    && su $USERNAME -c \
        "mkdir -p ${STEAMCMDDIR} \
        && cd ${STEAMCMDDIR} \
        && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - \
        && chmod 755 ./steamcmd.sh \
        && mkdir -p ${USERHOME}/.steam/sdk32 \
        && ln -sf ${STEAMCMDDIR}/linux32/steamclient.so ${USERHOME}/.steam/sdk32/steamclient.so \
        && mkdir -p ${SERVERDIR} \
        && { echo 'export LC_ALL=en_US.UTF-8'; \
             echo 'export LANG=en_US.UTF-8'; \
             echo 'export LANGUAGE=en_US.UTF-8'; } >> ~/.bashrc" \
    && apt-get remove --purge -y \
        wget \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $USERNAME
WORKDIR $STEAMCMDDIR

ENTRYPOINT ["./steamcmd.sh"]