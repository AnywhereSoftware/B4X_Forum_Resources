### [B4XPages] (B4J only) Show a B4XPage as modal by LucaMs
### 02/10/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170280/)

In a code module:  

```B4X
#IF B4J  
  
Public Sub ShowAsModal(PageID As String, Resizable As Boolean)  
    Dim BaseForm As Form  
    Dim objPage As Object = B4XPages.GetManager.GetPage(PageID)  
    BaseForm = B4XPages.GetNativeParent(objPage)  
    BaseForm.AlwaysOnTop = True  
    BaseForm.Resizable = Resizable  
  
    BaseForm.ShowAndWait  
End Sub  
  
#END IF
```