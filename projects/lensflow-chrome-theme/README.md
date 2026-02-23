# Lensflow Chrome Theme

Eigenständiges Subprojekt für ein Google-Chrome-Design mit euren Reisebildern (ohne Personen), getrennt vom Meeting-Timer.

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
├─ assets/
│  ├─ icons/
│  │  ├─ icon16.png
│  │  ├─ icon48.png
│  │  └─ icon128.png
│  └─ images/
│     ├─ ntp-background.jpg
│     └─ frame.jpg
└─ scripts/
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
