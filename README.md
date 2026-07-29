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

## 🔧 Task 1: XigmaNAS Installation / 安装

### Steps / 步骤

1. **Download ISO**: XigmaNAS 14.3.0.5 (685 MB) from SourceForge
2. **Create VM**: QEMU with x86_64 TCG emulation, 40GB disk, 2GB RAM
3. **Install**: Full Install to GPT partition — UFS filesystem
4. **Configure**: DHCP network, SSH, Web GUI
5. **Present**: 10-minute walkthrough of XigmaNAS architecture and features

### Key Challenges / 关键挑战

| Challenge | Solution |
|-----------|----------|
| ARM64 → x86_64 emulation | QEMU TCG (slow but functional) |
| Web GUI not accessible | Set DHCP networking → IP 10.0.2.15 |
| Slow serial console | VNC (localhost:5900) for screen interaction |

---

## 🎨 Task 2: Branding Modifications / 品牌修改

### Changes Made / 修改内容

| Item / 项目 | Original / 原版 | Modified / 修改版 |
|-------------|----------------|-------------------|
| Product Name | XigmaNAS | RidgerNAS |
| Hostname | xigmanas.local | ridgernas.local |
| Copyright | © 2018-2025 XigmaNAS | © 2026 RidgerNAS |
| Login Logo | XigmaNAS logo | Custom RidgerNAS logo (300×72) |
| Favicon | XigmaNAS icon | Custom RidgerNAS icon (32×32) |
| Meta Description | XigmaNAS Project | RidgerNAS Project |
| PHP/INC/CSS | 290+ files | All "XigmaNAS" → "RidgerNAS" |

### Files Modified / 修改的文件

```bash
# Source code modifications (290+ files)
XigmaNAS-source/
├── www/
│   ├── images/
│   │   ├── login_logo.png       # Web GUI login logo (300×72)
│   │   └── favicon.ico          # Favicon (32×32)
│   ├── fbegin.inc               # Meta description
│   └── *.php, *.inc, *.css      # 290+ files with string replacement
└── etc/
    ├── prd.name                 # Product name
    ├── prd.copyright            # Copyright string
    └── prd.url                  # Product URL
```

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
