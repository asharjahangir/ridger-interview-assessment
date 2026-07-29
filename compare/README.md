# Before/After Comparison

Side-by-side comparison of key files before and after rebranding from XigmaNAS → RidgerNAS.

## Folder structure

```
compare/
├── original/    # Files from XigmaNAS SVN r10655 (unchanged)
└── branded/     # Files after rebranding to RidgerNAS
```

## What changed

| File | Change |
|------|--------|
| `etc/prd.name` | "XigmaNAS" → "RidgerNAS" |
| `etc/prd.copyright` | Updated company name, URL, and year |
| `etc/prd.url` | "xigmanas.com" → "ridgernas.local" |
| `www/index.php` | License header: "Part of XigmaNAS" → "Part of RidgerNAS" |
| `www/fbegin.inc` | Page title, meta tags, logo reference |
| `www/login.php` | Login page text |
| `www/images/login_logo.png` | Custom RidgerNAS logo |
| `www/favicon.ico` | Custom RidgerNAS favicon |

## How to verify

```bash
diff -r compare/original compare/branded
```
