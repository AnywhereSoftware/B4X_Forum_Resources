### 🎁🚀 NEW FREE B4J TEMPLATE — MONACO EDITOR STUDIO 🚀🎁 by fernando1987
### 11/08/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/172305/)

I want to share a new free project template for B4J:  
  
🔥 **Monaco Editor Studio**  
  
![](https://www.b4x.com/android/forum/attachments/174489)  
  
**![](https://www.b4x.com/android/forum/attachments/174247)  
  
![](https://www.b4x.com/android/forum/attachments/174248)  
  
![](https://www.b4x.com/android/forum/attachments/174249)  
  
![](https://www.b4x.com/android/forum/attachments/174250)  
  
  
![](https://www.b4x.com/android/forum/attachments/174251)**  
  
  
This template uses **MonacoEditorView**, included with **JDashboardUI**, to create a modern desktop code editor based on Monaco.  
  
This is more than just a form containing an editor.  
  
The template already provides much of the structure required to start building your own code editor, developer tool or even a small custom IDE. 💻  
  
━━━━━━━━━━━━━━━━━━━━  
✨ WHAT IS INCLUDED?  
━━━━━━━━━━━━━━━━━━━━  
  
✅ Monaco Editor integrated with JDashboardUI  
✅ Multiple documents in native tabs  
✅ New file  
✅ Open file  
✅ Save  
✅ Save As  
✅ Close document  
✅ Save / Discard / Cancel confirmation for modified files  
✅ Built-in search  
✅ Native B4X procedure navigation  
✅ B4X snippets  
✅ Status bar  
✅ Custom menus with icons  
✅ Custom JDashboardUI window chrome  
✅ Automatic language detection from file extensions  
✅ External file modification detection before overwriting  
✅ UTF-8 file loading and saving  
✅ Original CRLF / LF line endings are preserved  
  
The template also correctly preserves B4X project/module metadata located before:  
  

```B4X
@EndOfDesignText@
```

  
  
This metadata stays outside the editor and is reattached unchanged when the file is saved.  
  
━━━━━━━━━━━━━━━━━━━━  
🎨 EDITOR THEMES  
━━━━━━━━━━━━━━━━━━━━  
  
Several Monaco themes are already included:  
  
✅ VS Dark  
✅ VS Light  
✅ Dracula  
✅ Catppuccin Mocha  
✅ GitHub Dark  
  
And the selected theme does not affect only Monaco.  
  
The window, menus, dialogs and other UI elements also adapt to the selected palette. 🎨  
  
━━━━━━━━━━━━━━━━━━━━  
💻 MULTIPLE LANGUAGES  
━━━━━━━━━━━━━━━━━━━━  
  
The Language menu allows you to quickly switch Monaco's language mode.  
  
The template includes:  
  
✅ B4X  
✅ JavaScript  
✅ JSON  
✅ XML  
✅ HTML  
✅ CSS  
✅ Python  
✅ SQL  
✅ Markdown  
✅ Plain Text  
  
Additional Monaco-supported languages can also be added easily.  
  
━━━━━━━━━━━━━━━━━━━━  
⌨️ INCLUDED SHORTCUTS  
━━━━━━━━━━━━━━━━━━━━  
  
Common shortcuts are already configured:  
  

```B4X
Ctrl + N       New file  
Ctrl + O       Open file  
Ctrl + S       Save  
Ctrl + Shift+S Save As  
Ctrl + W       Close document
```

  
  
━━━━━━━━━━━━━━━━━━━━  
🧩 COMPLETE SOURCE CODE  
━━━━━━━━━━━━━━━━━━━━  
  
Because this is a B4J project template, the complete source code is included.  
  
Some of the main files are:  
  

```B4X
EditorWorkspace.bas  
EditorDialogs.bas  
editor-host.js  
welcome.bas
```

  
  
EditorWorkspace.bas manages the window, tabs, documents, menus and per-document state.  
  
EditorDialogs.bas uses JDashboardUI components to provide custom dialogs.  
  
editor-host.js demonstrates how to extend and communicate with Monaco Editor directly.  
  
This also makes the template a practical example of how to use **MonacoEditorView in a real B4J application**.  
  
━━━━━━━━━━━━━━━━━━━━  
⚙️ HOW TO INSTALL  
━━━━━━━━━━━━━━━━━━━━  
  
Installation is very simple.  
  
Copy:  
  

```B4X
Monaco Editor Studio.b4xtemplate
```

  
  
to your:  
  

```B4X
Additional Libraries
```

  
  
folder.  
  
You can check the configured path from:  
  

```B4X
Tools → Configure Paths → Additional Libraries
```

  
  
Then refresh or restart B4J.  
  
When creating a new B4J project, select:  
  
🔥 **Monaco Editor Studio**  
  
as the project template.  
  
B4J will automatically create a new project containing all the required source files and assets.  
  
━━━━━━━━━━━━━━━━━━━━  
📦 NO MANUAL MONACO COPY REQUIRED  
━━━━━━━━━━━━━━━━━━━━  
  
There is no need to copy an existing Objects/monaco folder from another project.  
  
JDashboardUI automatically extracts its bundled Monaco runtime when the new application runs for the first time.  
  
Just make sure the application directory is writable during the initial extraction.  
  
━━━━━━━━━━━━━━━━━━━━  
📋 REQUIREMENTS  
━━━━━━━━━━━━━━━━━━━━  
  
✅ B4J 10.70 or later  
✅ Latest JDashboardUI  
✅ jCore  
✅ jFX  
  
MonacoEditorView is included with JDashboardUI.  
  
━━━━━━━━━━━━━━━━━━━━  
🎁 FREE TEMPLATE  
━━━━━━━━━━━━━━━━━━━━  
  
**Monaco Editor Studio is completely free.**  
  
You can use it as a starting point for:  
  
💻 Code editors  
🧩 Developer tools  
📝 Advanced text editors  
⚙️ Configuration editors  
🛠 Custom IDEs  
📄 SQL / JSON / XML / HTML editors  
🚀 Your own B4J tools  
  
The goal is to provide a useful starting point so you don't need to build the complete Monaco integration from scratch every time.  
  
I hope you find it useful. 🚀🔥  
  
**Monaco Editor Studio — Free B4J Project Template**