# Task 1: VM Setup / 虚拟机设置

## English

### Environment
- **Host**: MacBook Air M2 (Apple Silicon, ARM64)
- **Emulator**: QEMU 9.x with x86_64 TCG emulation
- **Guest OS**: XigmaNAS 14.3.0.5 (FreeBSD 14.3-RELEASE based)
- **ISO**: XigmaNAS-x64-LiveCD-14.3.0.5.10566.iso (685 MB)

### Installation Steps

1. **Create the virtual disk**:
   ```bash
   qemu-img create -f qcow2 xigmanas-disk.qcow2 40G
   ```

2. **Start the installer** (boot from LiveCD ISO):
   ```bash
   qemu-system-x86_64 -machine q35 -m 2048 -smp 2 \
     -drive file=xigmanas-disk.qcow2,format=qcow2 \
     -cdrom XigmaNAS-x64-LiveCD-14.3.0.5.10566.iso \
     -boot d -vga std -vnc :0 \
     -device e1000,netdev=net0 \
     -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::8888-:80
   ```

3. **Install**: From the console menu, select "Full Install" → GPT partition → UFS filesystem (NOT ZFS for OS)

4. **Boot from disk**: After installation, restart without the CD-ROM:
   ```bash
   qemu-system-x86_64 -machine q35 -m 2048 -smp 2 \
     -drive file=xigmanas-disk.qcow2,format=qcow2 \
     -boot c -vga std -vnc :0 \
     -device e1000,netdev=net0 \
     -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::8888-:80
   ```

5. **Configure network**: Console menu → Option 2 → Use DHCP
   - The VM gets IP 10.0.2.15 (QEMU internal NAT)

6. **Access web GUI**: http://localhost:8888 (admin / xigmanas)

### Troubleshooting

| Problem | Solution |
|---------|----------|
| VM won't boot from disk | Use `gptboot` (UFS/GPT), NOT `gptzfsboot` (ZFS) |
| Web GUI not accessible | Set DHCP, or bind lighttpd to 0.0.0.0 |
| Serial console empty | Use VNC at localhost:5900 instead |
| Slow keystrokes | Use QEMU monitor `sendkey` or console menu |

---

## 中文

### 环境
- **主机**: MacBook Air M2 (Apple Silicon, ARM64)
- **模拟器**: QEMU 9.x，x86_64 TCG 模拟
- **客户系统**: XigmaNAS 14.3.0.5（基于 FreeBSD 14.3-RELEASE）
- **ISO**: XigmaNAS-x64-LiveCD-14.3.0.5.10566.iso（685 MB）

### 安装步骤

1. **创建虚拟磁盘**:
   ```bash
   qemu-img create -f qcow2 xigmanas-disk.qcow2 40G
   ```

2. **启动安装程序**（从 LiveCD ISO 启动）:
   ```bash
   qemu-system-x86_64 -machine q35 -m 2048 -smp 2 \
     -drive file=xigmanas-disk.qcow2,format=qcow2 \
     -cdrom XigmaNAS-x64-LiveCD-14.3.0.5.10566.iso \
     -boot d -vga std -vnc :0 \
     -device e1000,netdev=net0 \
     -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::8888-:80
   ```

3. **安装**: 从控制台菜单选择"完整安装"→ GPT 分区 → UFS 文件系统（不要选 ZFS 作为系统盘）

4. **从磁盘启动**: 安装完成后，移除 CD-ROM 重新启动

5. **配置网络**: 控制台菜单 → 选项 2 → 使用 DHCP
   - VM 将获得 IP 10.0.2.15（QEMU 内部 NAT）

6. **访问 Web 管理界面**: http://localhost:8888（admin / xigmanas）

### 故障排除

| 问题 | 解决方案 |
|------|----------|
| VM 无法从磁盘启动 | 使用 `gptboot`（UFS/GPT），不要用 `gptzfsboot`（ZFS） |
| Web 界面无法访问 | 设置 DHCP，或将 lighttpd 绑定到 0.0.0.0 |
| 串行控制台无输出 | 使用 VNC 连接 localhost:5900 |
| 键盘输入缓慢 | 使用 QEMU monitor 的 sendkey 或控制台菜单 |