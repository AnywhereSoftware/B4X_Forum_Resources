### xCSVHelper - wrapper from Apache Commons CSV by tummosoft
### 04/21/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/159876/)

Apache Commons is a powerful library for handling CSV files. It offers features like reading arbitrary numbers of values per line and ignoring commas within quoted elements.  
  
Sources Code: [Github](https://github.com/tummosoft/xCSVHelper)  
  

```B4X
#AdditionalJar: commons-csv-1.10.0.jar  
#MultiDex: true  
  
Sub Process_Globals    
    Private xui As XUI  
     
    Dim csvparsering As xCSVHelper  
End Sub  
  
Sub Globals  
     
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    File.Copy(File.DirAssets,"customers-100.csv", File.DirInternalCache, "file1.csv")  
     
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub Button1_Click  
     
     
    Dim filepath As String = File.Combine(File.DirInternalCache, "file1.csv")  
    'Index,Customer Id,First Name,Last Name,Company,City,Country,Phone 1,Phone 2,Email,Subscription Date,Website  
    Dim fileds() As String = Array As String("_id","_customerid","_firstname")  
    csvparsering.FieldSeparator = ","  
    csvparsering.SkipEmptyRows = True  
    csvparsering.ErrorOnDifferentFieldCount = True  
    Dim lstrs As List = csvparsering.Parser(filepath, fileds)  
    Log("Size=" & lstrs.Size)  
     
    For i=0 To lstrs.Size - 1  
        Dim row As Map = lstrs.Get(i)  
        Log(row.Get("_firstname"))  
    Next  
End Sub
```

  
  

```B4X
Private Sub Button2_Click  
    Dim filepath As String = File.Combine(File.DirInternalCache, "file1.csv")  
    csvparsering.Initialize("csvparsering")  
    csvparsering.FieldSeparator = ","  
    csvparsering.SkipEmptyRows = True  
    csvparsering.ErrorOnDifferentFieldCount = True     
    csvparsering.Parser2(filepath)  
End Sub  
  
Sub csvparsering_Parsing(row As xCSVRecord)  
      
    Log("col=" &  row.getByColumn(0))  
    Log("col=" &  row.getByColumn(1))  
    Log("col=" &  row.getByColumn(2))  
End Sub
```