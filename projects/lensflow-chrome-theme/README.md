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
