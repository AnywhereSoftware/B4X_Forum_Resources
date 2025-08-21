### Get relative view position by stevel05
### 11/05/2019
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/39389/)

**Description**: These two subs will get the positions of a view relative to the activity, regardless of how many parent panels it is nested in.  
  
**Version:** 2  
  
**SubName:** GetRelativeTop  
  

```B4X
'Iterative sub to get the views Top relative to the activity window  
Public Sub GetRelativeTop(V As JavaObject) As Int  
    'I tried several methods to do this, this was the only one that worked across API's and devices  
   
    'One of these should always be the last parent  
    If GetType(V) = "android.view.ViewRoot" Or GetType(V) = "android.view.ViewRootImpl" Or GetType(V) = "android.widget.FrameLayout$LayoutParams" Then  
        Return 0  
    Else  
        'If V.Top is valid for this view returns a value then add it, else skip to the next parent  
        Try  
            Try  
                Dim VW As View = V  
                Return VW.Top + GetRelativeTop(V.RunMethod("getParent",Null))  
            Catch  
                Return 0  
            End Try  
        Catch  
            Try  
                Return GetRelativeTop(V.RunMethod("getParent",Null))  
            Catch  
                Return 0  
            End Try  
        End Try  
    End If  
End Sub
```

  
  
**SubName:** GetRelativeLeft  
  

```B4X
'Iterative sub to get the views Left relative to the activity window  
Public Sub GetRelativeLeft(V As JavaObject) As Int  
    'I tried several methods to do this, this was the only one that worked across API's and devices  
  
    'One of these should always be the last parent  
    If GetType(V) = "android.view.ViewRoot" Or GetType(V) = "android.view.ViewRootImpl" Or GetType(V) = "android.widget.FrameLayout$LayoutParams" Then  
        Return 0  
    Else  
        'If V.Left is valid for this view returns a value then add it, else skip to the next parent  
        Try  
            Try  
                Dim VW As View = V  
                Return VW.Left + GetRelativeLeft(V.RunMethod("getParent",Null))  
            Catch  
                Return 0  
            End Try  
        Catch  
            Try  
                Return GetRelativeLeft(V.RunMethod("getParent",Null))  
            Catch  
                Return 0  
            End Try  
        End Try  
    End If  
End Sub
```

  
  
**Depends On**: JavaObject  
  
Tags: View Position Relative Activity