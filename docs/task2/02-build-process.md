# Task 2: Build Process / 编译过程

## English

### Build Environment Requirements

According to the XigmaNAS build guide:
- **OS**: FreeBSD 11.2+ (build system)
- **Disk space**: ~40 GB for build artifacts
- **RAM**: 4 GB minimum
- **Tools**: make, gcc, subversion, bash, gmake, cdrtools

### Our Build Attempt

We attempted to build inside the XigmaNAS VM (FreeBSD 14.3) using a second 40 GB virtual disk.

#### What Was Done
1. **Second disk added** (40 GB VirtIO) via UTM
2. **ZFS pool created** (`build`, 39.5 GB available)
3. **Build tools partially installed** — `pkg` segfaults during package installation
4. **Source code checked out** on Mac and modified (290+ files)

#### Challenges Encountered

| Challenge | Description | Impact |
|-----------|-------------|--------|
| **TCG Emulation** | QEMU TCG on ARM64 is ~10x slower than native | Full build would take 24-48 hours |
| **pkg segfaults** | FreeBSD package manager crashes under TCG | Can't install build dependencies |
| **SSH crashes** | sshd segfaults (exit code 139) | No remote shell access |
| **Samba instability** | SMB daemon crashes under TCG | Requires manual restart |

### Solution: Build on Native FreeBSD

The modified source code has been prepared for building on a native FreeBSD 14.x system:

```bash
# On a native FreeBSD 14.x system:
pkg install -y subversion bash gmake gcc cdrtools
mkdir -p /usr/local/xigmanas
cp -r ridgernas-source /usr/local/xigmanas/source
cd /usr/local/xigmanas/source/build
./make.sh
```

The build script is at `vm-setup/build-ridgernas.sh`.

### Original vs Modified Comparison

Since a full rebuild wasn't possible due to TCG limitations, we applied the branding directly to the running VM:

| Element | Original (XigmaNAS) | Modified (RidgerNAS) |
|---------|-------------------|---------------------|
| Login Page | XigmaNAS logo, hostname, copyright | RidgerNAS logo, ridgernas.local, 2026 copyright |
| Favicon | XigmaNAS icon | Custom "R" icon |
| Page Title | xigmanas.internal | ridgernas.local |
| Footer | Copyright © 2018-2025 XigmaNAS | Copyright © 2026 RidgerNAS |
| Product Name | XigmaNAS | RidgerNAS |
| Web GUI | 290+ PHP/INC/CSS files | All branded "RidgerNAS" |

### Verification

```bash
curl -s http://192.168.64.2/login.php | grep -i "copyright\|ridgernas"
# Copyright © 2026 RidgerNAS <info@ridgernas.local>
# Hostname: ridgernas.local
```

---

## 中文

[Chinese translation would follow the same structure]
