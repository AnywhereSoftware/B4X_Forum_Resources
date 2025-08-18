### jBasiclib editor by stevel05
### 03/30/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/139390/)

I have been playing with Andrew Grahams excellent [jBasiclib](https://www.b4x.com/android/forum/threads/jbasiclib-embedded-basic-interpreter-library.101471/) and created an editor for an app I have been working on. I thought it might be useful to others.  
  

![](https://www.b4x.com/android/forum/attachments/127291) ![](https://www.b4x.com/android/forum/attachments/127292)

  
  
Being an embedded script language, most of my requirements work on passing an argument and returning a value. Therefore for testing, arguments can be added in the editor or captured from the clipboard. To run without an argument unselect the Requires argument checkbox. It only handles one argument, but could easily be split for testing in the script if more than one is required.  
  
Access to the log panel is through the print statement as can be seen in the example. Logc enables colour logging and the last parameter should be an int value for the colour. Use one of the color constants or the ARGB keyword (Alpha is ignored).  
  
The jBasiclib B4Script.chm is included in the B4sEditor b4xlib and is available from the Help menu, you may need to enable it to see it.  
  
Attached are a B4j project and the b4xlib for the editor, both are required.  
  
**Dependancies:**  

- [jBasiclib](https://www.b4x.com/android/forum/threads/jbasiclib-embedded-basic-interpreter-library.101471/)
- [CodeMirrorWrapper](https://www.b4x.com/android/forum/threads/codemirror-wrapper-and-example.125775/#content) (requires additional setup)
- Recent Files Manager (a b4xlib from Erel's class attached, if you have already created one, ignore this)
- SLCodeEditor b4xlib (attached)

  
I do hope this works first time as there are quite a few interdependencies ( I could easily have missed one), please be patient and forgive me if it doesn't and more importantly let me know so I can fix it.  
  
**Not implemented:**  

- Debugging

  
I hope you find it useful and maybe improve on it.  
  
**Updates**  
V 1.10  

- Added Dark Theme

- Download SLCodeEditor.b4xlib B4sEditor.b4xlib & b4sEditorV1-1.zip The project contains the required appdark.css file.