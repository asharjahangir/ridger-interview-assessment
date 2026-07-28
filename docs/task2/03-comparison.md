# Task 2: Comparison — Original vs. Modified / 原始与修改版本对比

## English

### ISO Comparison

We have two ISOs:

| File | Size | Description |
|------|------|-------------|
| `XigmaNAS-x64-LiveCD-14.3.0.5.iso` | 685 MB | Original XigmaNAS LiveCD |
| `RidgerNAS-x64-LiveCD-14.3.0.5.iso` | 856 MB | Modified RidgerNAS LiveCD |

### Boot Test

The modified ISO can be booted in UTM or any VM software. To test:

1. In UTM, create a new VM → "Emulate" → "Other" → add the RidgerNAS ISO
2. Boot from the ISO
3. At the console menu, select "Boot LiveCD"
4. The bootloader shows "RidgerNAS®" branding
5. Access web GUI to see RidgerNAS branding throughout

### Full Comparison Table

| Aspect | Original (XigmaNAS) | Modified (RidgerNAS) |
|--------|-------------------|----------------------|
| **ISO Volume Label** | `XigmaNAS-x64-LiveCD-14.3.0.5` | `RidgerNAS-x64-LiveCD-14.3.0.5` |
| **Version File** | `XigmaNAS-x64-LiveCD-14.3.0.5.10566` | `RidgerNAS-x64-LiveCD-14.3.0.5.10566` |
| **Bootloader** | `brand-XigmaNAS.4th` | All references → `RidgerNAS®` |
| **Web GUI Title** | XigmaNAS® WebGUI | RidgerNAS WebGUI |
| **Hostname** | `xigmanas.internal` | `ridgernas.local` |
| **Login Page Logo** | XigmaNAS logo | Custom RidgerNAS logo |
| **Favicon** | XigmaNAS icon | Custom "R" icon |
| **Copyright** | © 2018-2025 XigmaNAS | © 2026 RidgerNAS |
| **Product URL** | www.xigmanas.com | ridgernas.local |
| **Samba NetBIOS** | XIGMANAS | RIDGERNAS |
| **Kernel** | FreeBSD 14.3-RELEASE-p5 | Same (unchanged) |
| **Packages** | Original versions | Same (unchanged) |
| **Functionality** | All NAS features | Unchanged |

### What Was NOT Changed

- Kernel and system libraries remain original
- All packages (Samba, Lighttpd, PHP, ZFS, etc.) are original versions
- Security and authentication unchanged
- All NAS functionality preserved

---

## 中文

### ISO对比

| 文件 | 大小 | 描述 |
|------|------|------|
| `XigmaNAS-x64-LiveCD-14.3.0.5.iso` | 685 MB | 原始XigmaNAS LiveCD |
| `RidgerNAS-x64-LiveCD-14.3.0.5.iso` | 856 MB | 修改后的RidgerNAS LiveCD |

### 引导测试

修改后的ISO可以在UTM或任何VM软件中引导。测试方法：
1. 在UTM中创建新VM → "Emulate" → "Other" → 添加RidgerNAS ISO
2. 从ISO引导
3. 在控制台菜单选择"Boot LiveCD"
4. 引导加载器显示"RidgerNAS®"品牌
5. 访问Web GUI查看品牌变化

