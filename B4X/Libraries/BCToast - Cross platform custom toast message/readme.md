###  BCToast - Cross platform custom toast message by Erel
### 12/06/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/111046/)

BCToast is a custom "toast" message implementation based on BCTextEngine: <https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/#content>  
  
It requires BCTextEngine v1.65+.  
  
![](https://www.b4x.com/basic4android/images/java_Vr5tF2Iymf.png)  
  
Note that unlike B4A built-in toast message feature, this toast message can only be displayed from an Activity.  
  
Usage example:  

```B4X
Sub Globals  
   Private toast As BCToast  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   toast.Initialize(Activity) 'Use Page1.RootPanel in B4i or MainForm.RootPane in B4J.  
End Sub  
  
Sub Activity_Click  
   toast.Show($"The time now is $Time{DateTime.Now}"$)  
End Sub
```

  
  
Default duration is set to 3000 ms. It can be changed with the DurationMs field.  
The text itself is highly customizable. See BCTextEngine for more information.  
  
Tip: use the plain tag if you are showing error messages or any other unsanitized text:  

```B4X
Toast.Show($"[plain]${LastException.Message}[/plain]"$)
```

  
Otherwise the text might include square brackets which will be treated as invalid bbcode.  
  
  
V1.01 - Adds support for images.  
New fields:  

```B4X
Public PaddingSides As Int = 15dip  
Public PaddingTopBottom As Int = 10dip  
Public MaxHeight As Int = 100dip  
Public VerticalCenterPercentage As Int = 85
```