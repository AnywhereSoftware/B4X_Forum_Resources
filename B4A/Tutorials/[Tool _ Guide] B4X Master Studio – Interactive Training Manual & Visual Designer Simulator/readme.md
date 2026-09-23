### [Tool / Guide] B4X Master Studio – Interactive Training Manual & Visual Designer Simulator by Lammies
### 09/17/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/172095/)

Hi Everyone,  
  
I would like to share a project created for both newcomers and seasoned developers in the B4X ecosystem: B4X Master Studio.  
  
It is an interactive web-based training manual and visual simulator designed to explore and understand the modern B4X philosophy—especially B4XPages, the Visual Designer & Anchors, and B4J/B4A deployment workflows.  
  
You can either run it instantly in your browser (no installation) or download and run it offline on your local computer using the provided 1-click batch launcher.  
  
I will only show how to run it locally on you Windows PC:  
How to Run It Locally on Your Windows PC (1-Click Launch)  
  
If you prefer to keep and run it offline on your own machine, follow these simple steps:  
  
Prerequisite:  
  
You only need Node.js (LTS version) installed on your PC: [Download Node.js here](https://nodejs.org/) (Standard, free installer).  
  
Installation & Running:  
  
Download and unzip the project folder (e.g. B4XWEBTraining).  
Inside the project folder, simply double-click run.bat.  
  
What run.bat handles automatically for you:  
  
Verifies that Node.js is present.  
Installs all required dependencies on first launch (npm install).  
Checks if port 3000 is occupied by an earlier session and automatically frees it (preventing EADDRINUSE errors).  
Launches the local server and automatically pops open your default web browser at <http://localhost:3000>.  
  
Tip: To stop the server when you are done, simply close the Command Prompt window or press Ctrl + C.  
  
🚀 Features Included in the Studio  
  
Interactive Visual Designer & Anchor Simulator:  
Test how controls behave under LEFT, RIGHT, BOTH, TOP, and BOTTOM anchors when dynamically switching between phone portrait, tablet landscape, and desktop window sizes. Includes real-time AutoScaleAll simulation.  
  
Environment Path Validator:  
An interactive checker that verifies your paths to javac.exe (Java 19), android.jar, and B4A-Bridge, catching spaces in directory names and version mismatches before compiling.  
  
8-Module Curated Curriculum:  
  
Ecosystem & Philosophy (Native cross-compilation)  
Setup & SDK Configuration  
Visual Designer, Anchors & AutoScaleAll  
Modern B4XPages Architecture (Eliminating Activity lifecycle issues)  
Resumable Subs & Async Programming (Wait For, Sleep(0), HttpJob)  
Cross-Platform Data Persistence (SQLite, DBUtils, DirInternal vs DirData)  
End-to-End Task Manager Blueprint  
Production Deployment (TargetSDK 34 Google Play AAB & B4JPackager11 Standalone EXE)  
  
Forum Wisdom & Anti-Pattern Cheatsheet:  
Side-by-side comparisons highlighting best practices from Erel and forum veterans (e.g., avoiding deprecated DoEvents, managing runtime permissions, and preventing memory leaks).  
  
Interactive Inno Setup Script Generator:  
Configures ready-to-compile .iss scripts to package your standalone B4J builds into professional Windows installers.  
  
Feedback and suggestions are welcome!  
I hope this provides a helpful reference and training resource for the B4X community.