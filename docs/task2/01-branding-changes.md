# Task 2: Branding Modifications / 品牌修改

## English

### Overview
We modified the XigmaNAS source code (SVN r10655) to rebrand it as **RidgerNAS** — a custom NAS distribution for demonstration purposes. All changes are documented below.

### Source Code Download
```bash
# Download XigmaNAS source code from SVN
svn checkout https://svn.code.sf.net/p/xigmanas/code/trunk XigmaNAS-source
# Revision: 10655 (latest)
# Size: ~1.2 GB with all branches
```

### Branding Image Assets / 品牌图片资源

We created custom images for the rebranding:

| Image | File | Dimensions | Format | Description |
|-------|------|-----------|--------|-------------|
| Login Logo | `www/images/login_logo.png` | 300×72 | PNG (RGBA) | "RidgerNAS" text logo |
| Favicon | `www/favicon.ico` | 32×32 | PNG | "R" letter icon |
| Boot Splash | `boot/splash.bmp` | 640×480 | BMP | Boot splash screen |
| Brand Logo | `boot/images/xigmanas-brand-rev.png` | 375×100 | PNG | Bootloader logo |

### String Modifications / 字符串修改

We replaced all occurrences of "XigmaNAS" with "RidgerNAS" across the codebase:

```bash
# Replace in PHP files
find www/ -name "*.php" -o -name "*.inc" | xargs sed -i '' 's/XigmaNAS/RidgerNAS/g'

# Replace in CSS files
find www/ -name "*.css*" | xargs sed -i '' 's/XigmaNAS/RidgerNAS/g'

# Replace in bootloader
sed -i '' 's/XigmaNAS/RidgerNAS/g' boot/brand-XigmaNAS.4th
```

**Files affected**: 290+ PHP/INC/CSS files, 4 image files, 1 bootloader file

### Configuration Files Modified / 配置文件修改

| File | Original | Modified |
|------|----------|----------|
| `/etc/prd.name` | `XigmaNAS` | `RidgerNAS` |
| `/etc/prd.copyright` | `Copyright © 2018-2025 XigmaNAS® <info@xigmanas.com>` | `Copyright © 2026 RidgerNAS <info@ridgernas.local>` |
| `/etc/prd.url` | `www.xigmanas.com` | `ridgernas.local` |

### Live VM Branding Deployment / 部署到运行的 VM

Since we couldn't rebuild the entire OS (build environment challenges), we applied the branding changes directly to the running VM via the web GUI's `exec.php` endpoint:

1. **Auth**: Logged into web GUI, obtained auth token
2. **String replacement**: Used `sed` via `exec.php` to replace strings in all PHP/INC/CSS files
3. **Image upload**: Used `printf` with octal escapes to write binary files (base64 was unreliable due to URL encoding)
4. **Config files**: Wrote new `prd.name`, `prd.copyright`, `prd.url` files
5. **Hostname**: Changed to `ridgernas.local`
6. **Restart**: Restarted lighttpd web server to apply changes

### Verification / 验证

```bash
# Check branding on login page
curl -s http://localhost:8888/login.php | grep -i "ridgernas\|copyright"

# Output:
# <title>ridgernas.local</title>
# Copyright © 2026 RidgerNAS <info@ridgernas.local>
# Hostname: ridgernas.local
```

---

## 中文

### 概述
我们修改了 XigmaNAS 源代码（SVN r10655），将其重新品牌化为 **RidgerNAS**——一个用于演示目的的自定义 NAS 发行版。所有更改如下所述。

### 源代码下载
```bash
# 从 SVN 下载 XigmaNAS 源代码
svn checkout https://svn.code.sf.net/p/xigmanas/code/trunk XigmaNAS-source
# 版本: 10655（最新）
# 大小: 约 1.2 GB（含所有分支）
```

### 品牌图片资源

我们为重新品牌化创建了自定义图片：

| 图片 | 文件 | 尺寸 | 格式 | 描述 |
|------|------|------|------|------|
| 登录 Logo | `www/images/login_logo.png` | 300×72 | PNG | "RidgerNAS" 文字标识 |
| 网站图标 | `www/favicon.ico` | 32×32 | PNG | "R" 字母图标 |
| 启动画面 | `boot/splash.bmp` | 640×480 | BMP | 启动画面 |
| 品牌 Logo | `boot/images/xigmanas-brand-rev.png` | 375×100 | PNG | 引导加载器标识 |

### 字符串修改

我们在整个代码库中将所有"XigmaNAS"替换为"RidgerNAS"：

**涉及文件**: 290+ 个 PHP/INC/CSS 文件，4 个图片文件，1 个引导加载器文件

### 配置文件修改

| 文件 | 原版 | 修改版 |
|------|------|--------|
| `/etc/prd.name` | `XigmaNAS` | `RidgerNAS` |
| `/etc/prd.copyright` | `Copyright © 2018-2025 XigmaNAS® <info@xigmanas.com>` | `Copyright © 2026 RidgerNAS <info@ridgernas.local>` |
| `/etc/prd.url` | `www.xigmanas.com` | `ridgernas.local` |

### 部署到运行的 VM

由于无法重新编译整个操作系统（构建环境限制），我们通过 Web GUI 的 `exec.php` 端点直接对运行的 VM 应用品牌更改：

1. **认证**: 登录 Web GUI，获取认证令牌
2. **字符串替换**: 通过 `exec.php` 使用 `sed` 替换所有 PHP/INC/CSS 文件中的字符串
3. **图片上传**: 使用带八进制转义的 `printf` 写入二进制文件（base64 因 URL 编码问题不可靠）
4. **配置文件**: 写入新的 `prd.name`、`prd.copyright`、`prd.url` 文件
5. **主机名**: 更改为 `ridgernas.local`
6. **重启**: 重启 lighttpd Web 服务器以应用更改

### 验证

```bash
# 检查登录页面的品牌信息
curl -s http://localhost:8888/login.php | grep -i "ridgernas\|copyright"

# 输出:
# <title>ridgernas.local</title>
# Copyright © 2026 RidgerNAS <info@ridgernas.local>
# Hostname: ridgernas.local
```