FROM python:3.11-alpine3.16 as build

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

# malware file
RUN set -eux && \
    wget -q -P /mnt/ https://github.com/Da2dalus/The-MALWARE-Repo/raw/master/Virus/MadMan.exe

# ransomeware
RUN set -eux && \
    wget -q -P /mnt/ https://github.com/Da2dalus/The-MALWARE-Repo/raw/master/Ransomware/WannaCry.exe

# linux malware
RUN set -eux && \
    wget -q -P /mnt/ https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Linux.Trojan.Multiverze/0a5a7008fa1a17c8ee32ea4e2f7e25d7302f9dfc4201c16d793a1d03f95b9fa5.elf.x86 -O Linux.Trojan.Multiverze.elf.x86 && \
    wget -q -P /mnt/ https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Linux.Trojan.ShellBot/acccf2fa4e21f2cd1d7305186e4c83d6cde5ee98f1b37022b70170533e399a89.elf.x86_64 -O Linux.Trojan.ShellBot.elf.x86_64

COPY README.md /

RUN set -eux && \
    pip install --no-cache-dir grip==4.6.1 && \
    grip /README.md --export /mnt/index.html

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
