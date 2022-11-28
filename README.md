# Container image with malware and crypto miner for testing purposes

[![Container build](https://github.com/ruzickap/malware-cryptominer-container/actions/workflows/container-build.yml/badge.svg)](https://github.com/ruzickap/malware-cryptominer-container/actions/workflows/container-build.yml)

![Ransomware](https://raw.githubusercontent.com/MISP/intelligence-icons/52d597bf00d58b92ee8809802b507c6d0755235f/svg/ransomware.svg)
![Malware](https://raw.githubusercontent.com/MISP/intelligence-icons/513abc840b7ac92e4f8a4a7ecab2964007bf25f5/svg/malware.svg)
![Threat Actor](https://raw.githubusercontent.com/MISP/intelligence-icons/513abc840b7ac92e4f8a4a7ecab2964007bf25f5/svg/threat_actor.svg)

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
├── Linux.Trojan.Multiverze.elf.x86
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

List of malware/ransomware/crypto miner files located in the container:

- [eicar com](https://secure.eicar.org/eicar.com)
  - [Virustotal](https://www.virustotal.com/gui/file/275a021bbfb6489e54d471899f7db9d1663fc695ec2fe2a2c4538aabf651fd0f)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/275a021bbfb6489e54d471899f7db9d1663fc695ec2fe2a2c4538aabf651fd0f/)
- [eicar txt](https://secure.eicar.org/eicar.com.txt)
  - [Virustotal](https://www.virustotal.com/gui/file/275a021bbfb6489e54d471899f7db9d1663fc695ec2fe2a2c4538aabf651fd0f)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/275a021bbfb6489e54d471899f7db9d1663fc695ec2fe2a2c4538aabf651fd0f/)
- [eicar zip](https://secure.eicar.org/eicarcom2.zip)
  - [Virustotal](https://www.virustotal.com/gui/file/e1105070ba828007508566e28a2b8d4c65d192e9eaf3b7868382b7cae747b397)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/e1105070ba828007508566e28a2b8d4c65d192e9eaf3b7868382b7cae747b397)
- Crypto Miner [xmrig](https://github.com/xmrig/xmrig/releases/download/v6.18.1/xmrig-6.18.1-linux-static-x64.tar.gz)
  - [Virustotal](https://www.virustotal.com/gui/file/99a082f0d801be63e26bb96473409c2f9d98629b453d907554b3a107efd284fe)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/99a082f0d801be63e26bb96473409c2f9d98629b453d907554b3a107efd284fe)
- Ransomware [WannaCry](https://github.com/Da2dalus/The-MALWARE-Repo/raw/master/Ransomware/WannaCry.exe)
  - [Virustotal](https://www.virustotal.com/gui/file/be22645c61949ad6a077373a7d6cd85e3fae44315632f161adc4c99d5a8e6844)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/be22645c61949ad6a077373a7d6cd85e3fae44315632f161adc4c99d5a8e6844)
- Virus [MadMan](https://github.com/Da2dalus/The-MALWARE-Repo/raw/master/Virus/MadMan.exe)
  - [Virustotal](https://www.virustotal.com/gui/file/17d81134a5957fb758b9d69a90b033477a991c8b0f107d9864dc790ca37e6a23)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/17d81134a5957fb758b9d69a90b033477a991c8b0f107d9864dc790ca37e6a23)
- Malware [Linux.Trojan.Multiverze](https://github.com/timb-machine/linux-malware/raw/main/malware/binaries/Linux.Trojan.Multiverze/0a5a7008fa1a17c8ee32ea4e2f7e25d7302f9dfc4201c16d793a1d03f95b9fa5.elf.x86)
  - [Virustotal](https://www.virustotal.com/gui/file/0a5a7008fa1a17c8ee32ea4e2f7e25d7302f9dfc4201c16d793a1d03f95b9fa5)
  - [Hybrid Analysis](https://www.hybrid-analysis.com/sample/0a5a7008fa1a17c8ee32ea4e2f7e25d7302f9dfc4201c16d793a1d03f95b9fa5)

## Container details

- Container Image:
  - quay.io/petr_ruzicka/malware-cryptominer-container:1.1.2
- Container Registry:
  - <https://quay.io/repository/petr_ruzicka/malware-cryptominer-container?tab=tags>
- Container build pipeline:
  - <https://github.com/ruzickap/malware-cryptominer-container/actions/workflows/container-build.yml>
- Dockerfile used for building the container:
  - <https://github.com/ruzickap/malware-cryptominer-container/blob/main/Dockerfile>

## CloudFormation

Run the EC2 instance with docker and the [quay.io/petr_ruzicka/malware-cryptominer-container](https://quay.io/repository/petr_ruzicka/malware-cryptominer-container?tab=tags)
container with SSM enabled (only console access):

```bash
# Create CloudFormation Stack
aws cloudformation create-stack --capabilities CAPABILITY_IAM --stack-name ${USER}-malware-cryptominer-container-test \
 --template-body file://EC2InstanceWithDockerSample.yaml \
 --tags Key=Name,Value=${USER}-malware-cryptominer-container-test \
        Key=used_for,Value=dev

# Delete CloudFormation Stack
aws cloudformation delete-stack --stack-name ${USER}-malware-cryptominer-container-test
```

## Scanner tests

Few scanners which I used to identify the problems inside container image.
Output results will change in the future...

> Scanner tests were executed on: 2022-11-28

### Aqua Scanner

```bash
❯ docker pull quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1
❯ docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock registry.aquasec.com/scanner:2022.4 \
  -H https://xxxxxxxxx.cloud.aquasec.com -U 'ruzickap-scanner-test' -P 'xxxxxxx' \
  scan --local --scan-malware --collect-sensitive quay.io/petr_ruzicka/malware-cryptominer-container:1.2.0

2022-11-28 09:57:00.385 INFO  Logger started with level INFO
2022-11-28 09:57:02.351 INFO  Registering with server {"os": "linux", "os_version": "", "registries": []}
2022-11-28 09:57:02.553 INFO  Successfully registered {"scanner_id": 8894}
2022-11-28 09:57:03.066 INFO  Starting Scan Image {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1"}
2022-11-28 09:57:03.376 INFO  Start getting image information from registry... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63"}
2022-11-28 09:57:03.376 INFO  Connecting to registry... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63"}
2022-11-28 09:57:03.380 INFO  Requesting authorization to pull image... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63"}
2022-11-28 09:57:03.386 INFO  Getting image manifest... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63"}
2022-11-28 09:57:03.394 INFO  Found several platforms matching request, choosing first one {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "selected": "amd64::linux:", "matches": ["amd64::linux:"]}
2022-11-28 09:57:03.394 INFO  Getting image history... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:03.394 INFO  Getting image metadata... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:03.495 INFO  Working with Layer Digest Ids {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:03.495 INFO  End getting image information from registry... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:", "seconds": 0}
2022-11-28 09:57:03.495 INFO  Start getting assurance policies from server... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:03.495 INFO  Getting assurance policies... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:03.703 INFO  End getting assurance policies from server... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:", "seconds": 0}
2022-11-28 09:57:03.703 INFO  Start fetching security feed from server... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:03.804 INFO  Latest security feeds need to be pulled from server. {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:04.042 INFO  Latest security feeds need to be pulled from server. {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:04.154 INFO  Latest security feeds need to be pulled from server. {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:04.267 INFO  End fetching security feed from server... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:", "seconds": 1}
2022-11-28 09:57:04.267 INFO  Start pulling image... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:04.267 INFO  Start pulling image in Dockerless mode... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:05.806 INFO  End pulling image in Dockerless mode... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:", "seconds": 1}
2022-11-28 09:57:05.806 INFO  End pulling image {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:", "seconds": 1}
2022-11-28 09:57:05.806 INFO  Start analyzing image layer by layer without Docker... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:05.806 INFO  Start analyzing image by layer without Docker... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:06.836 INFO  End analyzing image by layer without Docker... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:", "seconds": 1}
2022-11-28 09:57:06.836 INFO  End analyzing image layer by layer without Docker... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:06.836 INFO  Contacting CyberCenter... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:07.309 INFO  Start merging layers analysis... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:07.310 INFO  End merging layers analysis... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:", "seconds": 0}
2022-11-28 09:57:07.310 INFO  Start Contacting CyberCenter... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:07.528 INFO  End Contacting CyberCenter... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:", "seconds": 0}
2022-11-28 09:57:07.528 INFO  Start processing results... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:07.631 INFO  End processing results... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:", "seconds": 0}
2022-11-28 09:57:07.632 INFO  Start applying assurance policies... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:07.833 INFO  Applying image assurance policies... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:"}
2022-11-28 09:57:07.834 INFO  End applying assurance policies... {"registry": "", "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1", "requested platform": "amd64:::", "job ID": "083a6798-35ea-4072-bafe-4485e2afafd1", "server version": "2022.4.64c5032a63", "scanning platform": "amd64::linux:", "seconds": 0}
2022-11-28 09:57:10.372 INFO  Skipping file hash saving.
{
  "image": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1",
  "scan_started": {
    "seconds": 1669629423,
    "nanos": 66194361
  },
  "scan_duration": 4,
  "image_size": 21565163,
  "digest": "sha256:d2723bc94d508dbbc1e1cff6c220a2d477603949b2a174c9360faad39eee1f15",
  "metadata": {
    "repo_digests": [
      "quay.io/petr_ruzicka/malware-cryptominer-container@sha256:447d3dc3ac81de3ae443decbfd0bce5ec10561d4f916e80cd56be072331b63b4"
    ]
  },
  "os": "alpine",
  "version": "3.16.3",
  "image_assurance_results": {
    "checks_performed": [
      {
        "policy_id": 265,
        "policy_name": "mypolicy",
        "control": "root_user"
      },
    ...
    ...
    ...
    ]
  },
  "vulnerability_summary": {},
  "scan_options": {
    "scan_executables": true,
    "scan_sensitive_data": true,
    "scan_malware": true,
    "scan_files": true,
    "scan_timeout": 3600000000000,
    "manual_pull_fallback": true,
    "save_adhoc_scans": true,
    "use_cvss3": true,
    "dockerless": true,
    "system_image_platform": "amd64:::",
    "telemetry_enabled": true,
    "scan_elf": true,
    "enable_fast_scanning": true,
    "memoryThrottling": true,
    "suggest_os_upgrade": true,
    "seim_enabled": true,
    "adhoc_scan_retention": 30
  },
  "initiating_user": "ruzickap-scanner-test",
  "data_date": 1669618636,
  "pull_name": "quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1",
  "scan_id": 1262414,
  "required_image_platform": "amd64:::",
  "scanned_image_platform": "amd64::linux:",
  "security_feeds_used": {
    "executables": "ef4e6ffe9e909f"
  },
  "image_id": 2264896,
  "internal_digest_id": {
    "id": 187617
  },
  "local": true,
  "OriginFromHostImage": true,
  "CanSkipFileHashSave": true
}
2022-11-28 09:57:10.584 INFO  Deregistering from console
2022-11-28 09:57:10.686 INFO  Scan successfully completed.
```

![Aqua - Image details](./img/Aqua-Image_details.avif)
![Aqua - Images](./img/Aqua-Images.avif)

### Trivy Scanner

Live web scan: <https://trivy.dev/results/?image=quay.io/petr_ruzicka/malware-cryptominer-container:1.2.0>

```bash
❯ trivy image quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1
2022-11-28T11:00:41.908+0100  INFO  Vulnerability scanning is enabled
2022-11-28T11:00:41.909+0100  INFO  Secret scanning is enabled
2022-11-28T11:00:41.909+0100  INFO  If your scanning is slow, please try '--security-checks vuln' to disable secret scanning
2022-11-28T11:00:41.909+0100  INFO  Please see also https://aquasecurity.github.io/trivy/v0.34/docs/secret/scanning/#recommendation for faster secret detection
2022-11-28T11:00:41.960+0100  INFO  Detected OS: alpine
2022-11-28T11:00:41.960+0100  INFO  Detecting Alpine vulnerabilities...
2022-11-28T11:00:41.962+0100  INFO  Number of language-specific files: 0

quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1 (alpine 3.16.3)

Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)
```

### Prisma Cloud Scanner

(Files are extracted to the disk, where the scanner is running)

> Locally installed MS Defender is alerting - seems like the content of the
> container image is extracted to the disk during scan

```bash
❯ docker pull quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1
❯ twistcli images scan --address=https://us-west1.cloud.twistlock.com/xxxxxxxxxxxxxx --details --user xxxx --password xxxx quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1
Scan results for: image quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1 sha256:d2723bc94d508dbbc1e1cff6c220a2d477603949b2a174c9360faad39eee1f15

Vulnerabilities found for image quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1: total - 0, critical - 0, high - 0, medium - 0, low - 0
Vulnerability threshold check results: PASS

Compliance Issues
+----------+------------------------------------------------+
| SEVERITY |                  DESCRIPTION                   |
+----------+------------------------------------------------+
| critical | Image contains malware                         |
+----------+------------------------------------------------+
| high     | Image contains binaries used for crypto mining |
+----------+------------------------------------------------+

Compliance found for image quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1: total - 2, critical - 1, high - 1, medium - 0, low - 0
Compliance threshold check results: PASS
Link to the results in Console: https://app4.prismacloud.io/compute?computeState=/monitor/vulnerabilities/images/ci?search=sha256%3Ad2723bc94d508dbbc1e1cff6c220a2d477603949b2a174c9360faad39eee1f15
```

![Prisma Cloud - Image details](./img/Prisma_Cloud-Image_details.avif)

### Wiz.io Scanner

(Files are extracted to the disk, where the scanner is running)

> Locally installed MS Defender is alerting - seems like the content of the
> container image is extracted to the disk during scan

```bash
❯ docker pull quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1
❯ wizcli docker scan --image quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1
           _            _ _
 __      _(_)____   ___| (_)
 \ \ /\ / / |_  /  / __| | |
  \ V  V /| |/ /  | (__| | |
   \_/\_/ |_/___|  \___|_|_|
 SUCCESS  Ready to scan Docker image quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1
 SUCCESS  Scanned Docker image
 SUCCESS  Docker image scan analysis ready
Evaluated policy: Default vulnerabilities policy
Vulnerabilities: CRITICAL: 0, HIGH: 0, MEDIUM: 0, LOW: 0, INFORMATIONAL: 0
    Total: 0, out of which 0 are fixable
    Scan was successfully performed and no vulnerabilities were detected
Scan results: PASSED. Container image meets policy requirements
```

![Wiz CICD Scans - Container image](./img/Wiz-CICD_Scans-Container_image.avif)

### Anchore - Grype Scanner

(Files are extracted to the disk, where the scanner is running)

```bash
❯ grype --scope all-layers quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1
 ✔ Vulnerability DB        [updated]
 ✔ Loaded image
 ✔ Parsed image
 ✔ Cataloged packages      [32 packages]
 ✔ Scanned image           [0 vulnerabilities]

No vulnerabilities found
```

### Snyk Scanner

```bash
❯ docker scan quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1

Testing quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1...

Package manager:   apk
Project name:      docker-image|quay.io/petr_ruzicka/malware-cryptominer-container
Docker image:      quay.io/petr_ruzicka/malware-cryptominer-container:1.2.1
Platform:          linux/amd64
Base image:        alpine:3.16.3

✔ Tested 18 dependencies for known vulnerabilities, no vulnerable paths found.

According to our scan, you are currently using the most secure version of the selected base image

For more free scans that keep your images secure, sign up to Snyk at https://dockr.ly/3ePqVcp
```

![Snyk - Container image](./img/Snyk-Container_image.avif)

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
kubectl run malware-cryptominer --image=quay.io/petr_ruzicka/malware-cryptominer-container:1.2.0
```
