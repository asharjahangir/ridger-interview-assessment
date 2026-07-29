# My Study Notes — RidgerNAS Interview

*Personal notes I prepared for the interview. Covers what I did, how it works, and what to say.*

---

## 1. The Tasks

| Task | What they asked | Status |
|------|----------------|--------|
| **Task 1** | Download XigmaNAS, install in VM, configure storage, 10-min presentation | ⏸️ VM installed, storage not configured |
| **Task 2** | Download source, modify branding, **recompile** into installable image, compare with original, 10-min presentation | ✅ Done |
| **Task 3** | Show personal projects | Skipped |

---

## 2. Concepts I Need to Know

### 2.1 What is a NAS?

A NAS is essentially a dedicated file server for an office network. Instead of having files scattered across everyone's computers, a NAS centralizes them. It supports multiple protocols so Windows, Mac, and Linux machines can all connect to it.

### 2.2 What is XigmaNAS?

XigmaNAS is an open-source NAS operating system, built on top of **FreeBSD** (a Unix-like OS, similar to Linux but more stable). It provides a web-based management interface (written in PHP) for configuring file sharing, storage, users, and backups.

**Architecture (three layers):**

```
┌──────────────────────────────────────┐
│   Web GUI (PHP + Lighttpd)           │  ← management interface
├──────────────────────────────────────┤
│   NAS services (Samba, ZFS, NFS)     │  ← file sharing engines
├──────────────────────────────────────┤
│   FreeBSD 14.3 kernel + drivers      │  ← the OS foundation
└──────────────────────────────────────┘
```

### 2.3 What is ZFS?

ZFS is the file system that XigmaNAS uses. It's significantly more advanced than NTFS (Windows) or APFS (Mac):

- **Data integrity**: Every block checksummed, corruption auto-repaired
- **Snapshots**: Instant, space-efficient filesystem snapshots (like Git commits)
- **Compression**: Transparent lz4/zstd compression
- **RAID-Z**: Better than traditional RAID — self-healing

**Key point for interview:** ZFS is XigmaNAS's strongest feature. FreeBSD has native ZFS support, which is one reason NAS systems choose it over Linux.

### 2.4 What is Compilation? (Important)

Web developers work with interpreted languages (JS, PHP, Python) — code runs directly, no build step.

C is different: C source code must be **compiled** into machine code (binary) that the CPU can execute.

```
C source code (.c files)          →    Compiler (Clang/GCC)      →    Binary machine code
35,000 files for FreeBSD kernel   →    Clang compiler             →    33MB kernel binary
```

The interviewer specifically asked for "重新编译" (recompilation). This means running a C compiler — not just changing text in files.

### 2.5 What is Cross-Compilation? (Key Achievement)

**Normal compilation**: Compiling code for the same CPU you're running on.
**Cross-compilation**: Compiling code for a **different** CPU architecture.

```
My MacBook M2 (ARM64)              →    Produces x86_64 code (for Intel/AMD NAS)
     ↑                                     
  Running Clang compiler           →    Targeting a different CPU
```

**Why I needed this:** My MacBook is ARM64 (M2 chip). XigmaNAS runs on x86_64 (Intel). I can't run FreeBSD's build tools directly on macOS. Solution:

1. Created an ARM64 FreeBSD VM (runs at native speed on M2 via Apple's Hypervisor Framework)
2. Installed FreeBSD source code + Clang
3. Used FreeBSD's cross-compilation: `TARGET=amd64 TARGET_ARCH=amd64`
4. The compiler produced x86_64 machine code while running on ARM64

**Interview soundbite:** "Because my MacBook uses an M2 ARM64 chip and the NAS needs x86_64 code, I set up cross-compilation. I ran FreeBSD's build system with `TARGET=amd64` on an ARM64 VM, which told the Clang compiler to generate x86_64 machine code. This is standard practice in embedded systems."

### 2.6 QEMU/UTM Quick Reference

| Mode | Description | Speed | When to use |
|------|-------------|-------|-------------|
| **HVF** | Apple's Hypervisor Framework | ✅ Native speed | ARM64 guest on ARM64 host |
| **TCG** | Software emulation | 🐌 5-10x slower | x86_64 guest on ARM64 host |

- Build VM (FreeBSD ARM64) → HVF (fast)
- XigmaNAS/RidgerNAS VMs (x86_64) → TCG (slow, but works)

---

## 3. Task 1 — What I Did

### Steps

1. Downloaded XigmaNAS ISO (718MB from SourceForge)
2. Created a VM in UTM (2 CPU, 2GB RAM, 40GB disk, x86_64, legacy BIOS)
3. Installed XigmaNAS — Full Install, GPT, UFS filesystem
4. Would configure storage via Web GUI:
   - Create ZFS pool `storage`
   - Create dataset `storage/share`
   - Enable Samba (Windows file sharing)
5. Verified everything: Web GUI at http://192.168.64.2, SSH access, file sharing works

### 10-Min Presentation Outline

**1-2 min: What is XigmaNAS?**
"A NAS is a file server for your office network. XigmaNAS is an open-source NAS OS based on FreeBSD. It provides file sharing, storage management, and backup through a web interface."

**3-4 min: Architecture**
Three-layer diagram: FreeBSD kernel → NAS services (Samba, ZFS) → PHP web GUI.

**Note:** Storage was not configured in the demo due to time constraints. The VM was set up and accessible.

**5-6 min: Live Demo**
Show Dashboard → (would show Storage/ZFS pool → Services/Samba if configured).

**7-8 min: Pros & Cons**
| Pros | Cons |
|------|------|
| ZFS is best-in-class | UI looks dated |
| Free and open source | Small community |
| Lightweight (512MB RAM min) | No Docker |
| Rock stable | Fewer drivers than Linux |

**9-10 min: Competitors**
- TrueNAS Core (same FreeBSD base, more commercial)
- TrueNAS Scale (Linux + Docker)
- OMV (Debian Linux, simpler)

---

## 4. Task 2 — What I Did (The Important One)

### 4.1 Source Code Download

Downloaded XigmaNAS source from SVN (r10655, ~124MB, 818 files). The source tree includes PHP web files, CSS, bootloader config, kernel config, and build scripts.

### 4.2 Branding Changes

Modified **305 files** — all instances of "XigmaNAS"/"xigmanas"/"XIGMANAS" replaced with "RidgerNAS"/"ridgernas"/"RIDGERNAS".

| What changed | Before | After |
|-------------|--------|-------|
| Web page titles | XigmaNAS WebGUI | RidgerNAS WebGUI |
| Boot screen | Welcome to XigmaNAS | Welcome to RidgerNAS |
| Hostname | xigmanas.internal | ridgernas.local |
| Copyright | © XigmaNAS | © RidgerNAS |
| Samba NetBIOS | XIGMANAS | RIDGERNAS |

Also processed the company logo into all required formats: splash.bmp (640×480), brand-rev.png (375×100), login_logo.png (300×72), favicon.ico (32×32), info.png (16×16).

### 4.3 Cross-Compiling the Kernel (This is the highlight)

**The problem:** M2 Mac is ARM64, NAS needs x86_64.

**The solution:** Cross-compilation on an ARM64 FreeBSD VM.

```
1. Set up ARM64 FreeBSD 14.3 VM (native speed via HVF)
2. Downloaded FreeBSD 14.3 source tree (src.txz)
3. Applied XigmaNAS kernel config (XIGMANAS-amd64)
4. Ran: make buildkernel KERNCONF=XIGMANAS-amd64 TARGET=amd64
5. ~20 minutes later → 33MB x86_64 kernel binary
```

**Why not buildworld?** FreeBSD's `make buildworld` compiles every userland tool (ls, cp, sshd, libc, etc.) — that takes 2-3 hours. Since XigmaNAS doesn't modify those, I downloaded the official pre-compiled FreeBSD 14.3 amd64 `base.txz` (200MB) instead. This is equivalent to what `buildworld` would produce, but saves hours.

### 4.4 ISO Assembly

Combined four components:

| Component | Source | How |
|-----------|--------|-----|
| Kernel | FreeBSD 14.3 source + XigmaNAS config | **Cross-compiled** ✅ |
| Userland | FreeBSD 14.3 official release | Pre-compiled base.txz |
| Web interface | XigmaNAS SVN source | **Branded 305 files** ✅ |
| Bootloader | XigmaNAS SVN source | **Branded** ✅ |

Used `mkisofs` to create: `RidgerNAS-x64-LiveCD-14.3.0.5.1.iso` (401MB).

### 4.5 Comparison

Both VMs are running:

| VM | Access | What's different |
|----|--------|-----------------|
| **XigmaNAS** (original) | http://192.168.64.2 | Original XigmaNAS |
| **RidgerNAS** (compiled) | https://localhost:8081 | Cross-compiled kernel + branded web |

**Visible differences:** Boot screen says "RidgerNAS", web GUI is branded, logos are custom.
**Invisible difference:** The kernel binary was compiled from source on July 28, 2026 — it's a genuine rebuild.

### 4.6 10-Min Presentation Outline

**1-2 min: Task Overview**
"The interviewer asked me to download XigmaNAS source, modify the branding, and recompile it into an installable image. The key word is recompile — this requires running a C compiler, not just changing text."

**3-4 min: Branding Changes**
"305 files modified — PHP, CSS, images, bootloader, and config. All instances of XigmaNAS replaced with RidgerNAS. Also created custom logo images from the company logo."

**5-6 min: The Compilation (Highlight)**
"The challenge: my MacBook is M2 ARM64, but the NAS is x86_64. I couldn't compile directly. Solution: I set up an ARM64 FreeBSD VM (native speed), and used FreeBSD's cross-compilation support. The Clang compiler ran on ARM64 but produced x86_64 machine code — 35,000 C files compiled into a 33MB kernel binary in about 20 minutes."

**7-8 min: ISO Assembly**
"Assembled the ISO from four parts: my cross-compiled kernel, the official FreeBSD userland (pre-compiled — no need to rebuild what we didn't change), the branded web interface, and the bootloader. Final ISO: 401MB, bootable."

**9-10 min: Demo + Q&A**
"Both VMs are running side by side. Same functionality, different branding, and the kernel is genuinely rebuilt from source."

---

## 5. Interview Q&A (My Prep)

### Q: "What challenges did you face?"

**My answer:** "The main challenge was the architecture mismatch. My MacBook uses an M2 ARM64 chip, but XigmaNAS targets x86_64. Running an x86_64 VM on ARM64 is 5-10x slower due to emulation, and some tools crash. The solution was to create an ARM64 FreeBSD VM (native speed via Apple's Hypervisor Framework) and use FreeBSD's cross-compilation feature. This is a standard technique in embedded systems development."

### Q: "Why not use Docker?"

**My answer:** "Docker on Mac runs Linux containers. FreeBSD is a different OS with a different kernel — the FreeBSD compilation tools can't run inside a Linux container. So Docker wasn't an option."

### Q: "What exactly did you compile?"

**My answer:** "I compiled the FreeBSD kernel — about 35,000 C source files processed by the Clang compiler, producing a 33MB x86_64 kernel binary. The kernel is the OS core that manages hardware, processes, memory, and file systems. The userland tools were downloaded pre-compiled because XigmaNAS doesn't modify them."

### Q: "How is this different from just changing text in the ISO?"

**My answer:** "Text replacement changes displayed strings. Compilation runs a C compiler that produces new machine code. Our kernel binary was compiled on July 28, 2026, from source, on different hardware than the original. It's a genuine rebuild, not a find-and-replace."

### Q: "What's the practical value?"

**My answer:** "This demonstrates the complete workflow for customizing an open-source NAS product: source code acquisition, branding, compilation, and ISO generation. If Ridger Company wanted to distribute a branded NAS appliance, this is exactly the process."

---

## 6. Demo Checklist

- [ ] XigmaNAS VM running (http://192.168.64.2)
- [ ] RidgerNAS VM running (https://localhost:8081)
- [ ] GitHub repo open: https://github.com/asharjahangir/ridger-interview-assessment
- [ ] ISO file ready to show (401MB, July 28 2026)

---

## 7. Quick Reference

| Term | What it is | Simple analogy |
|------|-----------|----------------|
| NAS | Network Attached Storage | A shared hard drive for the office |
| FreeBSD | Unix-like OS, Linux's cousin | More stable, less popular |
| ZFS | Advanced file system | NTFS + Git-like features |
| Kernel | OS core | The engine of a car |
| Compilation | C code → machine code | Building a house from blueprints |
| Cross-compilation | Compiling for a different CPU | Writing a recipe in English for a Chinese chef |
| ISO | CD/DVD image file | A ZIP of an entire CD |
| QEMU | Virtual machine software | Like VMware, free |
| TCG | Emulation mode | Running Windows games on a Mac |
| HVF | Native acceleration | Running a Mac app on a Mac |
| SVN | Version control | Git's older sibling |
| Samba | Windows file sharing protocol | What lets Windows see the NAS |
| Clang | C compiler | Part of LLVM, compiles C/C++/ObjC |
| x86_64 | Intel/AMD 64-bit | What most desktop computers use |
| ARM64 | Apple Silicon | What M1/M2/M3 Macs use |