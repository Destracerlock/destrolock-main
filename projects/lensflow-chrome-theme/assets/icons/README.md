# Extension Icons (generated or custom)

This repository intentionally avoids committing binary PNG files to keep PR creation compatible with environments that reject binary diffs.

Provide these files locally before loading in Chrome:

- `icon16.png`
- `icon48.png`
- `icon128.png`

Quick option: generate tiny safe placeholders via:

```bash
python3 projects/lensflow-chrome-theme/scripts/bootstrap-placeholders.py
```
