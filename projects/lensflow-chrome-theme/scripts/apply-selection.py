#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
GALLERY = ROOT / "assets" / "gallery"
OUT_IMAGES = ROOT / "assets" / "images"
OUT_SELECTION = ROOT / "newtab" / "selection.json"


def ensure_jpeg(path: Path) -> None:
    header = path.read_bytes()[:3]
    if header != b"\xff\xd8\xff":
        raise ValueError(f"{path.name} is not a JPEG file. Please use JPG/JPEG images for now.")


def choose_images(selected: list[str], favorite: str | None) -> tuple[str, str, list[str]]:
def choose_images(selected: list[str], favorite: str | None) -> tuple[str, str]:
    if not selected:
        raise ValueError("No images selected.")

    ordered = selected[:]
    if favorite and favorite in ordered:
        ordered.remove(favorite)
        ordered.insert(0, favorite)

    ntp = ordered[0]
    frame = ordered[1] if len(ordered) > 1 else ordered[0]
    return ntp, frame, ordered
    return ntp, frame


def main() -> int:
    parser = argparse.ArgumentParser(description="Apply customizer selection to theme assets.")
    parser.add_argument("selection", help="Path to selection.json from customizer UI")
    args = parser.parse_args()

    selection_path = Path(args.selection).resolve()
    data = json.loads(selection_path.read_text(encoding="utf-8"))

    selected = data.get("selected", [])
    favorite = data.get("favorite")

    if not isinstance(selected, list) or not all(isinstance(x, str) for x in selected):
        raise SystemExit("Invalid selection.json: 'selected' must be a list of filenames")
    if favorite is not None and not isinstance(favorite, str):
        raise SystemExit("Invalid selection.json: 'favorite' must be null or filename string")

    ntp_name, frame_name, ordered = choose_images(selected, favorite)
    ntp_name, frame_name = choose_images(selected, favorite)

    ntp_src = GALLERY / ntp_name
    frame_src = GALLERY / frame_name
    if not ntp_src.exists() or not frame_src.exists():
        raise SystemExit("Selected image file(s) not found in assets/gallery")

    try:
        ensure_jpeg(ntp_src)
        ensure_jpeg(frame_src)
    except ValueError as exc:
        raise SystemExit(str(exc))

    OUT_IMAGES.mkdir(parents=True, exist_ok=True)
    shutil.copy2(ntp_src, OUT_IMAGES / "ntp-background.jpg")
    shutil.copy2(frame_src, OUT_IMAGES / "frame.jpg")

    OUT_SELECTION.parent.mkdir(parents=True, exist_ok=True)
    OUT_SELECTION.write_text(
        json.dumps(
            {
                "selected": ordered,
                "favorite": favorite,
            },
            indent=2,
        ) + "\n",
        encoding="utf-8",
    )

    result = {
        "applied": {
            "theme_ntp_background": ntp_name,
            "theme_frame": frame_name,
        },
        "rotation": {
            "selection_json": str(OUT_SELECTION.relative_to(ROOT)),
            "count": len(ordered),
        },
        }
    }
    print(json.dumps(result, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
