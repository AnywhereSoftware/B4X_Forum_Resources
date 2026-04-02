### VisualHelp_JE by Jerryk
### 03/30/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/170617/)

The library displays local help above layout elements  
  
![](https://www.b4x.com/android/forum/attachments/170671)  
  
**VisualHelp\_JE  
Author: Jerryk  
Version: 1.14**  
  
Properties  
[TABLE]  
[TR]  
[TD]**BackgroundColor** (value As Int)[/TD]  
[TD]sets and gets a semi-transparent background[/TD]  
[TD]0x80808080[/TD]  
[/TR]  
[TR]  
[TD]**TextColor** (value As Int)[/TD]  
[TD]sets and gets the help text color[/TD]  
[TD]0xFFF5F5F5[/TD]  
[/TR]  
[TR]  
[TD]**TextSize** (value As Float)[/TD]  
[TD]sets and gets the help text size[/TD]  
[TD]20[/TD]  
[/TR]  
[TR]  
[TD]**HelpColor** (value As ColorDrawable)[/TD]  
[TD]sets and gets background for help text[/TD]  
[TD]xui.Color\_Black, 10dip, 2dip, xui.Color\_RGB(245, 245, 245)[/TD]  
[/TR]  
[TR]  
[TD]**SwitchIconColor** (value As Boolean)[/TD]  
[TD]automatically sets the icon color (white or black) according to the object color[/TD]  
[TD]True[/TD]  
[/TR]  
[TR]  
[TD]**BlackIcons** (value As Boolean)[/TD]  
[TD]When true, the icon color is black. Ignored when SwitchIconColor = true[/TD]  
[TD]False[/TD]  
[/TR]  
[TR]  
[TD]**SetIconDimensions** (width As Int, height As Int)[/TD]  
[TD]sets the icon size[/TD]  
[TD]50dip, 50dip[/TD]  
[/TR]  
[TR]  
[TD]**SetFrame** (color As Int, width As Int)[/TD]  
[TD]sets the color and thickness of the highlighted object's border[/TD]  
[TD]Color\_Yellow, 3dip[/TD]  
[/TR]  
[/TABLE]  
  
Funtions  
[TABLE]  
[TR]  
[TD]**Initialize** (Parent As B4XView, ptimeDisplay As Long)[/TD]  
[TD]initialize library[/TD]  
[TD]Parent - parent object, timeDisplay - time to automatically display next help, 0 = disabled[/TD]  
[/TR]  
[TR]  
[TD]**AddInfo** (pInfo As String, pY As Int)[/TD]  
[TD]adds info panel, without icon[/TD]  
[TD]pInfo - text of info, pY - Y position[/TD]  
[/TR]  
[TR]  
[TD]**AddHelp** (pTarget As B4XView, pHelp As String, pIcon As Byte)[/TD]  
[TD]adds help panel[/TD]  
[TD]pTarget - target object, pHelp - text of help, pIcon - type of icon[/TD]  
[/TR]  
[TR]  
[TD]**ShowHelp**[/TD]  
[TD]show helps[/TD]  
[TD][/TD]  
[/TR]  
[/TABLE]  
  
types of icons (also in white)  
![](https://www.b4x.com/android/forum/attachments/170672)![](https://www.b4x.com/android/forum/attachments/170673)![](https://www.b4x.com/android/forum/attachments/170674)![](https://www.b4x.com/android/forum/attachments/170675)![](https://www.b4x.com/android/forum/attachments/170682)![](https://www.b4x.com/android/forum/attachments/170676)![](https://www.b4x.com/android/forum/attachments/170677)![](https://www.b4x.com/android/forum/attachments/170681)![](https://www.b4x.com/android/forum/attachments/170678)![](https://www.b4x.com/android/forum/attachments/170679)![](https://www.b4x.com/android/forum/attachments/170680)