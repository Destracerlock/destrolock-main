#!/usr/bin/env python3
from __future__ import annotations

import base64
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

JPEG_BASE64 = (
    '/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxAQEBAQEA8QDw8PDw8QDw8PDw8PDw8QFREWFhURFRUYHSggGBolGxUV'
    'ITEhJSkrLi4uFx8zODMsNygtLisBCgoKDg0OGhAQGi0fHyUtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t'
    'LS0tLS0tLS0tLf/AABEIAAEAAQMBIgACEQEDEQH/xAAXAAADAQAAAAAAAAAAAAAAAAAAAQID/8QAFhEBAQEAAAAAAAAAAAAA'
    'AAAAAQAC/9oADAMBAAIQAxAAAAHRh//EABQQAQAAAAAAAAAAAAAAAAAAACD/2gAIAQEAAQUCcf/EABQRAQAAAAAAAAAAAAAAAAAA'
    'ACD/2gAIAQMBAT8Bp//EABQRAQAAAAAAAAAAAAAAAAAAACD/2gAIAQIBAT8Bp//Z'
)
PNG_BASE64 = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO7ZxWQAAAAASUVORK5CYII='


def write_file(path: Path, payload: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(payload)


def main() -> int:
    jpg = base64.b64decode(JPEG_BASE64)
    png = base64.b64decode(PNG_BASE64)

    write_file(ROOT / 'assets/images/ntp-background.jpg', jpg)
    write_file(ROOT / 'assets/images/frame.jpg', jpg)

    for icon in ('icon16.png', 'icon48.png', 'icon128.png'):
        write_file(ROOT / 'assets/icons' / icon, png)

    print('Generated placeholder assets: images + icons')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
