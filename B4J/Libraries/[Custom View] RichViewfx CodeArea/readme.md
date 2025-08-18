### [Custom View] RichViewfx CodeArea by stevel05
### 12/24/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/62823/)

This is a custom view and very light wrapper for the RichTextFX Codearea from Thomas Mikula on github. There is enough in here to display code, useful for a snippets manager or similar.  
  
![](https://www.b4x.com/android/forum/attachments/40938)  
  
It is based on the example provided here: <https://github.com/TomasMikula/RichTextFX#automatic-highlighting-of-java-keywords> and modified with some, but I'm certain not all, B4x keywords and types.  
  
It should provide a start to using the rest of the available views in that library.  
  
You need to download the fat jar from the website listed under Manual Download from here:  
<https://github.com/TomasMikula/RichTextFX#download>  
  
and add it you your additional libraries folder.  
  
In case they release a new version, make sure it's the same filename as in the additionalJar declaration at the top of the Main Module in the app. Otherwise, change the declaration.  
  
The customview is usable from the designer and from code, and provides an editable CodeArea. It is simple to make it read only in the designer or in code (see the demo)  
  
Requires B4j 4.20 Beta or later.  
  
Have fun  
  
**Update:** Added rfx-print, allows saving loading and printing of files and displaying Tabs as spaces.  
  
**rfxPrint requires**:  
  
[jfx8Print](https://www.b4x.com/android/forum/threads/b4j-print-javafx8.49836/) ,  
  
(Others Part of B4j distribution)  
jSQL  
jRandomAccessFile  
  
  
Uses Standard Utilities (Included in the project file):  
CSSUtils  
KeyValueStore  
  
**Update** rfx-print1.1: Improves cut and paste, allows cutting and pasting selections.  
**Update** rfx-print1.2:  
[INDENT]Add / Remove line numbers[/INDENT]  
[INDENT]Improved regex matching[/INDENT]  
[INDENT]Reposition cursor after cut / paste[/INDENT]  
[INDENT]Printer font size is a better match to the screen display[/INDENT]  
**Update** RichTextView0.2 and RichTextView-print1.3 updated to work with the latest fat-jar libraries (0,8.2 +) Also tested with 0.9.0  
  
  
[INDENT][/INDENT]  
**Note**: if the combo box displays downwards - off the screen, then you need to download the latest Java jdk. This was a bug which has now been fixed.  
  
  
**Update** to RichTextview-Print v 1.4 as a b4xlib to work with richtextfx-fat-0.10.5 which is downloadable from :<https://github.com/FXMisc/RichTextFX>.  
I've also uploaded the code in a project file. (RichFX-Print.zip and RichFX-PrintB4xlib)  
  
**Information** For those wanting to run on java > 8 you will need to add these lines to your project.  
  

```B4X
#VirtualMachineArgs: –add-opens javafx.graphics/javafx.scene.text=ALL-UNNAMED  –add-exports javafx.graphics/com.sun.javafx.text=ALL-UNNAMED  
#PackagerProperty: VMArgs = –add-opens javafx.graphics/javafx.scene.text=b4j –add-exports javafx.graphics/com.sun.javafx.text=b4j
```

  
249 209