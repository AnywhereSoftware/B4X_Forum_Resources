### Textsize and Colors of native MsgBox by Blueforcer
### 09/15/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/163119/)

**These functions help to change the style of the native **Android** Msgbox  
  
[SIZE=5]Usage:[/SIZE]**  

```B4X
Dim sf As Object = xui.Msgbox2Async("This is how to change the look of the native msgbox","Awesome","Yes","Cancel","No",Null)  
SetTextSize(sf,40,30,35)  
SetColorAndBorder(sf,xui.Color_Black,3dip,xui.Color_Magenta,5dip)  
SetTextColor(sf,xui.Color_White,xui.Color_Cyan,xui.Color_Red)
```

  
  
**[SIZE=5]Result:[/SIZE]**  
![](https://www.b4x.com/android/forum/attachments/156980)  
  
  
  
**[SIZE=5]TextSize[/SIZE]**  

```B4X
Sub SetTextSize(sf As Object, TitleSize As Int, MessageSize As Int, ButtonSize As Int)  
    Dim jo As JavaObject = sf  
    Dim context As JavaObject = jo.RunMethod("getContext", Null)  
    Dim res As JavaObject = context.RunMethod("getResources", Null)  
  
    ' Message  
    ChangeTextSize(jo.RunMethodJO("findViewById", Array(16908299)),MessageSize) ' android.R.id.message  
  
    ' Title  
    ChangeTextSize(jo.RunMethodJO("findViewById", Array(res.RunMethod("getIdentifier", Array("alertTitle", "id", "android")))),TitleSize)  
  
    ' Buttons  
    Dim buttonIds As List = Array("button1", "button2", "button3")  
    For Each btnId As String In buttonIds  
        Dim btnView As JavaObject = jo.RunMethodJO("findViewById", Array(res.RunMethod("getIdentifier", Array(btnId, "id", "android"))))  
        ChangeTextSize(btnView,ButtonSize)  
    Next  
    'Trigger redrawing, to recalculate the size of the messagebox  
    'here you can also set a custom msgbox size or use the constrains: -1 = MATCH_PARENT, -2 = WRAP_CONTENT  
    'use -1,-1 to get a Fullscreen msgbox  
    jo.RunMethodJO("getWindow", Null).RunMethod("setLayout", Array(-2, -2))  
End Sub  
  
Sub ChangeTextSize(view As JavaObject, size As Int)  
    If view <> Null Then  
        Dim r As Reflector  
        r.Target = view  
        r.RunMethod2("setTextSize", size, "java.lang.float")  
    End If  
End Sub
```

  
  
**[SIZE=5]Backgroundcolor and Border:[/SIZE]**  

```B4X
Sub SetColorAndBorder(sf As Object,BackgroundColor As Int,BorderWidth As Int,BorderColor As Int,BorderCornerRadius As Int)  
    Dim jo As JavaObject = sf  
    Dim cd2 As ColorDrawable  
    cd2.Initialize2(BackgroundColor, BorderCornerRadius, BorderWidth, BorderColor)  
    jo.RunMethodJO("getWindow", Null).RunMethod("setBackgroundDrawable", Array(cd2))  
End Sub
```

  
  
**[SIZE=5]Textcolor:[/SIZE]**  

```B4X
Sub SetTextColor(sf As Object, TitleTextcolor As Int, MessageTextcolor As Int, ButtonTextcolor As Int)  
    Dim jo As JavaObject = sf  
    Dim context As JavaObject = jo.RunMethod("getContext", Null)  
    Dim res As JavaObject = context.RunMethod("getResources", Null)  
   
    ' Message  
    ChangeTextColor(jo.RunMethodJO("findViewById", Array(16908299)),MessageTextcolor) ' android.R.id.message  
  
    ' Title  
    ChangeTextColor(jo.RunMethodJO("findViewById", Array(res.RunMethod("getIdentifier", Array("alertTitle", "id", "android")))),TitleTextcolor)  
  
    ' Buttons  
    Dim buttonIds As List = Array("button1", "button2", "button3")  
    For Each btnId As String In buttonIds  
        Dim btnView As JavaObject = jo.RunMethodJO("findViewById", Array(res.RunMethod("getIdentifier", Array(btnId, "id", "android"))))  
        ChangeTextColor(btnView,ButtonTextcolor)  
    Next  
End Sub  
  
Sub ChangeTextColor(view As JavaObject, color As Int)  
    If view <> Null Then  
        Dim r As Reflector  
        r.Target = view  
        r.RunMethod2("setTextColor", color, "java.lang.int")  
    End If  
End Sub
```