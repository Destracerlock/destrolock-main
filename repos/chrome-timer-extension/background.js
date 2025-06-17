chrome.runtime.onMessage.addListener((message) => {
  if (message.type === "start-timer") {
    chrome.alarms.create("standup-timer", {
      delayInMinutes: message.duration
    });
  }
});

chrome.alarms.onAlarm.addListener((alarm) => {
  if (alarm.name === "standup-timer") {
    chrome.notifications.create({
      type: "basic",
      iconUrl: "icon128.png",
      title: "Time's up!",
      message: "Next speaker please."
    });
  }
});
