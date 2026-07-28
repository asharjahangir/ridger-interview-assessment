# Task 1: Storage Configuration / 存储配置

## Overview / 概述

**English:** Storage services configured on the XigmaNAS VM via the web GUI.

**中文:** 通过 Web GUI 在 XigmaNAS 虚拟机上配置的存储服务。

---

## Services Configured / 已配置的服务

### 1. Web GUI (Lighttpd)

| Item / 项目 | Detail / 详情 |
|-------------|--------------|
| Port / 端口 | 80 (HTTP) |
| URL | http://192.168.64.2 |
| Credentials / 登录 | admin / xigmanas |
| Purpose / 用途 | Full visual configuration of all NAS services / NAS 服务的可视化配置管理 |

### 2. SSH Service / SSH 服务

| Item / 项目 | Detail / 详情 |
|-------------|--------------|
| Port / 端口 | 22 |
| Access / 访问 | `ssh root@192.168.64.2` (password: xigmanas) |
| Purpose / 用途 | Command-line management / 命令行管理 |

### 3. ZFS Storage Pool / ZFS 存储池

| Item / 项目 | Detail / 详情 |
|-------------|--------------|
| Pool name / 池名称 | `storage` |
| Dataset / 数据集 | `storage/share` → mounted at `/mnt/storage` |
| Capacity / 容量 | ~35 GB usable |
| Features / 功能 | Compression (lz4), snapshots, data integrity checksums / 压缩、快照、数据完整性校验 |

### 4. Samba (SMB/CIFS) / 文件共享

| Item / 项目 | Detail / 详情 |
|-------------|--------------|
| Workgroup / 工作组 | WORKGROUP |
| Share name / 共享名称 | `storage` |
| Path / 路径 | `/mnt/storage/share` |
| Access / 访问 | Guest (anonymous) + local user authentication / 访客 + 本地用户认证 |
| NetBIOS name / 名称 | XIGMANAS |

## Configuration Steps / 配置步骤

**English:**

1. **Storage → ZFS → Pool Manager**: Create pool `storage` from available disk
2. **Storage → ZFS → Datasets**: Create `storage/share` dataset
3. **Services → Control**: Enable Samba (SMB/CIFS)
4. **Services → SMB: Shares**: Add share → path `/mnt/storage/share`
5. **Access**: From any computer on the same network, connect to `\\192.168.64.2\storage`

**中文：**

1. **存储 → ZFS → 池管理器**：从可用磁盘创建池 `storage`
2. **存储 → ZFS → 数据集**：创建 `storage/share` 数据集
3. **服务 → 控制**：启用 Samba
4. **服务 → SMB: 共享**：添加共享 → 路径 `/mnt/storage/share`
5. **访问**：同一网络的电脑，连接到 `\\192.168.64.2\storage`

## Demo Checklist / 演示清单

- [ ] Dashboard / 仪表盘 → System Information, CPU, RAM, disk usage / 系统信息
- [ ] Storage → ZFS Pool → pool status, space usage / 池状态、空间使用
- [ ] Storage → Disks → SMART information / 磁盘健康信息
- [ ] Services → Samba → share configuration / 共享配置
- [ ] Network → Interface → IP configuration / 网络配置