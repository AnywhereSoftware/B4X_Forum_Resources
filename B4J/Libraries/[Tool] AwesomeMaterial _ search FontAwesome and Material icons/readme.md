### [Tool] AwesomeMaterial : search FontAwesome and Material icons by walt61
### 05/04/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/75193/)

Hi all,  
  
I wrote a little app to assist in searching these icons and copying 'Chr(…)' to the Clipboard. I imported the Material icons list from [here](https://github.com/google/material-design-icons/blob/master/iconfont/codepoints) and the FontAwesome one from [here](https://www.b4x.com/android/forum/threads/fontawesomeutils.74839/) (thank you, [USER=24057]@icefairy333[/USER] :)). Hope this will be useful for others too.  
  
EDIT 2022-05-04:  
This is no longer really relevant as the IDEs contain icon pickers now. However, this bit might be useful: the program can now save the icons to png or jpg files. Sizes and colours can be selected. I added this to be able to quickly generate an icon (for the taskbar or system tray) for a program from these font sets.  
  
Changes:  
- Replaced StatusBar (from JcontrolsFX library) with LabelStatus  
- Added RedirectOutput (for stdout and stderr)  
- Added 41 missing FontAwesome icons  
- Added CheckBox 'Also save as png or jpg'  
  
Here are some screenshots:  
  
![](https://www.b4x.com/android/forum/attachments/128829) ![](https://www.b4x.com/android/forum/attachments/128830)  
  
  
Cheers,  
  
walt61