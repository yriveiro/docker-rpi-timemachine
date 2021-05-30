FROM arm32v7/alpine:3
LABEL maintainer="yago.riveiro@gmail.com"

ADD https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-arm.tar.gz /tmp/s6-overlay-arm.tar.gz

ENV DEBUG=${DEBUG:-0}
ENV UID=${UID:-1000}
ENV GID=${GID:-1000}
ENV MIMIC_MODEL=${MIMIC_MODEL:-TimeCapsule8,119}
ENV SHARE_NAME=${SHARE_NAME:-"time-machine-rpi"}
ENV SMB_PORT=${SMB_PORT:-445}
ENV VOLUME_SIZE_LIMIT=${VOLUME_SIZE_LIMIT:-400G}
ENV HIDE_SHARES=${HIDE_SHARES:-no}
ENV WORKGROUP=${WORKGROUP:-WORKGROUP}


RUN addgroup -g "${GID}" timemachine && \
    adduser -u "${UID}" -G timemachine -h "/opt/timemachine" -s /bin/false \
    -D timemachine

RUN apk add --no-cache --purge -U \
        curl \
        bash \
        avahi\
        avahi-compat-libdns_sd \
        avahi-tools \
        dbus \
        samba-common-tools \
        s6 \
        samba-server && \
    apk del --purge curl && \
    tar xzf /tmp/s6-overlay-arm.tar.gz -C / && \
    rm /tmp/s6-overlay-arm.tar.gz && \
    mkdir /var/lib/timemachine && \
    mkdir -p /var/lib/samba/private && \
    chmod 700 /var/lib/samba/private && \
    mkdir -p /var/log/samba/cores && \
    chmod 700 /var/log/samba/cores && \
    touch /etc/samba/lmhosts && \
    rm /etc/samba/smb.conf && \
    rm /etc/avahi/services/*.service && \
    rm -rf /var/cache/apk/* /tmp/*

COPY s6 /etc/s6/services
COPY lib/ /usr/local/lib/timemachine/
COPY start_up.sh /start_up.sh

RUN --mount=type=secret,id=password cat /var/run/secrets/password
RUN /start_up.sh

ENTRYPOINT ["/init"]
