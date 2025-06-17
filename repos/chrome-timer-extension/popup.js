document.getElementById("startBtn").addEventListener("click", () => {
  chrome.runtime.sendMessage({ type: "start-timer", duration: 2 });
  document.getElementById("status").innerText = "Timer started for 2 minutes.";
});
