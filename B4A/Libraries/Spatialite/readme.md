### Spatialite by warwound
### 02/06/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/36296/)

**Spatialite wraps the [splite-android](https://www.gaia-gis.it/fossil/libspatialite/wiki?name=splite-android) project enabling you to create databases with geo-spatial features and make queries using geo-spatial functions.**  
  
Spatialite is an enhancement of the SQLite database.  
It has dedicated column data types for spatial features: Points, Polylines and Polygons, and various query functions that enable fast and efficient retrieval of spatial data from the database.  
The official reference for version 3.0.0 of spatialite can be found here: <http://www.gaia-gis.it/gaia-sins/spatialite-sql-3.0.0.html>.  
(The B4A spatialite library is based on version 3.0.1 of spatialite).  
  
**Spatialite  
Comment:** Spatialite is an SQLite extension for the Android platform.  
Currently version 3.0.1 of Spatialite is wrapped by this library.  
Spatialite is compiled using geos v3.3.6 and proj4 v4.8.0 patched.  
**Version:** 1.10  

- **Spatialite\_Blob**
Methods:

- **Close**
- **IsInitialized As Boolean**

- **Properties:**

- **InputStream As InputStreamWrapper** *[read only]*
Return InputStream for this blob.- **OutputStream As OutputStreamWrapper** *[read only]*
Return OutputStream for this blob.
- **Spatialite\_Callback**
Events:

- **Columns** (ColumnData() As String)
- **NewRow** (RowData() As String) As Boolean
- **Types** (TypeData() As String)

- **Methods:**

- **Initialize** (EventName As String)
- **IsInitialized As Boolean**

- **Spatialite\_Constants**
Fields:

- **SQLITE\_OPEN\_AUTOPROXY As Int**
- **SQLITE\_OPEN\_CREATE As Int**
- **SQLITE\_OPEN\_DELETEONCLOSE As Int**
- **SQLITE\_OPEN\_EXCLUSIVE As Int**
- **SQLITE\_OPEN\_FULLMUTEX As Int**
- **SQLITE\_OPEN\_MAIN\_DB As Int**
- **SQLITE\_OPEN\_MAIN\_JOURNAL As Int**
- **SQLITE\_OPEN\_MASTER\_JOURNAL As Int**
- **SQLITE\_OPEN\_NOMUTEX As Int**
- **SQLITE\_OPEN\_PRIVATECACHE As Int**
- **SQLITE\_OPEN\_READONLY As Int**
- **SQLITE\_OPEN\_READWRITE As Int**
- **SQLITE\_OPEN\_SHAREDCACHE As Int**
- **SQLITE\_OPEN\_SUBJOURNAL As Int**
- **SQLITE\_OPEN\_TEMP\_DB As Int**
- **SQLITE\_OPEN\_TEMP\_JOURNAL As Int**
- **SQLITE\_OPEN\_TRANSIENT\_DB As Int**
- **SQLITE\_OPEN\_URI As Int**
- **SQLITE\_OPEN\_WAL As Int**

- **Spatialite\_Database**
Methods:

- **BusyTimeout** (Milliseconds As Int)
*Set the timeout for waiting for an SQLite table to become unlocked.*- **Close**
*Close the SpatiaLite database file.*- **CreateAggregate** (FunctionName As String, NumberArgs As Int, Function1 As Function)
*Create aggregate user defined function.*- **CreateFunction** (FunctionName As String, NumberArgs As Int, Function1 As Function)
*Create regular user defined function.*- **ErrorMessage As String**
*Return last error message of SQLite3 engine.*- **Exec** (Query As String, Callback1 As CallbackImpl)
*The Callback events never seem to get raised, check if this is executing on a non UI thread.  
 Or catch the exception in this method to debug…*- **GetTable** (Query As String) **As TableResult**
- **GetTable2** (Query As String, MaxRows As Int) **As TableResult**
- **Initialize**
- **IsInitialized As Boolean**
- **LastError As Int**
*Return the code of the last error that occurred in any of the Exec methods.*- **LastInsertRowId As Long**
*Return the row identifier of the last inserted row.*- **Open** (DatabasePath As String, DatabaseFileName As String, OpenMode As Int)
*Open a SpatiaLite database file.*- **OpenBlob** (DatabaseName As String, TableName As String, ColumnName As String, Row As Long, ReadWrite As Boolean) **As Blob**
*Open an SQLite3 blob.  
 The returned Blob will not be initialized if an error occurs.*- **Prepare** (Query As String) **As Stmt**
*Prepare and return SQLite3 statement for SQL.*- **SetEncoding** (Encoding As String)
*Set character encoding.*
- **Spatialite\_Function**
Events:

- **Function** (FunctionContext1 As FunctionContext, Arguments() As String)
- **LastStep** (FunctionContext1 As FunctionContext)
- **Step** (FunctionContext1 As FunctionContext, Arguments() As String)

- **Methods:**

- **Initialize** (EventName As String)
*Initialize this user defined Function.  
Raises the events:  
Function(FunctionContext1 As FunctionContext, Arguments() As String).  
LastStep(FunctionContext1 As FunctionContext).  
 Step(FunctionContext1 As FunctionContext, Arguments() As String).*- **IsInitialized As Boolean**

- **Spatialite\_FunctionContext**
Methods:

- **Count As Int**
*Retrieve number of rows for aggregate function.*- **IsInitialized As Boolean**
- **SetError** (Error As String)
*Set function result from error message.*- **SetResultBytes** (Result() As Byte)
*Set function result from byte array.*- **SetResultDouble** (Result As Double)
*Set function result from double.*- **SetResultInt** (Result As Int)
*Set function result from integer.*- **SetResultString** (Result As String)
*Set function result from string.*- **SetResultZeroBlob** (Size As Int)
*Set function result as empty blob given size.*
- **Spatialite\_Stmt**
Methods:

- **BindBytes** (Position As Int, Bytes() As Byte)
*Bind positional byte array to compiled statement.*- **BindDouble** (Position As Int, Double1 As Double)
*Bind positional double value to compiled statement.*- **BindInt** (Position As Int, Integer1 As Int)
*Bind positional integer value to compiled statement.*- **BindLong** (Position As Int, Long1 As Long)
*Bind positional long value to compiled statement.*- **BindNull** (Position As Int)
*Bind positional SQL null to compiled statement.*- **BindParameterCount As Int**
*Return number of parameters in compiled statement.*- **BindParameterIndex** (Name As String) **As Int**
*Return index of named parameter in compiled statement.*- **BindParameterName** (Position As Int) **As String**
*Return name of parameter in compiled statement.*- **BindString** (Position As Int, String1 As String)
*Bind positional String to compiled statement.*- **BindZeroBlob** (Position As Int, Length As Int)
*Bind positional zero'ed blob to compiled statement.*- **ClearBindings**
*Clear all bound parameters of the compiled statement.*- **Close**
*Close the compiled statement.*- **Column** (ColumnIndex As Int) **As Object**
*Retrieve column data as Object from exec'ed statement.*- **ColumnBytes** (ColumnIndex As Int) **As Byte[]**
*Retrieve blob column from exec'ed statement.*- **ColumnCount As Int**
*Retrieve number of columns of exec'ed statement.*- **ColumnDatabaseName** (ColumnIndex As Int) **As String**
*Return database name of column of statement.*- **ColumnDeclaredType** (ColumnIndex As Int) **As String**
*Return declared column type of statement.*- **ColumnDouble** (ColumnIndex As Int) **As Double**
*Retrieve double column from exec'ed statement.*- **ColumnInt** (ColumnInt As Int) **As Int**
*Retrieve integer column from exec'ed statement.*- **ColumnLong** (ColumnIndex As Int) **As Long**
*Retrieve long column from exec'ed statement.*- **ColumnName** (ColumnIndex As Int) **As String**
*Return column name of column of statement.*- **ColumnOriginalName** (ColumnIndex As Int) **As String**
*Return origin column name of column of statement.*- **ColumnString** (ColumnIndex As Int) **As String**
*Retrieve string column from exec'ed statement.*- **ColumnTableName** (ColumnIndex As Int) **As String**
*Return table name of column of statement.*- **ColumnType** (ColumnIndex As Int) **As Int**
*Retrieve column type from exec'ed statement.*- **IsInitialized As Boolean**
- **Prepare As Boolean**
*Prepare the next SQL statement for the Stmt instance.*- **Reset**
*Reset the compiled statement without clearing parameter bindings.*- **Status** (Op As Int, Flag As Boolean) **As Int**
*Return statement status information.*- **Step As Boolean**
*Perform one step of compiled statement.*
- **Spatialite\_StringEncoder**
Methods:

- **Decode** (String1 As String) **As Byte[]**
*Decodes the given string that is assumed to be a valid encoding of a byte array.  
 Typically the given string is generated by the StringEncoder Encode method.*- **Encode** (Bytes() As Byte) **As String**
*Encodes the given byte array into a string that can be used by the SQLite database.  
The database cannot handle null (0x00) and the character '\'' (0x27).  
 The encoding consists of escaping these characters with a reserved character (0x01).*- **EncodeX** (Bytes() As Byte) **As String**
*Encodes the given byte array into SQLite3 blob notation, ie X'..'*
- **Spatialite\_TableResult**
Methods:

- **AtMaxRows As Boolean**
*Flag to indicate MaxRows condition.*- **Clear**
- **IsInitialized As Boolean**

- **Properties:**

- **Column() As String** *[read only]*
Column names of the result set.- **MaxRows As Int** *[read only]*
Maximum number of rows to hold in the table.- **NumberColumns As Int** *[read only]*
Number of columns in the result set.- **NumberRows As Int** *[read only]*
- **Rows() As String** *[read only]*
Rows of the result set.
Returns an Array of String Arrays, where each String Array represents a row of the result.- **Types() As String** *[read only]*
Types of columns of the result set or Null.
  
*Please note that i have only tested a small number of the library objects, if you find any bugs please post a bug report and i'll do my best to fix it.*  
  
The Spatialite.jar library file is over 14MBs in size so too large to attach to a forum post.  
So you can find the library files here: <http://b4a.martinpearman.co.uk/spatialite/> (Spatialite\_library\_files\_v2.20.zip).  
Also available at that link is SpatialiteGUI - a small Windows utility that will likely be very handy for you developers.  
  
Martin.