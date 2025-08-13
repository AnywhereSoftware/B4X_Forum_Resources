###  [B4XTable] Clear data only (keeping the table structure) by LucaMs
### 02/08/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/159126/)

**Edit**: [Erel's way](https://www.b4x.com/android/forum/threads/b4x-b4xtable-clear-data-only-keeping-the-table-structure.159126/post-977029) is much simpler!  
  
Author: [USER=121923]@cklester[/USER] (<https://www.b4x.com/android/forum/threads/b4xtable-clearing-data.142729/post-904607>)  
  

```B4X
Sub ClearB4XTable(xTable As B4XTable)  
    Dim lstData As List  
    lstData.Initialize  
    xTable.SetData(lstData)  
End Sub
```

  
  
  
  
*Note to Erel: this is not "cool":*  
  
![](https://www.b4x.com/android/forum/attachments/150532)