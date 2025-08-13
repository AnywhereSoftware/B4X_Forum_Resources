### ColorPicker view to integer Color (SelectedColor, scene.paint.paint) by MrKim
### 02/24/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/146391/)

This is B4J only. Took me a while to find it so thought this might help someone else.  
  

```B4X
Private FontColor As ColorPicker  
.  
.  
Dim MyColor as int = xui.PaintOrColorToColor(FontColor.SelectedColor)
```