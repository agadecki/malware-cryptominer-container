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

### Aqua Scanner

### Trivy Scanner

```bash
❯ trivy image malware-cryptominer-container
2022-11-04T13:11:21.290+0100    INFO    Need to update DB
2022-11-04T13:11:21.290+0100    INFO    DB Repository: ghcr.io/aquasecurity/trivy-db
2022-11-04T13:11:21.290+0100    INFO    Downloading DB...
34.84 MiB / 34.84 MiB [-------------------------------------------------------------------------------------------------------------------------------------------] 100.00% 9.95 MiB p/s 3.7s
2022-11-04T13:11:33.727+0100    INFO    Vulnerability scanning is enabled
2022-11-04T13:11:33.727+0100    INFO    Secret scanning is enabled
2022-11-04T13:11:33.727+0100    INFO    If your scanning is slow, please try '--security-checks vuln' to disable secret scanning
2022-11-04T13:11:33.727+0100    INFO    Please see also https://aquasecurity.github.io/trivy/v0.34/docs/secret/scanning/#recommendation for faster secret detection
2022-11-04T13:11:34.675+0100    INFO    Detected OS: alpine
2022-11-04T13:11:34.676+0100    INFO    Detecting Alpine vulnerabilities...
2022-11-04T13:11:34.677+0100    INFO    Number of language-specific files: 0

malware-cryptominer-container (alpine 3.16.2)

Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)
```

### Prisma Cloud Scanner

### Wiz.io Scanner

```bash
❯ wizcli docker scan --image malware-cryptominer-container
           _            _ _
 __      _(_)____   ___| (_)
 \ \ /\ / / |_  /  / __| | |
  \ V  V /| |/ /  | (__| | |
   \_/\_/ |_/___|  \___|_|_|
 SUCCESS  Ready to scan Docker image malware-cryptominer-container
 SUCCESS  Scanned Docker image
 SUCCESS  Docker image scan analysis ready
Evaluated policy: Default vulnerabilities policy
Vulnerabilities: CRITICAL: 0, HIGH: 0, MEDIUM: 0, LOW: 0, INFORMATIONAL: 0
    Total: 0, out of which 0 are fixable
    Scan was successfully performed and no vulnerabilities were detected
Scan results: PASSED. Container image meets policy requirements
```

### Anchore - Grype Scanner

```bash
❯ grype malware-cryptominer-container --scope all-layers
 ✔ Vulnerability DB        [updated]
 ✔ Loaded image
 ✔ Parsed image
 ✔ Cataloged packages      [32 packages]
 ✔ Scanned image           [0 vulnerabilities]

No vulnerabilities found
```

### Snyk Scanner

```bash
❯ docker scan malware-cryptominer-container

Testing malware-cryptominer-container...

Package manager:   apk
Project name:      docker-image|malware-cryptominer-container
Docker image:      malware-cryptominer-container
Platform:          linux/amd64
Base image:        alpine:3.16.2

✔ Tested 18 dependencies for known vulnerabilities, no vulnerable paths found.

According to our scan, you are currently using the most secure version of the selected base image

For more free scans that keep your images secure, sign up to Snyk at https://dockr.ly/3ePqVcp
```

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
