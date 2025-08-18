### CodeMirror Javascript Code editor wrapper - proof of concept. by stevel05
### 12/22/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/124854/)

**This proof of concept is now deprecated, for a more useful implementation see the** [CodeMirrorWrapper / CodeEditor Library](https://www.b4x.com/android/forum/threads/codemirror-wrapper-and-example.125775/post-785682)  
  
  
This is a proof of concept test for the javascript library [CodeMirror](https://codemirror.net/).  
  
I still like RichtextFX, but it is limited to Java 8, so I went in search of an alternative. Code Mirror seems very comprehensive and will do the simple task I want it for admirably. It is a huge project. If you want to use it I suggest you prepare yourself to do some reading.  
  
I have added a mode for B4x, but it is only currently a copy of the vbscript mode, and needs a lot of work. But it is fine just to prove to myself that it will work as I want it to. CodeMirror supports 100 different languages out of the box.  
  
The code includes wrappers for Webengine and Worker classes as well as a WebViewWrapper I wrote a few years ago to make interfacing B4j and Javascript more manageable.  
  
Unfortunately the full project is too large to upload, so I have removed the codemirror js library and zipped it for convenience, which you can download from my dropbox here: <https://www.dropbox.com/s/577qj8bf0225v7s/codemirror.zip?dl=0>  
  
It is version 5.58.3 which is the latest.  
  
Just copy that into your projects Files directory as is, it will be unzipped when the program runs.  
  
  
![](https://www.b4x.com/android/forum/attachments/103506)  
  
Screen shot as requested. (updated)  
  
**Update to V1.1**  

- Added change font size
- Added hide line numbes
- Fixed issue in CodeMirror library where it was not possible to select text with the mouse.

- CodeMirror Library patched as per - <https://github.com/codemirror/CodeMirror/issues/5733>

If you have downloaded the first version, you will need to download the new version of the CodeMirror library from my dropbox, comment out the check for the existing library so it can be overwritten: Line 50 of WebCodeEditor  
  

```B4X
'CodeMirror js files, only copied once. Updates not yet managed.  
'    If File.IsDirectory(XUI.DefaultFolder,"codemirror-5.58.3") = False Then  
        File.Copy(File.DirAssets,"codemirror.zip",XUI.DefaultFolder,"codemirror.zip")  
        Dim Arc As Archiver  
        Log(Arc.UnZip(XUI.DefaultFolder,"codemirror.zip",XUI.DefaultFolder,"") & "Files unzipped")  
        File.Delete(XUI.DefaultFolder,"codemirror.zip")  
'    End If
```

  
  
Then Uncomment it so it doesn't unzip the file every time it runs.  
  
**Update to V1.2**  

- changed HTML template for better loading and consistency.
- Implemented encodebase64 for text transfer
- now a proper wrapper, all required calls are in the CodeEditorWrapper
- improved syntax highlighting

  
**Update to V1.3**  

- Added access to most of the available languages
- Added b4x.js to the proper structure within CodeMirror mode folder and Meta.js
- Added new code module to Map Language Names to mime types
- Added and implemented autoLoad addon to select language by MimeType
- Changes to the CodeMirror library - requires downloading new version

  
**Upgrade to V1.4**  

- Added doc.clearHistory to setCode to stop undo removing the new code
- Added #javacompilerpath to ide parameter words.
- requires download of codemirrorlib
- Moved the InitializeFiles sub to the WebCodeEditor class where it belongs.

  
Don't forget to download the codemirror library and save it in the projects Files folder as is. <https://www.dropbox.com/s/577qj8bf0225v7s/codemirror.zip?dl=0>  
  
**This will be the last update to this version of the code mirror wrapper, it has proven useful to me but is tied too closely with the WebCodeEditor class, so I will be changing the way the wrapper works to make it easier to integrate into other projects and will release it as a new version once completed.  
  
Known issues:**  

- Sometimes the scrollbars do not disappear, resulting in the last line of the file being covered. if this is a problem for you then an extra empty line at the end will sort this out until a solution is found. - **This seems to no longer be an issue, let me know if you see it.**
- Smart strings are only parsed to 1 level, so it doesn't handle nested smart strings. If you know javascript well (which I don't) I'm sure you could sort this out. If you do, please share.

  
  
Now added a b4xlib with the required files  
  
There is a full manual and some examples on their website if you want to explore or find other functions [CodeMirror](https://codemirror.net/).  
  
Let me know how you get on with it.  
  
**Dependencies**  

- [CodeMirror.zip](https://www.dropbox.com/s/577qj8bf0225v7s/codemirror.zip?dl=0)
- [Archiver](https://www.b4x.com/android/forum/threads/lib-archiver.21688/post-125497)
- [jScriptEngine](https://www.b4x.com/android/forum/threads/jscriptengine.35781/post-210025)
- jStringUtils