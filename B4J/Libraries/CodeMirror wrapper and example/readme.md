### CodeMirror wrapper and example by stevel05
### 03/25/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/125775/)

After the [proof of concept test,](https://www.b4x.com/android/forum/threads/codemirror-javascript-code-editor-wrapper-proof-of-concept.124854/post-779522) here is a wrapper for the CodeMirror javascript libarary which runs quite happily in a Webview.  
  
Current functionality:  

- Highlighting Mode for B4x (and 100+ other languages)
- Minimal wrapper implementation in library, see the attached CodeEditor for an example of a fuller implementation
- implemented the available visual themes

  
In addition, the CodeEditor (also a b4xlib) is an example implementation. The only thing not implemented is file loading and saving as the would really depend on the structure of your project.  
  
**Dependencies:**  
  
CodeMirrorWrapper:  

- [Archiver](https://www.b4x.com/android/forum/threads/lib-archiver.21688/post-125497)
- [Throwables](https://www.b4x.com/android/forum/threads/b4x-throwables-library.125771/post-785655)

  
CodeEditor  

- CodeMirrorWrapper

  
CMMinimal Implementaion - Project  

- CodeMirrorWrapper

  
**Downloads: (Dropbox)**  
  
Both the CodeMirror b4xlib and the CodeMirror project are too large to attach to the forum as they contain the CodeMirror javascript library.  
You can download them from my dropbox here:  

- [CodeMirrorWrapper.b4xlib](https://www.dropbox.com/s/q0xi9jv0wrxmjbw/CodeMirrorWrapper.b4xlib?dl=0)
- [CodeMirrorWrapper Project](https://www.dropbox.com/s/agg6plpdpwgbj48/CodeMirrorWrapper.zip?dl=0)

  
**Version 1.5**  
  

- Separated from the CodeEditor module for easier minimal implementation.
- Added ReadOnly option
- Added Themes

- Requires an allowedthemes List to be passed so they can be validataed against the defined themes.
- You can pass a subset of the defined themes so only your preferred themes are available.

  
**Update 1.51**  
  

- Small process changes to enable minimal implementation

- Please download library / Project from the dropbox link
- added minimal implementation example.

  

![](https://www.b4x.com/android/forum/attachments/104774)

  
  
**Update 1.52**  

- Fixed readOnly bug
- Added LineWrapping
- Added Autofocus
- Removed dependency on JScriptEngine
- Added highlighting for [jBasicScript](https://www.b4x.com/android/forum/threads/jbasiclib-embedded-basic-interpreter-library.101471/) (as B4s)

**Please download the b4xlib and or project from my dropbox, links above. If you have a previous version the CodeMirror js library should update itself on first run. If you have made your own changes to the CodeMirror js library, save them first and re-apply.**  
  
  
The CodeEditor.b4xlib and Project and documentation XML files for both libraries are attached.  
  
I hope you find them useful. Let me know how you get on with them.