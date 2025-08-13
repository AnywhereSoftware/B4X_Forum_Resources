### xSQLCipher for Android Sqlcipher 4.5.4 by tummosoft
### 03/04/2024
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/159584/)

This library is modified based on Erel's source code. I tried popular SQLCipher libraries like Zetetic, Guardianproject but Sqlcipher worked better, even though this library is no longer updated.  
Some functions, because I don't have time, I haven't tested them yet. I posted the source code here. If there are any errors, please download the source code from [Github.com](https://github.com/tummosoft/xSQLCipher)  
  
\* Create new database on Android OS  
*sqlci.initializeCipher("dtest", "swqhccKWiaLKJuPCGH2ebA==", 20)  
  
\* Copy other source from Asset folder:| If your database is blank password, it can't not change*  
Dim target As String = File.Combine(File.DirInternalCache, "db\_cipher.db")  
File.Copy(File.DirAssets, "db\_cipher.db",File.DirInternalCache, "db\_cipher.db")  
sqlci.initializeCopy("sqlci", target, "", 1)  
  
\* A tool help you create Sqlcipher on desktop: ([console\_sqlcipher\_1.8.0.zip](https://github.com/tummosoft/xSQLCipher))  
![](https://www.b4x.com/android/forum/attachments/151461)  
  
  
**New method for xSQLCipher library:**  
*ChangePassword(password As String)  
ChangePassword(password() As Byte)   
getDatabasePath As String  
encrypt(RealPath As String, passphrase() As Byte)  
decrypt(RealPath As String, passphrase() As Byte)  
isDBEncrypted() as boolean  
DeleteTable(table as string, where as string, arg as string)  
PageSize() as long  
DatabasePath() as string*  
  
**GenerateAESKey and token**  

```B4X
Dim tken As xEncrypter  
Dim token As String = tken.encrypt(tken.generateAESKey, "12345678")    ' 128 bits (16 bytes)  
Dim seckey() As Byte = tken.SecretKey  
   
Log("HEX=" & tken.parseByte2HexStr(seckey))
```

  
  
**You can save your publickey to Preferences**  

```B4X
Dim tokenManganer As TokenManager  
tokenManganer.initialize  
tokenManganer.saveTokenToPreferences("sql_pass", token)
```

  
  
  

```B4X
#AdditionalJar: sqlite-2.4.0.aar  
#AdditionalJar: android-database-sqlcipher-4.5.4.aar  
  
Dim sqlci As xSQLCipher  
Dim key As String = "Hello world"  
Dim c As B4XCipher  
Dim b() As Byte = c.Encrypt(key.GetBytes("utf8"), "12345678")  
sqlci.initializeCipher(sqlci, "db3.db", "12345678", 1)  
  
Sub Button1_Click  
    sqlci.ExecNonQuery("CREATE TABLE table1 (col1 TEXT, col2 INTEGER, col3 INTEGER)")  
    For i=0 To 10  
        sqlci.ExecNonQuery2("INSERT INTO table1 VALUES (?, ?, ?)", Array As Object("some text" & i, i, i * 2))  
    Next  
   
End Sub  
  
Private Sub Button2_Click  
    Dim Cursor As Cursor  
    Cursor = sqlci.ExecQuery("SELECT col1, col2 FROM table1")  
    For i = 0 To Cursor.RowCount - 1  
        Cursor.Position = i  
        Log(Cursor.GetString("col1"))  
        Log(Cursor.GetInt("col2"))  
    Next  
End Sub
```