// the following lines will be replaced by docker/configurator, when it runs in a docker-container
window.onload = function () {
  const ui = SwaggerUIBundle({
    url: "../help?format=openapi",
    dom_id: '#swagger-ui',
    deepLinking: true,
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl
    ],
    layout: "StandaloneLayout"
  });

  window.ui = ui;

  // Inject a manual toggle feature inside Swagger's header top bar for Desktop users
  setTimeout(injectDesktopToggleButton, 1000);

  refreshB4XCode();
};

function refreshB4XCode() {
  const codeBox = document.getElementById("b4x-code-box");
  codeBox.innerText = "Syncing network templates with WebApiUtils maps...";

  fetch("../help?format=snippets")
    .then(response => {
      if (!response.ok) throw new Error("Could not reach HelpHandler metadata channels.");
      return response.text();
    })
    .then(data => {
      codeBox.innerText = data;
    })
    .catch(error => {
      codeBox.innerText = "Error loading snippets: " + error.message;
    });
}

// -----------------------------------------------------------------
// CLIPBOARD INTERACTIVE OPERATION METHODS
// -----------------------------------------------------------------
function copyAllCode() {
  const codeText = document.getElementById("b4x-code-box").innerText;
  const copyBtn = document.getElementById("copy-btn");

  navigator.clipboard.writeText(codeText).then(() => {
    // Provide a temporary visual completion verification state update
    const originalText = copyBtn.innerHTML;
    copyBtn.innerHTML = "✅ Copied!";
    copyBtn.style.background = "#98c379";

    setTimeout(() => {
      copyBtn.innerHTML = originalText;
      copyBtn.style.background = "#61afef";
    }, 2000);
  }).catch(err => {
    alert("Clipboard copy failed: " + err);
  });
}

// -----------------------------------------------------------------
// RESPONSIVE SCREEN STATE TOGGLE ENGINE
// -----------------------------------------------------------------
function toggleSidebar() {
  const sidebar = document.getElementById("b4x-sidebar");

  if (window.innerWidth <= 992) {
    // Handle sliding sheet animation states for phone views
    sidebar.classList.remove("collapsed");
    sidebar.classList.toggle("active");
  } else {
    // Handle width collapses directly for desktop view configurations
    sidebar.classList.remove("active");
    sidebar.classList.toggle("collapsed");
  }
}

// Inject a dedicated "Show Snippets" controller inside the base top bar link array layout
function injectDesktopToggleButton() {
  const topbar = document.querySelector(".topbar-wrapper");
  if (topbar) {
    const btn = document.createElement("button");
    btn.innerHTML = "⚡ Toggle B4X Snippets";
    btn.style.cssText = "background: #61afef; color: #1e222b; border: none; padding: 8px 14px; border-radius: 4px; font-weight: bold; cursor: pointer; margin-left: auto; font-size: 13px;";
    btn.onclick = toggleSidebar;
    topbar.appendChild(btn);
  }
}

// Add this precise html class toggle routine at the bottom of your swagger-initializer.js file
function toggleMobileTheme() {
  const htmlElement = document.documentElement; // This grabs the <html> element
  const themeBtn = document.getElementById("mobile-theme-btn");

  // Directly toggle the "dark-mode" class on the <html> tag
  if (htmlElement.classList.contains("dark-mode")) {
    htmlElement.classList.remove("dark-mode");
    themeBtn.innerHTML = "🌙";
    themeBtn.style.background = "#3e4451";
    themeBtn.style.color = "#ffcb6b";
  } else {
    htmlElement.classList.add("dark-mode");
    themeBtn.innerHTML = "☀️";
    themeBtn.style.background = "#abb2bf";
    themeBtn.style.color = "#d19a66";
  }
}