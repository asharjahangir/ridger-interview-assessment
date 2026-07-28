# Task 1: VM Setup / 虚拟机设置

## English

### Environment
- **Host**: MacBook Air M2 (Apple Silicon, ARM64)
- **Emulator**: QEMU 9.x via UTM with x86_64 TCG emulation
- **Guest OS**: XigmaNAS 14.3.0.5 (FreeBSD 14.3-RELEASE based)
- **ISO**: XigmaNAS-x64-LiveCD-14.3.0.5.10566.iso (718 MB)

### Installation Steps

1. **Create the virtual disk** (40GB):
   ```bash
   qemu-img create -f qcow2 disk.qcow2 40G
   ```

2. **VM configuration** (UTM):
   - Architecture: x86_64 (QEMU TCG emulation)
   - CPU: 2 cores
   - RAM: 2048 MB
   - Disk: 40GB VirtIO
   - Network: Shared (vmnet) → DHCP → 192.168.64.2
   - Boot: Legacy BIOS (not UEFI)
   - Display: virtio-vga

3. **Install**: Boot from ISO → Console menu → "Full Install" → GPT partition → UFS filesystem

4. **Post-install**: Eject ISO → Reboot from disk

5. **Configure network**: Console menu → Option 2 → DHCP enabled

6. **Web GUI**: http://192.168.64.2 (admin / xigmanas)

### VM Details
- **Hostname**: xigmanas.internal
- **IP**: 192.168.64.2 (DHCP via UTM shared networking)
- **Web GUI**: http://192.168.64.2
- **SSH**: ssh root@192.168.64.2 (password: xigmanas)
- **Storage**: 40GB disk → 3GB OS + 1GB swap + 35GB data

---

## 中文

### 环境
- **主机**: MacBook Air M2 (Apple Silicon, ARM64)
- **模拟器**: 通过 UTM 运行的 QEMU 9.x，x86_64 TCG 模拟
- **客户系统**: XigmaNAS 14.3.0.5（基于 FreeBSD 14.3-RELEASE）
- **ISO**: XigmaNAS-x64-LiveCD-14.3.0.5.10566.iso（718 MB）

### 安装步骤

1. **创建虚拟磁盘**（40GB）
2. **VM 配置**：x86_64 架构，2 CPU，2048 MB RAM，40GB VirtIO 磁盘，共享网络，Legacy BIOS
3. **安装**：从 ISO 启动 → 控制台菜单 → "完整安装" → GPT 分区 → UFS 文件系统
4. **重启**：从磁盘启动
5. **配置网络**：控制台菜单 → DHCP
6. **访问 Web 界面**：http://192.168.64.2（admin / xigmanas）

### 虚拟机详情
- **主机名**: xigmanas.internal
- **IP**: 192.168.64.2（DHCP）
- **Web GUI**: http://192.168.64.2
- **SSH**: ssh root@192.168.64.2（密码: xigmanas）
- **存储**: 40GB 硬盘 → 3GB 系统 + 1GB 交换 + 35GB 数据