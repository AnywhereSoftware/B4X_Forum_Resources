### [B4x] B4xDialog4Button by stevel05
### 12/21/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/124104/)

I needed a dialog with 4 options and rather than rewrite the b4xDialog class I opted for a different approach.  
  
This class adds a panel to an existing B4xDialog and adds 4 Buttons. quite simple really.  
  
![](https://www.b4x.com/android/forum/attachments/102335) ![](https://www.b4x.com/android/forum/attachments/102334)  
  
  
Some code was borrowed from the B4xDialog B4xLib so I could ensure compatibility across platforms.  
  
I attach a b4xlib and the source code in a b4j project.  
  
**Depends On:**  

- XUI
- XUI Views

**Usage:**  
  

```B4X
    Dialog.Title = "Add type"  
    Dialog.ButtonsFont = xui.CreateDefaultFont(14)  
  
    Dim D4 As B4xDialog4Button  
    D4.Initialize(Dialog)  
    Wait For (D4.Show("Select","NewBtn","Positive","Negative","Cancel")) Complete (Resp As Int)  
  
    Select Resp  
        Case D4.DialogResponse_NewButton  
            Log("NewButton")  
        Case D4.DialogResponse_Cancel  
            Log("Cancel")  
        Case D4.DialogResponse_Negative  
            Log("Negative")  
        Case D4.DialogResponse_Positive  
            Log("Positive")  
         
    End Select
```

  
  
**Update to v1.1**  

- Added ShowCustom and ShowTemplate
- Buttons will not respond to State changes (B4xInputTemplate) but works if you need the 4th button.

  
I can't test it on B4i, but there is no reason it shouldn't work.  
  
Let me know how you get on with it.