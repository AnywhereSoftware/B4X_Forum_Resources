### [DBF] Read/Write DBF file using jDBF by aeric
### 12/27/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/136728/)

<https://www.b4x.com/android/forum/threads/aceesing-dbf-files.47068/>  
The example above works but the characters are not displaying correctly. With some trial-and-error, I finally get it works like the Test.java  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
    #AdditionalJar: jdbf-1.2.jar  
#End Region  
  
Sub Process_Globals  
  
End Sub  
  
Sub AppStart (Args() As String)  
    ' Set charset to GBK  
    Dim CSet As JavaObject  
    CSet.InitializeStatic("java.nio.charset.Charset")  
    Dim cs As Object = CSet.RunMethod("forName", Array As String("GBK"))  
   
    ' Initialize DBF Reader  
    Dim dbfReader As JavaObject  
    dbfReader.InitializeNewInstance ("com.hexiong.jdbf.DBFReader", Array As Object ("book2.dbf")) ' D:\Development\B4J\DBF\Objects\  
  
    ' Get field name  
    Dim FieldsName As String  
    Dim FieldsCount As Object = dbfReader.RunMethod("getFieldCount", Null)  
    For i = 0 To FieldsCount - 1  
        Dim Fld As JavaObject = dbfReader.RunMethod("getField", Array As Object(i))  
        Dim Nam As String = Fld.RunMethod("getName", Null)  
        FieldsName = FieldsName & $"${Nam}  |  "$  
    Next  
    Log(FieldsName)  
   
    ' Read fields  
    Do While dbfReader.RunMethod("hasNextRecord", Null)  
        Dim res() As Object = dbfReader.RunMethod("nextRecord", Array As Object(cs))  
        Dim row As String  
        For Each Field In res  
            row = row & $"${Field}  |  "$  
        Next  
        Log(row & CRLF)  
    Loop  
   
    ' Close the dbf file  
    dbfReader.RunMethod ("close", Null)  
End Sub
```

  
  

```B4X
'Non-UI application (console / server application)  
#Region Project Attributes  
    #CommandLineArgs:  
    #MergeLibraries: True  
    #AdditionalJar: jdbf-1.2.jar  
#End Region  
  
Sub Process_Globals  
  
End Sub  
  
Sub AppStart (Args() As String)  
    TestWrite  
End Sub  
  
Sub TestRead  
    ' Initialize DBF Reader  
    Dim dbfReader As JavaObject  
    dbfReader.InitializeNewInstance("com.hexiong.jdbf.DBFReader", Array As Object ("testwrite.dbf"))  
  
    ' Get field name  
    Dim FieldsName As String  
    Dim FieldsCount As Object = dbfReader.RunMethod("getFieldCount", Null)  
    For i = 0 To FieldsCount - 1  
        Dim Fld As JavaObject = dbfReader.RunMethod("getField", Array As Object(i))  
        Dim Nam As String = Fld.RunMethod("getName", Null)  
        FieldsName = FieldsName & $"${Nam}  |  "$  
    Next  
    Log(FieldsName)  
   
    ' Read fields  
    i = 0  
    Do While dbfReader.RunMethod("hasNextRecord", Null)  
        Dim res() As Object = dbfReader.RunMethod("nextRecord", Null)  
        Dim row As String  
        For Each Field In res  
            row = row & $"${Field}  |  "$  
        Next  
        Log(row & CRLF)  
        i = i + 1  
    Loop  
    Log("Total Count: " & i)  
   
    ' Close the dbf file  
    dbfReader.RunMethod("close", Null)  
End Sub  
  
Sub TestWrite  
    ' Initialize JDB Fields  
    Dim t1 As Char = "C"  
    Dim t2 As Char = "N"  
    Dim t3 As Char = "F"  
    Dim t4 As Char = "D"  
   
    Dim JDBField As JavaObject  
    Dim col1 As JavaObject = JDBField.InitializeNewInstance("com.hexiong.jdbf.JDBField", Array("ID", t1, 8, 0))  
    Dim JDBField As JavaObject  
    Dim col2 As JavaObject = JDBField.InitializeNewInstance("com.hexiong.jdbf.JDBField", Array("Name", t1, 254, 0))  
    Dim JDBField As JavaObject  
    Dim col3 As JavaObject = JDBField.InitializeNewInstance("com.hexiong.jdbf.JDBField", Array("TestN", t2, 20, 0))  
    Dim JDBField As JavaObject  
    Dim col4 As JavaObject = JDBField.InitializeNewInstance("com.hexiong.jdbf.JDBField", Array("TestF", t3, 20, 6))  
    Dim JDBField As JavaObject  
    Dim col5 As JavaObject = JDBField.InitializeNewInstance("com.hexiong.jdbf.JDBField", Array("TestD", t4, 8, 0))  
   
    Dim JDBFields As JavaObject  
    Dim fields() As Object = JDBFields.InitializeArray("com.hexiong.jdbf.JDBField", Array(col1, col2, col3, col4, col5))  
   
    ' Initialize DBF Writer  
    Dim dbfWriter As JavaObject  
    dbfWriter.InitializeNewInstance("com.hexiong.jdbf.DBFWriter", Array As Object ("testwrite.dbf", fields))  
  
    Dim row1 As Object = Array("1", "hexiong ", 500, 500.123, CurrentDate)  
    Dim row2 As Object = Array("2", " hefang ", 600, 600.234, CurrentDate)  
    Dim row3 As Object = Array("3", "hexi01234567890123456789012345678901234567890123456789" & _  
    "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789" & _  
    "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789", 600, 600.234, CurrentDate)  
    Dim row4 As Object = Array("4", "heqiang", 700, 700.456, CurrentDate)  
  
    Dim records() As Object  
    records = Array As Object(row1, row2, row3, row4)  
    For i = 0 To records.Length - 1  
        dbfWriter.RunMethod("addRecord", Array(records(i)))  
    Next  
   
    ' Close the dbf file  
    dbfWriter.RunMethod("close", Null)  
   
    Log("testwrite.dbf write finished…….")  
    TestRead  
End Sub  
  
Sub CurrentDate As Object  
    Dim jo As JavaObject  
    jo.InitializeNewInstance("java.util.Date", Null)  
    'Log(jo)  
    Return jo  
End Sub
```

  
  
jDBF is available for free download here: <https://code.google.com/archive/p/jdbf/downloads>  
  
**Updates:**  
Reupload to GitHub as **version 1.3** <https://github.com/pyhoon/jdbf>  
[SPOILER="Republish"][/SPOILER][SPOILER="Republish"]  
**version: 1.4**  
- Fix trim of String field  
- Fix logical value with blank space as False  
**version: 1.5**  
- Fix error when not trim on number field  
**version: 1.6**  
- Fix error when not trim on date field  
  
Modified source code attached jdbf.zip (IntelliJ IDEA project)  
[/SPOILER]