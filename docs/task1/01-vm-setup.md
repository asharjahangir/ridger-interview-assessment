# Task 1: VM Setup / 虚拟机设置

## Overview / 概述

**English:** How the XigmaNAS virtual machine was created and configured.

**中文:** 如何创建和配置 XigmaNAS 虚拟机。

---

## Environment / 环境

| Item / 项目 | Detail / 详情 |
|-------------|--------------|
| Host / 主机 | MacBook Air M2 (Apple Silicon, ARM64) |
| VM Software / 虚拟机软件 | UTM (QEMU 9.x) |
| Emulation / 模拟模式 | x86_64 TCG (software emulation / 软件模拟) |
| Guest OS / 客户系统 | XigmaNAS 14.3.0.5 (FreeBSD 14.3-RELEASE based) |
| ISO / 安装镜像 | `XigmaNAS-x64-LiveCD-14.3.0.5.10566.iso` (718 MB) |

## Installation Steps / 安装步骤

**English:**

1. **Create virtual disk**: `qemu-img create -f qcow2 disk.qcow2 40G`
2. **VM Configuration (UTM)**:
   - Architecture: x86_64
   - CPU: 2 cores
   - RAM: 2048 MB
   - Disk: 40GB VirtIO
   - Network: Shared (vmnet) → DHCP → 192.168.64.2
   - Boot: Legacy BIOS (not UEFI)
3. **Install**: Boot from ISO → Console menu → "Full Install" → GPT partition → UFS filesystem
4. **Post-install**: Eject ISO → Reboot from disk
5. **Configure network**: Console menu → Option 2 → DHCP
6. **Web GUI**: http://192.168.64.2 (admin / xigmanas)

**中文：**

1. **创建虚拟磁盘**：`qemu-img create -f qcow2 disk.qcow2 40G`
2. **虚拟机配置（UTM）**：
   - 架构：x86_64
   - CPU：2 核
   - 内存：2048 MB
   - 磁盘：40GB VirtIO
   - 网络：共享模式 → DHCP → 192.168.64.2
   - 启动：Legacy BIOS（非 UEFI）
3. **安装**：从 ISO 启动 → 控制台菜单 → "完整安装" → GPT 分区 → UFS 文件系统
4. **安装后**：弹出 ISO → 从磁盘重启
5. **配置网络**：控制台菜单 → 选项 2 → DHCP
6. **Web 管理界面**：http://192.168.64.2（admin / xigmanas）

## VM Details / 虚拟机详情

| Item / 项目 | Value / 值 |
|-------------|-----------|
| Hostname / 主机名 | xigmanas.internal |
| IP Address / IP 地址 | 192.168.64.2 (DHCP) |
| Web GUI / 管理界面 | http://192.168.64.2 |
| SSH Access / SSH 访问 | ssh root@192.168.64.2 (password: xigmanas) |
| Storage / 存储 | 40GB disk → 3GB OS + 1GB swap + 35GB data |