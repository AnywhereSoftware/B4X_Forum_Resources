###  Localizator with CSV files by Cadenzo
### 03/01/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/114404/)

For the first time I try to make my apps multilingual and found [this very useful helper](https://www.b4x.com/android/forum/threads/b4x-localizator-localize-your-b4x-applications.68751/#content). But I prefer to use CSV files (not excel) for the translations. So I combined it with [this CSV-Parser](https://www.b4x.com/android/forum/threads/b4x-csvparser-csv-parser-and-generator.110901/#content).  
(By the way: Please check line 43 in the original CSVParser Class. I think, if you want to skip first row, it should be "**CurrentIndex = 1**", not 0.)  
  
Now in the tool, you choose a CSV file (by default separated with ';', but you can change it in the code. The rest is the same as in the original tool.  

```B4X
Private Sub BuildDatabaseFromCSV (Csv As String, Output As String)  
    Dim SeparatorChar As Char = ";"  
    Dim parser As CSVParser  
    parser.Initialize  
    Dim table As List = parser.Parse(File.ReadString(Csv, ""), SeparatorChar, False)  
  
    '…  
End Sub
```

  
  
The CSV file should be utf-8 encoded. If not, convert the encoding in the file or after File.ReadString in the code like that:  

```B4X
Sub ConvertTextencoding(text As String, fromEncoding As String, toEncoding As String) As String  
    Dim b() As Byte = text.getbytes(fromEncoding) 'Encoding: "UTF-8", "iso-8859-1", …  
    Return BytesToString( b, 0, b.Length, toEncoding)  
End Sub
```

  
  
**Update**: Now, after praxis test with google docs (table - download file as csv), had to correct a bug in line 100 (Main) and now it is "," as default SeparatorChar.