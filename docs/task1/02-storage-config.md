# Task 1: Storage Configuration



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

