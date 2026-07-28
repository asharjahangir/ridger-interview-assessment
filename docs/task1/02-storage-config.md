# Task 1: Storage Configuration / 存储配置

## English

### Services Configured

#### 1. Web GUI (Lighttpd)
- **Port**: 80 (HTTP)
- **URL**: http://192.168.64.2
- **Credentials**: admin / xigmanas
- **Features**: Full visual configuration of all NAS services

#### 2. SSH Service
- **Port**: 22
- **Access**: `ssh root@192.168.64.2` (password: xigmanas)
- **Usage**: Command-line management and file transfer

#### 3. ZFS Storage Pool
- **Pool name**: `storage`
- **Dataset**: `storage/share` mounted at `/mnt/storage`
- **Capacity**: ~35 GB usable
- **Features**: Compression (lz4), snapshots, data integrity checksums

#### 4. Samba (SMB/CIFS)
- **Workgroup**: WORKGROUP
- **Share name**: `storage`
- **Path**: `/mnt/storage/share`
- **Access**: Guest (anonymous) + local user authentication
- **NetBIOS name**: XIGMANAS

### How to Configure (via Web GUI)

1. **Storage → ZFS → Pool Manager**: Create pool `storage` from available disk
2. **Storage → ZFS → Datasets**: Create `storage/share` dataset
3. **Services → Control**: Enable Samba (SMB/CIFS)
4. **Services → SMB: Shares**: Add share → path `/mnt/storage/share`
5. **Access**: From any computer on the same network, connect to `\\192.168.64.2\storage`

### Demo Checklist

- [ ] Show Dashboard → System Information, CPU, RAM, disk usage
- [ ] Show Storage → ZFS Pool → pool status, space usage
- [ ] Show Storage → Disks → SMART information
- [ ] Show Services → Samba → share configuration
- [ ] Show Network → Interface → IP configuration

---

## 中文

### 已配置的服务

#### 1. Web 管理界面 (Lighttpd)
- **端口**: 80 (HTTP)
- **URL**: http://192.168.64.2
- **登录**: admin / xigmanas
- **功能**: 所有 NAS 服务的可视化配置管理

#### 2. SSH 服务
- **端口**: 22
- **访问**: `ssh root@192.168.64.2`（密码: xigmanas）
- **用途**: 命令行管理和文件传输

#### 3. ZFS 存储池
- **池名称**: `storage`
- **数据集**: `storage/share` 挂载于 `/mnt/storage`
- **容量**: 约 35 GB 可用
- **功能**: 压缩 (lz4)、快照、数据完整性校验

#### 4. Samba (SMB/CIFS)
- **工作组**: WORKGROUP
- **共享名称**: `storage`
- **路径**: `/mnt/storage/share`
- **访问**: 访客 + 本地用户认证
- **NetBIOS 名称**: XIGMANAS

### 配置方法（通过 Web GUI）

1. **存储 → ZFS → 池管理器**: 创建池 `storage`
2. **存储 → ZFS → 数据集**: 创建 `storage/share` 数据集
3. **服务 → 控制**: 启用 Samba
4. **服务 → SMB: 共享**: 添加共享 → 路径 `/mnt/storage/share`
5. **访问**: 同一网络的电脑，连接到 `\\192.168.64.2\storage`

### 演示清单

- [ ] 展示仪表盘 → 系统信息、CPU、内存、磁盘使用
- [ ] 展示存储 → ZFS 池 → 池状态、空间使用
- [ ] 展示存储 → 磁盘 → SMART 信息
- [ ] 展示服务 → Samba → 共享配置
- [ ] 展示网络 → 接口 → IP 配置