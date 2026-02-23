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
# Lensflow Chrome Theme

Eigenständiges Subprojekt für ein Google-Chrome-Design mit euren Reisebildern (ohne Personen), getrennt vom Meeting-Timer.

## Ziel jetzt (damit es sicher sichtbar wird)
Erstmal **one-size-fits-all** stabil zum Laufen bringen. Danach können wir Varianten/Customization hinzufügen.

## Was du aktuell vorbereiten musst
1. Deine JPG/JPEG-Quellbilder nach `assets/gallery/` legen.
2. `build-customizer.py` ausführen und in der UI auswählen.
3. `apply-selection.py` ausführen, damit `assets/images/ntp-background.jpg` und `assets/images/frame.jpg` lokal erzeugt werden.
## Kannst du alles selbst machen?
**Ja – fast alles.**
Ich kann Struktur, Manifest, Theme-Konfiguration, Release-Readme und Validierung komplett vorbereiten.

### Was ich von dir brauche
Nur diese 4 Dinge:
1. **5–10 finale Bilder** (ohne Personen), z. B. `edinburgh-castle.jpg`, `dean-village.jpg`.
2. **Cover-Bild fürs New Tab** (empfohlen mind. 1920x1080).
3. **Farbwunsch** (hell/dunkel oder 1–2 Hex-Farben, z. B. `#1f2a44`).
4. Optional: **Name + kurze Beschreibung** für das Theme im Store.

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
├─ assets/
│  ├─ gallery/
│  │  └─ *.jpg
├─ assets/
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
3. `chrome://extensions` öffnen
4. Developer mode ON
5. **Load unpacked** → `projects/lensflow-chrome-theme`
6. Neuen Tab öffnen

## Customizer Flow (mehrere Bilder)
1. Bilder in `assets/gallery/` legen (JPG/JPEG)
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
## Schnellstart (Debug-sicher)
1. Validieren:
   - `bash projects/lensflow-chrome-theme/scripts/validate-theme.sh`
2. In Chrome laden:
   - `chrome://extensions`
   - Developer mode ON
   - **Load unpacked** → `projects/lensflow-chrome-theme`
3. Wenn Theme nicht sichtbar ist:
   - auf `chrome://settings/appearance` gehen
   - auf **Reset to default** klicken
   - dann unpacked Theme erneut laden

## Customization mit Preview + Auswählen + Favorit

### 1) Bilder für Auswahl bereitstellen
- Lege alle JPG/JPEG-Bilder in `assets/gallery/`.

### 2) Preview-Seite generieren
```bash
python3 projects/lensflow-chrome-theme/scripts/build-customizer.py
```
Dann `projects/lensflow-chrome-theme/customizer/index.html` im Browser öffnen.

### 3) In der UI auswählen
- Bilder per Checkbox an/abwählen.
- Ein Bild optional als Favorit markieren.
- „Auswahl als JSON herunterladen" klicken (`selection.json`).

### 4) Auswahl auf Theme anwenden
```bash
python3 projects/lensflow-chrome-theme/scripts/apply-selection.py /PFAD/ZU/selection.json
bash projects/lensflow-chrome-theme/scripts/validate-theme.sh
```

**Regel:** Favorit wird zuerst verwendet (`theme_ntp_background`), zweites gewähltes Bild wird `theme_frame`. Wenn nur ein Bild gewählt ist, wird es für beide Slots verwendet.

## Hinweis zu Binary-Dateien & PRs
- Im Git-Repo liegen absichtlich **keine** JPG-Binaries mehr (vermeidet „Binary files are not supported"-Probleme bei manchen PR-Flows).
- Die Bilddateien entstehen lokal über `apply-selection.py` oder durch manuelles Kopieren.

## Häufige Ursache, wenn "lädt aber nicht angewendet"
- `frame.jpg` oder `ntp-background.jpg` fehlt/ist leer/kaputt (0 Bytes oder falsches Dateiformat).
- Der Validator prüft genau das jetzt mit.
   └─ validate-theme.sh
```

## Konkrete Bild-Zuordnung (aktuelle Empfehlung)
- `DeanVillage_Scotland_2025.jpg` → `assets/images/ntp-background.jpg`
- `VirginRock_Ireland_2025_LandView.jpg` → `assets/images/frame.jpg`

## Schnellstart

1. Deine finalen Bilder in `assets/images/` auf die Zielnamen kopieren.
2. `manifest.json` prüfen/anpassen.
3. Validieren:
   - `bash projects/lensflow-chrome-theme/scripts/validate-theme.sh`
4. Theme lokal laden:
   - Chrome öffnen → `chrome://extensions`
   - **Developer mode** aktivieren
   - **Load unpacked** → `projects/lensflow-chrome-theme`

## Bilder & Größen (Empfehlung)
- `ntp-background.jpg`: 1920x1080 oder größer
- `frame.jpg`: breite Landschaft, 3000px+ Breite sinnvoll
- Icons: 16x16, 48x48, 128x128 PNG

## Packaging-Idee für Eltern
- Kurzfristig: ZIP vom Ordner verschicken + lokale Installation per „Load unpacked“.
- Langfristig (einfacher): Veröffentlichung im Chrome Web Store.

## Nächste Schritte
- [ ] Eigene Bilder einsetzen
- [ ] Farbschema finalisieren
- [ ] Lokal testen
- [ ] ZIP/Release erstellen
