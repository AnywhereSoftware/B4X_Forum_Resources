### [B4XDaisyUIKit-Skills] How does it actually work? by Mashiane
### 09/13/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/172051/)

Hey gang!  
  
TLDR; [B4XDaisyUIKit-Skills](https://www.b4x.com/android/forum/threads/ai-skills-b4xdaisyuikit-skills-supercharge-claude-to-code-b4xdaisyuikit-instantly-beta.171762/) is a companion skills package for the [B4XDaisyUIKit](https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisyuikit-native-components-inspired-by-daisyui-tailwind.170352/), a DaisyUI + TailwindCSS based component framework for b4a.  
[HEADING=2][/HEADING]  
[HEADING=2]Introduction: The Problem with AI Writing B4X Code[/HEADING]  
If you have ever asked an LLM to build a mobile screen for B4A, you have probably run into these common stumbling blocks:  

1. **Invented APIs:** The AI hallucinates methods or properties that do not exist in the library.
2. **Web Framework Confusion:** Because DaisyUI and Tailwind CSS originate in the web world, LLMs frequently try to insert HTML tags, CSS styles, Flexbox, or WebViews into native B4X projects.
3. **Forgotten Wiring:** The AI writes a nice .bas page module but forgets to register it in B4XMainPage.bas or in the .b4a project file's NumberOfModules= count.
4. **"It builds, but does it look good?":** The code compiles, but touch targets are too small, content overflows the screen, or colors clash.

The **b4xdaisyuikit-skills** plugin was created to eliminate these issues entirely. It turns your AI assistant from an unpredictable code generator into a disciplined, self-verifying software engineer that delivers **100% native B4X apps on the first attempt**.  
  
[HEADING=2]The 4 Skills: How They Work Together[/HEADING]  
The ecosystem is divided into four focused skills:  
  
![](https://www.b4x.com/android/forum/attachments/173585)  
  
[HEADING=2]4.1. b4x-project-bootstrap: Greenfield Project Setup[/HEADING]  
When you say: *"Create a new inventory management app"*, this skill takes over first.  
  
It sets up the scaffolding so you never have to configure files manually:  

- Generates a clean project folder with <AppName>.b4a.
- Generates the standard B4XMainPage.bas entry point.
- Generates standard navigation shell templates (B4XPageNavDock for top navbar + bottom dock, or B4XPageNavOnly for sub-pages with back navigation).
- Automatically wires NumberOfModules and ModuleN= entries in the .b4a file.
- Provides install.ps1 and build-watch.ps1 scripts for automated single-command compilation and ADB deployment.

---

  
[HEADING=2]4.2. b4xdaisyuikit: Native UI/UX Composition[/HEADING]  
This is the creative workhorse. It translates modern DaisyUI design concepts into **100% native B4X Custom Views**.  

- **Pure Native Views:** Every button, card, navbar, modal, drawer, timeline, and input field is rendered with standard native views. No HTML, CSS, or WebView overhead.
- **Component Manifest as Ground Truth:** The AI is locked to a strict catalog of over 110 verified components. It knows every valid property, method, and event signature.
- **Consistent 3-Step Lifecycle:**The AI follows the strict B4X Custom View lifecycle:
- **Production Recipes:** Pre-engineered templates for analytics dashboards, multi-step forms, real-time feedback dialogs (B4XDaisySweetAlert), feature onboarding tours (EnjoyHint), and drawer navigation.

---

  
[HEADING=2]4.3. b4x-verify: The Conformance and Quality Gatekeeper[/HEADING]  
This is the secret weapon that stops bugs before they reach your device. It operates as a multi-stage quality pipeline:  

1. **pre-scan.ps1 (Negative Knowledge Gate):**
Fast grep scan. If the AI slipped any web syntax (HTML tags, CSS styles, Flexbox, Parent.AddView, or unverified methods) into the code, the pre-scan fails immediately and forces the AI to correct it.2. **verify-conformance.ps1 (Pre-Build API Gate):**
Verifies every component call against the official manifest. If the AI tries to call a method that does not exist, the script returns exit code 1. The code will not even attempt to compile until the issue is fixed.3. **build-watch.ps1 (Runtime Diagnostics Gate):**
Runs directly after the app launches on your Android device or emulator. It monitors logcat for runtime crashes, missing classes (ClassNotFoundException), missing assets (ResourceNotFound), touch targets smaller than 48dp, and UI jank.4. **capture-screens.ps1 & ux-review.md (Visual Audit Gate):**
Automates screen captures over ADB, then performs a visual UX inspection against Nielsen usability heuristics and WCAG 2.2 AA accessibility standards.

---

  
[HEADING=2]4.4. b4x-orchestrator: The First-Time-Right Closed Loop[/HEADING]  
The orchestrator ties everything together into a strict sequential pipeline:  
  
  
![](https://www.b4x.com/android/forum/attachments/173586)  
  
[HEADING=2]A Quick Example: How to Prompt Your AI Assistant[/HEADING]  
When working in an agentic IDE like Antigravity or Claude Code with these skills installed, you do not need to give your assistant paragraphs of defensive instructions.  
  
[HEADING=3]Good Prompt:[/HEADING]  
> *"Create a new greenfield B4A app called 'GymTracker' with two pages: a Dashboard page showing 3 Stat tiles and a Recent Workouts list, and a Log Workout form with inputs for exercise name, reps, weight, and a primary save button. Use the b4x-orchestrator to deliver it."*

[HEADING=3][/HEADING]  
[HEADING=3]What Happens Behind the Scenes:[/HEADING]  

1. The AI reads screen-contract.template.md and generates a screen contract specifying page views and interactions.
2. The AI invokes b4x-project-bootstrap to create the GymTracker directory, .b4a project file, and B4XMainPage.
3. The AI invokes b4xdaisyuikit to build B4XPageDashboard.bas and B4XPageLogWorkout.bas using legitimate library APIs.
4. The AI executes pre-scan.ps1 and verify-conformance.ps1. If any method name is slightly off, the tool fails, and the AI fixes it immediately.
5. The AI runs ./install.ps1, compiling the APK and installing it onto the active device.
6. build-watch.ps1 verifies the app runs without crashes, and capture-screens.ps1 takes screenshots to confirm proper alignment.
7. The AI presents you with the finished, tested app.

#SharingTheGoodness