### TD_Toast by Guenter Becker
### 04/05/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/166461/)

**Name**: TD\_Toast  
**Type**: custom B4A Class or b4xlib  
**Version**: 1  
  
This custom class subtitutes the standard android toast message. The benefits are:  

- Customizable GUI
- Timed out Message or static until clicked
- Inbuild Themes

  
[TABLE]  
[TR]  
[TD]![](https://www.b4x.com/android/forum/attachments/163193)[/TD]  
[TD]Theme Attention Toast[/TD]  
[/TR]  
[TR]  
[TD]![](https://www.b4x.com/android/forum/attachments/163194)[/TD]  
[TD]Theme Info Toast[/TD]  
[/TR]  
[TR]  
[TD]![](https://www.b4x.com/android/forum/attachments/163195)[/TD]  
[TD]Theme Question Toast,[/TD]  
[/TR]  
[TR]  
[TD]![](https://www.b4x.com/android/forum/attachments/163196)[/TD]  
[TD]Theme SuccessToast[/TD]  
[/TR]  
[TR]  
[TD]![](https://www.b4x.com/android/forum/attachments/163197)[/TD]  
[TD]Theme Error Toast[/TD]  
[/TR]  
[TR]  
[TD]![](https://www.b4x.com/android/forum/attachments/163198)[/TD]  
[TD]Individual Toast[/TD]  
[/TR]  
[TR]  
[TD]![](https://www.b4x.com/android/forum/attachments/163199)[/TD]  
[TD]Theme Loading Indicator Toast[/TD]  
[/TR]  
[/TABLE]  
  

1. Download Example Project from here [Download](https://drive.google.com/file/d/1DqAhjTbaxInsc1cGPvS4_fG_LeEzPE3J/view?usp=sharing)
2. Install Class in your project or copy *TD\_Toast.b4xlib* to your additional lib folder and activate lib in lib pane.
3. Activate this libs **B4XGifView, StringUtils, XUI**
4. Create a Reference in the *Class\_Globals* of the page like Private TD\_Toast1 as TD\_Toast

  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Sleep(0)  
      
    '# Initialize Class  
    '# Allways Me, Allways Root, eventname  
    TD_Toast1.Initialize(Me,Root,"TD_Toast1")  
End Sub
```

  
  
The Toast creates a Type Vaiable *TDToast* and a public Variable T*oastGUI.*  
**Type** TDToast ( \_  
 **Category** As String, **Duration** As Int, \_  
 **Width** As Int, **height** As Int, **Top** As Int, **Color** As Int, \_  
 **Bordercolor** As Int, **Borderwidth** As Int, **Borderradius** As Int, \_  
 **IconFile** As String, **IconWidth** As Int, **IconHeight** As Int, \_  
 **Text** As String, **Textcolor** As Int, **Textsize** As Int, \_  
 **click** As Boolean)  
  
The default duration for themed toasts is 3000ms. All needed Icons are inbuild.  
Before shown the toast view is added to the parent (B4XPage) and it is removed if the the toast goes hidden.  
  
**To show the Toast:  
TD\_Toast1.showtoast**(Category As String, Text As String, IconFile As String,click As Boolean)  
  
**Category** -Themed- : attention / info / error /question/sucess  
**Category** -individual- : gray  
**Category** -special - : *spinner* as loading indicator  
**Text**: The text shown may be a single ore multiline text. CSBuilder recomended.  
**IconFile**: Tehe Filename if categroy is gray otherwhise empty ""  
**click**: If True the toast is displayed until it is clicked.  
  
**To hide the toast manually:**  
**TD\_Toast1.killToast**  
  
**To customize the toast:**  
Before calling showToast set the individual values to the variable Public ToastGUI As TDToast (**TD\_Toast1**.ToastGUI….)  
  
**To click the toast:**  
If you click on the Toast the custom event \_click raises (**TD\_Toast1\_Click**)  
If you customize the ToastGUI you will be able to make every toast static/clickable or not.