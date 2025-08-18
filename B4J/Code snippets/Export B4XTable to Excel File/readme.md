### Export B4XTable to Excel File by Brian Michael
### 03/04/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/138908/)

Hello everyone, I want to share a method to be able to export a table from B4XTable to an Excel file.  
  
This code is very basic and can be adjusted for any need.  
  
You are free to play with its possibilities.  
  
In this case you will need the following libraries:  
-B4XTable 1.21+  
-jPoi v5.1+  
-XLUtils 2.6+  
  
  

```B4X
Public Sub ExportTableToExcel(Table as B4XTable)  
    Dim xl As XLUtils : xl.Initialize  
    Dim Workbook As XLWorkbookWriter = xl.CreateWriterBlank  
    Dim sheet1 As XLSheetWriter = Workbook.CreateSheetWriterByName("Excel Sheet Name")  
     
    Dim iColumn As Int = 0  
  
    For Each Column As B4XTableColumn In Table.Columns  
        sheet1.putString(xl.AddressZero(iColumn,0),Column.Title)  
        iColumn = iColumn + 1  
    Next  
     
    For i = 1 To Table.Size  
        Dim cInt As Int = 0  
        For Each Column As B4XTableColumn In Table.Columns  
            Dim Row As Object = Table.GetRow(i).Get(Column.Title)  
            sheet1.putString(xl.AddressZero(cInt,i),Row)  
            cInt = cInt + 1  
        Next  
    Next    
     
    Dim FileDialog As FileChooser : FileDialog.initialize  
     
    FileDialog.InitialFileName = "FileName.xlsx"  
    FileDialog.setExtensionFilter("Excel File", Array As String("*.xlsx"))  
    FileDialog.Title = "Select where you want to save"  
     
    Dim CompleteDir As String = FileDialog.ShowSave(MainForm)  
    Dim f As String = Workbook.SaveAs(File.GetFileParent(CompleteDir), File.GetName(CompleteDir), True)  
    Wait For (xl.OpenExcel(f)) Complete (Success As Boolean)  
     
    End Sub
```

  
  
How To Use:  
  
It's very easy, once you create the table and load the data, you can add a button to generate the excel file. It's just assigning the table you want to export to the function.  
  
PS: The code has a FileChooser to be able to select where you want to save the file.  
  

```B4X
ExportTableToExcel(TableObj)
```

  
  
  
Thanks for viewing this post, and any tips or other ways to do this code can be shared below.