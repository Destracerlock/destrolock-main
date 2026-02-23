const QUICKLINKS = [
  { title: "GitHub", url: "https://github.com" },
  { title: "YouTube", url: "https://youtube.com" },
  { title: "Google Maps", url: "https://maps.google.com" },
  { title: "Lensflow Repo", url: "https://github.com/Destracerlock/destrolock-main" }
];

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
