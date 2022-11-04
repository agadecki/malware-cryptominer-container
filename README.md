# Container image with malware and crypto miner for testing purposes

[![Container build](https://github.com/ruzickap/malware-cryptominer-container/actions/workflows/container-build.yml/badge.svg)](https://github.com/ruzickap/malware-cryptominer-container/actions/workflows/container-build.yml)

I decided to build minimal [nginx](https://hub.docker.com/_/nginx) based
container image which contains the following malware / crypto miner:

- [eicar](https://www.eicar.org/download-anti-malware-testfile/)
- [xmrig](https://xmrig.com/)
- malware and ransomware from: <https://github.com/Da2dalus/The-MALWARE-Repo>

The malware/crypto miner are stored inside container in directory:

```bash
/usr/share/nginx/html/
├── 50x.html
├── Fantom.exe
├── MadMan.exe
├── eicar
│   ├── eicar.com
│   ├── eicar.com.txt
│   └── eicarcom2.zip
├── index.html
└── xmrig
    ├── xmrig
    └── xmrig-linux-static-x64.tar.gz
```

- Container Image: <quay.io/petr_ruzicka/malware-cryptominer-container>
- Container Registry: <https://quay.io/repository/petr_ruzicka/malware-cryptominer-container?tab=tags>

## Scanner tests

Few scanners which I used to identify the problems inside container image.
Output results will change in the future...

### Aqua Scanner

### Trivy Scanner

```bash
❯ trivy image quay.io/petr_ruzicka/malware-cryptominer-container
2022-11-04T22:58:02.108+0100    INFO    Need to update DB
2022-11-04T22:58:02.108+0100    INFO    DB Repository: ghcr.io/aquasecurity/trivy-db
2022-11-04T22:58:02.108+0100    INFO    Downloading DB...
34.83 MiB / 34.83 MiB [------------------------------------------------------------------------------------------------------------------------------] 100.00% 3.79 MiB p/s 9.4s
2022-11-04T22:58:13.347+0100    INFO    Vulnerability scanning is enabled
2022-11-04T22:58:13.347+0100    INFO    Secret scanning is enabled
2022-11-04T22:58:13.347+0100    INFO    If your scanning is slow, please try '--security-checks vuln' to disable secret scanning
2022-11-04T22:58:13.347+0100    INFO    Please see also https://aquasecurity.github.io/trivy/v0.34/docs/secret/scanning/#recommendation for faster secret detection
2022-11-04T22:58:16.227+0100    INFO    Detected OS: alpine
2022-11-04T22:58:16.227+0100    INFO    Detecting Alpine vulnerabilities...
2022-11-04T22:58:16.229+0100    INFO    Number of language-specific files: 0

quay.io/petr_ruzicka/malware-cryptominer-container (alpine 3.16.2)

Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)
```

### Prisma Cloud Scanner

### Wiz.io Scanner

```bash
❯ docker pull quay.io/petr_ruzicka/malware-cryptominer-container
❯ wizcli docker scan --image quay.io/petr_ruzicka/malware-cryptominer-container
           _            _ _
 __      _(_)____   ___| (_)
 \ \ /\ / / |_  /  / __| | |
  \ V  V /| |/ /  | (__| | |
   \_/\_/ |_/___|  \___|_|_|
 SUCCESS  Ready to scan Docker image quay.io/petr_ruzicka/malware-cryptominer-container
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
❯ grype --scope all-layers quay.io/petr_ruzicka/malware-cryptominer-container                                          7s
 ✔ Vulnerability DB        [no update available]
 ✔ Loaded image
 ✔ Parsed image
 ✔ Cataloged packages      [32 packages]
 ✔ Scanned image           [0 vulnerabilities]

No vulnerabilities found
```

### Snyk Scanner

```bash
❯ docker scan quay.io/petr_ruzicka/malware-cryptominer-container

Testing quay.io/petr_ruzicka/malware-cryptominer-container...

Package manager:   apk
Project name:      docker-image|quay.io/petr_ruzicka/malware-cryptominer-container
Docker image:      quay.io/petr_ruzicka/malware-cryptominer-container
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
docker run -it --rm --entrypoint=/bin/sh --user root -p 8080:8080 malware-cryptominer-container
```

Run in Kubernetes:

```bash
kubectl run malware-cryptominer --image=quay.io/petr_ruzicka/malware-cryptominer-container
```
