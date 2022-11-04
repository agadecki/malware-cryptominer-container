FROM alpine:3.16 as build

# renovate: datasource=github-tags depName=xmrig/xmrig
ENV XMRIG_VERSION="6.18.1"

# xmrig
RUN set -eux && \
    mkdir /mnt/xmrig && \
    wget -q "https://github.com/xmrig/xmrig/releases/download/v${XMRIG_VERSION}/xmrig-${XMRIG_VERSION}-linux-static-x64.tar.gz" -O /mnt/xmrig/xmrig-linux-static-x64.tar.gz && \
    tar xvzf /mnt/xmrig/xmrig-linux-static-x64.tar.gz -C /mnt/xmrig/ --strip-components=1 "xmrig-${XMRIG_VERSION}/xmrig"

# eicar
RUN set -eux && \
    mkdir /mnt/eicar && \
    wget -q -P /mnt/eicar https://secure.eicar.org/eicar.com https://secure.eicar.org/eicar.com.txt https://secure.eicar.org/eicarcom2.zip

# private ssh key
# hadolint ignore=DL3018
RUN set -eux && \
    apk update && \
    apk add --no-cache openssh && \
    ssh-keygen -q -f "$HOME/.ssh/id_rsa" -N "" && \
    mv "$HOME/.ssh" /mnt/

# malware file
RUN set -eux && \
    wget -q -P /mnt/ https://github.com/Da2dalus/The-MALWARE-Repo/raw/master/Virus/MadMan.exe

# ransomeware
RUN set -eux && \
    wget -q -P /mnt/ https://github.com/Da2dalus/The-MALWARE-Repo/raw/master/Ransomware/Fantom.exe

####

FROM nginxinc/nginx-unprivileged:1.23-alpine-slim

COPY --from=build /mnt/ /usr/share/nginx/html/

RUN printf '%s\n' > /etc/nginx/conf.d/health.conf \
    'server {' \
    '    listen 8081;' \
    '    location / {' \
    '        access_log off;' \
    '        add_header Content-Type text/plain;' \
    '        return 200 "healthy\n";' \
    '    }' \
    '}'

USER nginx

#Healthcheck to make sure container is ready
HEALTHCHECK --interval=5m --timeout=3s CMD curl --fail http://localhost:8081 || exit 1
