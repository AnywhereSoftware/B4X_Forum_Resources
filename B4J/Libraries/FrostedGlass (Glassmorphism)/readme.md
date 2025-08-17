### FrostedGlass (Glassmorphism) by aeric
### 02/18/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/165671/)

**Introduction:**  
I have tried to create a blur panel for my dashboard or POS cashier layout a few years ago but failed.  
I retry with ChatGPT and DeepSeek AI assistant but still facing some problems with blurring effect, redrawing and positioning when the form is resized.  
Finally, I succeeded.  
Here I present to you the library.  
  
![](https://www.b4x.com/android/forum/attachments/161827)  

---

  
  
**FrostedGlass  
Author:** Aeric Poon  
**Version:** 2.11  

- Methods/Properties:

- Clear
- Redraw
- Panel As Pane (readonly)
- Visible As Boolean
- CornerRadius As Int

- Events

- MouseClicked

- Designer's properties

- Blur Radius (v1.x)
- Corner Radius

Code example:  

```B4X
Private Sub MainForm_Resize (Width As Double, Height As Double)  
    FrostedGlass1.Redraw  
End Sub  
  
Private Sub FrostedGlass1_MouseClicked  
    FrostedGlass2.Visible = Not(FrostedGlass2.Visible)  
End Sub
```