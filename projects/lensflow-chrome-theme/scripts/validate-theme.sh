#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MANIFEST="$ROOT_DIR/manifest.json"

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required" >&2
  exit 1
fi

python3 - <<'PY' "$MANIFEST"
import json
import sys
import json, sys
from pathlib import Path

manifest_path = Path(sys.argv[1])
root_dir = manifest_path.parent

try:
    data = json.loads(manifest_path.read_text(encoding='utf-8'))
except json.JSONDecodeError as exc:
    raise SystemExit(f"manifest.json invalid JSON: {exc}")

required = ["manifest_version", "name", "version", "chrome_url_overrides", "icons"]
data = json.loads(manifest_path.read_text(encoding='utf-8'))
required = ["manifest_version", "name", "version", "theme"]
missing = [k for k in required if k not in data]
if missing:
    raise SystemExit(f"Missing required keys: {missing}")

if data["manifest_version"] != 3:
    raise SystemExit("Extension must use manifest_version 3")

newtab = data.get("chrome_url_overrides", {}).get("newtab")
if not newtab:
    raise SystemExit("Missing chrome_url_overrides.newtab")

icons = data.get("icons", {})
if data["manifest_version"] != 2:
    raise SystemExit("Chrome themes must use manifest_version 2")

images = data.get("theme", {}).get("images", {})
images = data.get("theme", {}).get("images", {})
icons = data.get("icons", {})
required_image_keys = ["theme_frame", "theme_ntp_background"]
missing_image_keys = [k for k in required_image_keys if k not in images]
if missing_image_keys:
    raise SystemExit(f"Missing required theme image keys: {missing_image_keys}")

# icons are optional for themes; validate only if provided
icons = data.get("icons", {})
if icons:
    required_icon_keys = ["16", "48", "128"]
    missing_icon_keys = [k for k in required_icon_keys if k not in icons]
    if missing_icon_keys:
        raise SystemExit(f"Missing required icon keys (icons block is present): {missing_icon_keys}")
required_icon_keys = ["16", "48", "128"]
missing_icon_keys = [k for k in required_icon_keys if k not in icons]
if missing_icon_keys:
    raise SystemExit(f"Missing required icon keys: {missing_icon_keys}")

paths_to_check = {
    "newtab_html": newtab,
    "newtab_css": "newtab/newtab.css",
    "newtab_js": "newtab/newtab.js",
    "ntp_background": "assets/images/ntp-background.jpg",
    "frame_image": "assets/images/frame.jpg",
    "icon16": icons["16"],
    "icon48": icons["48"],
    "icon128": icons["128"],
}
    "theme_frame": images["theme_frame"],
    "theme_ntp_background": images["theme_ntp_background"],
}
if icons:
    paths_to_check.update({
        "icon16": icons["16"],
        "icon48": icons["48"],
        "icon128": icons["128"],
    })

missing_files = []
empty_files = []
invalid_signatures = []

for label, rel_path in paths_to_check.items():
    target = root_dir / rel_path
    if not target.exists():
        missing_files.append((label, rel_path))
        continue

    size = target.stat().st_size
    if size == 0:
        empty_files.append((label, rel_path))
        continue

    header = target.read_bytes()[:8]
    suffix = target.suffix.lower()
    if suffix in {".jpg", ".jpeg"} and not header.startswith(b"\xff\xd8\xff"):
        invalid_signatures.append((label, rel_path, "expected JPEG header"))
    if suffix == ".png" and header != b"\x89PNG\r\n\x1a\n":
        invalid_signatures.append((label, rel_path, "expected PNG header"))

if missing_files:
    formatted = ", ".join(f"{label} -> {path}" for label, path in missing_files)
    raise SystemExit(
        "Missing required files: " + formatted +
        "\nRun: python3 projects/lensflow-chrome-theme/scripts/bootstrap-placeholders.py"
    )

if empty_files:
    formatted = ", ".join(f"{label} -> {path}" for label, path in empty_files)
    raise SystemExit(f"Empty files detected: {formatted}")

if invalid_signatures:
    formatted = ", ".join(f"{label} -> {path} ({why})" for label, path, why in invalid_signatures)
    raise SystemExit(f"Invalid image signatures: {formatted}")

print("manifest.json is valid MV3 and required New Tab files/assets exist")
    # lightweight signature check for image files
    header = target.read_bytes()[:8]
    if target.suffix.lower() in {".jpg", ".jpeg"} and not header.startswith(b"\xff\xd8\xff"):
        invalid_signatures.append((label, rel_path, "expected JPEG header"))
    if target.suffix.lower() == ".png" and header != b"\x89PNG\r\n\x1a\n":
        invalid_signatures.append((label, rel_path, "expected PNG header"))
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

if empty_files:
    formatted = ", ".join(f"{label} -> {path}" for label, path in empty_files)
    raise SystemExit(f"Empty asset files detected: {formatted}")

if invalid_signatures:
    formatted = ", ".join(f"{label} -> {path} ({why})" for label, path, why in invalid_signatures)
    raise SystemExit(f"Invalid image file signatures: {formatted}")

print("manifest.json is valid and referenced theme assets look usable")
print("manifest.json is valid and required theme assets exist")
PY

echo "Validation passed: $MANIFEST"
