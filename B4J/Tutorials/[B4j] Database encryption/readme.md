### [B4j] Database encryption by MichalK73
### 03/21/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/166242/)

Hello.  
  
Recently there has been an increase in hacking, data theft, etc.  
Using databases, we are exposed to unauthorized downloading of data from databases, theft of entire databases, etc. containing sensitive personal data.  
A simple select will show encrypted data, as well as downloading database files will do nothing because the columns will be encrypted and unusable.  
Therefore, forced at home to secure the data in the database, I decided to write code that encrypts the data of the columns in the tables and full freedom of use in the application.  
I used the DBM bass from ABMaterial as a basis for this since I have many such applications but it can be applied to other types of applications.  
Like the encryption library I used: [Decrypter - De-/Encrypt String to base64 (including compatible php code to de/Encrypt)](https://www.b4x.com/android/forum/threads/decrypter-de-encrypt-string-to-base64-including-compatible-php-code-to-de-encrypt.52582/)  
I chose this library because it is very fast and this is important for me during frequent operations on the database. It is almost unnoticeable in most situations.  
Can be used for SQLite, Mysql and other database connections. Data encrypted in columns is visible in any sql client without special software. The example I give is for SQLite but has been used in MYSql and works very well.  
After initializing the connection, you need to initialize the encryption: specify the columns from all the tables that are encrypted, the encryption phrase and the password.  
  

```B4X
If File.Exists(File.DirApp, "baza.db") Then  
        DBM.InitializeSQLite(File.DirApp ,"baza.db",False)  
    Else  
        DBM.InitializeSQLite(File.DirApp ,"baza.db", True)  
        DBM.SQLCreate($"CREATE TABLE one (  
    idx      INTEGER PRIMARY KEY AUTOINCREMENT,  
    email    VARCHAR,  
    password VARCHAR,  
    money    VARCHAR  
);"$)  
    End If  
    DBM.InicjalizeCrypt(Array As String("email","password"), "myhidenpasswordfor database","Hd73js2Ajd93nfof39")
```

  
  
I added a test function that already writes sample data to a table with which you can later test functions.  

```B4X
Sub RandomTableCreate(row_count As Int) 'ignore  
    DBM.SQLDelete("delete from one", Null)  
    For i=0 To row_count  
        Dim h As String = DBM.GenerateRandomPassword(5,True,False,False,False)  
        Dim money As String = DBM.GenerateRandomPassword(3,True,False,False,False)  
        DBM.SQLInsert("insert into one (email,password,money) values(?,?,?)", Array As String($"${h}@myemail.com"$, "password"&h, money))  
    Next  
    DBM.EncryptTable("one", Array As String("email","password"))  
End Sub
```

  
  
For existing arrays, we can use the prepared function to encrypt the indicated columns. **EncryptTable**  

```B4X
DBM.EncryptTable("one", Array As String("email","password"))
```

  
  
We can also permanently decrypt the entire table by specifying the columns to be decrypted **DecryptTable**  

```B4X
DBM.DecryptTable("one", Array As String("email","password"))
```

  
  
The DBM module contains the following functions (Features taken from DBM ABMaterial):  

- **SQLSelectClear**(Query As String, Args As List) As List

Sql Select on arrays that do not have encrypted data  

- **SQLCreate**( Query As String)
- **SQLInsert**(Query As String, Args As List) As Int
- **SQLUpdate**(Query As String, Arg As List) As Int
- **SQLDelete**(Query As String, Arg As List) As Int
- **SQLSelectSingleResult**(Query As String, Arg As List) As String

Features needed for encrypted data:  

- **SQLSelect**(Query As String, Args As List) As List

Sql Select on arrays that have encrypted data, Query must be built using BSelect  

- **BSelect**(TableName As String, Fields As List, WhereFields As Map, OrderFields As Map, LastArg As List) As String - Builder query for select
- **BInsert**(TableName As String, Fields As Map) As String -Builder query for insert
- **BDelete**(TableName As String, WhereFields As Map) As String - Builder query for delete
- **BUpdate**(TableName As String, Fields As Map, WhereFields As Map) As String - Builder query for update
- **BSelectLike**(name\_table As String, Like As Map) As List

You can use 'like' for one column, in the future maybe it will be for multiple columns. If you want to query more in-depth, you have to search for it on your own, programmatically, in the retrieved data containing the search term.  

- **EncryptHash**(value As String) As String - string encryption
- **DecryptHash(**value As String) As String - string decryption

**Notes:**  
Encrypted columns must preferably be of VARCHAR type without specifying the column size because the data is only in alphanumeric base64 encrypted form resulting from the encryption library.  
As for the delivery of the press and the slogan of shforging, I leave the cretiveness to my own. You can write in the code of the program or somehow provide (API ??) , typed once from your finger when starting the server from the terminal, etc.  
You can use other encryption methods available in B4X by substituting in DecryptHash and EncryptHash functions.  
I used one that is very fast, and that counts with many operations on the database.  
  
**Performance**:  
It is known that you do not need to encrypt all columns with data, you can choose the most sensitive ones like : email, username, address, pin, password, money. It all depends on you what kind of data and what size it will be.  
It takes about 2 sec to create 20000 records with 3 columns (2 encrypted).  
SQL Like encrypted for 2000 records less than 1 sec.  
SQL Select for 2000 rows and 2 columns encrypted less than 1 sec.  
  
In the attached test project there are examples of how to use and the entire DBM module.