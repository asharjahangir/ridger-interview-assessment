# Task 2: Comparison — Original vs. Modified



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

