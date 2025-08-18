### Parse SQL Schema File Into SQLite by cklester
### 10/28/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/123938/)

When you [create a SQLite database with DB Browser for SQLite](https://www.b4x.com/android/forum/threads/b4x-create-and-use-sqlite-databases-with-db-browser.92527/#content), you can output a schema file for the database. Instead of manually copying each CREATE line into your source, you can simply use the code below to read and parse the schema file automatically and create the SQLite database inside of and for your app.  
  

```B4X
'returns a list of string commands you can pass to an SQLite database  
Sub ParseSQLSchemaFile (dir As String, fn As String) As List  
    Dim txtSql As String  
    Dim cmdList As List  
    Dim i As Int  
  
    cmdList.Initialize  
    If File.Exists(xui.DefaultFolder,fn) Then  
        txtSql = File.ReadString(dir, fn)  
        Dim sb As StringBuilder  
        sb.Initialize  
        i = 0  
        Do While i < txtSql.Length  
            Dim next_char As String = txtSql.CharAt(i)  
            If next_char = ";" Then  
                sb.Append(next_char)  
                cmdList.Add(sb)  
                sb.Initialize  
            Else If Asc(next_char) <> 10 And Asc(next_char) <> 13 And Asc(next_char) <> 9 Then  
                sb.Append(next_char)  
            End If  
            i=i+1  
        Loop  
    End If  
    Return cmdList  
End Sub  
  
'here is an example function making use of it  
Sub CreateBaseDB (schemaFile as string, dbfn as string)  
    SQL1.InitializeSQLite(xui.DefaultFolder,dbfn,True)  
    Dim txtCmdList As List  
   
    txtCmdList.Initialize  
    txtCmdList = ParseSQLSchemaFile(xui.DefaultFolder, schemaFile)  
  
    For Each cmd As String In txtCmdList  
        SQL1.ExecNonQuery(cmd)  
    Next  
End Sub
```

  
  
Please note that generally (from what I've seen), the DB Browser for SQLite outputs a "BEGIN TRANSACTION;" and "COMMIT;", so you can be sure SQLite will be operating at peak efficiency with this code.