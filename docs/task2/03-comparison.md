# Task 2: Comparison — Original vs. Modified / 原始与修改版本对比

## Overview / 概述

**English:** Side-by-side comparison of the original XigmaNAS and the compiled RidgerNAS.

**中文:** 原始 XigmaNAS 与编译的 RidgerNAS 的并排对比。

---

## ISO Comparison / ISO 对比

| File / 文件 | Size / 大小 | Description / 描述 |
|-------------|------------|-------------------|
| `XigmaNAS-x64-LiveCD-14.3.0.5.10566.iso` | 718 MB | Original XigmaNAS (includes embedded image / 含嵌入式映像) |
| `RidgerNAS-x64-LiveCD-14.3.0.5.1.iso` | 401 MB | Compiled RidgerNAS (LiveCD only, no embedded / 仅 LiveCD) |

## VM Comparison / 虚拟机对比

| Aspect / 方面 | Original (XigmaNAS) | Compiled (RidgerNAS) |
|---------------|--------------------|----------------------|
| **VM Software / 虚拟机软件** | UTM (QEMU TCG) | QEMU directly (TCG) |
| **IP Address / IP 地址** | 192.168.64.2 | localhost:8081 (HTTPS) |
| **Web GUI / 管理界面** | XigmaNAS WebGUI | RidgerNAS WebGUI |
| **Bootloader / 引导加载器** | "Welcome to XigmaNAS" | "Welcome to RidgerNAS" |
| **Kernel / 内核** | Original FreeBSD 14.3 kernel | **Cross-compiled kernel** (33MB, x86_64) |
| **Userland / 用户空间** | Original FreeBSD binaries | FreeBSD 14.3 base.txz (pre-compiled) |
| **Web Files / 网页文件** | Original XigmaNAS | **Branded ~305 files** → "RidgerNAS" |
| **Hostname / 主机名** | xigmanas.internal | ridgernas.local |
| **Login Logo / 登录标识** | XigmaNAS logo | Custom RidgerNAS logo |
| **Favicon / 网站图标** | XigmaNAS icon | Custom "R" icon |
| **Samba NetBIOS** | XIGMANAS | RIDGERNAS |

## What Was Changed / 变更内容

| Category / 类别 | Files / 文件数 | Details / 详情 |
|----------------|--------------|----------------|
| PHP/INC source / 源码 | ~290 files | All "XigmaNAS" → "RidgerNAS" |
| CSS files / 样式文件 | ~15 files | Color references, branding / 颜色引用、品牌 |
| Bootloader / 引导加载器 | `brand-XigmaNAS.4th` | Boot splash, menu title / 启动画面、菜单标题 |
| Kernel config / 内核配置 | `XIGMANAS-amd64` | Renamed, cross-compiled / 重命名、交叉编译 |
| Images / 图片 | 4 assets / 个资源 | Logo, favicon, splash, login |
| Config files / 配置文件 | `prd.name`, `loader.conf` | Product identity / 产品标识 |
| ISO metadata / 元数据 | Volume label, publisher / 卷标、发布者 | "Ridger Company Limited" |

## What Was NOT Changed / 未变更的内容

- FreeBSD kernel functionality / 内核功能 (same drivers, same behavior)
- All NAS features / 所有 NAS 功能 (Samba, ZFS, iSCSI, FTP, NFS)
- Security and authentication / 安全性和认证
- Package versions / 软件包版本

## Boot Test Results / 启动测试结果

| Test / 测试 | Result / 结果 |
|-------------|--------------|
| BIOS boot / BIOS 引导 | ✅ SeaBIOS → CD Loader → BTX loader |
| Boot menu / 启动菜单 | ✅ "Welcome to RidgerNAS" |
| Kernel load / 内核加载 | ✅ Our compiled kernel loads / 我们编译的内核加载成功 |
| MFSROOT load / 根文件系统加载 | ✅ FreeBSD base + branded web / 品牌化系统加载成功 |
| Console menu / 控制台菜单 | ✅ Boots to console / 启动到控制台菜单 |
| Web GUI / 管理界面 | ✅ HTTPS port 8081 accessible / 可访问 |
| SSH / 远程访问 | ✅ Port 2224 accessible / 可访问 |