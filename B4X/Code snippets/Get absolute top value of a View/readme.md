###  Get absolute top value of a View by LucaMs
### 11/17/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/164095/)

```B4X
Private Sub GetAbsViewTop(xView As B4XView) As Int  
    Dim Top As Int = xView.top  
    Dim Parent As B4XView = xView.Parent  
    Do While Parent.IsInitialized = True  
        #IF B4A  
            If GetType(Parent).EndsWith("b4a.BALayout") Then  
                Try  
                    Top = Top + Parent.Top  
                    Parent = Parent.Parent  
                Catch  
                    Exit  
                    Log(LastException)  
                End Try  
            Else  
                Exit  
            End If  
        #ELSE  
            Top = Top + Parent.Top  
            Parent = Parent.Parent  
        #End If  
    Loop  
    Return Top  
End Sub
```

  
  
Tested very little. Also, maybe someone has already published a snippet like this.  
  
EDIT: read [post #12](https://www.b4x.com/android/forum/threads/b4x-get-absolute-top-value-of-a-view.164095/post-1006722)