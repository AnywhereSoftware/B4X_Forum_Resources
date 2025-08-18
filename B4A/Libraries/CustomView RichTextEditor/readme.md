### CustomView RichTextEditor by Guenter Becker
### 04/10/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/127721/)

**[SIZE=6]OUTDATED! New Version to, have look here: [RTFeditor Version 2021 | B4X Programming Forum](https://www.b4x.com/android/forum/threads/rtfeditor-version-2021.129581/) [/SIZE]**  
  
Hello to all forum Members,  
I hope all of you are well. Looking through the forum I find the library SMMRichEditor. Playing around with it I started a new project to use this lib to build a custom view like a small word processor.  
  
**[SIZE=6]RTFEditor[/SIZE]**  
  
Version  1.3  
  
**Updated 2021/04/6 1.3:**   

- fixed minor bugs

  
![](https://www.b4x.com/android/forum/attachments/108124)  
  
**Feature list:**  
  

- Textgravity: bold, italic, underline, strikethrough, superscript, subscript
- Text as unordered list with bullets.
- Text as ordered list with numbers.
- Text with a leading checkbox.
- Align Text: left, center, right
- Set (all Text) Textcolor.
- Set (all Text) Textsize.
- Set indent, outdent.
- Undo last command/input.
- Editor scroll up/down
- Button/Function State color

**Event:** TextChanged(HTML)  
Every Time the editor text changes this event is fired and returns the text as a standard string. It should be no problem to save this string to a file or database.  
In addtion you may get the editor text from the global 'EditorText'.  
  
**Property:**   
*EditorHTMLText* as String  
Set Text to the editor e.g. retrive text from database to editor.  
*Editor Panel Height* as Int  
Default value is 200. The height of the inner control panel (editor). if this height is greater than the controls height text will scroll.  
  
**Language**: B4A  
  
**Find attached:**  
"RTFEditorDEMO.zip" as a B4A Demo Project  
library/custom control 'RTFEditor.b4xlib'  
Add the Files from "Ressources2Files.ZIP" uncompressed to the Files Directory of your Project.  
  
**NOTICE !!**  
  

- The RTFEditor view works with the libraries shown in the picture (see attached images).
- The editor creates the text as html formated string including html format characters.
- **The core of RTFeditor is the control *SMMRichEditor.* This internal control is NOT my control! Therefore I don't have access to it's source code*.* All *SMMRichEditor* Limitiations are also limiting** ***RTFeditor*** **functions***.* If you like take this link to find the SMMRichEditor lib: <https://www.b4x.com/android/forum/threads/richeditor-view.66319/#content>
- If you try debug mode you will get an error that some files like Editor.html are not found. This is why in Debug mode files are not stored in the asset folder. In release mode all is good.
- The lib file RTFeditor.B4xLib is a standard zip compressed file. To get access to the control source code rename the file to .zip uncompress it and you will get RTFeditor.bas file. Import this into a project and the code access is open

Any Comments or optimization proposals are welcome.