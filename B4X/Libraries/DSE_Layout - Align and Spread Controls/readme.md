###  DSE_Layout - Align and Spread Controls by epiCode
### 12/04/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/144438/)

Drawing Inspiration from [USER=1]@Erel[/USER]'s DDD - SpreadControlsHorizontally, I tried to build two function I need very often and sharing here with everyone!  
  
What can you do with this class:  
1. Spread controls horizontally or vertically  
2. Spread controls without altering their height or width  
3. Spread controls with or without space in between  
4. Align and spread controls wrt first control  
  
**SpreadHorizontally**  
'Spreads the controls horizontally.  
'Parameters: pnl, max, gap, align  
'#0 Panel with controls in it  
'#1 Maximum size of each control (0 for no maximum, -1 to retain size),  
'#2 Minimum gap between controls  
'#3 Align with first control ( "top", "bottom", "center")  
  
**SpreadVertically**  
'Spreads the controls Vertically.  
'Parameters: pnl, max, gap, align  
'#0 Panel with controls in it  
'#1 Maximum size of each control (0 for no maximum, -1 to retain size),  
'#2 Minimum gap between controls  
'#3 Align with first control ( "left", "right", "center")  
  
**Usage:**  
Copy the Library (DSE\_Layout.b4xlib) to Additional Library Folder  
Refresh Libraries in IDE and Add DSE\_Layout  
Access the Methods from Designer Script Window ( DSE\_Layout ) or declare Class and call Method directly.  
  
Shared as B4xLib, Feel free to modify, Give credit if you like to!