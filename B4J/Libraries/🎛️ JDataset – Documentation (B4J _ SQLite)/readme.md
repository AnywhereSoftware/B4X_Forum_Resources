### 🎛️ JDataset – Documentation (B4J / SQLite) by fernando1987
### 08/29/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/168444/)

**Part of**: JDashboardUI (New Update)  
**Inspired by**: [jSD\_BindingNavigator – SQLite GUI Navigator](https://www.b4x.com/android/forum/threads/sd-bindingnavigator-sqlite-gui-navigator.91041/)  
  
  
**JDataset** is a powerful class integrated into the **JDashboardUI** framework, designed to seamlessly bind JavaFX UI elements to SQLite database tables. It provides robust support for CRUD operations, image and BLOB handling, data export, and automatic synchronization with UI views, making it ideal for building dynamic dashboards.  
  
  

---

  
  
[HEADING=2]🚀 **Key Features in JDashboardUI with JDataset**[/HEADING]  
  

- **Seamless UI Binding**: Automatically links JavaFX controls (e.g., TextField, Label, ImageView) to database fields using tags or explicit mapping.
- **Full CRUD Support**: Create, read, update, and delete records with built-in methods.
- **Image and BLOB Handling**: Supports PNG, ICO, and file storage as BLOBs with conversion to/from Bitmap and Base64.
- **Data Export**: Export records to Maps or Lists of Maps for easy integration with dashboards.
- **Efficient Navigation and Search**: Navigate records, search by column, and validate fields with clear status codes.
- **Panel-Wide Binding**: Link all controls in a panel with a single method (AddGroupView).
- **Cross-Platform Compatibility**: Works with B4J (JavaFX) and B4A, with robust error handling.

  

---

  
  
[HEADING=2]✅ **Key Advantages**[/HEADING]  
  

- **Automatic Synchronization**: UI controls update automatically when navigating records or modifying data.
- **Comprehensive Data Handling**: Supports text, numbers, images, and BLOBs with type-safe operations.
- **Simplified Workflow**: Reduces boilerplate code with panel-wide binding and automatic query handling.
- **Robust Error Handling**: Logs errors and provides meaningful return values for debugging.
- **Dashboard Integration**: Perfect for real-time data visualization in JDashboardUI widgets.

  

---

  
  
[HEADING=2]🛠️ **Class Structure**[/HEADING]  
  
[HEADING=3]**Class: JDataset**[/HEADING]  
[HEADING=3][/HEADING]  
  
[HEADING=3]**Properties**[/HEADING]  
  

- **CurrentTable** As String [read only]
Returns the name of the current table.
*Method*: getCurrentTable- **Position** As Int [read only]
Returns the current record index:

- -3: Database not initialized.
- -2: Query result is empty.
- -1: No record is currently positioned.
- >=0: Current record index.
*Method*: getPosition
- **Size** As Int [read only]
Returns the number of records in the current query:

- -1: Query not executed or database not initialized.
- >=0: Number of records.
*Method*: getSize
- **SQL** As SQL [read only]
Returns the SQL object for direct database access.
*Method*: getSQL
  
[HEADING=3]**Functions**[/HEADING]  
  

- **Initialize(Path As String, FileName As String, CreateIfNecessary As Boolean)**
Initializes the JDataset object with a SQLite database connection.

- **Path**: Directory path to the database file.
- **FileName**: Name of the database file.
- **CreateIfNecessary**: If True, creates the database file if it doesn't exist.
*Example*:
Dim ds As JDataset
ds.Initialize(File.DirApp, "mydb.db", True)- **AddLinkView(View As Object, Field As String)**
Links a single UI control to a database field.
Supported controls: TextField, JEditText, Label, ComboBox, CheckBox, jCheckbox, ImageView, JImageView.

- **View**: The UI control to link.
- **Field**: The database field name to bind to the control.
*Example*:
ds.AddLinkView(txtName, "Name")- **AddGroupView(Panel As Object) As String**
Links all controls in a panel to database fields based on their Tag properties.

- **Panel**: The pane containing the controls.
- **Returns**: Success message or error description.
*Example*:
Log(ds.AddGroupView(pnlMain)) ' Links all controls with non-empty tags- **ClearLinkView**
Clears all linked views.
*Example*:
ds.ClearLinkView- **Query(StringQuery As String, PrimaryKeyName As String)**
Executes a SQL query and populates the IDs list with primary key values.

- **StringQuery**: The SQL SELECT query.
- **PrimaryKeyName**: The primary key column name.
*Example*:
ds.Query("SELECT \* FROM Employees", "ID")- **Query2(StringQuery As String, StringArg() As String, PrimaryKeyName As String)**
Executes a parameterized SQL query.

- **StringQuery**: The SQL SELECT query with placeholders (?).
- **StringArg**: Array of parameter values.
- **PrimaryKeyName**: The primary key column name.
*Example*:
ds.Query2("SELECT \* FROM Employees WHERE Department = ?", Array As String("HR"), "ID")- **AddRecord**
Adds a new record to the database using values from linked views.
*Example*:
ds.AddRecord- **DeleteRecord**
Deletes the current record from the database.
*Example*:
ds.DeleteRecord- **UpdateChange**
Updates the current record with values from linked views.
*Example*:
ds.UpdateChange- **NextRecord**
Moves to the next record and updates linked views.
*Example*:
ds.NextRecord- **PreviousRecord**
Moves to the previous record and updates linked views.
*Example*:
ds.PreviousRecord- **FirstRecord**
Moves to the first record and updates linked views.
*Example*:
ds.FirstRecord- **LastRecord**
Moves to the last record and updates linked views.
*Example*:
ds.LastRecord- **RefreshField**
Refreshes the current record’s view values.
*Example*:
ds.RefreshField- **Search(ColumnName As String, Value As Object) As Boolean**
Searches for a record by a specific column value and positions to it.

- **ColumnName**: The column to search.
- **Value**: The value to match.
- **Returns**: True if found, False otherwise.
*Example*:
If ds.Search("Name", "John") Then Log("Record found!")- **Find(Table\_Name As String, PrimaryKeyName As String, ColumnName As String, Value As String)**
Finds records in a specific table by column and value, updating the IDs list.

- **Table\_Name**: The target table.
- **PrimaryKeyName**: The primary key column.
- **ColumnName**: The column to search.
- **Value**: The value to match.
*Example*:
ds.Find("Employees", "ID", "Name", "John")- **getString(Field As String) As String**
Gets a string value from the current record.

- **Returns**: The field value or empty string on error.
*Example*:
Log(ds.getString("Name"))- **getInt(Field As String) As Int**
Gets an integer value from the current record.

- **Returns**: The field value or 0 on error.
*Example*:
Log(ds.getInt("Age"))- **getLong(Field As String) As Long**
Gets a long value from the current record.

- **Returns**: The field value or 0 on error.
*Example*:
Log(ds.getLong("Salary"))- **getDouble(Field As String) As Double**
Gets a double value from the current record.

- **Returns**: The field value or 0 on error.
*Example*:
Log(ds.getDouble("Price"))- **getBlob(Field As String) As Byte()**
Gets a BLOB value from the current record.

- **Returns**: The byte array or Null on error.
*Example*:
Dim bytes() As Byte = ds.getBlob("Photo")- **GetBitmap(Field As String) As Object**
Gets a bitmap from a BLOB field.

- **Returns**: The bitmap object or Null on error.
*Example*:
Dim bmp As Object = ds.GetBitmap("Photo")- **ImageToBytes(img As Object) As Byte()**
Converts an image (B4XBitmap or JavaFX Image) to a byte array.

- **Returns**: The byte array or Null on error.
*Example*:
Dim bytes() As Byte = ds.ImageToBytes(imgView.GetImage)- **BytesToBitmap(Bytes() As Byte) As B4XBitmap**
Converts a byte array to a B4XBitmap.

- **Returns**: The bitmap or Null on error.
*Example*:
Dim bmp As B4XBitmap = ds.BytesToBitmap(bytes)- **ImageToBase64(img As Image) As String**
Converts an image to a Base64 string.

- **Returns**: The Base64 string or empty string on error.
*Example*:
Log(ds.ImageToBase64(imgView.GetImage))- **Base64ToImage(b64 As String) As B4XBitmap**
Converts a Base64 string to a B4XBitmap.

- **Returns**: The bitmap or Null on error.
*Example*:
Dim bmp As B4XBitmap = ds.Base64ToImage(base64String)- **StoreFile(Field As String, FilePath As String)**
Stores a file as a BLOB in the database.

- **Field**: The BLOB field name.
- **FilePath**: The path to the file.
*Example*:
ds.StoreFile("Photo", "C:/images/photo.png")- **RetrieveFile(Field As String, SavePath As String) As Boolean**
Retrieves a file from a BLOB field and saves it to disk.

- **Field**: The BLOB field name.
- **SavePath**: The destination file path.
- **Returns**: True if successful, False otherwise.
*Example*:
If ds.RetrieveFile("Photo", "C:/output/photo.png") Then Log("File saved!")- **GetFileSize(Field As String) As Long**
Gets the size of a file stored in a BLOB field.

- **Returns**: The size in bytes or 0 on error.
*Example*:
Log(ds.GetFileSize("Photo"))- **IsFileFieldValid(Field As String) As Boolean**
Checks if a BLOB field contains valid file data.

- **Returns**: True if valid, False otherwise.
*Example*:
If ds.IsFileFieldValid("Photo") Then Log("Valid file data")- **GetTableFields As List**
Gets all field names for the current table.

- **Returns**: A list of field names or Null on error.
*Example*:
Dim fields As List = ds.GetTableFields- **FieldExists(FieldName As String) As Boolean**
Checks if a field exists in the current table.

- **Returns**: True if the field exists, False otherwise.
*Example*:
If ds.FieldExists("Name") Then Log("Field exists")- **ExportRecordToMap As Map**
Exports the current record to a Map (column names as keys, values as values).

- **Returns**: The record Map or Null on error.
*Example*:
Dim record As Map = ds.ExportRecordToMap- **ExportAllRecordsToList As List**
Exports all records from the current query to a List of Maps.

- **Returns**: A list of record Maps or Null on error.
*Example*:
Dim records As List = ds.ExportAllRecordsToList- **ExportQueryToList(QueryString As String, Args() As String) As List**
Exports records from a custom query to a List of Maps.

- **QueryString**: The SQL query.
- **Args**: Optional parameters for parameterized queries (pass Null if not needed).
- **Returns**: A list of record Maps or Null on error.
*Example*:
Dim records As List = ds.ExportQueryToList("SELECT \* FROM Employees WHERE Department = ?", Array As String("HR"))- **UpdateFieldValue(Field As String, Value As Object) As Boolean**
Updates a specific field in the current record with a value (supports BLOBs, images, etc.).

- **Field**: The field name.
- **Value**: The value to set (string, number, image, file path, etc.).
- **Returns**: True if successful, False otherwise.
*Example*:
ds.UpdateFieldValue("Photo", "C:/images/newphoto.png")- **SetViewsEnabled(Enabled As Boolean)**
Enables or disables all linked views.

- **Enabled**: True to enable, False to disable.
*Example*:
ds.SetViewsEnabled(False)- **IsViewLinked(FieldName As String) As Boolean**
Checks if a view is linked to a specific field.

- **Returns**: True if linked, False otherwise.
*Example*:
If ds.IsViewLinked("Name") Then Log("View is linked")- **IsInitialized As Boolean**
Checks if the JDataset object is initialized.

- **Returns**: True if initialized, False otherwise.
*Example*:
If ds.IsInitialized Then Log("Dataset is ready")- **CreateTable(NameTable As String, Columns As Map)**
Creates a new table with the specified columns.

- **NameTable**: The table name.
- **Columns**: A Map of column names to SQL types (e.g., Map("Name" -> "TEXT", "Age" -> "INTEGER")).
*Example*:
Dim cols As Map
cols.Initialize
cols.Put("Name", "TEXT")
cols.Put("Age", "INTEGER")
ds.CreateTable("Employees", cols)
  

---

  
  
[HEADING=2]📝 **Usage Example**[/HEADING]  

```B4X
' Initialize JDataset  
  
Dim ds As JDataset  
  
ds.Initialize(File.DirApp, "mydb.db", True)  
  
  
  
' Create a table  
  
Dim cols As Map  
  
cols.Initialize  
  
cols.Put("ID", "INTEGER PRIMARY KEY")  
  
cols.Put("Name", "TEXT")  
  
cols.Put("Photo", "BLOB")  
  
ds.CreateTable("Employees", cols)  
  
  
  
' Link UI controls  
  
ds.AddLinkView(txtName, "Name")  
  
ds.AddLinkView(imgPhoto, "Photo")  
  
  
  
' Query records  
  
ds.Query("SELECT * FROM Employees", "ID")  
  
  
  
' Navigate records  
  
ds.NextRecord  
  
ds.PreviousRecord  
  
  
  
' Add a new record  
  
txtName.Text = "John Doe"  
  
imgPhoto.SetImage(xui.LoadBitmap(File.DirAssets, "john.png"))  
  
ds.AddRecord  
  
  
  
' Export all records  
  
Dim records As List = ds.ExportAllRecordsToList  
  
For Each record As Map In records  
  
    Log($"Name: ${record.Get("Name")}"$)  
  
Next
```

  
  
  

---

  
  
[HEADING=2]🛡️ **Error Handling**[/HEADING]  
  

- All methods include try-catch blocks to prevent crashes.
- Errors are logged with Log("Error in [Method]: " & LastException.Message).
- Methods return meaningful values (Null, False, empty strings, or -1) on failure.
- Check IsInitialized, getPosition, and getSize to ensure valid state before operations.

  

---

  
  
[HEADING=2]🔗 **Integration with JDashboardUI**[/HEADING]  
  
JDataset is designed to work seamlessly with JDashboardUI’s views, enabling real-time data updates in visual components. Use ExportAllRecordsToList or ExportQueryToList to feed data into dashboard visualizations, and leverage AddGroupView to bind entire panels effortlessly.  
  
📹 **Demo Video**  
  
  
Below is a video showing how JDataset powers Inno Setup Generator in a real application:  
  
<https://www.b4x.com/android/forum/threads/%F0%9F%9B%A0%EF%B8%8F-inno-setup-generator-%E2%80%93-package-your-b4j-apps-into-professional-installers.167921/>  
  
(Note: The video plays directly from the Google Drive link. If it doesn’t load, click the link to watch: **Watch Video**)  
  
  
[MEDIA=googledrive]1qhW\_-\_9Dxq3i89eodLgpDSY1Dg8vo-Bw[/MEDIA]  
  

---