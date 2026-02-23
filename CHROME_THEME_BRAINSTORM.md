# Brainstorm: Eigenes Google-Chrome-Design mit Familien-Fotos (ohne Personen)

## Ziel
Ein herunterladbares Chrome-Theme erstellen, damit z. B. deine Eltern es installieren können und in Chrome eure Ferienmotive sehen (z. B. Schloss Edinburgh, Dean Village, Virgin Rock).

## Aufwand (realistisch)
- **MVP (1 Theme, lokal installierbar):** ca. **1–3 Stunden**
- **Sauber verpackt + GitHub Repo + Anleitung für Eltern:** ca. **3–6 Stunden**
- **Polish (mehrere Varianten, optimierte Bilder, Versions-Updates):** ca. **1–2 Tage**

## Technischer Kern
Ein Chrome-Theme ist im Prinzip eine kleine Browser-Erweiterung mit:
- `manifest.json`
- Bilddateien (`.png`/`.jpg`)
- optionalen Farbangaben für Tabs/Toolbar

## Vorschlag für Repo-Struktur
Wenn ihr den Meeting-Timer nicht mischen wollt:

### Option A (empfohlen): Neues eigenes GitHub-Repo
- Vorteile: sauber getrennt, keine Kollisionen mit bestehendem Projekt
- Name-Ideen:
  - `lensflow-chrome-theme`
  - `family-travel-chrome-theme`

### Option B: Subprojekt im bestehenden Repo
- z. B. unter `projects/chrome-theme/`
- ok für schnellen Start, aber langfristig oft unübersichtlicher

## Branch vs. neues Repo
- **Nur Branch** reicht, wenn es ein kleines Experiment bleibt.
- **Neues Repo** ist besser, wenn:
  - andere Leute (Eltern) es später nutzen sollen,
  - es Releases/Versionen geben soll,
  - der Scope klar getrennt sein soll.

## Download/Installation für Eltern
Chrome erlaubt Themes am einfachsten über den Chrome Web Store oder lokal als entpackte Erweiterung (Developer Mode).

Für „einfacher Download + Klick + fertig“ ist der Web Store benutzerfreundlicher, braucht aber einmaligen Setup-Aufwand.

## Bild-Richtlinien (wichtig)
- Nur Bilder, bei denen ihr die Rechte habt (eigene Fotos: perfekt).
- Keine klar erkennbaren Personen (wie von dir gewünscht).
- Auf gute Auflösung achten (z. B. 1920px+ Breite für NTP-Hintergrund).

## Nächste Schritte (konkret)
1. Entscheidung: **neues Repo** oder **Subprojekt**.
2. 5–10 Lieblingsmotive auswählen.
3. Bilder zuschneiden/komprimieren.
4. Minimal-Theme mit `manifest.json` bauen.
5. Lokale Installation testen.
6. README mit Installationsanleitung für Eltern schreiben.

## Kurzfazit
Der Aufwand ist absolut machbar und eher klein bis mittel. Für dein Ziel („Eltern sollen es nutzen“) ist ein **eigenes Repo** die sauberste Lösung.
