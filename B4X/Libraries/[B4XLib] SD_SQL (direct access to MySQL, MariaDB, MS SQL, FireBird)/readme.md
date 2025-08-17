###  [B4XLib] SD_SQL (direct access to MySQL, MariaDB, MS SQL, FireBird) by Star-Dust
### 04/05/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/121478/)

Based on [USER=21400]@Peter Simpson[/USER]'s code ([**here**](https://www.b4x.com/android/forum/threads/jdbcsql-connector-j-connect-directly-to-mysql-mssql-postgresql-mariadb-and-oracle-databases.107545/)), I developed a library that allows you to connect **directly** to MySql, MsSql (for the moment) databases with **B4A and B4J.** *To be clear, you don't need JRDC to connect to the database located on a server*  
  
(I am working on a version for b4i, but it is only obtainable with a wrap. it will take a long time because I have never written a line in objective-c).  
SQL library already exists for B4J and it would not be necessary to create a new library. But to maintain compliance in writing the code I preferred to develop a B4XLib that works for both B4i and B4j   
  
Being a B4XLib class, the code is perfectly reusable. It suffices on these two jar files **jtds-1.3.1.jar** and **mysql-connector-java-5.1.47-bin.jar**. (You can find these files in the [USER=21400]@Peter Simpson[/USER] thread or on the internet). With both B4A and B4J the jar files must be copied to the libreries folder.  
To connect to the Firebird database read [**post 26**](https://www.b4x.com/android/forum/threads/b4x-b4xlib-sd_sql-for-ms-sql-mysql-firebird.121478/post-807143)  
  
***It is not a wrap**, it does not depend on the internal SQL library. It is written entirely in B4X  
You can use it to access DataBases that allow **direct access both in a local network** and through the internet. you cannot access databases of external services that allow access only through PHP or ASP*  
  
**NOTE**: *You can use this library for personal and commercial use. Include it in your projects.. Attention, even if it is a **B4XLib** library, it is not allowed to decompress it, modify it, change its name or redistribute it without the permission of the author*   
For **B4A** Add this on Manifest:  

```B4X
<uses-permission android:name="android.permission.INTERNET" />  
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

  
  
**SD\_SQL  
  
Author:   
Version:** 0.07  

- **SD\_ResultSet**

- **Functions:**

- **Close**
- **first** As Boolean
- **GetBytes** (ColumnName As String) As Byte()
*You can use it like GetBlob*- **GetBytes2** (index As Int) As Byte()
*You can use it like GetBlob*- **GetColumnName** (index As Int) As String
- **GetDouble** (ColumnName As String) As Double
- **GetDouble2** (index As Int) As Double
- **GetFloat** (ColumnName As String) As Float
- **GetFloat2** (index As Int) As Float
- **GetInt** (ColumnName As String) As Int
- **GetInt2** (index As Int) As Int
- **GetLong** (ColumnName As String) As Long
- **GetLong2** (index As Int) As Long
- **GetRow** As Int
- **GetShort** (ColumnName As String) As Short
- **GetShort2** (index As Int) As Short
- **GetString** (ColumnName As String) As String
- **GetString2** (index As Int) As String
- **Initialize** (OriginalResultSet As JavaObject)
*Initializes the object. You can add parameters to this method if needed.*- **isClosed** As Boolean
- **last** As Boolean
- **NextRow** As Boolean
- **PreviousRow** As Boolean
- **relativeRow** (row As Int) As Boolean
*is used to move the cursor to the relative row number in the ResultSet object, it may be positive or negative.*
- **Properties:**

- **ColumnCount** As Int [read only]

- **SD\_SQL**

- **Events:**

- **Ready** (Success As Boolean)

- **Fields:**

- **MyConnection** As Object

- **Functions:**

- **Close**
- **Connect** (DriverClass As String, JDBCurl As String, DBUser As String, DBPassword As String)
- **connected** As Boolean
- **ExecNonQuery** (Statement As String) As Boolean
- **ExecQuery** (Query As String) As SD\_ResultSet
*Return resultSet object*- **ExecQueryResutSet** (Query As String) As Object
- **Initialize** (CallBack As Object, Event As String)
*Initializes the object. Insert row with #AdditionalJar  
 MySQL Driver <code> #AdditionalJar: mysql-connector-java-5.1.47-bin.jar</code>  
 MSSQL Driver <code> #AdditionalJar: jtds-1.3.1.jar</code>  
 PostgreSQL Driver <code> #AdditionalJar: postgresql-42.2.6.jar</code>  
 MariaDB Driver <code> #AdditionalJar: mariadb-java-client-2.4.2.jar</code>  
 Oracle Driver <code> #AdditionalJar: ojdbc8.jar</code>*
  
  

---

  
*Update 0.02*  
[INDENT]Add: GetRow, first, last, isClosed, GetShort, GetShort2[/INDENT]  
[INDENT][/INDENT]  
*Update 0.03*  
[INDENT]Add: PreviousRow, relativeRow[/INDENT]  
[INDENT][/INDENT]  
*Update 0.04*  
[INDENT]ExecNonQuery return boolean success value[/INDENT]  
[INDENT][/INDENT]  
*Update 0.06*  
[INDENT]Fix Bugs[/INDENT]  
[INDENT][/INDENT]  
*Update 0.07*  
[INDENT]Added the connect method, Added the connected field. Examples updated[/INDENT]