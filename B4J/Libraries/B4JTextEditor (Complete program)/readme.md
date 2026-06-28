### B4JTextEditor (Complete program) by JakeBullet70
### 06/26/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171390/)

As I was learning Claude AI and planning mode this came out. Its feature complete and there is some really good code to learn from - take - use in your own apps.  
This is a complete program.  
  
Took about 1.5 days, if you want to see Claude AI planning mode check out the claude.md (its in claude.zip) file.   
  
  
Featrues:  

- **Multi-document tabs** — each tab keeps its own text, undo history, syntax highlighting, and modified (\*) state. New (Ctrl+N), Close (Ctrl+W), switch with Ctrl+PageUp/PageDown.
- **File operations** — New / Open / Save / Save As / Exit, with per-document save prompts on close and a window-close guard.
- **Edit operations** — Undo / Redo / Cut / Copy / Paste / Select All.
- **Syntax highlighting** — multi-language (Java, Python, JSON, B4X, Markdown), auto-detected by file extension with a View ▸ Language override. One regex-driven engine, theme-colored token categories (comment / string / char / annotation / number / type / keyword).
- **Find / Replace bar** — non-modal floating widget (Ctrl+F / Ctrl+R): Prev/Next with an "x of y" count, Replace / Replace All, **Match case**, **Whole word**, **Regex** (with $1 group references), and **All tabs** (search/replace across every open document). Esc to close.
- **Go to Line** (Ctrl+G).
- **Word wrap** (Alt+Z).
- **Setup panel** (Help ▸ Setup) — global settings: theme (Light/Dark), font family + size, tab size, soft/hard tabs, line numbers, word wrap, highlight current line, auto indent, default encoding, default EOL. Persisted to settings.properties.
- **This Document panel** (View ▸ This Document) — the active document's encoding, line endings, and read-only toggle.
- **Multi-encoding I/O** — UTF-8, UTF-8 BOM, UTF-16 LE, UTF-16 BE with BOM detection on open; LF/CRLF detected on open and re-applied on save.
- **Read-only documents** — per-document, seeded from the file's read-only attribute on open.
- **Recent files** — MRU list under File ▸ Open Recent, persisted across sessions.
- **Drag-and-drop** — drop files onto the window to open them.
- **Status bar** — Ln / Col / encoding / EOL / language / modified indicator.
- **Keyboard-first** — Alt menu mnemonics and Ctrl accelerators throughout.

  
Use and abuse as you see fit. Its Open source!  
  
![](https://www.b4x.com/android/forum/attachments/172045)  
![](https://www.b4x.com/android/forum/attachments/172046)  
  
<https://github.com/jakebullet70/B4JTextEditor>