###  B4XDialog - show with animation by Erel
### 02/24/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/114292/)

Slides the dialog from one of the sides.  
  

```B4X
Sub AnimateDialog (dlg As B4XDialog, FromEdge As String)  
    Dim base As B4XView = dlg.Base  
    Dim top As Int = base.Top  
    Dim left As Int = base.Left  
    Select FromEdge.ToLowerCase  
        Case "bottom"  
            base.Top = base.Parent.Height  
        Case "top"  
            base.Top = -base.Height  
        Case "left"  
            base.Left = -base.Width  
        Case "right"  
            base.Left = base.Parent.Width  
    End Select  
    base.SetLayoutAnimated(300, left, top, base.Width, base.Height)  
End Sub
```

  
  
Usage example:  

```B4X
Sub Globals  
    Private dialog As B4XDialog  
    Private xui As XUI  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    dialog.Initialize(Activity)  
    dialog.Title = "test"  
End Sub  
  
Sub Activity_Click  
    Dim rs As Object = dialog.Show("aaa", "Ok", "Not Ok", "")  
    AnimateDialog(dialog, "right")  
    Wait For (rs) Complete (Result As Int)  
    If Result = xui.DialogResponse_Positive Then  
        '…  
    End If  
End Sub
```