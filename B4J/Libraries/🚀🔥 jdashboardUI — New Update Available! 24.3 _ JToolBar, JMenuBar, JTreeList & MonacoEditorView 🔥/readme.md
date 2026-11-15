### 🚀🔥 jdashboardUI — New Update Available! 24.3 | JToolBar, JMenuBar, JTreeList & MonacoEditorView 🔥🚀 by fernando1987
### 11/08/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/172515/)

Hello everyone! 😎  
  
A new **jdashboardUI update** is now available, bringing important improvements to **JToolBar, JMenuBar, JTreeList, and MonacoEditorView**.  
  
This update focuses on providing more flexibility, better component integration, richer navigation, and advanced editor extensibility.  
  
Let's take a look at what's new!  
  

---

  
[HEADING=3]🔥 1. JToolBar — More Than Just a Toolbar![/HEADING]  
JToolBar continues evolving into a more complete and flexible toolbar component for B4J.  
  
**Highlights:**  
  

- ✅ Dropdown menu buttons with icons, images, and text.
- ✅ Nested menus and submenus.
- ✅ Menu separators and individual menu items.
- ✅ Support for embedding custom JavaFX Views and B4J controls inside dropdown menus.
- ✅ Programmatically show, hide, and clear menus.
- ✅ Manage the enabled, visible, and selected states of toolbar items.
- ✅ More flexibility for tooltips, icons, colors, themes, and custom styling.
- ✅ Responsive wrapping, allowing toolbar items to automatically move to additional rows when space becomes limited.
- ✅ Improved support for identifying items through stable EventName values.

One of the most interesting features is **AddMenuView**.  
  
You can now include controls such as TextFields, ComboBoxes, or other compatible Views directly inside a dropdown menu.  
  
**Possible use cases:** document editors, custom IDEs, formatting toolbars, dashboards, filter menus, and advanced desktop applications.  
  
![](https://www.b4x.com/android/forum/attachments/174718)  
  
📖 Documentation:  
<https://b4xapp.com/en/docs/jdashboardui/jtoolbar>  
  
[HEADING=3]🔥 2. JMenuBar — Enhanced Menu Management[/HEADING]  
JMenuBar has also received improvements focused on menu behavior, customization, and application integration.  
  
**Highlights:**  
  

- ✅ Better management of menu items and submenus.
- ✅ Support for icons and images in menu commands.
- ✅ Improvements related to initialization and image-based menu elements.
- ✅ Programmatic enabling and disabling of menu items.
- ✅ Persistent item states with restoration support.
- ✅ Programmatically trigger menu actions.
- ✅ Menu shortcuts and event-based command handling.
- ✅ Theme customization and predefined themes.
- ✅ Support for configurable menu colors, fonts, dimensions, and visual properties.

For example, you can enable or disable commands dynamically depending on the application's current state, and preserve those states when necessary.  
  
**Possible use cases:** File/Edit/View menus, document management, application settings, conditional commands, and professional desktop interfaces.  
  
📖 Documentation:  
<https://b4xapp.com/en/docs/jdashboardui/jmenubar>  
  
[HEADING=3]🌳 3. JTreeList — Hierarchical Navigation and Project Explorers[/HEADING]  
JTreeList provides an organized way to build hierarchical navigation interfaces.  
  
**Highlights:**  
  

- ✅ Create root nodes and child nodes.
- ✅ Expand and collapse hierarchical structures.
- ✅ Support for FontAwesome-style icons and custom images.
- ✅ Select nodes programmatically.
- ✅ Find and select nodes using Tag values.
- ✅ Update individual node captions without rebuilding the entire tree.
- ✅ Update multiple node captions using SetNodeTexts.
- ✅ Remove nodes and clear the structure.
- ✅ Customize colors, fonts, backgrounds, and selection appearance.
- ✅ Context menu integration.
- ✅ Click and right-click events.

**Possible use cases:** project explorers, file managers, document trees, database explorers, navigation panels, and visual designers.  
  
You could even combine **JTreeList with MonacoEditorView** to build your own code editor with a project explorer!  
  
![](https://www.b4x.com/android/forum/attachments/174719)  
  
📖 Documentation:  
<https://b4xapp.com/en/docs/jdashboardui/jtreelist>  
  

---

  
[HEADING=3]💻 4. MonacoEditorView — Extend Monaco with Your Own JavaScript![/HEADING]  
This is another particularly interesting improvement.  
  
**MonacoEditorView can now be extended using external JavaScript files**, allowing developers to introduce additional editor capabilities without modifying the internal Monaco resources or the jdashboardUI library.  
  
New public methods include:  
  

- <span>LoadJavaScriptFile(Dir, FileName)</span> — Load your own JavaScript extension.
- <span>ExecuteJavaScript(Script)</span> — Execute JavaScript inside the editor.
- <span>ExecuteJavaScriptWithResult(Script)</span> — Execute JavaScript and retrieve a result.

**What can you do with this?**  
  
✅ **Custom IntelliSense and code completion**  
  
Use the public Monaco APIs to register your own completion providers. You can create contextual suggestions for keywords, functions, properties, methods, variables, and application-specific objects.  
  
✅ **Custom snippets**  
  
Insert reusable code templates, procedure structures, and snippets with editable placeholders.  
  
✅ **Additional programming-language support**  
  
Extend Monaco with specialized completions and editor behavior for languages or formats used by your application, such as VBA, XML, RibbonX, or custom DSLs.  
  
✅ **Custom commands and keyboard shortcuts**  
  
Add editor commands or shortcuts for actions such as navigation, formatting, inserting templates, or executing application-specific operations.  
  
✅ **Custom diagnostics and validation**  
  
Build extensions that analyze editor content and display errors, warnings, or other contextual information using the Monaco APIs.  
  
✅ **Advanced code navigation**  
  
Develop extensions for locating procedures, navigating to symbols, or integrating the editor with a project explorer.  
  
✅ **Communication between B4J and JavaScript**  
  
Execute JavaScript from B4J and retrieve values through the public API.  
  
**A simple example**  
  
Create a JavaScript file such as <span>my-intellisense.js</span> and add it to your B4J project Files folder.  
  
Then load it after the editor is ready:  
  

```B4X
Private Sub MonacoEditorView1_Ready  
Dim Success As Boolean = MonacoEditorView1.LoadJavaScriptFile(File.DirAssets, "my-intellisense.js")  
Log("JavaScript extension loaded: " & Success)  
End Sub
```

  
  
Inside that JavaScript file, you can use public Monaco APIs such as:  
  
<span>monaco.languages.registerCompletionItemProvider(…)</span>  
  
This allows you to register your own IntelliSense suggestions for the corresponding language.  
  
**Important:** the JavaScript extension is supplied by your application. Advanced IntelliSense providers, commands, diagnostics, and custom language features are possibilities you can implement; they are not all automatically included by simply loading a file.  
  
No need to modify <span>monaco.zip</span>, <span>editor.html</span>, or the bundled jdashboardUI library!  
  
MonacoEditorView also continues to provide multi-document management, tab navigation, code editing, search, snippets, VBA procedure navigation, and other editor features.  
  
![](https://www.b4x.com/android/forum/attachments/174720)  
  
![](https://www.b4x.com/android/forum/attachments/174722)  
  
📖 Full documentation:  
<https://b4xapp.com/en/docs/jdashboardui/monacoeditorview>  
  

---

  
[HEADING=3]📚 Updated Documentation[/HEADING]  
The official documentation has been expanded with explanations, implementation instructions, use cases, examples, public methods, properties, and events.  
  
These components are now documented in greater detail so both new and experienced B4J developers can understand and use them.  
  
🔗 <https://b4xapp.com/en/docs/jdashboardui>  
  
[HEADING=3]📥 Download the Update[/HEADING]  
Existing customers can download the latest available library version from their **B4X Store dashboard**.  
  
🔗 <https://b4xapp.com>  
  
This update is part of the continued maintenance and evolution of jdashboardUI. The library is already extensive, and future updates will continue to focus on important improvements, corrections, and useful functionality.  
  
Thank you for your continued support! ❤️  
  
**Happy coding with B4J! 🚀**