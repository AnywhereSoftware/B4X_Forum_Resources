###  VS Code B4X IDE Companion — A Complete Tutorial for Cross Platform by Mashiane
### 04/09/2026
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/170777/)

[HEADING=2]Greetings…[/HEADING]  
![](https://www.b4x.com/android/forum/attachments/171067)  
  
[HEADING=2]Introduction[/HEADING]  
For a long time, developing with B4X meant staying inside the native B4X IDE. It is a great tool, but if you are one of the many developers who prefer Visual Studio Code as your daily editor, you were left without IntelliSense, proper navigation, code formatting, or any of the modern IDE features that make coding faster and more enjoyable.  
  
**VS Code B4X IDE Companion** changes that. It is a VS Code extension that brings the full B4X development experience into Visual Studio Code — auto-complete, hover documentation, Go to Definition, Find All References, structural code formatting, build integration, and much more. Everything runs completely offline, reading directly from your existing B4X installation. Nothing to configure from scratch.  
  
![](https://www.b4x.com/android/forum/attachments/171068)  
  
This tutorial will walk you through every major feature so that by the end you can use the extension to its full potential.  
  

---

  
[HEADING=2]Requirements[/HEADING]  
Before you install, make sure you have:  
  

- **Visual Studio Code** version 1.95 or later
- An installed B4X platform — **B4A**, **B4i**, **B4J**, or **B4R** (or any combination)
- A B4X project with .bas / .b4x source files

That is all. You do not need to install Node.js separately, and you do not need to configure any library paths manually. The extension discovers everything automatically from your B4X installation.  
  

---

  
[HEADING=2]Installation[/HEADING]  

1. Open Visual Studio Code.
2. Click the **Extensions** icon in the Activity Bar (or press Ctrl+Shift+X).
3. Search for **B4X IDE Companion**.
4. Click **Install**.

Alternatively, download the .vsix file and install it manually via: Extensions panel → ⋯ menu → Install from VSIX…  
  
Once installed, the extension activates automatically whenever you open a .bas or .b4x file.  
  

---

  
[HEADING=2]Opening Your First B4X Project[/HEADING]  
The most important first step is to open your project through the extension — not just drag-and-drop a folder into VS Code.  
  

1. Press Ctrl+Shift+P to open the Command Palette.
2. Type **B4X Companion: Open B4X Project…** and press Enter.
3. A file picker opens. Navigate to your project and select the project file:

- .b4a for Android projects
- .b4i for iOS projects
- .b4j for Java/Desktop projects
- .b4r for Arduino/Raspberry Pi projects

![](https://www.b4x.com/android/forum/attachments/171069)  
  
After selecting your project, wait until the extension finishes loading. A status indicator shows on bottom left of your VSCode app.  
  
![](https://www.b4x.com/android/forum/attachments/171071)  
  
Wait until this is indicating …Ready before you can use the extension  
  
![](https://www.b4x.com/android/forum/attachments/171072)  
  
***Highlight: Context Menu (right click in code window)  
  
When your .bas file is opened (click on left treeview, you can right click to show the context menu and access the B4X Companion context menu)***  
  
![](https://www.b4x.com/android/forum/attachments/171070)  
  
**Hover Intellisense**  
  
![](https://www.b4x.com/android/forum/attachments/171086)  
  
**Dot Intellisense**  
  
![](https://www.b4x.com/android/forum/attachments/171087)  
  
Rule #1: Always Backup your code first (the extension back-ups your project every 10 minutes)  
  
The extension then performs several things automatically in sequence:  
  

- Adds the project folder to your VS Code workspace
- Scans %APPDATA%\Anywhere Software\ to find your platform INI files
- Reads library folder paths from those INI files
- Parses the <Libraries> section of your project file to know which libraries to load
- Loads XML library descriptors for all declared libraries
- Extracts and indexes .b4xlib archives
- Starts the local Language Server in the background
- Applies your B4X IDE font and color theme as hints in VS Code

> **Tip:** You only need to open your project this way once per session. The extension remembers the last opened project and automatically reloads IntelliSense on the next VS Code launch.

---

  
[HEADING=2]IntelliSense: Auto-Complete[/HEADING]  
Once your project is loaded, auto-complete is available throughout your .bas files.  
  
[HEADING=3]Keyword completions[/HEADING]  
Start typing any B4X keyword and the completion list appears. All 70+ keywords are covered — If, For, Select, Try, Dim, Return, ExitSub, and more. Each completion includes a description of what it does.  
  
[HEADING=3]Class and method completions[/HEADING]  
When you type a class name followed by a dot, the extension resolves the type via the cross-file type inference engine and shows all available methods, properties, and fields from the matching library descriptor or workspace module.  
  
Dim btn As Button  
btn. ' <- completion list shows all Button methods and properties  
[HEADING=3]Local variable and Sub completions[/HEADING]  
Variables declared with Dim in the current Sub, and all Subs declared in the current file, are included in the completion list automatically. You do not need to be in the same scope — the extension indexes the entire current file.  
  
[HEADING=3]Workspace-wide completions[/HEADING]  
Classes and modules declared in other .bas files in your workspace are also available. If you define a custom class module and reference it in another file, completions for that class appear correctly.  
  
[HEADING=3]Preprocessor directive completions[/HEADING]  
Type # and a completion list appears for all B4X preprocessor directives: #If B4A, #Region, #End Region, AdditionalJar:, Event:, and more — immediately usable without memorising the exact syntax.  
  
[HEADING=3]Triggering completions manually[/HEADING]  
If the suggestion list does not appear automatically, press Ctrl+Space to trigger it at any time.  
  

---

  
[HEADING=2]IntelliSense: Hover Documentation[/HEADING]  
Hover your mouse cursor over any symbol — a Sub name, a class name, a method call, a variable — and a tooltip appears with full documentation.  
  
For **library classes and methods**, the hover tooltip shows:  
  

- The method signature with all parameters
- Return type
- A description from the library descriptor

For **workspace Subs**, the hover tooltip shows:  
  

- The Sub signature
- Its location (file and line)
- Links to **Go to Definition**, **Find All References**, and **Search Online**

You can click those links directly from inside the hover tooltip without closing it or moving your cursor.  
  
For **B4X primitive types** (String, Int, Boolean, Long, Float, Double, Byte), hover shows type documentation explaining the range and purpose of each type.  
  

---

  
[HEADING=2]IntelliSense: Signature Help[/HEADING]  
When you are typing arguments inside a Sub call, the extension shows a parameter hint bar at the top of the cursor. As you move through each argument separated by commas, the current parameter is highlighted.  
  
ac.Initialize("ac", Me)  
' ^– hint shows: MessageSender As Object  
This works for both library methods and workspace-defined Subs. It is triggered automatically when you type ( or ,. You can also trigger it manually with Ctrl+Shift+Space.  
  

---

  
[HEADING=2]Code Navigation[/HEADING]  
[HEADING=3]Go to Definition — F12[/HEADING]  
Press F12 (or right-click → **B4X Companion → Go to Definition**) on any symbol to jump to its definition.  
  
The extension resolves in the following order:  
  

1. Local Sub or Type in the current file
2. Sub defined in another .bas module in the workspace
3. Method in an XML library descriptor
4. Class defined in the workspace
5. Class defined in an XML library

This means that pressing F12 on a Sub from another module, a library class, or your own custom class module all work correctly.  
  
[HEADING=3]Peek Definition — Alt+F12[/HEADING]  
Press Alt+F12 to open an **inline peek window** showing the definition without navigating away from your current position. The definition appears embedded in the editor. Press Escape to close it.  
  
[HEADING=3]Find All References — Shift+F12[/HEADING]  
Press Shift+F12 on any symbol to find every place it is used. Unlike many editors, this extension searches **all .bas and .b4x files on disk in your workspace** — not just the files you currently have open. Results appear in VS Code's native References panel, grouped by file with exact line numbers.  
  
[HEADING=3]Document Symbol Outline — Ctrl+Shift+O[/HEADING]  
Press Ctrl+Shift+O to open a fuzzy-searchable outline of the current file. It lists every Sub, Type, Region, and global variable in the file with their line positions. Selecting an entry jumps directly to it. This is the fastest way to navigate to a specific Sub in a large module.  
  
[HEADING=3]Workspace Symbol Search — Ctrl+T[/HEADING]  
Press Ctrl+T to search symbols across the **entire workspace and all loaded XML libraries** at once. Type any part of a name and matching Subs, classes, methods, and properties appear in a scrollable picker. Up to 500 symbols are returned, covering both your own code and library APIs together.  
  

---

  
[HEADING=2]Rename Symbol — F2[/HEADING]  
Press F2 on any Sub name, Type name, or variable to rename it across all project files in one step.  
  
The rename is **case-preserving**: if the original symbol is written as MYVAR in one place and MyVar in another, each occurrence is renamed in the matching case style automatically. You will see a preview of all affected files before the rename is applied.  
  

---

  
[HEADING=2]Code Lens — Inline Reference Counts[/HEADING]  
Above each Sub declaration you will see a small line like:  
  
3 references (document) · 8 references (workspace)  
This is the **Code Lens** display. It shows how many times that Sub is called in the current file and across the full workspace. Clicking the count triggers **Find All References** immediately, opening the full reference list in the panel below.  
  
This is especially useful for identifying unused Subs or understanding how widely a Sub is used across a large project.  
  

---

  
[HEADING=2]Code Formatting[/HEADING]  
[HEADING=3]Format Document — Shift+Alt+F[/HEADING]  
Press Shift+Alt+F (or right-click → **B4X Companion → Format Document**) to apply structural formatting to the entire file.  
  
The formatter handles:  
  

- **Block indentation** for Sub/End Sub, If/Else If/Else/End If, For/Next, Select Case/Case/End Select, Try/Catch/End Try, Do/Loop, While/Loop, #Region/#End Region, and #If/#End If
- **Keyword casing** — normalises end sub to End Sub, dim to Dim, if to If, etc. ALLCAPS identifiers (like SQL\_QUERY) are left unchanged
- **Blank line management** — collapses multiple consecutive blank lines into one, and ensures one blank line before each Sub
- **String and comment protection** — content inside "double-quoted strings" and 'comment lines is never modified

If your project has a designer-generated #EndOfDesignText@ header at the top, the formatter leaves everything above that line untouched.  
  
[HEADING=3]Format Selection[/HEADING]  
Select a range of lines and use right-click → **B4X Companion → Format Selection** to format only the selected block.  
  
[HEADING=3]Un-Format Document[/HEADING]  
Right-click → **B4X Companion → Un-Format Document** removes all leading indentation from every line, left-aligning the entire file. This is useful if you need to paste code into the native B4X IDE which has its own indentation engine.  
  
[HEADING=3]Remove Blank Lines[/HEADING]  
Right-click → **B4X Companion → Remove Blank Lines** removes every empty line in the file, compacting it into a single continuous block. You can follow this with Format Document to re-apply spacing and indentation cleanly.  
  
[HEADING=3]Remove Comments[/HEADING]  
Right-click → **B4X Companion → Remove Comments** deletes every line that begins with ' (B4X comment style). The formatter is applied automatically afterward. This is useful for sharing clean production code without leaving debug notes behind.  
  

---

  
[HEADING=2]Block Comments[/HEADING]  
Select one or more lines and use:  
  

- **Block Comment** — adds ' to the start of each selected line
- **Un-Block Comment** — removes the leading ' from each selected line

Blank lines and lines that are already commented/uncommented in the opposite direction are skipped gracefully. These are available in the right-click **B4X Companion** submenu.  
  

---

  
[HEADING=2]Code Snippets[/HEADING]  
The extension includes over 100 code snippets for common B4X patterns. Type the snippet prefix and press Tab to expand it.  
  
Some of the most useful ones:  
  
[TABLE]  
[TR]  
[TH]Prefix[/TH]  
[TH]Expands to[/TH]  
[/TR]  
[TR]  
[TD]sub[/TD]  
[TD]Basic Sub / End Sub block[/TD]  
[/TR]  
[TR]  
[TD]pubsub[/TD]  
[TD]Public Sub template[/TD]  
[/TR]  
[TR]  
[TD]privsub[/TD]  
[TD]Private Sub template[/TD]  
[/TR]  
[TR]  
[TD]eventsub[/TD]  
[TD]Event Sub template[/TD]  
[/TR]  
[TR]  
[TD]if[/TD]  
[TD]If / End If block[/TD]  
[/TR]  
[TR]  
[TD]ife[/TD]  
[TD]If / Else / End If block[/TD]  
[/TR]  
[TR]  
[TD]foreach[/TD]  
[TD]For Each … In … Next loop[/TD]  
[/TR]  
[TR]  
[TD]select[/TD]  
[TD]Select Case / Case / End Select block[/TD]  
[/TR]  
[TR]  
[TD]try[/TD]  
[TD]Try / Catch / End Try block[/TD]  
[/TR]  
[TR]  
[TD]type[/TD]  
[TD]Type declaration block[/TD]  
[/TR]  
[TR]  
[TD]b4xpage[/TD]  
[TD]Full B4XPage template[/TD]  
[/TR]  
[TR]  
[TD]customview[/TD]  
[TD]Custom view template[/TD]  
[/TR]  
[/TABLE]  
Experiment with short prefixes followed by Tab — there are snippets for the entire B4X toolkit.  
  

---

  
[HEADING=2]Auto-Close Keywords[/HEADING]  
When you finish typing a block opener and press Enter, the extension automatically inserts the matching closing keyword on a new line below:  
  
[TABLE]  
[TR]  
[TH]You type[/TH]  
[TH]Auto-inserted[/TH]  
[/TR]  
[TR]  
[TD]Sub MySub + Enter[/TD]  
[TD]End Sub[/TD]  
[/TR]  
[TR]  
[TD]If condition Then + Enter[/TD]  
[TD]End If[/TD]  
[/TR]  
[TR]  
[TD]For i = 1 To 10 + Enter[/TD]  
[TD]Next[/TD]  
[/TR]  
[TR]  
[TD]Select sVar + Enter[/TD]  
[TD]End Select[/TD]  
[/TR]  
[TR]  
[TD]Try + Enter[/TD]  
[TD]End Try[/TD]  
[/TR]  
[/TABLE]  
This keeps your blocks closed and ready to fill in without manual typing.  
  

---

  
[HEADING=2]Diagnostics and Code Actions[/HEADING]  
[HEADING=3]Type Placement Validation[/HEADING]  
B4X requires that Type declarations be placed inside Class\_Globals or Process\_Globals. If you accidentally place a Type block outside those scopes, the extension will underline it with a warning in the editor.  
  
Press Ctrl+. (or click the lightbulb icon) and choose **Move Type to Class\_Globals** to let the extension automatically move the block to the correct location with a single click.  
  
[HEADING=3]CallSub Validation[/HEADING]  
When you use CallSub, CallSubDelayed, or CallSub3 to invoke a Sub by name (as a string), the extension validates that the target Sub actually exists in your project. If not, a warning is shown under the call.  
  
CallSub(Me, "Button1\_Click") ' <- warned if Button1\_Click doesn't exist  
This catches a common source of silent runtime errors — calling a Sub that was renamed or deleted — before you ever run the app.  
  
[HEADING=3]Extract Method[/HEADING]  
Select a block of code you want to refactor into its own Sub, then press Ctrl+. and choose **Extract Method**. The extension:  
  

1. Analyses the selected code to infer which variables need to be passed as parameters
2. Creates a new Sub with the inferred parameter list
3. Shows a preview of the result before applying

This is available in both the context menu under **B4X Companion → Quick Fix** and via the Ctrl+. shortcut.  
  

---

  
[HEADING=2]Code Folding[/HEADING]  
The editor lets you collapse and expand any of the following block types by clicking the fold gutter arrow or pressing Ctrl+Shift+[:  
  

- Sub / End Sub
- If / End If
- For / Next
- Select Case / End Select
- Try / Catch / End Try
- Do / Loop
- While / Loop
- Type / End Type
- #Region / #End Region

Large files with many Subs become much easier to navigate when you can fold down the Subs you are not currently working on.  
  

---

  
[HEADING=2]Search Online[/HEADING]  
Right-click on any word in your code and choose **B4X Companion → Search Online**. This opens a browser tab with a B4X forum search pre-filtered for your platform (B4A, B4J, B4i, or B4R) and the word under the cursor as the search query. It is the fastest way to look up how a library class or method is used by the community.  
  

---

  
[HEADING=2]Build and Install[/HEADING]  
Once your project is open, you can trigger a full build and device install without leaving VS Code.  
  
Press Ctrl+Shift+P → **B4X Companion: Build & Install Project**.  
  

- For **B4A** projects: calls B4ABuilder.exe, compiles the project, and pushes the resulting APK to a connected Android device via adb
- For **B4J** projects: calls B4JBuilder.exe and builds the JAR

The build output appears in the VS Code terminal panel. Build errors are shown inline. This requires that your B4X platform installation path is correctly detected (or set via b4xIntellisense.b4aInstallPath in settings).  
  

---

  
[HEADING=2]Developer Tools[/HEADING]  
[HEADING=3]Capture GIF from Device[/HEADING]  
Ctrl+Shift+P → **B4X Companion: Capture GIF from Device**  
  
Records a GIF video from a connected Android device using adb and ffmpeg. Useful for creating demo videos or bug reports. The GIF is saved to your project folder.  
  
> Requires adb to be on your system PATH and ffmpeg installed.

[HEADING=3]Capture Screenshots[/HEADING]  
Ctrl+Shift+P → **B4X Companion: Capture Screenshots (Scroll)**  
  
Captures a sequence of screenshots from a connected Android device, intended for scrolling content. Screenshots are saved to your project folder.  
  

---

  
[HEADING=2]Theme Import from B4X IDE[/HEADING]  
If you have customised the color theme inside your native B4X IDE and want the same colours in VS Code:  
  

1. Press Ctrl+Shift+P → **B4X Companion: Import Theme From B4A Install**
2. A picker shows all .vssettings theme files from your B4A installation's Themes/ folder
3. Select a theme and it is imported and applied to VS Code

> **Note:** Theme import is best-effort. Most standard B4A themes translate well, but some custom colour mappings may not have a direct VS Code equivalent.

---

  
[HEADING=2]Settings Reference[/HEADING]  
All settings are available at File → Preferences → Settings → search **B4X Companion**. Here are the key ones to know:  
  
[TABLE]  
[TR]  
[TH]Setting[/TH]  
[TH]What it controls[/TH]  
[/TR]  
[TR]  
[TD]b4aIniPath[/TD]  
[TD]Override the auto-detected B4A INI path. Leave blank for automatic detection.[/TD]  
[/TR]  
[TR]  
[TD]b4jIniPath[/TD]  
[TD]Override the auto-detected B4J INI path.[/TD]  
[/TR]  
[TR]  
[TD]b4iIniPath[/TD]  
[TD]Override the auto-detected B4i INI path.[/TD]  
[/TR]  
[TR]  
[TD]b4rIniPath[/TD]  
[TD]Override the auto-detected B4R INI path.[/TD]  
[/TR]  
[TR]  
[TD]b4aInstallPath[/TD]  
[TD]Path to B4A installation folder (needed for Build & Install and theme import).[/TD]  
[/TR]  
[TR]  
[TD]autoApplyIni[/TD]  
[TD]Whether to apply font/theme hints from INI automatically. Options: prompt, always, never.[/TD]  
[/TR]  
[TR]  
[TD]autoAddProjectFolderOnOpen[/TD]  
[TD]Add the project folder to the workspace when opening a project. Default: true.[/TD]  
[/TR]  
[TR]  
[TD]autoLoadProjectAssets[/TD]  
[TD]Automatically load libraries and start the LSP after opening a project. Default: true.[/TD]  
[/TR]  
[TR]  
[TD]autoBackupInterval[/TD]  
[TD]How often (in milliseconds) to auto-backup the project folder. Default: 600000 (10 minutes).[/TD]  
[/TR]  
[TR]  
[TD]extractMethod.previewBehavior[/TD]  
[TD]How Extract Method shows results: prompt, autoApply, or alwaysPreview.[/TD]  
[/TR]  
[TR]  
[TD]preferLiveSources[/TD]  
[TD]Use live workspace and XML sources rather than the bundled API index. Default: true.[/TD]  
[/TR]  
[TR]  
[TD]debug[/TD]  
[TD]Enable a timestamped debug log file for diagnosing extension issues.[/TD]  
[/TR]  
[/TABLE]  
For most users, the defaults work without any changes. You only need to touch these settings if your B4X installation is in a non-standard location.  
  

---

  
[HEADING=2]How Auto-Discovery Works[/HEADING]  
You may wonder how the extension finds your libraries without any configuration. Here is what happens under the hood:  
  
When you open a project, the extension scans %APPDATA%\Anywhere Software\ and looks for each platform's INI file:  
  
[TABLE]  
[TR]  
[TH]Platform[/TH]  
[TH]Folder[/TH]  
[TH]INI File[/TH]  
[/TR]  
[TR]  
[TD]B4A[/TD]  
[TD]Basic4android\[/TD]  
[TD]b4xV5.ini[/TD]  
[/TR]  
[TR]  
[TD]B4i[/TD]  
[TD]B4i\[/TD]  
[TD]b4xV5.ini[/TD]  
[/TR]  
[TR]  
[TD]B4J[/TD]  
[TD]B4J\[/TD]  
[TD]b4xV5.ini[/TD]  
[/TR]  
[TR]  
[TD]B4R[/TD]  
[TD]B4R\[/TD]  
[TD]b4xV5.ini[/TD]  
[/TR]  
[/TABLE]  
From each INI file it reads the LibrariesFolder and AdditionalLibrariesFolder paths, then loads XML descriptors for only the libraries declared in your project's <Libraries> section. It does not load the entire library catalogue — only what your project actually uses — which keeps IntelliSense fast and relevant.  
  
Parsed library metadata is cached in a persistent SQLite database so subsequent loads are near-instant.  
  

---

  
[HEADING=2]Known Limitations[/HEADING]  

- The XML parser does not currently process <event>, <objectwrapper>, or <owner> elements from library descriptors. Some specialised library metadata may not appear in completions.
- Theme import from .vssettings is best-effort. Highly customised B4A themes may not translate perfectly.

---

  
[HEADING=2]Conclusion[/HEADING]  
VS Code B4X IDE Companion brings the complete developer toolkit that B4X developers deserve: real IntelliSense, reliable navigation, structural formatting, safety diagnostics, effortless refactoring, and build integration — all working offline from your existing installation with zero manual configuration.  
  
Open your project, start typing, and let the extension handle the rest.  
  
If you encounter any issues or have feature requests, post in the B4X forum thread or open an issue on the extension repository. The extension is actively developed and community feedback directly shapes what comes next.  
  
Happy coding.