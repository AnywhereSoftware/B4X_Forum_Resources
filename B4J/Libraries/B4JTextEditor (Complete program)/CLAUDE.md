# B4JEditor — project memory

A B4J (JavaFX desktop) text editor inspired by Microsoft `edit`
(https://github.com/microsoft/edit). Clean native desktop styling, single-document MVP.

## Build / run
- Project file: `Editor.b4j` (AppType=JavaFX). Libraries: jcore, jfx, jxui, javaobject.
- Build: B4J IDE, or the b4j MCP tools (`b4j_build` / `b4j_run`). Output jar: `Objects/Editor.jar`.
- Entry: `AppStart` in `Editor.b4j` builds the UI in code (no layout file is loaded).

## Architecture (non-obvious decisions)
- **Editor surface = RichTextFX `CodeArea`** (line-number gutter, virtualized scrolling, future
  syntax highlighting), wrapped by the `CodeEditor` class (`CodeEditor.bas`) and driven via
  `JavaObject`. The CodeArea is wrapped in a flowless `VirtualizedScrollPane` (that scroll pane is
  the node added to the UI; `CodeEditor.AsNode` returns it). `CodeEditor` exposes a small swappable
  API so the surface can be replaced **without touching `Main`**.
  - Jars live in `C:\dev\b4x\b4j\ext_libs` and are referenced with `#AdditionalJar:` in `Main`:
    richtextfx-0.11.7, flowless-0.7.4, undofx-2.1.1, wellbehavedfx-0.3.3, reactfx-2.0-M5.
  - All editor ops (text get/set, undo/redo, cut/copy/paste, selectAll, caret, selectRange, wrap)
    are `JavaObject` calls on the CodeArea. Ln/Col use native `getCurrentParagraph` / `getCaretColumn`.
  - **Adding the CodeArea to the AnchorPane:** use B4J `RootPane.AddNode(Editor.AsNode, ...)` — B4J
    unwraps the `JavaObject` arg. Do NOT reflect `getChildren().add(...)` via JavaObject: the list's
    concrete class (`com.sun.javafx.collections.VetoableListDecorator`) is in a non-exported module
    and reflection throws `IllegalAccessException`.
  - **Modified detection:** no Java change-listener. `Main.caretTimer` (150ms) polls caret+length;
    on activity it compares `Editor.Text` to a saved `Baseline` (set after New/Open/Save). Bonus:
    undoing back to the saved state clears the modified flag.
  - JavaObject method-arg gotcha: numeric anchors must be `Double` (`0.0`, not `0`) or you get
    "Method not matched".
  - **Fallback:** if a future JDK/JavaFX upgrade breaks richtextfx 0.11.7, drop to 0.11.2. The old
    `TextArea`-backed `CodeEditor` is in git/`.bak` history if a zero-jar build is ever needed.
- **No `.bjl` layout is loaded.** Hand-writing the binary layout JSON broke the designer's resize
  builder (`NodeWrapper.buildResize` NPE). Instead the UI is built on `MainForm.RootPane` (an
  AnchorPane) and sized with **JavaFX AnchorPane anchor constraints** (`SetAnchors` helper →
  `AnchorPane.setTopAnchor/...`). `Files/Layout1.bjl` is unused/leftover.
  - Anchor values **must be passed as `Double`** (`0.0`, not `0`) or `JavaObject` reports
    "Method not matched".
- **Window-close guard:** `MainForm_CloseRequest` consumes the close event (via JavaObject
  `consume`) when the document is modified, prompts, then closes.
- **Line/Col status:** a 150ms `Timer` (`caretTimer`) polls the caret (`TextArea` has no caret
  event) and recomputes Ln/Col by scanning the text for `Chr(10)`.
- **Encoding/EOL:** multi-encoding. Open reads **bytes** (`File.ReadBytes`), detects a BOM
  (UTF-8/UTF-16LE/UTF-16BE) else falls back to the configured default, decodes via
  `BytesToString(..., CharsetFor(enc))`. Save encodes via `EncodeText` (`text.GetBytes(charset)` +
  a prepended BOM where applicable) and `File.WriteBytes`. UI encoding names: `UTF-8`, `UTF-8 BOM`,
  `UTF-16 LE`, `UTF-16 BE` — see the **Encoding** #Region in `Main`. Every non-default encoding
  carries a BOM, so open is simply **BOM → default** (`DetectEncoding(data, SettingEncoding)`); no
  per-file memory is needed (ANSI was intentionally dropped — it's BOM-less and indistinguishable
  from UTF-8, which would have required remembering encodings per path). LF vs CRLF is detected on
  open (presence of `\r\n`) and re-applied on save (`Editor.Text` is LF-internal; the CodeArea
  normalizes `\r\n`→`\n` on input). Encoding + EOL are **per-document** (Setup panel's Per-Document
  section, applied on next save); there are also persisted **defaults** for new docs. Verified by a
  runtime round-trip self-test (UTF-8/BOM/UTF-16 LE/BE all round-trip; temp test since removed).

## Module map
- `CodeEditor.bas` — class wrapping the RichTextFX `CodeArea` (swappable editor API). Also holds the
  inline-Java highlight bridge (`nativeHighlight`/`nativeClear`/`nativeAddStylesheet`).
- `SyntaxHL.bas` — highlighting engine: loads the language registry, builds one combined
  named-group regex per language, maps extension→language, decides what/when to highlight.
- `SyntaxLanguages.bas` — language definitions as data (name/extensions/keywords/ci/patterns).
  Regex is plain B4X text (backslashes literal; a literal `"` via `Chr(34)`). Same shape as JSON, so
  these can later move to JSON files in `Files\` without changing `SyntaxHL`.
- `Document.bas` — one open document = one tab. Holds its own `CodeEditor` (so text, undo history
  and highlighting are preserved per tab) plus per-document state (path/eol/encoding/baseline/lang).
- `FindBar.bas` — non-modal find/replace widget: a floating `Pane` pinned top-right over the editor
  (anchored top+right, fixed size; grows down for the replace row). Owns its own search state and
  find/replace logic over `CodeEditor`. Shown by `Main` on Ctrl+F / Ctrl+R; Esc closes it.
  - **Option toggles** (always-visible row): **Match case**, **Whole word**, **Regex**, **All tabs**.
    Matching uses B4X `Regex.Matcher2(pattern, opts, text)` (not substring), so matches are
    **variable length** — each is an `Int(2)` `{start, len}`. `BuildPattern` = the term (regex
    as-typed, else `Pattern.quote`'d literal) optionally wrapped `\b(?:…)\b` for whole-word; case is
    `Regex.CASE_INSENSITIVE` unless Match case. An invalid regex → `MatchesIn` returns an
    **uninitialized** list and the bar shows "Bad regex". **Replace** runs through
    `BuildReplacement` (java `Matcher.appendReplacement`/`appendTail`), so in Regex mode the
    replacement honours `$1`/`$2`… group references; in literal mode the replacement is
    `Matcher.quoteReplacement`'d so `$`/`\` are literal. A bad pattern *or* a bad group ref (e.g. `$5`
    with fewer groups) sets `mRepError` → "Bad regex". Single Replace runs `BuildReplacement` on just
    the selected match. The option checkboxes are read **live** in the matchers (no cached fields) — setting
    `CheckBox.Checked` programmatically does **not** fire `CheckedChange`, so caching them would go
    stale; reading live also keeps it correct.
  - **"All tabs" checkbox** = search/replace across **all open documents**. Find Next/Prev spill into
    following/preceding docs and wrap around the whole set (`FindNextAll`/`FindPrevAll`), switching
    the active tab via `Main.GoToDoc` (which re-points `mEditor` through `Bar.SetEditor`) and showing
    a global "x of y" count. Replace All loops every doc (`ReplaceAllIn` per editor) and flags each
    changed doc via `Main.NoteDocChanged`. The bar reaches other docs through Main accessors
    `DocCount`/`DocEditorAt`/`ActiveDocIndex`/`GoToDoc`/`NoteDocChanged`. After a cross-doc jump it
    re-focuses the find field (the tab switch's `Editor.RequestFocus` would otherwise steal focus).
  - Esc is wired with an **inline-Java** `addEventFilter(KEY_PRESSED)` that calls back via
    `ba.raiseEventFromUI(this, "onescape", null)` → the B4X `onescape` sub. `TextField`'s B4J wrapper
    has no KeyPressed event, so this is the clean way. (`Action` event = Enter → Find Next.)
- `SetupBar.bas` — non-modal Setup panel (same floating-`Pane` style as `FindBar`): the **global**
  editor settings (theme, font, tab size, soft/hard tabs, line numbers, word wrap, highlight line,
  auto indent, default encoding/EOL). Control events push to the matching `Main.Set*`, which apply to
  every open editor and persist via `Main.SaveSettings`. Shown by `Main` on Help ▸ Setup; Esc closes
  it (inline-Java `attachEsc`). `Show` takes one `Map` of all current values.
- `ThisDocBar.bas` — non-modal "This Document" panel (View ▸ This Document): the **active document's**
  encoding + line endings (applied on next save) + **Read only** toggle, pushing to
  `Main.SetEncoding`/`SetEol`/`SetReadOnly`. `Main` keeps it on the active tab via `RefreshPerDoc`
  (now also carries the read-only flag) on switch.
- `Main` (in `Editor.b4j`) — menu bar, file ops, edit ops, status bar, theme, and the tab/document
  manager (#Region Documents/tabs). Find/Replace delegate to `FindBar`; Go-to-line is a modal dialog.

## Multi-document tabs (non-obvious bits)
- A jFX `TabPane` fills the editor area; each tab's content is a document's own `CodeEditor` node,
  set via JavaObject `setContent` (accepts any Node and auto-fills — no resize wiring needed).
  `Tabs.Add` / `Tabs.RemoveAt` on the B4J `TabPane.Tabs` list work (it's live); reflecting
  `getTabs().add()` would hit the same non-exported-module `IllegalAccessException` as `getChildren`.
- **Active-mirror design:** Main's existing globals (`Editor`, `CurrentPath`, `Modified`, `Eol`,
  `Baseline`, `LastHLText`, …) MIRROR the active `Document`, so most pre-existing single-doc code is
  unchanged. `SwitchTo(idx)` → `SaveActiveTo(oldDoc)` then `LoadActiveFrom(newDoc)` (re-points
  `Editor`, and `Highlighter.SetEditor` / `Bar.SetEditor`). `tabs_TabChanged` drives switching on
  user tab clicks; it's idempotent via `mActiveIndex`.
- Each document keeps its **own** `CodeArea`, so undo history and style spans persist per tab with no
  save/restore of text. Close via the tab **X** or **Ctrl+W** (both run the save prompt).
- **Tab X close:** B4J's `TabPage` wrapper has no close event, so the X is intercepted with inline
  Java in `Document.AttachClose` — `setOnCloseRequest` `consume()`s the native close (so nothing
  closes without the prompt) and raises a B4X event carrying the tab's `Id`; `Main.TabCloseRequest`
  finds the doc by id, selects it, prompts, then `CloseActiveDoc`. Needs
  `TabPane.setTabClosingPolicy(ALL_TABS)` (set in `BuildUI`) or the X only shows on the active tab.
- B4X gotcha: a field named `tab` fails to parse ("Unknown type: tab") — use `page`.
- Verified by running: Ctrl+N adds a tab and switches; typing per tab is independent;
  **Ctrl+PageUp/PageDown** switches and the correct content/`*`-state is restored.

## Syntax highlighting (non-obvious bits)
- One regex-driven engine, many language configs. Each language → one combined regex of named groups
  `(?<KEYWORD>...)|(?<STRING>...)|...`; the matched group name maps to a CSS style class. Categories
  are a fixed small set (`comment/string/char/annotation/number/type/keyword`, in that precedence)
  so one theme colors all. `keyword`/`type` come from per-language **word lists** (`keywords`/`types`
  keys) — `type` is ordered before `keyword`, so a word in both lists is coloured as a type (this is
  how Java primitives `int`/`String`/… render teal vs. blue keywords). Both also accept a **pattern
  fallback** in `patterns` when there's no word list (used by Markdown: headings as a `keyword`
  pattern, links as a `type` pattern). Languages: Java, Python, JSON, B4X, **Markdown** (`md`).
  Markdown maps headings→keyword, code→string, bold→annotation, links→type, HTML-comments/blockquote
  →comment, using Java's scoped multiline flag `(?m:^…)` inside the group (the engine compiles the
  combined regex with no global flags).
- The `StyleSpans` are built in **inline Java** in `CodeEditor` (`StyleSpansBuilder`). Inline-Java in
  a B4X class can't use `import` (illegal inside a class body) — use fully-qualified names.
  `nativeHighlight` reads `area.getText()` itself (not a passed string) so span length always matches
  the area length (no race with the 150ms re-highlight tick).
- **Theme is a real file:** `DirAssets` is virtual in Release, so `InstallTheme` writes the CSS to
  `File.DirTemp\syntax.css` and adds its `file:///` URI to the CodeArea stylesheets.
- Re-highlight is debounced by the existing `caretTimer` (re-runs only when text changed, ≤ every
  150ms). Language auto-selects by extension on Open; `View ▸ Language` overrides (handler uses the
  `Sender` MenuItem's `Tag`). B4X gotcha: a param named `regex` clashes with the built-in `Regex`
  object; a local named `names` clashes with a `Names` sub — rename.
- Verified by an in-app JavaFX node `snapshot` saved to PNG (OS screenshots were unavailable);
  keywords/strings/comments/numbers render correctly for Java.
- Future: highlight only the visible viewport for very large files; add `type` category + per-lang
  type lists; externalize packs to JSON.

## What works (verified by running the app)
**Multi-document tabs** (New=Ctrl+N opens a tab, Close=Ctrl+W, Ctrl+PageUp/PageDown to switch; each
tab keeps its own text/undo/highlighting/`*`-state); File New/Open/Save/Save As/Exit;
Undo/Redo/Cut/Copy/Paste/Select All; non-modal **find/replace bar**
(Ctrl+F/Ctrl+R, Prev/Next with "x of y" count, Replace / Replace All, Esc to close, case-insensitive,
wrap-around, **"All tabs" = search/replace across every open document**); **Go to Line** (Ctrl+G); Word Wrap (Alt+Z); multi-language **syntax highlighting**
(Java/Python/JSON/B4X, auto-detected by extension + View▸Language override) with line-number gutter;
status bar Ln/Col/encoding/EOL/language/modified; modified `*` in title; Alt menu mnemonics + Ctrl
accelerators; **Setup panel** (Help ▸ Setup) — global settings: theme Light/Dark, font family +
size, tab size, soft/hard tabs, line numbers, word wrap, highlight current line, auto indent,
default encoding, default EOL — persisted to `settings.properties` in `File.DirData(APP_NAME)` and
applied to every open editor; **This Document panel** (View ▸ This Document) — the active doc's
encoding + line endings, applied on its next save.

## Settings (Setup panel) — non-obvious bits

- **Soft tabs** are implemented in inline Java in `CodeEditor` (`installTabHandler`): a
  `KEY_PRESSED` event filter consumes a plain Tab (no Ctrl/Shift/Alt) and `replaceSelection`s
  `_tabSize` spaces. `_tabSize` is a Java instance field on the `CodeEditor` class, set by
  `SetTabSize` — each editor has its own. (RichTextFX 0.11.7 has **no** tab/tabSize API anywhere in
  the `CodeArea` hierarchy — verified by `javap` against the jar — so this is the clean way to get
  "tab size = N spaces".)
- The Tab key fires **two** events: `KEY_PRESSED` (where the spaces are inserted) and a separate
  `KEY_TYPED` carrying `\t`. `installTabHandler` must consume **both** or a literal tab slips in on
  top of the spaces (this was the "3 looked like 4" bug).
- **Literal tabs from opened files** render at the chosen width via JavaFX `TextFlow.tabSize`
  (the only tab knob that exists, and it's JavaFX's, not RichTextFX's). `applyTabSizeToVisible`
  walks `area.lookupAll(".paragraph-text")` (the ParagraphText TextFlows; style class confirmed
  `paragraph-text`) and calls `setTabSize(_tabSize)`. RichTextFX recreates these nodes on scroll, so
  it's reapplied (deferred via `Platform.runLater`) on `getVisibleParagraphs()` invalidation
  (scroll/resize) and on `plainTextChanges()` (edits). Note: this only affects **display**; the Tab
  key still inserts spaces, and saved files contain only what's in the buffer.
- **Line-number toggle** is also inline Java (`setLineNumbers`): on → `setParagraphGraphicFactory(
  LineNumberFactory.get(area))`, off → `setParagraphGraphicFactory(null)`. Done in Java to avoid the
  `JavaObject` null-arg method-matching problem.
- Settings live in `Main` globals (`SettingTabSize`/`SettingLineNumbers`/`SettingEol`/
  `SettingFontFamily`/`SettingFontSize`/`SettingSoftTabs`/`SettingWordWrap`), loaded **before** the
  first `NewDoc` (so the first editor gets them) and re-applied on every change. `File.ReadMap`
  returns strings, so booleans are parsed as `= "true"`; tab size is clamped 1..16, font size 6..72,
  and `eol` is forced to `CRLF` unless `LF` on load (guards bad/old values). The Setup panel's `Show`
  takes a `Map` of all current values (one place to extend when adding a setting).
- **Font** is set via `CodeEditor.SetFont(family, size)` rebuilding the CodeArea inline `setStyle`
  (family falls back `'<chosen>','Consolas','monospace'`; keeps `-fx-background-color: white`). The
  family combo is populated from `javafx.scene.text.Font.getFamilies()` (all installed families).
- **Soft vs hard tabs:** `_softTabs` Java field on `CodeEditor`; the Tab `KEY_PRESSED` handler
  inserts `_tabSize` spaces (soft) or a single `\t` (hard). The `KEY_TYPED` `\t` is consumed
  **unconditionally** (we always insert ourselves) so no native double-insert. Hard tabs render at
  the chosen width via the same `TextFlow.tabSize` path as opened-file tabs.
- **Word wrap** is now a persisted setting: both `View ▸ Word Wrap` (`mnuWrap_Action`) and the panel
  route through `Main.SetWordWrap`, which keeps the `mnuWrap` check, all editors, and the file in
  sync. `mnuWrap.Selected` is seeded from `SettingWordWrap` in `BuildMenuBar`.
- **Highlight current line** uses RichTextFX **paragraph styles** (`setParagraphStyle(idx, ["current-
  line"])`), independent of the syntax `setStyleSpans` (text styles), so they don't clash. There's no
  caret-position listener — `caretTimer_Tick` calls `Editor.RefreshCurrentLine` each poll, which
  moves the `current-line` class to `getCurrentParagraph()` and clears the previous (`_hlLast`). The
  `.current-line` background is themed in `BuildThemeCss`. (Getter for verification is on the
  `Paragraph` object — `getParagraphs().get(i).getParagraphStyle()` — not the area.)
- **Auto indent**: the Tab `KEY_PRESSED` handler also intercepts ENTER (when `_autoIndent`), reads
  the current line via `area.getText(getCurrentParagraph())`, and `replaceSelection("\n" + <leading
  whitespace>)`. ENTER's separate `KEY_TYPED` (`\r`/`\n`) is consumed too (like Tab's `\t`) to avoid
  a double newline. Both default **on**.
- B4X gotcha: identifiers are **case-insensitive**, so a param/local can't shadow a global of the
  same letters — `w` clashed with const `W`, and local `lbl` clashed with const `LBL` (renamed to
  `wd` / `lb`).
- B4X gotcha: `Chr(n)` returns a **Char**, not a String, so `Chr(0xFEFF).GetBytes(...)` fails
  ("Object expected"); assign to a `String` first.
- **Theme** is a real CSS file rebuilt by `BuildThemeCss(theme)` (`Main`) covering `.code-area`
  background, `.code-area .text` default fill, `.lineno` gutter, `.caret`, `.selection`, the
  `.current-line` highlight, and the token palette. Class names verified against the jar.
  - **CSS specificity gotcha:** the default-text rule `.code-area .text` (specificity 0,2,0) is more
    specific than a bare token class like `.keyword` (0,1,0), so it overrode every token color and
    made all syntax one color. Fix: scope token rules as `.code-area .text.keyword` etc. (0,3,0) so
    they win. (Token spans are applied to the same `Text` node that carries the `text` class, so the
    compound `.text.keyword` matches.) Verified with light+dark editor snapshots. **Live theme switch** needs a stylesheet *reload*:
  JavaFX caches stylesheets by URL, so `InstallTheme` writes a **fresh filename** each call
  (`syntax<counter>.css`) and `CodeEditor.nativeAddStylesheet` does `getStylesheets().clear()` then
  `add()`. `SetTheme` rewrites + re-points every open editor. Editor bg/fg therefore come from CSS,
  **not** inline style — `SetFont` no longer sets `-fx-background-color` (it would override the theme).
- **Theme covers the whole window chrome** (menu bar, tabs, buttons/fields/combos, popups), not just
  the editor, by overriding modena's looked-up colors (`-fx-base`/`-fx-background`/
  `-fx-control-inner-background`/`-fx-accent`). **Set these as an INLINE style on the scene root node**
  (`ApplyChromeBase` → `MainForm.RootPane.Style = "-fx-base:…"`), **not** as a `.root {}` CSS rule in
  the scene stylesheet — a `.root` rule conflicts with combo/menu **popups** (which live in their own
  scene) and triggers modena `CssStyleHelper` warnings ("Could not resolve `-fx-text-background-color`",
  "String cannot be cast to Paint"). Inline on the node lets popups resolve looked-up colors cleanly
  through the node parent chain. modena re-derives all controls automatically — no per-control CSS.
  `ApplyChromeBase` runs in `BuildUI` and on every `SetTheme`. The floating panels + status bar use
  **looked-up colors** in their inline styles (`-fx-background`, `-fx-box-border`, `-fx-text-base-color`)
  instead of hardcoded hex so they follow the base. (The editor stylesheet is still attached to the
  Scene via `formHelpers.SetSceneStylesheet` for the `.code-area`/token rules; it has no `.root`.)
- **Per-document vs default** (Setup sections): `Main.SetEncoding`/`SetEol` change the **active doc**
  (used on next save, no persist); `Main.SetDefaultEncoding`/`SetDefaultEol` change the persisted
  default for new docs. `mnuSetup_Action` passes one `Map` with both the globals and the active
  doc's `enc`/`eol`.
- The per-document encoding/EOL live in their own non-modal **`ThisDocBar`** panel (View ▸ This
  Document, `mnuThisDoc_Action`), separate from the global Setup panel. Like Setup it's a floating
  `Pane` pinned top-right. Because it's non-modal, when it's open and the user switches tabs its
  combos must follow the new active doc: `LoadActiveFrom` calls `DocBar.RefreshPerDoc(Encoding, Eol)`
  when `DocBar.IsVisible` (guarded by `mLoading` so it doesn't echo back into `SetEncoding`/`SetEol`).
  The status bar already tracked the active doc via the global mirror; only the panel needed this.
- B4X gotcha: B4J's `ComboBox.SelectedIndexChanged` event signature is
  `(Index As Int, Value As String)` — a one-arg handler compiles but throws a *runtime*
  "signature does not match expected signature" when the event first fires.
- **EOL setting** (`Main.SetEol`) is the default line ending for **new** documents *and* applies to
  the current document immediately (so the next save uses it). Opening a file still auto-detects its
  EOL in `LoadFile`, overriding the default for that doc. The Setup combo shows the **active doc's**
  current `Eol` when opened (index 0=CRLF, 1=LF). Changing EOL does **not** flag the doc modified —
  the `Baseline` is LF-internal text and the EOL is only re-applied at write time.

## Not yet done (plan Section 8 — post-MVP)
Viewport-only highlighting for very large files, still more languages.
**Known gap:** the window-X guard relies on the modified flags; covered for the in-app paths.

## Read-only & the help doc (non-obvious bits)

- **Read-only** is per-document: `CodeEditor.SetEditable(b)` (RichTextFX `CodeArea.setEditable`),
  mirrored as `DocReadOnly` (global) ↔ `Document.readonly`. Toggled from the **This Document** panel
  (`Main.SetReadOnly`), shown in the status bar ("read-only"). On open, `LoadFile` sets it from the
  **file attribute** via `CanWrite` (`java.io.File.canWrite()` — honours the Windows read-only
  attribute and Linux write permission). `LoadActiveFrom` re-applies `SetEditable` on tab switch.
- **Custom tab titles:** `DisplayName` (global) ↔ `Document.displayName`; `DocName` returns it when
  set (else the file name / "Untitled"). Used by the help doc so the tab/title read "Editor Shortcuts".
- **Help ▸ Editor Shortcuts** (`mnuShortcuts_Action`) reads the bundled `Files/EditorShortcuts.md`
  via `File.ReadString(File.DirAssets, …)` (works in Release; `DirAssets` is virtual) and opens it in a
  new tab through `OpenHelpDoc`: sets the text, `DisplayName`, Markdown highlighting, and
  `SetReadOnly(True)`, then `SetBaseline` (clean → no save prompt on close). The `.md` is registered
  as `File3` in the project (`NumberOfFiles=3`).

## Recent files & drag-drop (non-obvious bits)

- **Recent files:** `RecentFiles` (a `List` of paths, MRU-first) persisted to `recent.txt` in
  `File.DirData(APP_NAME)` via `File.WriteList`/`ReadList` (one path per line — handles Windows
  backslashes fine). `AddRecent` (called at the end of `LoadFile` and on successful `SaveFile`)
  dedupes case-insensitively, caps at `RECENT_MAX`, and rebuilds the **File ▸ Open Recent** submenu.
  The submenu (`mRecent`, a `Menu` added to `mFile.MenuItems` like the Language submenu) is rebuilt
  by `RebuildRecentMenu`: clear via `RemoveAt` loop (the live JavaFX list), one `mnuRecent` item per
  path (full path as text, `Tag` = path), a "Clear Recent List" item, or a placeholder when empty.
  `LoadRecent` runs **before** `BuildUI` so the menu is populated on first build. The submenu sits at
  the **bottom of File**, below Exit and a divider added by `AddSeparator` (a native
  `SeparatorMenuItem` via `Menu.getItems().add()` — reflection-safe, unlike `Pane.getChildren()`).
- **Drag-drop to open:** inline Java in `formHelpers` (`installFileDrop`) adds **scene-level**
  `DRAG_OVER`/`DRAG_DROPPED` event **filters** (filters fire before the CodeArea's own drag handling,
  so drops over the editor are caught). It only acts when `dragboard.hasFiles()`, so the editor's
  internal text drag is left alone. Each dropped path is raised to the B4X `filedropped` sub, which
  calls `Main.OpenDroppedFile` → `OpenDoc`. Wired in `AppStart` via `fhelper.InstallFileDrop` **after**
  `MainForm.Show` (the scene only exists once shown). JavaFX gotcha: the completion setter is
  `setDropCompleted(true)`, not `setDropComplete`.

**Done since:** Open now reuses a pristine Untitled tab (empty + unmodified + no path) instead of
always adding a new one (`OpenDoc`). Exit now prompts **per document** — `ConfirmExit` loops every
open doc, `SwitchTo`s each unsaved one and runs its own `ConfirmDiscard` (Save/Don't Save/Cancel);
cancelling any one aborts the exit.

## AI reference docs
Coding rules live in `C:\dev\b4x\src\__AI-md files\` (`General-AI-Instructions.md`,
`B4X-Coding-Reference.md`, `B4J-Coding-Reference.md`). Note: per the project owner, `' Claude
created`/`' Claude edited` attribution markers are intentionally **omitted** here — the whole project
is Claude-authored, so they add no signal.
