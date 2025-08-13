### Print or Save as PDF a Table from B4XTable by Brian Michael
### 12/25/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/145030/)

Hello everyone, I want to share a method to be able to print or save as pdf a table from B4XTable.  
  
This code is very basic and can be adjusted for any need.  
  
You are free to play with its possibilities.  
  
In this case you will need the following libraries:  
-B4XTable 1.21+  
-Printing 1.0+ ([Link](https://www.b4x.com/android/forum/threads/printing-and-pdf-creation.76712/#content))  
  
  

```B4X
Public Sub PrintTable(Table As B4XTable, FileName As String)  
  
    Dim printer As Printer  
    printer.Initialize("printer")  
      
    Dim PrintString As String = $"  
    <!DOCTYPE html>  
    <html>  
    <head>  
    <style>  
    Table {  
    font-family: arial, sans-serif;  
    border-collapse: collapse;  
    width: 100%;  
    }  
      
    td, th {  
    border: 1px solid #dddddd;  
    text-align: left;  
    padding: 8px;  
    }  
      
    tr:nth-child(even) {  
    background-color: #dddddd;  
    }  
    </style>  
    </head>  
    <body>  
    <h2>File Name: ${FileName}</h2>  
    <h4>Date: ${DateUtils.TicksToString(DateTime.Now)}</h4>  
    <Table><tr>  
    "$  
          
    For Each Column As B4XTableColumn In Table.Columns  
        PrintString = PrintString & $"<th>${Column.Title}</th>${CRLF}"$  
    Next  
    PrintString = PrintString & "</tr>"  
      
    For i = 1 To Table.Size  
        PrintString = PrintString & "<tr>"  
        For Each Column As B4XTableColumn In Table.Columns  
            Dim Row As Object = Table.GetRow(i).Get(Column.Title)  
            PrintString = PrintString & $"<td>${Row}</td>${CRLF}"$  
        Next  
        PrintString = PrintString & "</tr>"  
    Next  
    PrintString = PrintString & "</table>"  
      
    printer.PrintHtml("job", $"${PrintString}"$)  
End Sub
```

  
  
  
How to Use:  
> It's very easy, once you create the table and load the data, you can add a button to print the table. It's just assigning the table you want to print the function.

  

```B4X
PrintTable(B4XTable, FileName)
```

  
  
> - B4XTable = Your table  
> - FileName = The name you want to show

  
  
Thanks for viewing this post, and any tips or other ways to do this code can be shared below.`