### NumberProgressBar V3 by DonManfred
### 05/15/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/52356/)

This is a wrapper for [this Github-project](https://github.com/daimajia/NumberProgressBar).  
This is a complete rewrite of the wrapper as i lost the source by accident.  
V2 includes CustomProperties for the Designer.  
  
**NumberProgressBar  
Author:** DonManfred (wrapper)  
**Version:** 3  

- **NumberProgressBar**
Events:

- **onProgressChange** (current As Int, maxvalue As Int)

- **Fields:**

- **ba As BA**

- **Methods:**

- **BringToFront**
- **DesignerCreateView** (base As PanelWrapper, lw As LabelWrapper, props As Map)
- **Initialize** (EventName As String)
- **Invalidate**
- **Invalidate2** (arg0 As Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsInitialized As Boolean**
- **RemoveView**
- **RequestFocus As Boolean**
- **SendToBack**
- **SetBackgroundImage** (arg0 As Bitmap)
- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)
- **dp2px** (dp As Float) **As Float**
- **incrementProgressBy** (by As Int)
- **sp2px** (sp As Float) **As Float**

- **Properties:**

- **Background As Drawable**
- **Color As Int** *[write only]*
- **Enabled As Boolean**
- **Height As Int**
- **Left As Int**
- **Max As Int**
- **Parent As Object** *[read only]*
- **Prefix As String**
- **Progress As Int**
- **ProgressTextColor As Int**
*progress text color.*- **ProgressTextSize As Float**
*progress text size.*- **ProgressTextVisible As Boolean**
- **ReachedBarColor As Int**
- **ReachedBarHeight As Float**
- **Suffix As String**
- **Tag As Object**
- **Top As Int**
- **UnreachedBarColor As Int**
- **UnreachedBarHeight As Float**
- **Visible As Boolean**
- **Width As Int**

  
![](https://camo.githubusercontent.com/0c92568af7ec4e04e2e1503acdd2ca99854ab0b5/687474703a2f2f7777332e73696e61696d672e636e2f6d773639302f36313064633033346a77316566797264386e376937673230637a30326d7135662e676966)  
  
Code used in Example  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
    Private np1 As NumberProgressBar  
    Private np2 As NumberProgressBar  
    Private np3 As NumberProgressBar  
    Dim t1, t2, t3 As Timer  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("Layout1")  
    np1.incrementProgressBy(0)  
    np1.ProgressTextColor = Colors.Blue  
    np1.ReachedBarColor = Colors.Yellow  
    np1.UnreachedBarColor = Colors.Red  
    np1.UnreachedBarHeight = 1dip  
    np1.ReachedBarHeight = 5dip  
    np1.Prefix = "%"  
    np1.Suffix = ""  
    t1.Initialize("t1",50)  
    t1.Enabled = True  
  
    np2.incrementProgressBy(0)  
    np2.ProgressTextColor = Colors.White  
    np2.ReachedBarColor = Colors.Green  
    np2.UnreachedBarColor = Colors.Red  
    np2.UnreachedBarHeight = 5dip  
    np2.ReachedBarHeight = 5dip  
    t2.Initialize("t2",60)  
    t2.Enabled = True  
  
    np3.incrementProgressBy(0)  
    np3.ProgressTextColor = Colors.Green  
    np3.ReachedBarColor = Colors.Magenta  
    np3.UnreachedBarColor = Colors.LightGray  
    np3.UnreachedBarHeight = 5dip  
    np3.ReachedBarHeight = 1dip  
    np3.Prefix = "Prefix"  
    np3.Suffix = "Suffix"  
    t3.Initialize("t3",100)  
    t3.Enabled = True  
End Sub  
Sub t1_tick  
    If np1.Progress <= 100 Then  
        np1.incrementProgressBy(1)  
    Else  
        t1.Enabled = False  
    End If  
End Sub  
Sub t2_tick  
    If np2.Progress <= 100 Then  
        np2.incrementProgressBy(1)  
    Else  
        t2.Enabled = False  
    End If  
End Sub  
Sub t3_tick  
    If np3.Progress <= 100 Then  
        np3.incrementProgressBy(1)  
    Else  
        t3.Enabled = False  
    End If  
End Sub
```

  
  
  
This library is Donationware. You can download the library, you can test the library. But if you want to USE the library in your App you need to Donate for it.  
Please click here to donate (You can donate any amount you want to donate for the library (or my work) :)  
[![](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=AHKKJCKJE8N7W)