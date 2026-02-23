# Lensflow Chrome Theme (MV3 New Tab Extension)

Dieses Projekt ist jetzt eine **Manifest-v3 Extension mit New-Tab-Override** (statt altem Theme-Manifest).

## Was du bekommst
- schlanke New-Tab-Seite mit Fokus auf dein Bild
- zentrierte Google-Suchleiste
- konfigurierbare Quicklinks (`newtab/newtab.js`)
- optionaler Header-Strip aus `frame.jpg`

## Wichtig: PRs ohne Binärdateien
PNG/JPG-Dateien werden **nicht committed**, damit PR-Erstellung nicht mit
"Binary files are not supported" scheitert.

Lokale Runtime-Dateien:
- `assets/images/ntp-background.jpg`
- `assets/images/frame.jpg`
- `assets/icons/icon16.png`
- `assets/icons/icon48.png`
- `assets/icons/icon128.png`

Platzhalter lokal erzeugen:
```bash
python3 projects/lensflow-chrome-theme/scripts/bootstrap-placeholders.py
```

## Install & Test (Chrome 145)
1. Platzhalter oder eigene Dateien bereitstellen (siehe oben)
2. Validieren:
   ```bash
   bash projects/lensflow-chrome-theme/scripts/validate-theme.sh
   ```
3. `chrome://extensions` öffnen
4. Developer mode ON
5. **Load unpacked** → `projects/lensflow-chrome-theme`
6. Neuen Tab öffnen

## Customizer Flow (mehrere Bilder)
1. Bilder in `assets/gallery/` legen (JPG/JPEG)
2. Customizer bauen:
   ```bash
   python3 projects/lensflow-chrome-theme/scripts/build-customizer.py
   ```
3. `customizer/index.html` öffnen, Bilder auswählen, Favorit optional setzen, `selection.json` exportieren
4. Auswahl anwenden:
   ```bash
   python3 projects/lensflow-chrome-theme/scripts/apply-selection.py /PFAD/ZU/selection.json
   ```

### Verhalten bei mehreren Bildern
- `apply-selection.py` setzt weiterhin die zwei Hauptbilder für Fallback (`ntp-background.jpg`, `frame.jpg`).
- Zusätzlich schreibt es `newtab/selection.json`.
- New Tab rotiert dann über die ausgewählten Gallery-Bilder (damit nicht immer das gleiche Bild erscheint).

## Quicklinks konfigurieren
In `newtab/newtab.js` oben das Array `QUICKLINKS` anpassen.
