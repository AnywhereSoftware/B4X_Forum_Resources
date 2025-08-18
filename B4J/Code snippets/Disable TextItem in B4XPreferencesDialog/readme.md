### Disable TextItem in B4XPreferencesDialog by aeric
### 08/06/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/133228/)

Sometimes we want to lock a TextItem from being editable. For example a primary key item.  

```B4X
Dim sf As Object = PrefDialog.ShowDialog(Data, "OK", "CANCEL")  
If RowId > 0 Then  
    Dim pi As B4XPrefItem = PrefDialog.GetPrefItem("Item Code") ' <– Disallow edit on Item Code  
    PrefDialog.CustomListView1.AnimationDuration = 0  
    If pi.ItemType = PrefDialog.TYPE_TEXT Then  
        Dim pnl As B4XView = PrefDialog.CustomListView1.GetPanel(0)  
        Dim ft As B4XFloatTextField = pnl.GetView(0).Tag  
        ft.mBase.Enabled = False  
    End If  
End If  
  
Wait For (sf) Complete (Result As Int)
```

  
References:  
<https://www.b4x.com/android/forum/threads/b4x-cross-platform-editable-b4xtable-form-example.104766/>  
<https://www.b4x.com/android/forum/threads/solved-how-to-hide-cancel-confirm-buttons-in-textitem-of-the-b4xpreferencesdialog.116534/post-728125>