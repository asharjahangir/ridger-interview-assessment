# Task 1: Storage Configuration / 存储配置

## English

### Services Configured

#### 1. SSH Service
- **Port**: 22 (mapped to host :2222)
- **Access**: `ssh -p 2222 root@localhost` (password: xigmanas)
- **Usage**: Programmatic management and file transfer

#### 2. Web GUI (Lighttpd)
- **Port**: 80 (mapped to host :8888)
- **URL**: http://localhost:8888
- **Credentials**: admin / xigmanas
- **Features**: Full visual configuration of all NAS services

#### 3. ZFS Storage Pool
- **Pool name**: `storage`
- **Dataset**: `storage/share` mounted at `/mnt/storage`
- **Capacity**: ~38 GB usable
- **Features**: Compression, snapshots, quotas, replication

#### 4. Samba (SMB/CIFS)
- **Workgroup**: WORKGROUP
- **Share**: `/mnt/storage/share` accessible to LAN clients
- **Authentication**: Local users or anonymous

### Web GUI Screenshots

Login page: http://localhost:8888 (after branding: RidgerNAS)
Dashboard: System Information, Storage status, Service status
Storage: ZFS pool management, dataset creation, quotas
Services: Samba, SSH, FTP, Rsync, UPS, etc.

### Key Features Demonstrated

1. **ZFS capabilities**: Snapshots, compression (lz4), checksums, repair
2. **Samba configuration**: Share creation, permissions, guest access
3. **Web GUI management**: No manual config file editing needed
4. **Monitoring**: Disk usage, system logs, SMART status

---

## 中文

### 已配置的服务

#### 1. SSH 服务
- **端口**: 22（映射到主机 :2222）
- **访问**: `ssh -p 2222 root@localhost`（密码: xigmanas）
- **用途**: 程序化管理和文件传输

#### 2. Web 管理界面 (Lighttpd)
- **端口**: 80（映射到主机 :8888）
- **URL**: http://localhost:8888
- **登录**: admin / xigmanas
- **功能**: 所有 NAS 服务的可视化配置管理

#### 3. ZFS 存储池
- **池名称**: `storage`
- **数据集**: `storage/share` 挂载于 `/mnt/storage`
- **容量**: 约 38 GB 可用
- **功能**: 压缩、快照、配额、复制

#### 4. Samba (SMB/CIFS)
- **工作组**: WORKGROUP
- **共享**: `/mnt/storage/share` 可供局域网客户端访问
- **认证**: 本地用户或匿名访问

### 演示的关键功能

1. **ZFS 功能**: 快照、压缩 (lz4)、校验和、修复
2. **Samba 配置**: 共享创建、权限设置、访客访问
3. **Web 界面管理**: 无需手动编辑配置文件
4. **监控**: 磁盘使用、系统日志、SMART 状态