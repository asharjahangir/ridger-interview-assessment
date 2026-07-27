# Task 2: Comparison — Original vs. Modified / 原始与修改版本对比

## English

### Overview

Since a full recompilation into an ISO image was not feasible within the assessment environment (see [Build Process](./02-build-process.md)), we demonstrate the comparison by showing the live branded VM running alongside the original XigmaNAS LiveCD booted in a separate VM instance.

### Comparison Table

| Aspect | Original (XigmaNAS) | Modified (RidgerNAS) |
|--------|-------------------|----------------------|
| **Product Name** | XigmaNAS | RidgerNAS |
| **Version** | 14.3.0.5 (r10566) | 14.3.0.5 (r10566) — same base |
| **Kernel** | FreeBSD 14.3-RELEASE-p5 | FreeBSD 14.3-RELEASE-p5 — unchanged |
| **Web GUI Title** | XigmaNAS® WebGUI | RidgerNAS WebGUI |
| **Hostname** | `xigmanas.internal` | `ridgernas.local` |
| **Login Page Logo** | XigmaNAS logo | Custom RidgerNAS logo |
| **Favicon** | XigmaNAS icon | Custom "R" icon |
| **Copyright** | © 2018-2025 XigmaNAS | © 2026 RidgerNAS |
| **Product URL** | www.xigmanas.com | ridgernas.local |
| **Bootloader Brand** | XigmaNAS splash | Custom splash (created) |
| **IRC Channel** | `#xigmanas` on Libera.Chat | `#xigmanas` (not changed) |
| **Donate Link** | PayPal to XigmaNAS | PayPal to RidgerNAS |
| **Samba NetBIOS Name** | XIGMANAS | RIDGERNAS |
| **Samba Server String** | XigmaNAS Server | RidgerNAS |
| **Storage Services** | N/A | Samba share at `/mnt/data/share` |
| **Data Partition** | None | 35 GB UFS at `/mnt/data` |

### How to Verify

#### Original (XigmaNAS LiveCD)
1. Download the original ISO from [SourceForge](https://sourceforge.net/projects/xigmanas/files/Stable/)
2. Boot in UTM or any VM software
3. Navigate to the web GUI

#### Modified (RidgerNAS VM)
1. Start the VM: `utmctl start XigmaNAS` (or via UTM GUI)
2. Access web GUI: `http://192.168.64.2`
3. Login: `admin` / `xigmanas`
4. Observe branding throughout the interface

#### Screenshots
Screenshots of the branded web GUI are available in the `docs/images/` directory.

### Verification Commands

```bash
# Check web GUI title and copyright
curl -s http://192.168.64.2/login.php | grep -iE "title|copyright|hostname"

# Check product config files
curl -s http://192.168.64.2/exec.php -d "txtCommand=cat /etc/prd.name"

# Check logo image
curl -s -o /dev/null -w "Logo: %{size_download} bytes\n" http://192.168.64.2/images/login_logo.png

# Check favicon
curl -s -o /dev/null -w "Favicon: %{size_download} bytes\n" http://192.168.64.2/favicon.ico
```

### What Was NOT Changed

The following remain as original XigmaNAS:
- **Kernel**: No modifications to FreeBSD kernel
- **System libraries**: All original FreeBSD 14.3 libraries
- **Packages**: Samba, Lighttpd, PHP, etc. — original versions
- **Functionality**: All NAS features (ZFS, Samba, FTP, etc.) unchanged
- **Security**: No changes to authentication or access control

This is intentional — the branding modification is a surface-level change that does not affect the stability, security, or functionality of the system.

---

## 中文

### 对比概览

由于完整编译ISO镜像在评估环境中不可行，我们通过在运行中的已修改VM上展示品牌变化，并与原始XigmaNAS进行比较。

### 主要变化

| 方面 | 原始 (XigmaNAS) | 修改后 (RidgerNAS) |
|------|----------------|-------------------|
| **产品名称** | XigmaNAS | RidgerNAS |
| **Web GUI标题** | XigmaNAS® WebGUI | RidgerNAS WebGUI |
| **主机名** | xigmanas.internal | ridgernas.local |
| **登录Logo** | XigmaNAS标志 | 定制RidgerNAS标志 |
| **版权信息** | © 2018-2025 XigmaNAS | © 2026 RidgerNAS |
| **Samba名称** | XIGMANAS | RIDGERNAS |

### 未修改的部分

- 内核：未修改
- 系统库：原始FreeBSD 14.3库
- 软件包：Samba, Lighttpd, PHP等 — 原始版本
- 功能：所有NAS功能不变
- 安全性：认证和访问控制不变

