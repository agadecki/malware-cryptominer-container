# Container image with malware and crypto miner for testing purposes

I decided to build minimal [nginx](https://hub.docker.com/_/nginx) based
container image which contains the following malware / crypto miner:

* [eicar](https://www.eicar.org/download-anti-malware-testfile/)
* [xmrig](https://xmrig.com/)

The malware/crypto miner are stored inside container in directory:

```bash
/usr/share/nginx/html/
├── 50x.html
├── eicar
│   ├── eicar.com
│   ├── eicar.com.txt
│   └── eicarcom2.zip
├── index.html
└── xmrig
    ├── xmrig
    └── xmrig-linux-static-x64.tar.gz
```

## Scanner tests

Few scanners which I used to identify the problems inside container image.
Output results will change in the future...

### Trivy Scanner

### Prisma Cloud Scanner

### Wiz.io Scanner

### Anchore - Grype Scanner

### Snyk Scanner

## Local tests

Container build:

```bash
docker build . -t malware-cryptominer-container
```

Run container and download the malware file:

```bash
docker run -it --rm -p 8080:8080 malware-cryptominer-container

wget http://localhost:8080/xmrig/xmrig
wget http://localhost:8080/eicar/eicar.com
```

Debug container:

```bash
docker run -it --rm --entrypoint=/bin/sh -p 8080:8080 malware-cryptominer-container
```
