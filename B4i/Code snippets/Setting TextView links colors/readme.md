### Setting TextView links colors by Erel
### 03/10/2024
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/159794/)

![](https://www.b4x.com/android/forum/attachments/151615)  
  

```B4X
Private Sub SetTextViewLinkAttributes(view As TextView, Foreground As Int, LineColor As Int)  
    Dim no As NativeObject = view  
    Dim m As Map = CreateMap("NSColor": no.ColorToUIColor(Foreground), "NSUnderlineColor": no.ColorToUIColor(LineColor))  
    no.SetField("linkTextAttributes", m.ToDictionary)  
End Sub
```

  
  
Example:  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Dim cs As CSBuilder  
    cs.Initialize.Font(xui.CreateDefaultFont(20)).Append("example text1 ")  
    cs.Link("link1").Underline.Append("This is my Link").Pop.Pop  
    cs.Append(" example text2").PopAll  
    TextView1.AttributedText = cs  
    SetTextViewLinkAttributes(TextView1, xui.Color_Red, xui.Color_Green)  
End Sub
```