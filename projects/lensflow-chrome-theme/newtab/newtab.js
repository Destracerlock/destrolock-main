const QUICKLINKS = [
  { title: "GitHub", url: "https://github.com" },
  { title: "YouTube", url: "https://youtube.com" },
  { title: "Google Maps", url: "https://maps.google.com" },
  { title: "Lensflow Repo", url: "https://github.com/Destracerlock/destrolock-main" }
];

const FALLBACK_IMAGES = {
  background: "../assets/images/ntp-background.jpg",
  banner: "../assets/images/frame.jpg"
};

const quicklinksRoot = document.getElementById("quicklinks");

function renderQuicklinks() {
  for (const item of QUICKLINKS) {
    const a = document.createElement("a");
    a.className = "quicklink";
    a.href = item.url;
    a.target = "_blank";
    a.rel = "noopener noreferrer";

    const title = document.createElement("div");
    title.className = "title";
    title.textContent = item.title;

    const url = document.createElement("div");
    url.className = "url";
    url.textContent = item.url.replace(/^https?:\/\//, "");

    a.append(title, url);
    quicklinksRoot.append(a);
  }
}

function loadRotationIndex(key) {
  const raw = localStorage.getItem(key);
  const parsed = Number.parseInt(raw ?? "0", 10);
  return Number.isFinite(parsed) ? parsed : 0;
}

function pickFromSelection(selection, key) {
  if (!selection?.selected?.length) return null;
  const idx = loadRotationIndex(key);
  const file = selection.selected[idx % selection.selected.length];
  localStorage.setItem(key, String((idx + 1) % selection.selected.length));
  return file;
}

async function applySelectedImages() {
  try {
    const response = await fetch("selection.json", { cache: "no-store" });
    if (!response.ok) return;

    const selection = await response.json();
    const bg = pickFromSelection(selection, "lensflow:bg-index");
    const banner = pickFromSelection(selection, "lensflow:banner-index");

    if (bg) {
      document.body.style.background =
        `linear-gradient(rgba(5,10,19,.22), rgba(5,10,19,.5)), url('../assets/gallery/${bg}') center/cover no-repeat fixed`;
    }

    if (banner) {
      const topBanner = document.querySelector(".top-banner");
      if (topBanner) {
        topBanner.style.background =
          `linear-gradient(rgba(5,10,19,.2), rgba(5,10,19,.6)), url('../assets/gallery/${banner}') center/cover no-repeat`;
      }
    }
  } catch {
    // keep fallback image paths if no selection.json is present
  }
}

window.addEventListener("DOMContentLoaded", async () => {
  renderQuicklinks();
  await applySelectedImages();
  document.getElementById("searchInput")?.focus();
const quicklinksRoot = document.getElementById("quicklinks");

for (const item of QUICKLINKS) {
  const a = document.createElement("a");
  a.className = "quicklink";
  a.href = item.url;
  a.target = "_blank";
  a.rel = "noopener noreferrer";

  const title = document.createElement("div");
  title.className = "title";
  title.textContent = item.title;

  const url = document.createElement("div");
  url.className = "url";
  url.textContent = item.url.replace(/^https?:\/\//, "");

  a.append(title, url);
  quicklinksRoot.append(a);
}

window.addEventListener("DOMContentLoaded", () => {
  const input = document.getElementById("searchInput");
  input?.focus();
});
