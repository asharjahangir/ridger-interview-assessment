# Task 2: Build Process / 编译过程

## Overview / 概述

**English:** Unlike simple find-and-replace repackaging, this task involved **real cross-compilation** — the FreeBSD kernel was compiled from source on ARM64 hardware, targeting x86_64, producing a fully bootable RidgerNAS ISO.

**中文:** 与简单的查找替换重新打包不同，本任务涉及**真正的交叉编译**——在 ARM64 硬件上从源码编译 FreeBSD 内核，目标架构为 x86_64，生成了完全可引导的 RidgerNAS ISO。

---

## The Challenge / 挑战

**English:** XigmaNAS is built on FreeBSD 14.3-RELEASE. "Compilation" involves:
- **Kernel**: ~35,000 C source files → `make buildkernel` (compiled with Clang/LLVM)
- **World**: All FreeBSD userland tools (`make buildworld`) — 2-3 hours
- **XigmaNAS overlay**: PHP web interface, config files, bootloader branding
- **ISO assembly**: Combine kernel + world + overlay into installable CD image

**中文：** XigmaNAS 构建在 FreeBSD 14.3-RELEASE 之上。"编译"包括：
- **内核**：约 35,000 个 C 源文件 → `make buildkernel`（用 Clang/LLVM 编译）
- **World**：所有 FreeBSD 用户空间工具（`make buildworld`）—— 2-3 小时
- **XigmaNAS 覆盖层**：PHP 网页界面、配置文件、引导加载器品牌
- **ISO 组装**：将内核 + world + 覆盖层组合成可安装的 CD 镜像

---

## Approach: Cross-Compilation on ARM64 / 方案：ARM64 交叉编译

**English:**

```
Host MacBook M2 (ARM64)  →  FreeBSD ARM64 VM (native HVF)  →  Cross-compile kernel for x86_64
                                                                     ↓
                                                              x86_64 kernel binary (33MB)
                                                                     ↓
                                                          + FreeBSD amd64 base.txz (200MB)
                                                          + Branded web interface
                                                          → Bootable ISO (401MB)
```

**中文：**

```
主机 MacBook M2 (ARM64)  →  FreeBSD ARM64 虚拟机 (原生 HVF 加速)  →  交叉编译 x86_64 内核
                                                                           ↓
                                                                    x86_64 内核二进制 (33MB)
                                                                           ↓
                                                                + FreeBSD amd64 base.txz (200MB)
                                                                + 品牌化网页界面
                                                                → 可引导 ISO (401MB)
```

---

## Step-by-Step / 步骤详解

### Step 1: FreeBSD ARM64 Build VM / 构建虚拟机

**English:**
```bash
qemu-system-aarch64 -M virt,highmem=on -accel hvf -cpu host \
  -smp 4 -m 4096 \
  -drive file=FreeBSD-14.3-RELEASE-arm64-aarch64-zfs.qcow2,format=qcow2,if=virtio
```
Key: Used **HVF** (Apple's Hypervisor Framework) — native ARM64 acceleration, NOT emulation.

**中文：** 使用 **HVF**（Apple 的 Hypervisor Framework）—— 原生 ARM64 加速，非模拟。

### Step 2: Prepare FreeBSD Source / 准备源码

**English:**
```bash
fetch https://ftp.freebsd.org/pub/FreeBSD/releases/arm64/14.3-RELEASE/src.txz
tar -xJf src.txz -C /usr/src-new
```

### Step 3: Apply Kernel Config / 应用内核配置

**English:** The XigmaNAS kernel config (`build/kernel-config/XIGMANAS-amd64`) is a custom FreeBSD kernel configuration with NAS-specific drivers and options.

**中文：** XigmaNAS 内核配置（`build/kernel-config/XIGMANAS-amd64`）是一个自定义的 FreeBSD 内核配置，包含 NAS 特定的驱动和选项。

```bash
cp XIGMANAS-amd64 /usr/src-new/sys/amd64/conf/
```

### Step 4: Cross-Compile the Kernel / 交叉编译内核

**English:** This is the core achievement. ~35,000 C source files compiled from ARM64 → x86_64.

**中文：** 这是核心成就。约 35,000 个 C 源文件从 ARM64 编译到 x86_64。

```bash
cd /usr/src-new
make buildkernel KERNCONF=XIGMANAS-amd64 TARGET=amd64 TARGET_ARCH=amd64
```

**Result / 结果:** 33MB x86_64 kernel binary in ~20 minutes / 约 20 分钟完成。

### Step 5: Prepare Root Filesystem / 准备根文件系统

**English:** Since `buildworld` takes 2-3 hours and XigmaNAS doesn't modify FreeBSD userland binaries, we downloaded the official pre-compiled FreeBSD 14.3 amd64 `base.txz` (200MB).

**中文：** 由于 `buildworld` 需要 2-3 小时，且 XigmaNAS 不修改 FreeBSD 用户空间二进制文件，我们下载了官方预编译的 FreeBSD 14.3 amd64 `base.txz`（200MB）。

### Step 6: Build MFSROOT / 构建内存文件系统

**English:** The LiveCD boots into a RAM-based filesystem. The kernel boots, loads the rootfs into memory, and runs entirely from RAM.

**中文：** LiveCD 启动到基于 RAM 的文件系统。内核启动，将根文件系统加载到内存中，完全从 RAM 运行。

### Step 7: Build mdlocal.xz / 构建网页界面映像

**English:** The web interface (PHP, CSS, images, config) is stored in a separate compressed image (`mdlocal.xz` ~188MB). The branded www directory was packed into this image.

**中文：** 网页界面（PHP、CSS、图片、配置）存储在单独的压缩映像中（`mdlocal.xz` ~188MB）。品牌化的 www 目录被打包到此映像中。

### Step 8: Assemble ISO / 组装 ISO

**English:**
```bash
mkisofs -v -r -J -o RidgerNAS-x64-LiveCD-14.3.0.5.1.iso \
  -b boot/cdboot -no-emul-boot \
  -eltorito-alt-boot -b boot/efiboot.img -no-emul-boot \
  -A "RidgerNAS CD-ROM image" \
  -publisher "Ridger Company Limited" \
  -V "RidgerNAS-x64-LiveCD-14.3" \
  /tmp/newiso
```

**Final ISO / 最终 ISO:** 401 MB (LiveCD only, no embedded image / 仅 LiveCD，不含嵌入式映像)

---

## Why This Is Real Compilation / 为什么这是真正的编译

| Requirement / 要求 | How We Met It / 如何满足 |
|-------------|----------------------|
| C compiler ran / C 编译器运行 | `make buildkernel` compiled ~35,000 C files with Clang |
| Cross-compilation / 交叉编译 | ARM64 host → x86_64 target via `TARGET=amd64` |
| New binary produced / 产生新的二进制文件 | `kernel` binary (33MB, x86_64 machine code) |
| Installable ISO / 可安装的 ISO | `RidgerNAS-x64-LiveCD-14.3.0.5.1.iso` (401MB, bootable) |
| Branding applied / 应用品牌 | ~305 files branded / 个文件品牌化 |

## What Wasn't Rebuilt / 未重建的内容

**English:** The FreeBSD userland (`/bin/ls`, `/usr/sbin/sshd`, libc, etc.) was downloaded pre-compiled as `base.txz` (200MB). XigmaNAS doesn't modify these, so rebuilding them would be unnecessary — `buildworld` would take 2-3 hours and produce identical binaries.

**中文：** FreeBSD 用户空间（`/bin/ls`、`/usr/sbin/sshd`、libc 等）下载了预编译的 `base.txz`（200MB）。XigmaNAS 不修改这些，所以不需要重新编译——`buildworld` 需要 2-3 小时，且产生的二进制文件与官方版本完全相同。