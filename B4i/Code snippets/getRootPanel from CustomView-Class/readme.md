### getRootPanel from CustomView-Class by Filippo
### 08/30/2026
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/171946/)

Hi,  
  
using 'myRootPanel = Props.Get("page")' retrieves the RootPanel when a CustomView is located within a Page or Panel; using the procedure retrieves the RootPanel even if it is located within a ScrollView.  
  

```B4X
Public Sub getRootPanel(v As B4XView) As B4XView  
    Dim current As Object = v  
    Dim lastValidPanel As B4XView = v  
      
    Do While True  
        ' We retrieve the parent as a generic object to avoid crashes during casting  
        Dim parentObj As Object = current.As(B4XView).Parent  
          
        ' Abort if no parent exists  
        If parentObj = Null Then Exit  
          
        ' Check the parent's type  
        Dim t As String = GetType(parentObj)  
      
        ' Only if it's a genuine B4i panel do we take it to the next level  
        If t.Contains("B4IPanelView") Or t.Contains("UIScrollView") Then  
            lastValidPanel = parentObj  
            current = parentObj  
        Else  
            ' UIWindow, UITransitionView, etc. reached -> End loop  
            Exit  
        End If  
    Loop  
      
    Return lastValidPanel  
End Sub
```