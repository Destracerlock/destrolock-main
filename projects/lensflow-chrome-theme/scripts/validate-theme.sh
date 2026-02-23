#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MANIFEST="$ROOT_DIR/manifest.json"

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required" >&2
  exit 1
fi

python3 - <<'PY' "$MANIFEST"
import json, sys
from pathlib import Path

manifest_path = Path(sys.argv[1])
root_dir = manifest_path.parent

data = json.loads(manifest_path.read_text(encoding='utf-8'))
required = ["manifest_version", "name", "version", "theme"]
missing = [k for k in required if k not in data]
if missing:
    raise SystemExit(f"Missing required keys: {missing}")

images = data.get("theme", {}).get("images", {})
icons = data.get("icons", {})
required_image_keys = ["theme_frame", "theme_ntp_background"]
missing_image_keys = [k for k in required_image_keys if k not in images]
if missing_image_keys:
    raise SystemExit(f"Missing required theme image keys: {missing_image_keys}")

required_icon_keys = ["16", "48", "128"]
missing_icon_keys = [k for k in required_icon_keys if k not in icons]
if missing_icon_keys:
    raise SystemExit(f"Missing required icon keys: {missing_icon_keys}")

paths_to_check = {
    "theme_frame": images["theme_frame"],
    "theme_ntp_background": images["theme_ntp_background"],
    "icon16": icons["16"],
    "icon48": icons["48"],
    "icon128": icons["128"],
}

missing_files = []
for label, rel_path in paths_to_check.items():
    target = (root_dir / rel_path).resolve()
    if not target.exists():
        missing_files.append((label, rel_path))

if missing_files:
    formatted = ", ".join(f"{label} -> {path}" for label, path in missing_files)
    raise SystemExit(f"Missing asset files: {formatted}")

print("manifest.json is valid and required theme assets exist")
PY

echo "Validation passed: $MANIFEST"
