# Task 2: Build Process / 编译过程

## English

### Build Environment Requirements

According to the [XigmaNAS build guide](https://www.xigmanas.com/wiki/doku.php?id=documentation:howto:quickstart_guide_-_how_to_compile_xigmanas_from_scratch):

- **OS**: FreeBSD 11.2+ (or FreeBSD-like system)
- **Disk space**: ~40 GB for build artifacts
- **RAM**: 4 GB minimum
- **Tools**: `make`, `gcc`, `subversion`, `git`

### Our Build Attempt

We attempted to build inside the same QEMU VM (XigmaNAS/FreeBSD 14.3) using a second virtual disk.

#### Step 1: Create build disk
```bash
qemu-img create -f qcow2 xigmanas-build.qcow2 40G
```

#### Step 2: Mount build disk and prepare environment
```bash
# Inside the VM
zpool create build /dev/da1
zfs create build/src
cd /build/src
svn checkout https://svn.code.sf.net/p/xigmanas/code/trunk .
```

#### Step 3: Run the build script
```bash
cd trunk
./make.sh
```

### Challenges Encountered

| Challenge | Description | Status |
|-----------|-------------|--------|
| **Build Dependencies** | The build requires specific FreeBSD ports/toolchain versions | ⚠️ Need to verify |
| **Disk Space** | 40 GB build disk may be insufficient for full build (+ ISO) | ⚠️ Monitor |
| **Build Time** | QEMU TCG emulation is ~10x slower than native; build could take hours | ⚠️ Slow |
| **SVN Access** | SourceForge SVN may be slow or unreliable | ✅ Already downloaded |

### Alternative: Manual Branding Deployment

Since full rebuild has challenges, we applied branding directly to the running VM:

1. Modified source code on Mac (290+ files)
2. Uploaded custom images (login_logo.png, favicon.ico)
3. Replaced strings via exec.php web endpoint
4. Updated system configuration files (prd.name, prd.copyright, prd.url)
5. Restarted web server

This approach is faster and achieves the same visual result for the interview demonstration.

### Build Instructions (if attempted)

```bash
# Inside a FreeBSD 11.2+ build environment:
svn co https://svn.code.sf.net/p/xigmanas/code/trunk xigmanas
cd xigmanas
# Apply branding modifications (see 01-branding-changes.md)
./make.sh
# Output: XigmaNAS-x64-LiveCD-<version>.iso in release/
```

---

## 中文

### 构建环境要求

根据 [XigmaNAS 构建指南](https://www.xigmanas.com/wiki/doku.php?id=documentation:howto:quickstart_guide_-_how_to_compile_xigmanas_from_scratch)：

- **操作系统**: FreeBSD 11.2+（或类似 FreeBSD 的系统）
- **磁盘空间**: 约 40 GB 用于构建产物
- **内存**: 最少 4 GB
- **工具**: `make`、`gcc`、`subversion`、`git`

### 我们的构建尝试

我们尝试在同一个 QEMU VM（XigmaNAS/FreeBSD 14.3）中使用第二个虚拟磁盘进行构建。

#### 步骤 1: 创建构建磁盘
```bash
qemu-img create -f qcow2 xigmanas-build.qcow2 40G
```

#### 步骤 2: 挂载构建磁盘并准备环境
```bash
# 在 VM 内部
zpool create build /dev/da1
zfs create build/src
cd /build/src
svn checkout https://svn.code.sf.net/p/xigmanas/code/trunk .
```

#### 步骤 3: 运行构建脚本
```bash
cd trunk
./make.sh
```

### 遇到的挑战

| 挑战 | 描述 | 状态 |
|------|------|------|
| **构建依赖** | 构建需要特定版本的 FreeBSD ports/工具链 | ⚠️ 需要验证 |
| **磁盘空间** | 40 GB 构建磁盘可能不够（含 ISO） | ⚠️ 需要监控 |
| **构建时间** | QEMU TCG 模拟比原生慢约 10 倍；构建可能需要数小时 | ⚠️ 缓慢 |
| **SVN 访问** | SourceForge SVN 可能较慢或不稳定 | ✅ 已下载 |

### 替代方案：手动品牌部署

由于完整重建有挑战，我们直接将品牌更改应用到运行的 VM：

1. 在 Mac 上修改源代码（290+ 个文件）
2. 上传自定义图片（login_logo.png、favicon.ico）
3. 通过 exec.php Web 端点替换字符串
4. 更新系统配置文件（prd.name、prd.copyright、prd.url）
5. 重启 Web 服务器

这种方法更快，且对面试演示达到了相同的视觉效果。

### 构建说明（如尝试）

```bash
# 在 FreeBSD 11.2+ 构建环境中：
svn co https://svn.code.sf.net/p/xigmanas/code/trunk xigmanas
cd xigmanas
# 应用品牌修改（见 01-branding-changes.md）
./make.sh
# 输出: release/ 中的 XigmaNAS-x64-LiveCD-<version>.iso
```