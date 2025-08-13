### SetEllipsize for Multiple Lines in B4X Labels by Mehrzad238
### 05/18/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/167051/)

In B4X, the default behavior for ellipsizing text in a Label is limited to a single line when the SingleLine property is set to true. This often restricts developers who want to display longer text while still managing how it is presented in the UI.   
  
The SetEllipsize Sub provides a solution by allowing you to set ellipsizing for multiple lines (e.g., two lines) without needing to enable the SingleLine property. This enables better control over text display in Labels and improves the user interface by ensuring that overflowing text is handled gracefully.  
  

```B4X
Sub SetEllipsize(lbl As Label)  
    Dim jo As JavaObject = lbl  
    jo.RunMethod("setMaxLines", Array(2)) ' Limit to 2 lines  
    jo.RunMethod("setEllipsize", Array("END")) ' Add ellipsis at the end  
End Sub
```