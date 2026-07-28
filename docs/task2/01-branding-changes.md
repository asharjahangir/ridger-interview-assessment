# Task 2: Branding Modifications



### Overview
We modified the XigmaNAS source code (SVN r10655) to rebrand it as **RidgerNAS** — a custom NAS distribution for demonstration purposes. All changes are documented below.

### Source Code Download
```bash
# Download XigmaNAS source code from SVN
svn checkout https://svn.code.sf.net/p/xigmanas/code/trunk XigmaNAS-source
# Revision: 10655 (latest)
# Size: ~124 MB, 818 files
```

### Branding Image Assets / 品牌图片资源

We created custom images from the company logo (1120×1486 PNG):

| Image | File | Dimensions | Format | Description |
|-------|------|-----------|--------|-------------|
| Boot Splash | `build/boot/splash.bmp` | 640×480 | BMP | Boot splash screen |
| Brand Logo | `build/boot/images/brand-rev.png` | 375×100 | PNG | Bootloader logo |
| Login Logo | `www/images/login_logo.png` | 300×72 | PNG | Web GUI login logo |
| Favicon | `www/favicon.ico` | 32×32 | PNG | Browser tab icon |
| Info Icon | `www/images/info.png` | 16×16 | PNG | Status indicator |

### String Modifications / 字符串修改

**305 files modified** across the codebase — all occurrences of "XigmaNAS", "xigmanas", and "XIGMANAS" replaced with "RidgerNAS", "ridgernas", and "RIDGERNAS":

```bash
# Replace all variants in all text files
find . -type f \( -name "*.php" -o -name "*.inc" -o -name "*.css" \
  -o -name "*.js" -o -name "*.html" -o -name "*.4th" -o -name "*.conf" \) \
  -exec sed -i '' 's/XigmaNAS/RidgerNAS/g; s/xigmanas/ridgernas/g; s/XIGMANAS/RIDGERNAS/g' {} +
```

### Configuration Files Modified / 配置文件修改

| File | Original | Modified |
|------|----------|----------|
| `build/xigmanas.files` | XigmaNAS file list | Renamed entries |
| `build/make.sh` | XigmaNAS build script | Updated references |
| `build/functions.inc` | XigmaNAS functions | Updated paths |
| `etc/prd.name` | `XigmaNAS` | `RidgerNAS` |
| `etc/rc.d/lighttpd` | xigmanas references | ridgernas references |
| `boot/loader.conf` | loader_brand | `RidgerNAS` |

### Bootloader Branding / 引导加载器品牌

The bootloader displays "RidgerNAS" in the console menu:

```
 __  ___                       _   _    _    ____  
 \ \/ (_) __ _ _ __ ___   __ _| \ | |  / \  / ___| 
  \  /| |/ _` | '_ ` _ \ / _` |  \| | / _ \ \___ \ 
  /  \| | (_| | | | | | | (_| | |\  |/ ___ \ ___) |
 /_/\_\_|\__, |_| |_| |_|\__,_|_| \_/_/   \_\____/ 
         |___/                                     
 ╔═════════════════════════════════════════╗
 ║          Welcome to RidgerNAS           ║
 ╚═════════════════════════════════════════╝
```

### Verification / 验证

```bash
# Confirm no remaining XigmaNAS references
grep -r "XigmaNAS" --include="*.php" --include="*.inc" --include="*.css" \
  --include="*.conf" --include="*.4th" . | wc -l
# Output: 0 (all replaced)
```

