# Task 2: Comparison — Original vs. Modified / 原始与修改版本对比

## English

### ISO Comparison

We have two ISOs:

| File | Size | Description |
|------|------|-------------|
| `XigmaNAS-x64-LiveCD-14.3.0.5.10566.iso` | 718 MB | Original XigmaNAS (includes embedded image) |
| `RidgerNAS-x64-LiveCD-14.3.0.5.1.iso` | 401 MB | Compiled RidgerNAS (LiveCD only, no embedded) |

### VM Comparison (Both Running)

| Aspect | Original (XigmaNAS) | Compiled (RidgerNAS) |
|--------|-------------------|----------------------|
| **VM Software** | UTM (QEMU TCG) | QEMU directly (TCG) |
| **IP Address** | 192.168.64.2 | localhost:8081 (HTTPS) |
| **Web GUI** | XigmaNAS WebGUI | RidgerNAS WebGUI |
| **Bootloader** | "Welcome to XigmaNAS" | "Welcome to RidgerNAS" |
| **Kernel** | Original FreeBSD 14.3 kernel | **Cross-compiled kernel** (33MB, x86_64) |
| **Userland** | Original FreeBSD binaries | FreeBSD 14.3 base.txz (pre-compiled) |
| **Web Files** | Original XigmaNAS | Branded ~305 files → "RidgerNAS" |
| **Hostname** | xigmanas.internal | ridgernas.local |
| **Login Logo** | XigmaNAS logo | Custom RidgerNAS logo |
| **Favicon** | XigmaNAS icon | Custom "R" icon |
| **Samba NetBIOS** | XIGMANAS | RIDGERNAS |
| **Storage** | ZFS pool + Samba share | Same (install from our ISO) |

### Screenshot Comparison

**Bootloader Screen:**
```
Original:           Modified:
╔══════════════════╗ ╔══════════════════╗
║ Welcome to       ║ ║ Welcome to       ║
║   XigmaNAS       ║ ║   RidgerNAS      ║
╚══════════════════╝ ╚══════════════════╝
```

**Login Page:**
- Original: Shows XigmaNAS logo, copyright, "XigmaNAS® WebGUI"
- Modified: Shows RidgerNAS logo, "Copyright © 2026 RidgerNAS", "RidgerNAS WebGUI"

### What Was Changed

| Category | Files | Details |
|----------|-------|---------|
| PHP/INC source | ~290 files | All "XigmaNAS" → "RidgerNAS" |
| CSS files | ~15 files | Color references, branding |
| Bootloader | `brand-XigmaNAS.4th` | Boot splash, menu title |
| Kernel config | `XIGMANAS-amd64` | Renamed, cross-compiled |
| Images | 4 assets | Logo, favicon, splash, login |
| Config files | `prd.name`, `prd.version`, `loader.conf` | Product identity |
| ISO metadata | Volume label, publisher | "Ridger Company Limited" |

### What Was NOT Changed

- FreeBSD kernel **functionality** (same drivers, same behavior)
- All NAS features (Samba, ZFS, iSCSI, FTP, NFS)
- Security and authentication
- Package versions

### Boot Test Results

The compiled RidgerNAS ISO boots successfully:
1. ✅ BIOS boot: SeaBIOS → CD Loader → BTX loader
2. ✅ Boot menu displays "Welcome to RidgerNAS"
3. ✅ Kernel loads (our compiled kernel)
4. ✅ MFSROOT loads (FreeBSD base + branded web)
5. ✅ Boots to console menu
6. ✅ Web GUI accessible (HTTPS port 8081)
7. ✅ SSH accessible (port 2224)

---

## 中文

### ISO 对比

| 文件 | 大小 | 描述 |
|------|------|------|
| `XigmaNAS-x64-LiveCD-14.3.0.5.10566.iso` | 718 MB | 原始 XigmaNAS（含嵌入式映像） |
| `RidgerNAS-x64-LiveCD-14.3.0.5.1.iso` | 401 MB | 编译的 RidgerNAS（仅 LiveCD） |

### 虚拟机对比（两台均在运行）

| 方面 | 原始 (XigmaNAS) | 编译 (RidgerNAS) |
|------|----------------|-------------------|
| **虚拟机软件** | UTM (QEMU TCG) | QEMU (TCG) |
| **IP 地址** | 192.168.64.2 | localhost:8081 (HTTPS) |
| **Web GUI** | XigmaNAS WebGUI | RidgerNAS WebGUI |
| **引导加载器** | "Welcome to XigmaNAS" | "Welcome to RidgerNAS" |
| **内核** | 原始 FreeBSD 14.3 内核 | **交叉编译内核** (33MB, x86_64) |
| **用户空间** | 原始 FreeBSD 二进制 | FreeBSD 14.3 base.txz (预编译) |
| **网页文件** | 原始 XigmaNAS | 品牌化 ~305 个文件 → "RidgerNAS" |
| **主机名** | xigmanas.internal | ridgernas.local |
| **登录 Logo** | XigmaNAS logo | 自定义 RidgerNAS logo |
| **网站图标** | XigmaNAS 图标 | 自定义 "R" 图标 |
| **Samba NetBIOS** | XIGMANAS | RIDGERNAS |
| **存储** | ZFS 池 + Samba 共享 | 相同（从我们的 ISO 安装） |

### 变更内容

| 类别 | 文件数 | 详情 |
|------|--------|------|
| PHP/INC 源码 | ~290 个文件 | 所有 "XigmaNAS" → "RidgerNAS" |
| CSS 文件 | ~15 个文件 | 颜色引用、品牌 |
| 引导加载器 | `brand-XigmaNAS.4th` | 启动画面、菜单标题 |
| 内核配置 | `XIGMANAS-amd64` | 重命名、交叉编译 |
| 图片 | 4 个资源 | Logo、favicon、启动画面、登录 |
| 配置文件 | `prd.name`、`prd.version`、`loader.conf` | 产品标识 |
| ISO 元数据 | 卷标、发布者 | "Ridger Company Limited" |

### 未变更的内容

- FreeBSD 内核**功能**（相同的驱动，相同的行为）
- 所有 NAS 功能（Samba、ZFS、iSCSI、FTP、NFS）
- 安全性和认证
- 软件包版本

### 启动测试结果

编译的 RidgerNAS ISO 成功启动：
1. ✅ BIOS 引导
2. ✅ 启动菜单显示 "Welcome to RidgerNAS"
3. ✅ 内核加载（我们编译的内核）
4. ✅ MFSROOT 加载（FreeBSD 基础 + 品牌化网页）
5. ✅ 启动到控制台菜单
6. ✅ Web GUI 可访问（HTTPS 端口 8081）
7. ✅ SSH 可访问（端口 2224）