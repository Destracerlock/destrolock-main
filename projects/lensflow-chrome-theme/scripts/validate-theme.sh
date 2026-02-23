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
from pathlib import Path

manifest_path = Path(sys.argv[1])
root_dir = manifest_path.parent

try:
    data = json.loads(manifest_path.read_text(encoding='utf-8'))
except json.JSONDecodeError as exc:
    raise SystemExit(f"manifest.json invalid JSON: {exc}")

required = ["manifest_version", "name", "version", "chrome_url_overrides", "icons"]
missing = [k for k in required if k not in data]
if missing:
    raise SystemExit(f"Missing required keys: {missing}")

if data["manifest_version"] != 3:
    raise SystemExit("Extension must use manifest_version 3")

newtab = data.get("chrome_url_overrides", {}).get("newtab")
if not newtab:
    raise SystemExit("Missing chrome_url_overrides.newtab")

icons = data.get("icons", {})
required_icon_keys = ["16", "48", "128"]
missing_icon_keys = [k for k in required_icon_keys if k not in icons]
if missing_icon_keys:
    raise SystemExit(f"Missing required icon keys: {missing_icon_keys}")

selection_path = root_dir / "newtab/selection.json"
if selection_path.exists():
    try:
        sel = json.loads(selection_path.read_text(encoding='utf-8'))
    except json.JSONDecodeError as exc:
        raise SystemExit(f"newtab/selection.json invalid JSON: {exc}")
    if not isinstance(sel.get("selected", []), list):
        raise SystemExit("newtab/selection.json must contain list key 'selected'")

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
PY

echo "Validation passed: $MANIFEST"
