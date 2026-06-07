###  VSCode B4X IDE Companion: A Research Paper on its LSP (Language Server Protocol) by Mashiane
### 06/04/2026
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/171176/)

Hi Fam  
  
This post seeks to address a question that I have been asked about the LSP that is built within the B4X IDE Companion Visual Studio Extension.  
  
**First things first…**  
  
1. The B4X IDE Companion is completely built using AI and is published in the [VSCode MarketPlace](https://marketplace.visualstudio.com/items?itemName=AneleMbangaMashy.b4x-intellisense)  
2. The [complete source code](https://github.com/Mashiane/VSCode-B4X-IDE-Companion) of the Extension is available in GitHub.  
  
**What is an LSP?  
  
Language Server Protocol (LSP)** is a standardized protocol that allows code editors and IDEs to communicate with programming language tools such as compilers, linters, formatters, and code analyzers. It was originally developed by Microsoft for Visual Studio Code and is now widely supported across many editors and programming languages.  
[HEADING=2]The Problem LSP Solves[/HEADING]  
Before LSP, every editor needed its own language support implementation. For example, if you wanted:  

- Auto-completion
- Go to Definition
- Find References
- Error Checking
- Refactoring

[HEADING=2]How LSP Works?[/HEADING]  
LSP uses a **client-server architecture**.   
  
**Client**  
Your editor (VS Code, Neovim, Emacs, Sublime Text, etc.)  
  
**Server**  
A language-specific process that understands the code  
  
**How did we get here?  
  
The Challenge of B4X IntelliSense** Building a true Language Server for B4X isn't easy. A massive challenge is **platform isolation**: a .b4a project must *never* load a .b4j library, even if both are installed on your machine. Add in the complexity of multiple library formats (XML, .b4xlib archives, .bas modules) and implicit type resolution, and you have a huge parsing challenge.  
**The Solution: A Dual-Indexing Architecture** To balance incredible responsiveness with deep accuracy, this extension doesn't just use one index—it uses **two** independent, complementary systems:  

1. **The Client (TypeScript Extension Host):** This handles the "deep semantic understanding." It parses XML libraries, understands your Dim declarations, and runs a sophisticated type-inference engine. This means when you chain properties (like Button1.Text.Length), the client knows exactly what type you are accessing at every step.
2. **The Server (Separate Node.js LSP Process):** This is built for absolute speed. It runs a fast, trie-based symbol index across your entire project in parallel. It powers instant prefix-based auto-completions, project-wide case-preserving renames, and rapid Go-To-Definition lookups.

The governing philosophy of this extension is: **"Nothing is assumed. Everything is factual."**. Only files confirmed to exist on disk are loaded. Only libraries explicitly declared in your #Region Project Attributes via LibraryN= are referenced.  
  
*Three things the client-side code doesn't provide:*  
  
 1. Project-wide Rename — The LSP server is the only rename provider. It reads every candidate file from disk, finds all occurrences of a symbol, skips inside strings/comments, and preserves casing (MyVar → NewVar, MYVAR → NEWVAR). The client has no equivalent.  
 2. Cross-file Go-to-Definition — The server maintains a GlobalSymbolTable that indexes every .bas/.b4x file in the project directory — not just the ones currently loaded into WorkspaceClassStore. When you F12 on a Sub name, the server finds it across all files.  
 3. Cross-file duplicate symbol warnings — The server detects when a symbol name appears in multiple files and warns: "Symbol 'X' is also defined in other files (file1.bas, file2.bas)".  
  
 So the LSP server exists because cross-file operations + process isolation justified a separate process, and the LSP protocol gave us a standard way to communicate with it.   
  
The other reason is process isolation. The server's loadFromDisk walks the entire project directory and parses every .bas/.b4x file through a worker pool. If this work happened in the extension host process, it would compete with VS Code's UI thread for CPU and memory. Running it in a forked child process means:  
  
 - Heavy indexing doesn't freeze VS Code  
 - A parser crash in a worker thread doesn't take down the extension  
 - The server can be restarted independently (up to 5 times within 5 minutes)  
  
**What does our B4X IDE Companion bring as at date of print?**  
  
Brings full IntelliSense, code navigation, diagnostics, and refactoring to B4X development inside VS Code — supporting all four platforms (B4A, B4i, B4J, B4R) — fully offline, no internet required.  
  
 *IntelliSense & Completions*  
  
 - Context-aware completions — keywords, library classes, workspace Subs, properties, events, and primitive types all merge into one list  
 - Type-inferred dot completion — type btn. and get Text, Tag, Visible, etc. because the engine chains Dim btn As Button → Button.Text → String.Length  
 - Common class bare-word completions — Log, Msgbox, CRLF, TAB, File, etc. work without typing Common.  
 - Parameter hints — signature help for Sub calls with parameter names and types  
 - Snippet completions — B4X-specific snippets for common patterns  
  
 *Code Navigation*  
  
 - Go to Definition (F12) — jumps to the source of any Sub, Type, or Class across the entire project  
 - Find All References (Shift+F12) — searches every workspace file for a symbol  
 - Go to Symbol (Ctrl+Shift+O) — outline view of Subs, Types, and Classes in the current file  
 - Workspace Symbol Search (Ctrl+T) — search across all project modules  
 - Go to Implementation & Go to Type Definition — follows type chains to the real class  
 - CodeLens — reference count annotations above Sub declarations  
 - Document Links — clickable links in code where applicable  
 - Rename Symbol (F2) — project-wide rename with case preservation (MyVar → MyCounter stays PascalCase, myvar → mycounter stays lowercase), skips strings and comments  
  
 *Diagnostics (Real-Time Warnings)*  
  
 - Type placement warnings — flags Type declarations outside Class\_Globals or Process\_Globals  
 - Type placement warnings — flags Type declarations outside Class\_Globals or Process\_Globals  
 - CallSub validation — warns when CallSub("Module", "SubName") targets a Sub that doesn't exist  
 - Unused Sub detection — identifies Subs never called anywhere, excluding event handlers and lifecycle Subs  
 - Unused library detection — flags libraries declared in the project file but never referenced in code  
 - Duplicate symbol warnings — alerts when a Sub/Type name is defined in multiple files  
  
 *Refactoring & Code Actions*  
  
 - Extract Method — select code, invoke the code action, and it's extracted into a new Sub with auto-inferred parameters  
 - Quick Fix for Type diagnostics — suggests moving Type declarations into the correct globals block  
 - Auto-close keywords — typing Sub auto-inserts End Sub, If inserts End If, etc.  
 - Format Document / Format Selection — B4X-specific indentation and spacing rules  
 - Block Comment / Uncomment — toggle comment blocks  
  
 *Project Management*  
  
 - Open B4X Project — detects platform from file extension (.b4a → B4A, .b4j → B4J, etc.), parses the project file, loads declared libraries and modules  
 - Auto-detect B4X projects — scans the workspace for project files on activation  
 - Strict platform isolation — a B4A project only loads B4A libraries, never B4J/B4i/B4R  
 - Library resolution chain — searches internal libraries folder → additional libraries folder → b4xlib archives, validating every file exists on disk before loading  
 - B4XPages, shared modules, b4xlib extraction — all resolved and loaded automatically  
 - Platform theme import — import B4X color themes into VS Code settings  
 - Project Statistics — webview dashboard showing Sub counts, library usage, module breakdown  
  
Below is the research paper about our LSP Server and how it works.  
  
[Download the LSP Research Paper from Github](https://github.com/Mashiane/VSCode-B4X-IDE-Companion/blob/main/LSP-ARCHITECTURE-RESEARCH-PAPER.pdf)  
  
You can watch an illustrator video here.  
  
  
[MEDIA=youtube]HF68y2Iw6jQ[/MEDIA]  
  
  
  
You can also listen to our podcast about this topic here.  
  
<https://github.com/Mashiane/VSCode-B4X-IDE-Companion/blob/main/Dual_Indexing_Architecture_in_B4X_IntelliSense.m4a>