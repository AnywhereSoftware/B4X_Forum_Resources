###  BBScrollingLabel  - rich text scrolling label by Erel
### 10/17/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/114310/)

![](https://www.b4x.com/basic4android/images/F0DYcnZwgV.gif)  
(this is an animated gif, it is is much smoother in real usage)  
  
BBScrollingLabel is similar to XUI Views ScrollingLabel, however it is based on BCTextEngine and can therefore display formatted text.  
  
It is cross platform.  
  
Usage instructions:  
- Download the b4xlib and put it in the B4X additional library folder: <https://www.b4x.com/android/forum/threads/103165/#content>  
- Add reference to BBScrollingLabel and BCTextEngine : <https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/#content>  
- Add BBScrollingLabel with the designer.  
  
Code:  

```B4X
Sub Globals  
    Private BBScrollingLabel1 As BBScrollingLabel  
    Private TextEngine As BCTextEngine  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("1")  
    TextEngine.Initialize(Activity) 'change to Form.RootPane in B4J or Page.RootPanel in B4i  
    BBScrollingLabel1.TextEngine = TextEngine  
    BBScrollingLabel1.Text = $"BBScrollingLabel: Red Green Blue. More information: https://www.b4x.com……………"$  
End Sub  
  
Sub Activity_Resume  
    'this is required in B4A only (when not using B4XPages). It resumes the animation after the activity was paused.  
    BBScrollingLabel1.Text = BBScrollingLabel1.Text  
End Sub
```

  
  
**Updates**  
  
v1.05 - mBase is public.  
v1.04 - Fixes an issue where invalid text cannot be replaced.  
v1.03 - Fixes an issue where previous text wasn't cleared.  
v1.02 - Fixes an issue in B4i where the label is resized before it is ready.  
v1.01 - Fixes crash when text is empty.  
 - New MaxWidth designer property. Sets the maximum width of the full text.