###  DOListDialog - simple and customisable class by Dave O
### 05/15/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/161064/)

DOListDialog is a free class that makes it easy to display a list dialog.  
  
Features:  
- Easy to use: supply a title and a list and you're good to go.  
- Auto-size the dialog to the minimum width or height needed, or leave it full-size.  
- Show or hide the Cancel button as needed.  
- Customize the visual layout by editing familiar component views.  
- Free to use or modify (as long as you credit me as the original developer).  
- Requires no additional libraries.  
  
Still to do:  
- Add support for the abstract designer.  
- Auto-adapt to the current device theme (e.g. dark mode).  
- Check compatibility with B4XPages (which I haven't tried yet - guessing it won't be hard).  
- Add support for XUI (haven't gone there yet).  
  
Background:  
I needed to show a list to the user, and was surprised to find that most (all?) of the various dialog libraries didn't include a list dialog, or provided something close but not quite what I was looking for [edit: didn't know about InputListAsync - see below]. B4XDialog has a flexible custom dialog with a list template, but its variable naming conflicted with my code, so I decided to roll my own.  
  
Demo app and class attached. Cheers!  
  
![](https://www.b4x.com/android/forum/attachments/153648) ![](https://www.b4x.com/android/forum/attachments/153649)