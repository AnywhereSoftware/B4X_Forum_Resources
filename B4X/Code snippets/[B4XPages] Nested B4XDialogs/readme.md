###  [B4XPages] Nested B4XDialogs by Erel
### 06/16/2020
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/119094/)

B4A project is attached.  
  
By default, when a B4XDialog is shown it will close other visible dialogs. This is prevented with this line:  

```B4X
Dim rs As Object = MainDialog.ShowCustom(CustomPanel, "Ok", "", "")  
MainDialog.Base.Parent.Tag = "" 'this will prevent the dialog from closing when the second dialog appears.  
Wait For (rs) Complete (Result As Int)
```

  
  
The other interesting thing is how to handle the back key:  

```B4X
Sub B4XPage_CloseRequest As ResumableSub  
    For Each d As B4XDialog In Array(SecondDialog, MainDialog) 'order is important. Should start from the nested dialog.  
        If d.Visible Then  
            d.Close(xui.DialogResponse_Cancel)  
            Return False 'don't close the page  
        End If  
    Next  
    Return True  
End Sub
```