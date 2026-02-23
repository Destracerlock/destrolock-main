# Lensflow Chrome Theme (MV3 New Tab Extension)

Dieses Projekt ist jetzt **keine klassische Chrome-Theme-Manifest-v2-Lösung** mehr, sondern eine **Manifest-v3 Extension mit New-Tab-Override**.

Damit funktioniert es zuverlässig in modernen Chrome-Versionen (inkl. Chrome 145):
- eigenes New Tab Layout
- Hintergrundbild aus `assets/images/ntp-background.jpg`
- dezente Header/Overlay-Leiste aus `assets/images/frame.jpg`
- zentrierte Google-Suche + Quicklinks

## Bestehender Workflow bleibt gleich
Du kannst weiterhin die vorhandenen Scripts nutzen:
- `scripts/build-customizer.py`
- `scripts/apply-selection.py`

Und die gleichen Zielpfade bleiben erhalten:
- `assets/images/ntp-background.jpg`
- `assets/images/frame.jpg`
- `assets/icons/icon16.png`, `icon48.png`, `icon128.png`

> Hinweis: Aus PR-Kompatibilitätsgründen werden PNG/JPG-Dateien nicht mehr fest committed.
> Erzeuge lokale Platzhalter mit:
> `python3 projects/lensflow-chrome-theme/scripts/bootstrap-placeholders.py`

## Projektstruktur

```text
projects/lensflow-chrome-theme/
├─ manifest.json
├─ README.md
├─ customizer/
│  └─ index.html
├─ newtab/
│  ├─ newtab.html
│  ├─ newtab.css
│  └─ newtab.js
├─ assets/
│  ├─ gallery/
│  │  └─ *.jpg
│  ├─ icons/
│  │  ├─ icon16.png
│  │  ├─ icon48.png
│  │  └─ icon128.png
│  └─ images/
│     ├─ ntp-background.jpg
│     └─ frame.jpg
└─ scripts/
   ├─ validate-theme.sh
   ├─ build-customizer.py
   └─ apply-selection.py
```

## Install & Test (Chrome 145)
1. Falls noch keine lokalen Bilder/Icons vorhanden sind, Platzhalter erzeugen:
   ```bash
   python3 projects/lensflow-chrome-theme/scripts/bootstrap-placeholders.py
   ```
2. Validieren:
   ```bash
   bash projects/lensflow-chrome-theme/scripts/validate-theme.sh
   ```
3. In Chrome öffnen: `chrome://extensions`
4. **Developer mode** einschalten
5. **Load unpacked** → `projects/lensflow-chrome-theme`
6. Neuen Tab öffnen → du solltest Hintergrund + Search + Quicklinks sehen

## Customizer-Flow
1. Bilder in `assets/gallery/` ablegen
2. Customizer bauen:
   ```bash
   python3 projects/lensflow-chrome-theme/scripts/build-customizer.py
   ```
3. `projects/lensflow-chrome-theme/customizer/index.html` öffnen
4. Auswahl treffen + `selection.json` exportieren
5. Auswahl anwenden:
   ```bash
   python3 projects/lensflow-chrome-theme/scripts/apply-selection.py /PFAD/ZU/selection.json
   ```
6. Danach erneut validieren und New Tab neu öffnen

## Binary-safe Hinweis
- Keine persönlichen Urlaubsbilder committen.
- PNG/JPG-Assets sind per `.gitignore` als lokale Runtime-Dateien vorgesehen.
- Erzeuge bei Bedarf Platzhalter lokal über `scripts/bootstrap-placeholders.py`.
