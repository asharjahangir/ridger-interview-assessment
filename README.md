# 🏢 Ridger Company Limited — 开发测试题目

**Candidate**: Ashar Jahangir  
**Position**: Software Developer  
**Date**: July 2026  

---

## 📋 Overview / 概述

This repository contains the complete solution for the Ridger Company Limited technical interview assessment, covering three tasks:

本仓库包含 Ridger Company Limited 技术面试测试的完整解决方案，涵盖三个任务：

| Task / 任务 | Description / 描述 | Status / 状态 |
|-------------|-------------------|--------------|
| **Task 1** | Install XigmaNAS in a VM, 10-min presentation / 安装 XigmaNAS，配置存储服务，10分钟讲解 | ✅ Complete  |
| **Task 2** | Download XigmaNAS source, modify branding (Logo, Icon, strings), recompile / 下载源代码，修改品牌标识，重新编译 | ✅ Complete |
| **Task 3** | Showcase personal projects with architecture explanation / 展示个人项目成果 | ⏸️ Pending discussion |

---

## 🖥️ System Architecture / 系统架构

```
┌─────────────────────────────────────────────────────┐
│                   MacBook Air M2                     │
│                 (Apple Silicon, ARM64)                │
│                                                      │
│  ┌──────────────────────────────────────────────┐    │
│  │              QEMU (x86_64 emulation)          │    │
│  │  ┌─────────────────────────────────────────┐  │    │
│  │  │         XigmaNAS / RidgerNAS VM          │  │    │
│  │  │  • FreeBSD 14.3-RELEASE                 │  │    │
│  │  │  • 40GB virtual disk                    │  │    │
│  │  │  • 2GB RAM, 2 CPU cores (emulated)      │  │    │
│  │  │  • SSH :2222 → :22                      │  │    │
│  │  │  • Web GUI :8888 → :80                  │  │    │
│  │  └─────────────────────────────────────────┘  │    │
│  └──────────────────────────────────────────────┘    │
│                                                      │
│  Source Code: XigmaNAS SVN r10655                    │
│  Branding: XigmaNAS → RidgerNAS                      │
│  Build: FreeBSD 11.2+ build environment               │
└─────────────────────────────────────────────────────┘
```

---

## 🚀 Quick Start / 快速开始

### Prerequisites / 前提条件

```bash
# macOS (Homebrew)
brew install qemu tigervnc-viewer subversion

# Ubuntu/Debian
sudo apt install qemu-system-x86 qemu-kvm xvnc4viewer subversion
```

### Run the VM / 运行虚拟机

```bash
cd vm-setup
./start-vm.sh        # Start the XigmaNAS VM
# Web GUI: http://localhost:8888
# SSH: ssh -p 2222 root@localhost (password: xigmanas)
```

---

## 📚 Documentation / 文档

| File / 文件 | English / 英文 | 中文 / Chinese |
|-------------|---------------|----------------|
| [Task 1: VM Setup](docs/task1/01-vm-setup.md) | ✅ | ✅ |
| [Task 1: Presentation Notes](docs/task1/03-presentation-notes.md) | ✅ | ✅ |
| [Task 2: Branding Modifications](docs/task2/01-branding-changes.md) | ✅ | ✅ |
| [Task 2: Build Process](docs/task2/02-build-process.md) | ✅ | ✅ |
| [Task 2: Comparison](docs/task2/03-comparison.md) | ✅ | ✅ |
| [Task 3: Project Showcase](docs/task3/01-personal-projects.md) | ✅ | ✅ |

---

## 🔧 Task 1: XigmaNAS Installation

### Step 1: Download the ISO

```bash
# Download XigmaNAS 14.3.0.5 (x64 LiveCD)
wget https://sourceforge.net/projects/xigmanas/files/XigmaNAS-14.3.0.5/14.3.0.5/XigmaNAS-x64-LiveCD-14.3.0.5.iso/download -O XigmaNAS-x64-LiveCD-14.3.0.5.iso
# Size: ~685 MB
```

### Step 2: Create the VM (UTM on macOS)

| Setting | Value |
|---------|-------|
| Architecture | x86_64 (emulated via QEMU) |
| System | FreeBSD 14 |
| RAM | 2 GB |
| CPU | 2 cores |
| Disk | 40 GB (IDE) |
| Network | Shared (vmnet) → DHCP |
| ISO | XigmaNAS-x64-LiveCD-14.3.0.5.iso |

### Step 3: Install to Disk

1. Boot from ISO → "Welcome to XigmaNAS" menu
2. Press **9** for Install → select "Full Install on HDD + DATA + SWAP"
3. Choose GPT partition scheme → confirm
4. After installation, remove the ISO from the VM's CD drive and reboot
5. The VM boots to the console configuration menu

### Step 4: Access the Web GUI

- Check the IP on the console menu (Option 1: "Assign Network Interfaces")
- Open browser: `http://<vm-ip>`
- Default login: **admin / xigmanas**

### Key Challenges

| Challenge | Solution |
|-----------|----------|
| ARM64 → x86_64 emulation | QEMU TCG (slow but functional) |
| Web GUI not accessible | Set DHCP networking → assigned IP via console menu |
| Slow serial console | Use UTM GUI window for direct console access |

---

## 🎨 Task 2: Branding & Cross-Compilation

### Step 1: Download XigmaNAS Source Code

```bash
# Download from SVN (revision 10655)
svn checkout https://svn.code.sf.net/p/xigmanas/code/trunk XigmaNAS-source
# Size: ~124 MB, 818 files
```

### Step 2: Replace All Branding Strings

```bash
cd XigmaNAS-source

# Replace all three capitalizations across PHP, INC, CSS, JS, HTML, conf files
find . -type f \( -name "*.php" -o -name "*.inc" -o -name "*.css" -o -name "*.js" -o -name "*.html" -o -name "*.4th" -o -name "*.conf" \) \
  -exec sed -i '' \
  -e 's/XigmaNAS/RidgerNAS/g' \
  -e 's/xigmanas/ridgernas/g' \
  -e 's/XIGMANAS/RIDGERNAS/g' {} +
```

### Step 3: Update Branding Identity Files

These three files control the product name, URL, and copyright text shown throughout the web GUI:

```bash
# Product name (appears in page titles, headers, emails)
echo "RidgerNAS" > etc/prd.name

# Product URL (appears in footer links and documentation)
echo "ridgernas.local" > etc/prd.url

# Copyright string (appears in page footers)
echo "Copyright © 2018-2026 RidgerNAS <info@ridgernas.local>" > etc/prd.copyright
```

### Step 4: Replace Logo Images

Replace the two image files in the source tree:

| File | What it is | Where it appears |
|------|-----------|-----------------|
| `www/images/login_logo.png` (300×72) | Login page logo | Top of login form and web GUI header |
| `www/favicon.ico` (32×32) | Browser tab icon | Browser tab, bookmarks |

```bash
# Copy your custom images into the source tree
cp /path/to/custom/login_logo.png www/images/login_logo.png
cp /path/to/custom/favicon.ico www/favicon.ico
```

### Step 5: Verify All Changes

```bash
# Should output 0 — no XigmaNAS references remaining
grep -r "XigmaNAS" --include="*.php" --include="*.inc" --include="*.css" --include="*.conf" --include="*.4th" . | wc -l
```

Result: **305 files modified**, zero remaining references to XigmaNAS.

### Step 6: Cross-Compile & Build the ISO

See [docs/task2/02-build-process.md](docs/task2/02-build-process.md) for the full build process.

Summary: Since the build machine is ARM64 (Apple Silicon) and the target is x86_64, the kernel must be cross-compiled:

1. Set up a FreeBSD 14.3 build VM (AArch64, native)
2. Cross-compile the x86_64 kernel using FreeBSD's build system
3. Extract the original ISO's `mdlocal.xz` (1.3GB — the web GUI filesystem)
4. Modify the UFS image with branded web files
5. Repack and assemble the final ISO (401MB)

```bash
# Build script reference
cd build
./make.sh
# Output: RidgerNAS-x64-LiveCD-14.3.0.5.iso
```

### Changes Summary

| Item | Original | Modified |
|------|----------|----------|
| Product Name | XigmaNAS | RidgerNAS |
| Hostname | xigmanas.local | ridgernas.local |
| Copyright | © 2018-2025 XigmaNAS | © 2026 RidgerNAS |
| Login Logo | XigmaNAS logo | Custom logo (300×72) |
| Favicon | XigmaNAS icon | Custom icon (32×32) |
| PHP/INC/CSS | 290+ files | All "XigmaNAS" → "RidgerNAS" |

---

## 📦 Repository Structure / 仓库结构

```
ridger-interview/
├── README.md                    # This file (English + 中文)
├── docs/
│   ├── task1/
│   │   ├── 01-vm-setup.md       # VM setup guide (双语)
│   │   └── 03-presentation-notes.md # 10-min presentation (双语)
│   ├── task2/
│   │   ├── 01-branding-changes.md # Branding modifications (双语)
│   │   ├── 02-build-process.md    # Build process (双语)
│   │   └── 03-comparison.md       # Original vs modified comparison (双语)
│   ├── task3/
│   │   └── 01-personal-projects.md # Personal project showcase (双语)
│   └── assets/
│       ├── logos/               # Custom branding images
│       └── screenshots/         # VM screenshots
├── vm-setup/
│   ├── start-vm.sh              # Script to start the VM
│   └── README.md                # VM management guide
└── branding/                    # Branding assets
```

---

## 📝 License / 许可

This project is for assessment purposes only.  
本项目仅用于评估目的。

XigmaNAS is licensed under the BSD 3-Clause License.  
Modified branding is for demonstration purposes only.
