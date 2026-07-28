# Task 1: VM Setup



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

