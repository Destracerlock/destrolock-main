# Lensflow Chrome Theme

Eigenständiges Subprojekt für ein Google-Chrome-Design mit euren Reisebildern (ohne Personen), getrennt vom Meeting-Timer.

## Ziel jetzt (damit es sicher sichtbar wird)
Erstmal **one-size-fits-all** stabil zum Laufen bringen. Danach können wir Varianten/Customization hinzufügen.

## Was du aktuell vorbereiten musst
1. Deine JPG/JPEG-Quellbilder nach `assets/gallery/` legen.
2. `build-customizer.py` ausführen und in der UI auswählen.
3. `apply-selection.py` ausführen, damit `assets/images/ntp-background.jpg` und `assets/images/frame.jpg` lokal erzeugt werden.

## Projektstruktur

```text
projects/lensflow-chrome-theme/
├─ manifest.json
├─ README.md
├─ customizer/
│  └─ index.html
├─ assets/
│  ├─ gallery/
│  │  └─ *.jpg
│  └─ images/
│     ├─ ntp-background.jpg
│     └─ frame.jpg
└─ scripts/
   ├─ validate-theme.sh
   ├─ build-customizer.py
   └─ apply-selection.py
```

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
