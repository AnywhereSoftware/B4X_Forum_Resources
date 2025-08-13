### Export B4XTable to Excel File (B4A) by Brian Michael
### 12/25/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/145029/)

Hello everyone, I want to share a method to be able to export a table from B4XTable to an Excel file in B4A.  
  
This code is very basic and can be adjusted for any need.  
  
You are free to play with its possibilities.  
  
In this case you will need the following libraries:  
-B4XTable 1.21+  
-Excel 1.00+  
  
  

```B4X
Public Sub ExportTableToExcel(Table As B4XTable, FileName As String)  
    Log("Exporting table.")  
     
    Dim Download_Path As String = File.DirRootExternal & "/Download"  
    Log($"File Dir: ${Download_Path}/${FileName}"$)  
  
  
    Dim newWorkbook As WritableWorkbook  
    newWorkbook.Initialize(Download_Path, $"${FileName}"$)  
    Dim sheet1 As WritableSheet  
    sheet1 = newWorkbook.AddSheet(FileName, 0)  
   
   
    Dim iColumn As Int = 0  
  
    For Each Column As B4XTableColumn In Table.Columns  
        Dim cell As WritableCell  
        cell.InitializeText(iColumn, 0, Column.Title)  
        sheet1.AddCell(cell)  
        iColumn = iColumn + 1  
    Next  
     
    For i = 1 To Table.Size  
        Dim cInt As Int = 0  
        For Each Column As B4XTableColumn In Table.Columns  
            Dim Row As Object = Table.GetRow(i).Get(Column.Title)  
            Dim cell As WritableCell  
            cell.InitializeText(cInt, i, Row)  
            sheet1.AddCell(cell)  
            cInt = cInt + 1  
        Next  
    Next  
     
    'Must call write and close to save the data.  
    newWorkbook.Write  
    newWorkbook.Close  
    xui.MsgboxAsync($"File Dir: ${Main.Path}/${FileName}"$,"Table Exported")  
    Log("Export sucessfull!…")  
End Sub
```

  
  
  
How to Use:  
> It's very easy, once you create the table and load the data, you can add a button to generate the excel file. It's just assigning the table you want to export to the function.

  

```B4X
ExportTableToExcel(B4XTable, FileName)
```

  
  
> - B4XTable = Your table  
> - FileName = The name you want to save

  
  
Thanks for viewing this post, and any tips or other ways to do this code can be shared below.  
  
  
B4J Code: <https://www.b4x.com/android/forum/threads/export-b4xtable-to-excel-file.138908/>