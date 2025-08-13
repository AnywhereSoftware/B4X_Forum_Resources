### Localize B4XFloatTextField Hint text by AnandGupta
### 06/23/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/148673/)

I need to localize B4XFloatTextField Hint text so I added the below in **Localizator.bas**  
  
[B4X] [B4XPages] Localizator | B4X Programming Forum  
<https://www.b4x.com/android/forum/threads/b4x-b4xpages-localizator.142775/>  
  

```B4X
#if B4A  
Public Sub LocalizeLayout(PanelOrActivity As Panel)  
    For Each v As View In PanelOrActivity.GetAllViewsRecursive  
        'Log(v)  
        If v Is Label Then 'this will catch all of Label subclasses which includes EditText, Button and others  
            Dim lbl As Label = v  
            Log("< "&lbl.Text)  
            lbl.Text = Localize(lbl.Text)  
            Log("> "&lbl.Text)  
        End If  
        If v Is EditText Then  
            Dim et As EditText = v  
            Log("< "&et.Hint)  
            et.Hint = Localize(et.Hint)  
            Log("> "&et.Hint)  
        End If  
        If v.Tag Is B4XFloatTextField Then  
            Dim ft As B4XFloatTextField = v.Tag  
            Log("< "&ft.HintText)  
            ft.HintText = Localize(ft.HintText)  
            ft.Update  
            Log("> "&ft.HintText)  
        End If  
    Next  
End Sub  
#else if B4I
```

  
  
Hope it helps members.