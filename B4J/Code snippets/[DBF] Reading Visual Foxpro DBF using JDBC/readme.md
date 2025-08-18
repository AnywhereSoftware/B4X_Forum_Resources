### [DBF] Reading Visual Foxpro DBF using JDBC by aeric
### 12/14/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/136840/)

This snippet demonstrates how to use FoxPro JDBC Driver to read DBF file. The driver read the DBF file and generate a H2 cache in C:/Users/<UserName>/.DbSchema/jdbc-dbf-cache/  
 Compare to jDBF driver, this driver can read more field types such as timestamp (T) or datetime, General, Memo and more.  
  
Download FoxPro JDBC Driver: <https://dbschema.com/jdbc-drivers/FoxProJdbcDriver.zip>  
More info: <https://dbschema.com/jdbc-driver/FoxPro.html>  
GitHub: <https://github.com/wise-coders/dbf-jdbc-driver>  
  
[DBF] Read/Write DBF file using jDBF: <https://www.b4x.com/android/forum/threads/dbf-read-write-dbf-file-using-jdbf.136728/>  
  
H2 Database: <https://www.b4x.com/android/forum/threads/h2-database.132688/>  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 900  
    #MainFormHeight: 500  
#End Region  
#AdditionalJar: javadbf-1.13.2  
#AdditionalJar: dbschema-dbf-jdbc1.0.jar  
#AdditionalJar: h2-1.4.200.jar  
' Download FoxPro JDBC Driver: https://dbschema.com/jdbc-drivers/FoxProJdbcDriver.zip  
' More info: https://dbschema.com/jdbc-driver/FoxPro.html  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
     
    Public dbf As JdbcSQL  
    Private driver As String = "com.dbschema.xbase.DbfJdbcDriver"  
    Private jdbcUrl As String = "jdbc:dbschema:dbf:/C://Users//Aeric//Desktop//jdbcDBF//Objects//data?[charset=GBK]"  
    Private B4XTable1 As B4XTable  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
     
    Wait For (ReadTable) Complete (Success As Boolean)  
    If Success Then  
        xui.MsgboxAsync("Success", "ReadTable")  
    End If  
End Sub  
  
Sub Connect As Boolean  
    dbf.Initialize(driver, jdbcUrl)  
    If dbf.IsInitialized Then  
        Return True  
    End If  
    Return False  
End Sub  
  
Sub ReadTable As ResumableSub  
    Dim Success As Boolean  
    If Connect Then  
        Try  
            Dim sf As Object = dbf.ExecQueryAsync("dbf", "SELECT * FROM sample", Null)  
            Wait For (sf) dbf_QueryComplete (Success As Boolean, res As JdbcResultSet)  
            If Success Then                
                Log(" ")  
                Do While res.NextRow  
                    Log($"id: ${res.GetInt("id")} | Name: ${res.GetString("item_name")} | Barcode: ${res.GetInt("barcode")} | Cost: ${res.GetDouble("avg_cost")} | Created: ${res.GetString("created_on")}"$)  
                Loop  
                res.Close  
            End If  
             
            Log(" ")  
             
            ' B4J Tutorial H2 Database  
            ' https://www.b4x.com/android/forum/threads/h2-database.132688/  
            Dim driver As String = "org.h2.Driver"  
            Dim url As String = $"jdbc:h2:C://Users//Aeric//.DbSchema//jdbc-dbf-cache/bc2c5c3e2a2f9142b893f50d4287f8c1;database_to_upper=false"$  
            Dim DB As SQL  
            DB.Initialize(driver, url)  
             
            ' Test UPDATE  
            DB.ExecNonQuery2("UPDATE sample SET ITEM_NAME = ? WHERE ID = ?", Array("Testing", 1))  
             
            B4XTable1.AddColumn("id", B4XTable1.COLUMN_TYPE_NUMBERS)  
            B4XTable1.AddColumn("Name", B4XTable1.COLUMN_TYPE_TEXT)  
            B4XTable1.AddColumn("Barcode", B4XTable1.COLUMN_TYPE_TEXT)  
            B4XTable1.AddColumn("Cost", B4XTable1.COLUMN_TYPE_NUMBERS)  
            B4XTable1.AddColumn("Created", B4XTable1.COLUMN_TYPE_TEXT)  
             
            Dim data As List  
            data.Initialize  
             
            Dim res As ResultSet = DB.ExecQuery("SELECT * FROM sample")  
            Do While res.NextRow  
                Log($"id: ${res.GetInt("id")} | Name: ${res.GetString("item_name")} | Barcode: ${res.GetInt("barcode")} | Cost: ${res.GetDouble("avg_cost")} | Created: ${res.GetString("created_on")}"$)  
                data.Add(Array(res.GetInt("id"), res.GetString("item_name"), res.GetInt("barcode"), res.GetDouble("avg_cost"), res.GetString("created_on")))  
            Loop  
            res.Close  
            B4XTable1.SetData(data)  
            B4XTable1.Refresh  
            Success = True  
        Catch  
            Log(LastException)  
        End Try  
        CloseConnection  
    End If  
    Return Success  
End Sub  
  
Sub CloseConnection  
    dbf.Close  
End Sub
```