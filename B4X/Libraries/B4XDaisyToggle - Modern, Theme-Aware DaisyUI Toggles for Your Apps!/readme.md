###  B4XDaisyToggle - Modern, Theme-Aware DaisyUI Toggles for Your Apps! by Mashiane
### 06/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171303/)

Hello Fam! 👋  
  
If you are looking to bring a modern, web-inspired aesthetic to your B4A and B4X projects, I am thrilled to introduce **B4XDaisyToggle**!  
Inspired by the sleek aesthetics of the DaisyUI CSS framework, this component brings beautiful, theme-aware toggle switches straight to the B4X Designer. Whether you are building a settings menu, login options, or a complex user preferences screen, this custom view provides massive flexibility right out of the box.  
  
**🌟 Key Features:**  

- **Rich Color Variants:** Built-in support for gorgeous semantic colors: *Neutral, Primary, Secondary, Accent, Info, Success, Warning,* and *Error*.
- **Scale to Fit:** Choose from 5 different sizes (xs, sm, md, lg, xl) to perfectly match your app's typography and layout.
- **Advanced States:** Beyond standard Checked and Unchecked modes, it fully supports Disabled layouts and a specialized Indeterminate state.
- **Label Alignment:** Easily position your text label at the start (label on right) or end (label on left) of the toggle knob.
- **Fully Customizable:** Override the background, border, and text colors directly from the designer or via the public API to fit your brand identity (e.g., custom indigo to orange transitions).
- **Shadows & Elevations:** Add visual depth to your UI with customizable shadow levels ranging from none to 2xl.

![](https://www.b4x.com/android/forum/attachments/171889) ![](https://www.b4x.com/android/forum/attachments/171890) ![](https://www.b4x.com/android/forum/attachments/171891)  
  
  
**🚀 Quick Usage Example:** Adding functionality to the toggle is incredibly simple. You can easily hook into the Checked event to trigger your logic. Here is a quick snippet highlighting standard usage within a B4XPage:  
' Make sure to generate the members in your IDE from the Designer!  
  

```B4X
Private Sub tg_Checked(Checked As Boolean)  
    Dim source As B4XDaisyToggle = Sender  
    Dim textVal As String = source.Text  
      
    ' Handle textless (visual-only) toggles  
    If textVal.Length = 0 Then   
        textVal = "Textless Toggle"  
    End If  
      
    #If B4A  
    ToastMessageShow(textVal & " checked: " & Checked, False)  
    #End If  
End Sub
```

  
  
Drop your questions and feedback below. Happy coding, and let's make some beautiful apps together! ✨  
  
#SharingTheGoodness  
  
  
[MEDIA=youtube]dJme63fyi-g[/MEDIA]