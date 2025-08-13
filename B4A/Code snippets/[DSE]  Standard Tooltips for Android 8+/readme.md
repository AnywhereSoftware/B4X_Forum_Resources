### [DSE]  Standard Tooltips for Android 8+ by stevel05
### 10/13/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/143481/)

Based on [USER=13742]@Dave O[/USER] 's code in this [thread](https://www.b4x.com/android/forum/threads/standard-tooltips-for-android-8.143440/), here is a Designer script extension to add standard tooltips for Android 8+  
  

```B4X
'Parameters: Text As String, 1 view  
'Code in DesignerScript:{class}.SetTooltip("Tooltip", Button1)  
Public Sub SetTooltip(DesignerArgs As DesignerArgs)  
    Dim p As Phone  
    If p.SdkVersion >= 26 Then  
        Dim Text As String = DesignerArgs.Arguments.Get(0)  
        Dim viewJO As JavaObject = DesignerArgs.GetViewFromArgs(1)  
        viewJO.RunMethod("setOnLongClickListener", Array As Object(Null))   'remove any longClick listener  
        viewJO.RunMethod("setTooltip", Array As Object(Text))  
    End If  
End Sub
```

  
  
Then just add the code to the designer script for your layout.  
  
Code in DesignerScript: {class}.SetTooltip("Tooltip", Button1)  
  
{class} is wherever you put the sub, it can go in any class you like. It can go in B4xMainPage, or an existing Utils class if you have one, or it's own separate class.