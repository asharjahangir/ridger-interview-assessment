# Task 2: Branding Changes / 品牌修改

## Overview / 概述

**English:** All branding modifications made to the XigmaNAS source code (SVN r10655) to rebrand it as RidgerNAS.

**中文:** 对 XigmaNAS 源代码（SVN r10655）进行的所有品牌修改，重新品牌化为 RidgerNAS。

---

## Source Code Download / 源代码下载

**English:**
```bash
svn checkout https://svn.code.sf.net/p/xigmanas/code/trunk XigmaNAS-source
# Revision: 10655
# Size: ~124 MB, 818 files
```

**中文：**
```bash
svn checkout https://svn.code.sf.net/p/xigmanas/code/trunk XigmaNAS-source
# 版本: 10655
# 大小: ~124 MB, 818 个文件
```

## Branding Image Assets / 品牌图片资源

**English:** Custom images created from the company logo (1120×1486 PNG):

| Image | File | Dimensions | Description |
|-------|------|-----------|-------------|
| Login Logo | `www/images/login_logo.png` | 300×72 | Web GUI login logo / 登录界面标识 |
| Favicon | `www/favicon.ico` | 32×32 | Browser tab icon / 浏览器标签图标 |

**中文：** 从公司 Logo（1120×1486 PNG）生成了以上图片资源。

## String Modifications / 字符串修改

**English:** **305 files modified** — all occurrences of "XigmaNAS", "xigmanas", and "XIGMANAS" replaced with "RidgerNAS", "ridgernas", and "RIDGERNAS".

**中文：** 修改了 **305 个文件**，将所有 "XigmaNAS"、"xigmanas"、"XIGMANAS" 替换为 "RidgerNAS"、"ridgernas"、"RIDGERNAS"。

```bash
find . -type f \( -name "*.php" -o -name "*.inc" -o -name "*.css" \
  -o -name "*.js" -o -name "*.html" -o -name "*.4th" -o -name "*.conf" \) \
  -exec sed -i '' 's/XigmaNAS/RidgerNAS/g; s/xigmanas/ridgernas/g; s/XIGMANAS/RIDGERNAS/g' {} +
```

## Configuration Files Modified / 配置文件修改

| File / 文件 | Original / 原值 | Modified / 修改后 |
|-------------|----------------|-------------------|
| `etc/prd.name` | XigmaNAS | RidgerNAS |
| `etc/rc.d/lighttpd` | xigmanas references | ridgernas references |
| `boot/loader.conf` | XigmaNAS brand | RidgerNAS brand |
| `build/xigmanas.files` | XigmaNAS file list | Renamed entries |

## Verification / 验证

**English:**
```bash
grep -r "XigmaNAS" --include="*.php" --include="*.inc" --include="*.css" \
  --include="*.conf" --include="*.4th" . | wc -l
# Output: 0 (all replaced / 全部替换)
```

**中文：** 确认没有残留的 XigmaNAS 引用。