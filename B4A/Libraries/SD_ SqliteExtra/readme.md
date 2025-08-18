### SD: SqliteExtra by Star-Dust
### 11/20/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/90805/)

This new library is used to add some functions to the already precious SQL library.  

1. Insertion, updating and reading of images in fields of type BLOB.
2. Functions to add a table, a field. Update a field. Delete a row or table.
3. List of tables, fields and typos of the fields contained in the database
4. Commands to populate List and ListView also with images.

  
**SD\_SqliteExtra  
  
Author:** Star-Dust  
**Version:** 1.03  

- **sqlite**

- **Fields: (**TypeBase**)**

- **TypeFieldBlob** As String
- **TypeFieldInteger** As String
- **TypeFieldNumeric** As String
- **TypeFieldReal** As String
- **TypeFieldText** As String

- **Functions:**

- **AddField** (FileNameDB As String, NameTable As String, NameField As String, TypeField As String, defaultValue As String) As Boolean
 *Example:  
 Dim sq as sqlite  
 sq.initialize  
 sq.AddField("mysql.db","mytable","myfield","")  
 sq.AddField("mysql.db","mytable","myNumberfield","0")*- **AddTable** (FileNameDB As String, NameTable As String, Fields As String, CreateIfNecessary As Boolean) As Boolean
 *Example:  
 Dim sq as sqlite  
 sq.initialize  
 sq.AddTable("mysql.db","mytable","ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, Number INTEGER default 0, Name TEXT default ''")*- **Class\_Globals** As String
- **DeleteRow** (FileNameDB As String, NameTable As String, Condition As String) As String
 *Example:  
 Dim sq as sqlite  
 sq.initialize  
 sq.DeleteRow("mysql.db","mytable","ID=1")*- **DeleteTable** (FileNameDB As String, NameTable As String) As String
 *Example:  
 Dim sq as sqlite  
 sq.initialize  
 sq.DeleteTable("mysql.db","tableOld")*- **Initialize** As String
*Initializes the object. You can add parameters to this method if needed.*- **InsertBitmap** (filenameDB As String, TableName As String, Field As String, Bm As Bitmap) As String
 *Example:  
 Dim sq as sqlite  
 sq.initialize  
 sq.InsertBitmap("mysql.db", "mytable", "imageField", LoadBitmap(File.DirInternal,"myimage.png"))*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **getListTable**(Path As String,FileName As String) As List
- **getListFieldName**(Path As String,FileName As String, TableName As String) As List
- **getListFieldTypeBase**(Path As String,FileName As String, TableName As String) As List
- **getListFieldTypeName**(Path As String,FileName As String, TableName As String) As List
- **PopulateList** (FileNameDB As String, NameTable As String, FieldName As String, Condition As String) As List
 *Example:  
 Dim sq as sqlite  
 sq.initialize  
 Dim L As list = sq.PopolateList("mysql.db","mytable","Name", "")*- **PopulateListTwoLine** (FileNameDB As String, NameTable As String, FieldName As String, FieldSecondLine As String, FieldID As String, Condition As String, LV As ListView, CLearListView As Boolean) As String
 *Example:  
 Dim sq as sqlite  
 sq.initialize  
 sq.PopolateListTwoLine("mysql.db","mytable","City","State","ID", "", ListView1,True)*- **PopulateListTwoLineBitmap** (FileNameDB As String, NameTable As String, FieldName As String, FieldSecondLine As String, FieldID As String, FieldBitmap As String, Condition As String, LV As ListView, CLearListView As Boolean) As String
 *Example:  
 Dim sq as sqlite  
 sq.initialize  
 sq.PopolateListTwoLine("mysql.db","mytable","City","State","banner","ID", "", ListView1,True)*- **PopulateListView** (FileNameDB As String, NameTable As String, FieldName As String, FieldID As String, Condition As String, LV As ListView, CLearListView As Boolean) As String
 *Example:  
 Dim sq as sqlite  
 sq.initialize  
 sq.PopolateList("mysql.db","mytable","CityField","ID", "", ListView1,True)*- **readBitmap** (filenameDB As String, TableName As String, Filter As String, Field As String) As Bitmap
 *Example:  
 Dim sq as sqlite  
 sq.initialize  
 Dim B as Bitmap = sq.readBitmap("mysql.db", "mytable","ID=1", "imageField")*- **UpdateBitmap** (filenameDB As String, TableName As String, Filter As String, Field As String, Bm As Bitmap) As String
 *Example:  
 Dim sq as sqlite  
 sq.initialize  
 sq.UpdateBitmap("mysql.db", "mytable","ID=1", "imageField", LoadBitmap(File.DirInternal,"myimage.png"))*- **UpdateField** (FileNameDB As String, NameTable As String, FieldName As String, Value As String, Condition As String) As String
 *Example:  
 Dim sq as sqlite  
 sq.initialize  
 sq.UpdateField("mysql.db","mytable","NumberField", "100", "ID=1")  
 sq.UpdateField("mysql.db","mytable","StringField", "'StringValue'", "ID=1")*
  
*![](https://www.b4x.com/android/forum/attachments/65646) ![](https://www.b4x.com/android/forum/attachments/65647)   
  
![](https://www.b4x.com/android/forum/attachments/65651)*