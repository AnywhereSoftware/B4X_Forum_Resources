###  AS AutoComplete - Custom Datasource and Icons by Alexander Stolte
### 01/02/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/164919/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-autocomplete-based-on-as-selectionlist.164908/>  
  
In this example I will show you how you can use your own data source and also display icons.  
  
In this example I use a SQLite database with all countries and flags  
  
![](https://www.b4x.com/android/forum/attachments/160291) ![](https://www.b4x.com/android/forum/attachments/160292)  
  
**Custom Datasource**  
If you have not specified a data source, the [ICODE]RequestNewData[/ICODE] event is triggered every time the search text changes.  
  
When the event is triggered, a snapshot of the layout is created, the list is emptied and only filled when SetNewData is added with the new items.  
  
**Example**  

```B4X
Private Sub AS_AutoComplete1_RequestNewData(SearchText As String)  
      
    Dim lstItems As List 'New List of AS_SelectionList_Item  
    lstItems.Initialize  
      
    'SQL query based on the search text  
    Dim DR As ResultSet = sql1.ExecQuery2("SELECT * FROM dt_Country WHERE name LIKE ? ORDER BY name ASC",Array As String("%" & SearchText & "%"))  
      
    Do While DR.NextRow  
          
        'This is only required in this example, otherwise the flag emojis will not be displayed  
        Dim Buffer() As Byte  
        Buffer = DR.GetBlob("flag")  
        Dim FlagEmoji As String = BytesToString(Buffer,0,Buffer.Length,"UTF-8")  
      
        'Add item to the list  
        lstItems.Add(AS_AutoComplete1.CreateItem(DR.GetString("name"),AS_AutoComplete1.TextToBitmap(FlagEmoji,xui.CreateDefaultFont(25),xui.Color_Black),DR.GetString("code")))  
          
    Loop  
    DR.Close  
      
    AS_AutoComplete1.SetNewData(lstItems) 'Pass the list of items  
      
End Sub
```

  
As soon as SetNewData is called, the list is filled with the new items and displayed it  
  
Example Project is attached