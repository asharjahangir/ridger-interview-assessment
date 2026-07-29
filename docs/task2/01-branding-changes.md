# Task 2: Branding Changes

## What can be done via Web GUI vs what requires source code changes

Some settings are configurable through the XigmaNAS web GUI. Others are hardcoded in the source code and require modifying files and recompiling.

### Settings available in the Web GUI (can be changed without recompiling)

| Setting | Web GUI Menu Path |
|---------|------------------|
| Hostname | **System → General** → Hostname field |
| Domain | **System → General** → Domain field |
| IP Address / DHCP | **Network → Interface** → IPv4 Configuration |
| DNS Servers | **Network → Interface** → DNS |
| Web GUI port (80/443) | **System → Advanced → WebGUI** |
| Language | **System → General** → Language |
| Timezone / NTP | **System → General** → Time & Date |
| SSH enable/disable | **Services → Control** → SSH |
| SMB/CIFS enable | **Services → Control** → SMB |
| ZFS pool creation | **Storage → ZFS → Pool Manager** |
| SMB share creation | **Services → SMB: Shares** |
| User/group management | **Access → Users** |

### Settings NOT available in the Web GUI (require source code changes)

These are hardcoded into the PHP, HTML, and configuration files — there is no admin panel for them.

---

## Login Logo Change

### What we changed

The login logo is the image shown above the login form at `http://192.168.64.x/`.

### Source file

`www/images/login_logo.png` (300×72 pixels)

### How we changed it

1. Created a custom logo from the Ridger company logo (resized to 300×72)
2. Replaced the file: `www/images/login_logo.png`
3. The file is referenced by `www/fbegin.inc` (the page header template) which includes it on every page

Once the ISO is rebuilt, the new logo appears on the login page and in the web GUI header.

The same process applies to the favicon: `www/favicon.ico` (32×32), referenced in `www/fbegin.inc` as the browser tab icon.

---

## String Replacements (XigmaNAS → RidgerNAS)

### What we changed

All visible text in the web GUI: page titles, copyright notices, product name references, meta descriptions, navigation labels.

### Source files affected

305 files total, in these directories:

| Directory | File types | Count |
|-----------|-----------|-------|
| `www/*.php` | PHP pages (index.php, system.php, services.php, etc.) | ~200 |
| `www/*.inc` | PHP includes (fbegin.inc, header.inc, etc.) | ~60 |
| `www/*.css` | Stylesheets | ~15 |
| `www/*.js` | JavaScript files | ~10 |
| `etc/prd.name` | Product name | 1 |
| `etc/prd.copyright` | Copyright string | 1 |
| `etc/prd.url` | Product URL | 1 |
| `etc/rc.d/*` | Boot/service scripts | ~10 |
| `boot/loader.conf` | Boot loader config | 1 |

### How we changed them

```bash
# Replace all three capitalizations across all relevant file types
find . -type f \( -name "*.php" -o -name "*.inc" -o -name "*.css" \
  -o -name "*.js" -o -name "*.html" -o -name "*.4th" -o -name "*.conf" \) \
  -exec sed -i '' \
  -e 's/XigmaNAS/RidgerNAS/g' \
  -e 's/xigmanas/ridgernas/g' \
  -e 's/XIGMANAS/RIDGERNAS/g' {} +
```

### Specific changes in key files

| File | What was changed |
|------|-----------------|
| `www/index.php` | License header: "Part of XigmaNAS" → "Part of RidgerNAS" |
| `www/fbegin.inc` | `<title>` tag content, meta description, logo image reference |
| `etc/prd.name` | "XigmaNAS" → "RidgerNAS" (one line file, controls product name throughout GUI) |
| `etc/prd.copyright` | "Copyright © 2018-2025 XigmaNAS" → "Copyright © 2018-2026 RidgerNAS" |
| `etc/prd.url` | "xigmanas.com" → "ridgernas.local" |
| `build/xigmanas.files` | Build file list references renamed from xigmanas → ridgernas |
| `boot/loader.conf` | Brand strings in boot configuration |

### Verification

```bash
# Confirm no XigmaNAS references remain in modified files
grep -r "XigmaNAS" --include="*.php" --include="*.inc" --include="*.css" \
  --include="*.conf" --include="*.4th" . | wc -l
# Output: 0
```

---

## Why these require recompilation

XigmaNAS stores product branding in text files (`/etc/prd.name`, `/etc/prd.copyright`, `/etc/prd.url`) and in PHP templates. These are bundled into the ISO's `mfsroot` image during build. There is no database, no settings file in `/var`, and no web GUI panel for these values — they come from the source tree. To change them, you must:

1. Modify the source files
2. Rebuild the ISO
3. Boot from the new ISO

The web GUI is only for operational configuration (network, storage, services, users, etc.), not for product branding.
