### [Tool] Make your own notification icon with an ASCII and/or a FontAwesome/Material Icons character by walt61
### 03/28/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/103754/)

Hi all,  
  
I wanted an easy way to create simple B4A notification icons consisting of a letter and a symbol; the symbol could then show things like 'there is a message' / 'there are no messages' / 'there is no network connection'. So I came up with MakeNotificationPng. Attached you'll find the B4J project as well as a small B4A app (TestNotificationPng) with which you can test the generated icons.  
  
Usage - top left pane:  
- Select a character in at least one of the ComboBoxes in the top left corner  
- Use the TextField to filter the right hand side Combobox descriptions  
- Use the RadioButtons to choose FontAwesome or Material Icons for the right hand side Combobox  
- The 'Restart' Button lets you restart afresh  
  
In the top right pane:  
- Select which character(s) to manipulate (the left one or the right, or both)  
- Move the selected character(s) left/right/up/down with the arrow Buttons  
- Move either character by dragging it (if checkbox 'Enable dragging' is checked; dragging the right hand side character may be erratic; I didn't find a bulletproof solution for this issue so if that happens, use the 'move' buttons instead)  
- Flip the selected character(s) horizontally or vertically (may not work depending on the OS and JDK version)  
- Rotate the selected character(s) 30 degrees at a time  
- Use the ComboBox to change the left character's font  
- Change the font size of the selected character(s)  
- Use the CheckBoxes to set/unset Bold and Italic for the left character's font  
- Use the yellow handles to crop the image (thank you Klaus :)  
- Save the image as png (and make it read-only) in a B4A app's Objects\res\drawable folder, from where it can be used as a Notification icon  
  
Files folder contents:  
 - listfa.txt: a copy of C:\Program Files (x86)\Anywhere Software\B4J\FontAwesomeList.txt  
 - listmi.txt: a copy of C:\Program Files (x86)\Anywhere Software\B4J\MaterialIcons.txt  
  
Library dependencies:  
 - JavaObject, jCore, jFX, jGauges, jShell, jXUI: core libraries by Erel  
 - xResizeAndCrop: by Klaus - <https://www.b4x.com/android/forum/threads/b4x-xui-xresizeandcrop.100109/>  
  
Enjoy!  
  
![](https://www.b4x.com/android/forum/attachments/127145)