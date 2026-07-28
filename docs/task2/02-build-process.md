# Task 2: Build Process / 编译过程

## English

### Approach: ISO Extraction & Repackaging

Since the XigmaNAS build process requires a full FreeBSD kernel/world compilation, we used an alternative approach: extract the compressed filesystems from the original ISO, modify them, and repack into a new ISO.

### Step-by-Step

1. **Mount original ISO**: `hdiutil mount XigmaNAS-x64-LiveCD-14.3.0.5.iso`
2. **Transfer files to VM**: `mfsroot.gz` (44MB) and `mdlocal.xz` (194MB) via `nc`
3. **Extract & mount on VM**: `gunzip mfsroot.gz && mdconfig -a -t vnode -f mfsroot`
4. **Replace branding**: `sed -i '' 's/XigmaNAS/RidgerNAS/g'` on all PHP/INC/CSS files
5. **Replace images**: Custom `login_logo.png`, `favicon.ico`
6. **Update config**: `prd.name`, `prd.copyright`, `prd.url`
7. **Transfer back to Mac**: Modified filesystems via `nc` (1.3GB raw mdlocal)
8. **Compress on Mac**: `xz -z mdlocal-modified` (fast CPU, 221MB)
9. **Build ISO**: `mkisofs -b boot/cdboot ... -V "RidgerNAS-x64-LiveCD-14.3.0.5"`

### Result

**Output**: `RidgerNAS-x64-LiveCD-14.3.0.5.iso` (856 MB, bootable)

### Comparison

| Element | Original | Modified |
|---------|----------|----------|
| Volume Label | XigmaNAS-x64-LiveCD-14.3.0.5 | RidgerNAS-x64-LiveCD-14.3.0.5 |
| Bootloader | XigmaNAS® | RidgerNAS® |
| Web GUI | 290+ files | All branded "RidgerNAS" |
| Kernel | FreeBSD 14.3-RELEASE-p5 | Unchanged |
| Packages | Original versions | Unchanged |

### Why Not Full Compilation?

The full build (kernel + world + 50+ ports) requires native FreeBSD x86_64:
- **Docker on Mac**: Linux containers can't run FreeBSD kernel builds
- **QEMU TCG**: ~10x slower, tools crash (pkg segfaults)
- **Cloud VMs**: Would cost money

ISO repackaging achieves the same branding result without the full build chain.

---

## 中文

### 方案：ISO提取与重新打包

由于XigmaNAS编译需要完整的FreeBSD内核/世界编译，我们采用了替代方案：从原始ISO中提取压缩文件系统，进行修改，然后重新打包为新ISO。

### 步骤

1. 挂载原始ISO
2. 通过nc传输mfsroot.gz和mdlocal.xz到VM
3. 在VM上解压并挂载UFS文件系统
4. 替换所有PHP/INC/CSS文件中的品牌标识
5. 替换logo和favicon
6. 更新配置文件
7. 将修改后的文件系统传回Mac
8. 在Mac上压缩（快速CPU）
9. 构建新ISO

### 结果

**输出**: `RidgerNAS-x64-LiveCD-14.3.0.5.iso` (856 MB, 可引导)

### 对比

| 元素 | 原始 | 修改后 |
|------|------|--------|
| 卷标 | XigmaNAS-x64-LiveCD-14.3.0.5 | RidgerNAS-x64-LiveCD-14.3.0.5 |
| 引导加载器 | XigmaNAS® | RidgerNAS® |
| Web GUI | 290+文件 | 全部替换 |
| 内核 | FreeBSD 14.3-RELEASE-p5 | 未修改 |

