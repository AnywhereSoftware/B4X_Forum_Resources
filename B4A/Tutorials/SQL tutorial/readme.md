### SQL tutorial by Erel
### 10/02/2019
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/6736/)

Update 2018:  
  
New video tutorial:  
  
[MEDIA=vimeo]263187269[/MEDIA]  
  
The source code is available here: <https://www.b4x.com/android/forum/threads/b4x-erel-teaches-programming-video-tutorials.88787/page-2#post-577932>  
  
Async methods: [[B4X] SQL with Wait For](https://www.b4x.com/android/forum/threads/79532/#content)  
  
The following tutorial is obsolete:  
  
This tutorial covers the SQL library and its usage with Basic4android.  
There are many general SQL tutorials that cover the actual SQL language. If you are not familiar with SQL it is recommended to start with such a tutorial.  
[SQL Introduction](http://www.w3schools.com/sql/sql_intro.asp)  
  
A new code module is available named [DBUtils](http://www.b4x.com/forum/basic4android-getting-started-tutorials/8475-dbutils-android-databases-now-simple.html). It contains methods for common tasks which you can use and also learn from the code.  
  
Android uses SQLite which is an open source SQL implementation.  
Each implementation has some nuances. The following two links cover important information regarding SQLite.  
SQLite syntax: [Query Language Understood by SQLite](http://www.sqlite.org/lang.html)  
SQLite data types: [Datatypes In SQLite Version 3](http://www.sqlite.org/datatype3.html)  
  
**SQL in Basic4android**  
The first step is to add a reference to the SQL library. This is done by going to the Libraries tab and checking SQL.  
There are two types in this library.  
An SQL object gives you access to the database.  
The Cursor object allows you to process queries results.  
  
Usually you will want to declare the SQL object as a process global object. This way it will be kept alive when the activity is recreated.  
  
SQLite stores the database in a single file.  
When we initialize the SQL object we pass the path to a database file (which can be created if needed).  

```B4X
Sub Process_Globals  
    Dim SQL1 As SQL  
End Sub  
  
Sub Globals  
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    If FirstTime Then  
        SQL1.Initialize(File.DirDefaultExternal, "test1.db", True)  
    End If  
    CreateTables  
    FillSimpleData  
    LogTable1  
    InsertManyRows  
    Log("Number of rows = " & SQL1.ExecQuerySingleResult("SELECT count(*) FROM table1"))  
   
    InsertBlob 'stores an image in the database.  
    ReadBlob 'load the image from the database and displays it.  
End Sub
```

The SQL1 object will only be initialized once when the process starts.  
In our case we are creating it in the sd card. The last parameter (CreateIfNecessary) is True so the file will be created if it doesn't exist.  
  
There are three types of methods that execute SQL statements.  
**ExecNonQuery -** Executes a "writing" statement and doesn't return any result. This can be for example: INSERT, UPDATE or CREATE TABLE.  
  
**ExecQuery** - Executes a query statement and returns a Cursor object that is used to process the results.  
  
**ExecQuerySingleResult -** Executes a query statement and returns the value of the first column in the first row in the result set. This method is a shorthand for using ExecQuery and reading the value with a Cursor.  
  
We will analyze the example code:  

```B4X
Sub CreateTables  
    SQL1.ExecNonQuery("DROP TABLE IF EXISTS table1")  
    SQL1.ExecNonQuery("DROP TABLE IF EXISTS table2")  
    SQL1.ExecNonQuery("CREATE TABLE table1 (col1 TEXT , col2 INTEGER, col3 INTEGER)")  
    SQL1.ExecNonQuery("CREATE TABLE table2 (name TEXT, image BLOB)")  
End Sub
```

The above code first deletes the two tables if they exist and then creates them again.  
  

```B4X
Sub FillSimpleData  
    SQL1.ExecNonQuery("INSERT INTO table1 VALUES('abc', 1, 2)")  
    SQL1.ExecNonQuery2("INSERT INTO table1 VALUES(?, ?, ?)", Array As Object("def", 3, 4))  
End Sub
```

In this code we are adding two rows. SQL.ExecNonQuery2 receives two parameters. The first parameter is the statement which includes question marks. The question marks are then replaced with values from the second List parameter. The List can hold numbers, strings or arrays of bytes (blobs).  
Arrays are implicitly converted to lists so instead of creating a list we are using the Array keyword to create an array of objects.  
  

```B4X
Sub LogTable1  
    Dim Cursor1 As Cursor  
    Cursor1 = SQL1.ExecQuery("SELECT col1, col2, col3 FROM table1")  
    For i = 0 To Cursor1.RowCount - 1  
        Cursor1.Position = i  
        Log("************************")  
        Log(Cursor1.GetString("col1"))  
        Log(Cursor1.GetInt("col2"))  
        Log(Cursor1.GetInt("col3"))  
    Next  
    Cursor1.Close  
End Sub
```

This code uses a Cursor to log the two rows that were previously added.  
SQL.ExecQuery returns a Cursor object.  
Then we are using the For loop to iterate over all the results.  
Note that before reading values from the Cursor we are first setting its position (the current row).  
  

```B4X
Sub InsertManyRows  
    SQL1.BeginTransaction  
    Try  
        For i = 1 To 500  
            SQL1.ExecNonQuery2("INSERT INTO table1 VALUES ('def', ?, ?)", Array As Object(i, i))  
        Next  
        SQL1.TransactionSuccessful  
    Catch  
        Log(LastException.Message)  
    End Try  
    SQL1.EndTransaction  
End Sub
```

This code is an example of adding many rows. Internally a lock is acquired each time a "writing" operation is done.  
By explicitly creating a transaction the lock is acquired once.  
The above code took less than half a second to run on a real device.  
Without the BeginTransaction / EndTransaction block it took about 70 seconds.  
A transaction block can also be used to guarantee that a set of changes were successfully done. Either all changes are made or none are made.  
By calling SQL.TransactionSuccessful we are marking this transaction as a successful transaction. If you omit this line, all the 500 INSERTS will be ignored.  
It is very important to call EndTransaction eventually.  
Therefore the transaction block should usually look like:  

```B4X
SQL1.BeginTransaction  
Try  
  'Execute the sql statements.  
SQL1.TransactionSuccessful  
Catch  
'the transaction will be cancelled  
End Try  
SQL1.EndTransaction
```

Note that using transactions is only relevant when doing "writing" operations.  
  
**Blobs**  
The last two methods write an image file to the database and then read it and set it as the activity background.  

```B4X
Sub InsertBlob  
    Dim Buffer() As Byte = File.ReadBytes(File.DirAssets, "smiley.gif")  
    'write the image to the database  
    SQL1.ExecNonQuery2("INSERT INTO table2 VALUES('smiley', ?)", Array As Object(Buffer))  
End Sub
```

Here we are using a special type of OutputStream which writes to a dynamic bytes array.  
File.Copy2 copies all available data from the input stream into the output stream.  
Then the bytes array is written to the database.  
  

```B4X
Sub ReadBlob  
    Dim Cursor1 As Cursor = SQL1.ExecQuery2("SELECT image FROM table2 WHERE name = ?", Array As String("smiley"))  
    Cursor1.Position = 0  
    Dim Buffer() As Byte = Cursor1.GetBlob("image")  
    Dim InputStream1 As InputStream  
    InputStream1.InitializeFromBytesArray(Buffer, 0, Buffer.Length)  
    Dim Bitmap1 As Bitmap  
    Bitmap1.Initialize2(InputStream1)  
    InputStream1.Close  
    Activity.SetBackgroundImage(Bitmap1)  
End Sub
```

Using a Cursor.GetBlob we fetch the previously stored image.  
Now we are using an input stream that reads from this array and load the image.  
  
**Asynchronous queries**  
SQL library v1.20 supports asynchronous select queries and asynchronous batch inserts.  
  
Asynchronous means that the task will be processed in the background and an event will be raised when the task completes. This is useful when you need to issue a slow query and keep your application responsive.  
  
The usage is quite simple:  

```B4X
sql1.ExecQueryAsync("SQL", "SELECT * FROM table1", Null)  
…  
Sub SQL_QueryComplete (Success As Boolean, Crsr As Cursor)  
    If Success Then  
        For i = 0 To Crsr.RowCount - 1  
            Crsr.Position = i  
            Log(Crsr.GetInt2(0))  
        Next  
    Else  
        Log(LastException)  
    End If  
End Sub
```

  
The first parameter is the "event name". It determines which sub will handle the QueryComplete event.  
  
**Batch inserts**  
SQL.AddNonQueryToBatch / ExecNonQueryBatch allow you to asynchronously process a batch of non-query statements (such as INSERT statements).  
You should add the statements by calling AddNonQueryToBatch and eventually call ExecNonQueryBatch.  
The task will be processed in the background. The NonQueryComplete event will be raised after all the statements execute.  

```B4X
For i = 1 To 10000  
        sql1.AddNonQueryToBatch("INSERT INTO table1 VALUES (?)", Array As Object(Rnd(0, 100000)))  
Next  
sql1.ExecNonQueryBatch("SQL")  
…  
Sub SQL_NonQueryComplete (Success As Boolean)  
    Log("NonQuery: " & Success)  
    If Success = False Then Log(LastException)  
End Sub
```