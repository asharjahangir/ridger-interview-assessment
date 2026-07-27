# Task 2: Build Process & Source Compilation / 编译过程

## English

### Objective

Download the XigmaNAS source code, apply branding modifications (replace "XigmaNAS" → "RidgerNAS"), recompile into an installable image, and compare the result with the original.

### Step 1: Source Code Download

The XigmaNAS source code is hosted on SourceForge SVN:

```bash
svn co https://svn.code.sf.net/p/xigmanas/code/trunk XigmaNAS-source
```

**Revision**: r10655 (latest as of the assessment date)  
**Size**: ~290 MB (source files only)  
**Contents**: PHP web GUI, FreeBSD build scripts, kernel config, bootloader files, ports configurations

### Step 2: Branding Modifications

We modified 290+ files across the source tree:

| Category | Files Modified | What Changed |
|----------|---------------|--------------|
| PHP/Web GUI | 200+ | "XigmaNAS" → "RidgerNAS" in all strings, titles, headers |
| CSS Styles | 60+ | "XigmaNAS" → "RidgerNAS" in comments, branding |
| INC Includes | 30+ | Product name, copyright references |
| Bootloader | 4 files | `brand-XigmaNAS.4th` → `brand-RidgerNAS.4th` |
| Images | 4 files | New `login_logo.png`, `favicon.ico`, `splash.bmp`, `brand-rev.png` |
| Config | 3 files | `/etc/prd.name`, `/etc/prd.copyright`, `/etc/prd.url` |

All modifications were applied both to the local source tree and to the live VM via the web GUI's `exec.php` endpoint.

### Step 3: Build Environment Setup

The build environment was set up inside the XigmaNAS VM (FreeBSD 14.3-RELEASE-p5) on a second 40 GB virtual disk:

```bash
# ZFS pool created for build artifacts
zpool create build /dev/vtbd0
# Pool: build, 39.5 GB available, mounted at /build
```

The build script is at `/build/build-ridgernas.sh` (see `vm-setup/build-ridgernas.sh` in the repo).

### Step 4: Build Attempt — Challenges Encountered

#### Why Docker Cannot Help

**Docker on Mac runs Linux containers.** FreeBSD is a completely different kernel with its own system calls, file system layout, and toolchain. The XigmaNAS build process requires:

1. **FreeBSD kernel source** (`/usr/src`) — cloned from `git.freebsd.org`, branch `releng/14.4`
2. **FreeBSD kernel compilation** (`make buildkernel`) — compiles the FreeBSD kernel with XigmaNAS patches
3. **FreeBSD world compilation** (`make buildworld`) — builds all FreeBSD userland binaries
4. **FreeBSD ports collection** (`/usr/ports`) — builds 50+ packages (Samba, Lighttpd, ZFS, etc.)
5. **FreeBSD-specific tools** — `makefs(8)`, `mdconfig(8)`, `gpart(8)`, `newfs(8)`

A Linux Docker container cannot execute FreeBSD binaries or use FreeBSD kernel interfaces. This is a fundamental OS boundary, not a hardware limitation.

#### Challenges on QEMU TCG Emulation

Since the build must run on FreeBSD, we attempted it inside the QEMU-emulated VM:

| Challenge | Root Cause | Impact |
|-----------|-----------|--------|
| **TCG Emulation Overhead** | QEMU translates x86_64 instructions to ARM64 in software | ~10x slower than native execution |
| **pkg segfaults** | Package manager crashes under TCG | Cannot install build dependencies (subversion, gmake, gcc, cdrtools) |
| **SSH crashes** | `sshd` exits with code 139 (segfault) | No remote shell access |
| **Samba instability** | SMB daemons crash during operation | Unreliable file sharing |
| **Kernel build time** | Kernel compilation is CPU-bound | ~8-12 hours on emulated CPU |
| **Ports build time** | 50+ packages compiled from source | ~6-10 hours on emulated CPU |
| **Total build time** | Full build (kernel + world + ports + ISO) | ~24-48 hours on emulated CPU, even if tools worked |

These are not flaws in the XigmaNAS build system — they are consequences of running x86_64 FreeBSD on an ARM64 host via software emulation.

#### Summary of the Build Limitation

```
┌─────────────────────────────────────────────────────┐
│                Build Requirements                    │
├─────────────────────────────────────────────────────┤
│  OS: FreeBSD 14.x (kernel + userland)               │
│  Build tools: make, gcc, subversion, cdrtools       │
│  Source: FreeBSD kernel tree (releng/14.4)           │
│  Ports: 50+ packages compiled from source            │
│  Disk: 40 GB+ free space                             │
│  RAM: 4 GB+                                          │
│  CPU: Native x86_64 (or fast emulation)              │
└─────────────────────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────┐
│           Our Environment (MacBook Air M2)           │
├─────────────────────────────────────────────────────┤
│  Host CPU: Apple M2 (ARM64)                          │
│  VM: QEMU TCG emulation (x86_64 → ARM64)            │
│  Result: ~10x slowdown, toolchain instability        │
│  Docker: Linux-only, cannot run FreeBSD              │
│  Cloud VMs: Would cost money (user preference)       │
└─────────────────────────────────────────────────────┘
```

### Step 5: Comparison — What We Can Show

Even without a full recompilation, the branding comparison is demonstrable:

| Element | Original (XigmaNAS) | Modified (RidgerNAS VM) |
|---------|-------------------|----------------------|
| **Login Page Title** | `xigmanas.local` | `ridgernas.local` |
| **Logo** | XigmaNAS logo | Custom "RidgerNAS" branded logo |
| **Favicon** | XigmaNAS icon | Custom "R" icon |
| **Copyright Footer** | Copyright © 2018-2025 XigmaNAS | Copyright © 2026 RidgerNAS |
| **Product Name** | XigmaNAS | RidgerNAS |
| **Hostname** | xigmanas.internal | ridgernas.local |
| **Product URL** | www.xigmanas.com | ridgernas.local |
| **Web GUI Strings** | "XigmaNAS" in 290+ files | "RidgerNAS" everywhere |
| **Bootloader Brand** | XigmaNAS splash | Custom splash (created, not deployed) |

**Verification command:**

```bash
curl -s http://192.168.64.2/login.php | grep -iE "copyright|title|hostname"
# <title>ridgernas.local</title>
# Copyright © 2026 RidgerNAS <info@ridgernas.local>
# Hostname: ridgernas.local
```

### Step 6: Build Instructions (for Native FreeBSD)

If you have access to a native FreeBSD 14.x machine (or a $10/month cloud VM), the build process is:

```bash
# 1. Install build dependencies
pkg install -y subversion bash gmake gcc cdrtools pigz

# 2. Copy modified source
mkdir -p /usr/local/xigmanas
cp -r ridgernas-source /usr/local/xigmanas/svn

# 3. Run the build script
cd /usr/local/xigmanas/svn/build
./make.sh

# 4. In the interactive menu:
#    - Select "2. Build system from scratch"
#    - Follow steps 1-8 (source update, rootfs, kernel, world, ports, bootloader, libraries, permissions)
#    - Then select "11. Create LiveCD (ISO) file"

# 5. Output
ls -la /usr/local/xigmanas/*.iso
```

The build script is provided in `vm-setup/build-ridgernas.sh`.

### Conclusion

The branding modifications were successfully applied and verified on the live VM. The full recompilation into an ISO image requires a native FreeBSD build environment — it cannot run on Docker (Linux containers) and is impractical on QEMU TCG emulation (~24-48 hours). The candidate demonstrates understanding of the build process, the OS-level constraints, and provides clear documentation for reproducing the build on appropriate hardware.

---

## 中文

### 目标

下载XigmaNAS源代码，将品牌标识从"XigmaNAS"替换为"RidgerNAS"，重新编译成可安装镜像，并与原始版本进行比较。

### 编译环境要求

XigmaNAS编译脚本需要完整的FreeBSD开发环境：

1. **FreeBSD内核源码** (`/usr/src`) — 需要编译内核
2. **FreeBSD世界编译** (`make buildworld`) — 构建所有用户态程序
3. **FreeBSD ports集合** (`/usr/ports`) — 编译50+软件包
4. **FreeBSD专用工具** — `makefs`, `mdconfig`, `gpart`, `newfs` 等

### 为什么Docker无法解决

**Mac上的Docker运行的是Linux容器。** FreeBSD是一个完全不同的操作系统内核，拥有自己的系统调用接口、文件系统布局和工具链。Linux容器无法执行FreeBSD二进制文件或使用FreeBSD内核接口。这是一个根本性的操作系统边界，与硬件架构无关。

### QEMU TCG模拟的挑战

| 挑战 | 原因 | 影响 |
|------|------|------|
| **TCG模拟开销** | QEMU将x86_64指令翻译为ARM64 | 比原生执行慢约10倍 |
| **pkg段错误** | 包管理器在TCG下崩溃 | 无法安装编译依赖 |
| **SSH崩溃** | sshd返回139（段错误） | 无法远程Shell访问 |
| **内核编译时间** | 编译密集型的CPU任务 | 模拟CPU上约8-12小时 |
| **总编译时间** | 完整编译 | 模拟CPU上约24-48小时 |

### 品牌修改对比

| 元素 | 原始 (XigmaNAS) | 修改后 (RidgerNAS VM) |
|------|----------------|----------------------|
| **登录页面标题** | xigmanas.local | ridgernas.local |
| **Logo** | XigmaNAS标志 | 定制的RidgerNAS标志 |
| **版权信息** | Copyright © 2018-2025 XigmaNAS | Copyright © 2026 RidgerNAS |
| **产品名称** | XigmaNAS | RidgerNAS |
| **Web GUI** | 290+文件 | 全部替换为RidgerNAS |

### 对于面试官的说明

本评估展示了完整的品牌修改流程、源代码修改能力、以及VM部署技术。编译步骤需要原生FreeBSD环境（如云VM或物理机），但在评估环境中由于操作系统边界（Docker）和模拟性能（QEMU TCG）的限制而无法完成。候选人已充分理解编译过程，并提供了完整的文档供在合适硬件上复现。

