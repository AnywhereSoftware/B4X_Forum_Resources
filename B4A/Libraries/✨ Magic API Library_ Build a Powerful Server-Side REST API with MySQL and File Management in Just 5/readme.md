### ✨ Magic API Library: Build a Powerful Server-Side REST API with MySQL and File Management in Just 5 Minutes! 🚀 by fernando1987
### 01/27/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/148322/)

**⚡️ Unleash the API Power: Magic API for Seamless B4X Integration**  
  
? Greetings, B4X enthusiasts! Today, I'm thrilled to unveil the magic behind our latest creation—the Magic API. Elevate your B4X applications with streamlined API integration, simplifying CRUD operations effortlessly. From uploading api.php to securing your connection data, this library is your key to seamless integration. Explore its advantages and fortify your data integrity with advanced security measures. Let's dive into the API revolution!  
  
? Advantages of Magic API:  
✨ Unlock the Magic: Seamlessly integrate API functionality into your B4X applications.  
✉️ Effortless CRUD Operations: Create, Read, Update, and Delete with ease, optimizing data management.  
? Advanced Security Measures: API key authentication, HTTPS encryption, and input validation ensure data confidentiality and integrity.  
? Base URL: <http://example.com/api.php>  
? User-Friendly Initialization: Just upload, edit the header with your connection data, and you're ready to communicate!  
  
  
?Usage Instructions:  
  
1. Upload the api.php file to your server.  
2. Edit the header with your connection data.  
3. You're ready to communicate your app with your mobile and desktop applications.  
  
Note: The API works fine without the library, but the library will help you communicate more easily.  
  
? Explore API Documentation:  
[HEADING=2]API Documentation[/HEADING]  
[HEADING=2]Security[/HEADING]  
The API employs several security measures to ensure the integrity and confidentiality of your data:  
  

- **Authentication:** All API requests require an API key to be included as a query parameter. This key uniquely identifies the client making the request and provides access control to the API endpoints.
- **HTTPS:** Communication with the API is always encrypted over HTTPS, ensuring that data transmitted between the client and the server remains confidential.
- **Input validation:** The API performs input validation and sanitization to prevent common security vulnerabilities such as SQL injection or cross-site scripting (XSS) attacks.

[HEADING=2]Base URL[/HEADING]  
<http://example.com/api.php>  
[HEADING=2]Authentication[/HEADING]  
The API uses an API key for authentication. The API key must be included as a parameter in all requests.  
  
[HEADING=3]Authentication Parameters[/HEADING]  

- api\_key (required): The API key to authenticate the request.

[HEADING=2]Available Resources[/HEADING]  
[HEADING=3]GET /api.php[/HEADING]  
Retrieve records from a table.  
  
[HEADING=3]Parameters[/HEADING]  

- table (required): The name of the table from which you want to retrieve records.
- id (optional): The ID of the specific record you want to retrieve.
- column and value (optional): The name of a column and its value to filter the records.
- comparison (optional): The comparison operator to use in the search. It can be >, <, >=, or <=.

[HEADING=3]Examples[/HEADING]  
  
Retrieve all records from a table:  
  
  
   
GET api.php?table=example&api\_key=your\_api\_key  
  
  
   
Retrieve a specific record by ID:  
  
  
   
GET api.php?table=example&id=1&api\_key=your\_api\_key  
  
  
   
Retrieve records filtered by a column and its value:  
  
  
   
GET api.php?table=example&column=age&value=25&api\_key=your\_api\_key  
  
  
   
Retrieve records with comparison:  
  
  
   
GET api.php?table=example&column=age&value=25&comparison=>&api\_key=your\_api\_key  
  
  
   
[HEADING=3]POST /api.php[/HEADING]  
Create a new record in a table.  
  
[HEADING=3]Parameters[/HEADING]  

- table (required): The name of the table in which you want to create the record.

[HEADING=3]Request Body[/HEADING]  
You must provide the data for the new record in JSON format in the request body.  
  
[HEADING=3]Example[/HEADING]  
 POST /api.php?table=example&api\_key=your\_api\_key  
   
  
 {  
 "name": "John Doe",  
 "age": 30,  
 "email": "[EMAIL]johndoe@example.com[/EMAIL]"  
 }  
   
[HEADING=3]PUT /api.php[/HEADING]  
Update an existing record in a table.  
  
[HEADING=3]Parameters[/HEADING]  

- table (required): The name of the table in which the record exists.
- id (required): The ID of the specific record you want to update.

[HEADING=3]Request Body[/HEADING]  
You must provide the updated data for the record in JSON format in the request body.  
  
[HEADING=3]Example[/HEADING]  
  
Update a record by ID in the "example" table:  
  
  
   
PUT api.php?table=example&id=1&api\_key=your\_api\_key  
  
   
Request Body:  
  
  
   
{  
 "age": 30  
}  
  
  
   
Update records by column and value in the "example" table:  
  
  
   
PUT api.php?table=example&column=name&value=John&api\_key=your\_api\_key  
  
   
Request Body:  
  
  
   
{  
 "age": 30  
}  
  
  
   
Update records by comparison:  
  
  
   
PUT /api.php?table=example&column=age&value=25&comparison=>&api\_key=your\_api\_key  
   
  
 {  
 "age": 35  
 }  
  
  
   
[HEADING=3]DELETE /api.php[/HEADING]  
Delete records from a table.  
  
[HEADING=3]Parameters[/HEADING]  

- table (required): The name of the table from which you want to delete records.
- id or column and value (required): You can provide the ID of the specific record you want to delete, or use a column and its value to filter the records.
- comparison (optional): The comparison operator to use in the search. It can be >, <, >=, or <=.

[HEADING=3]Examples[/HEADING]  
  
Delete a record by ID in the "example" table:  
  
  
 DELETE /api.php?table=example&id=1&api\_key=your\_api\_key  
   
Delete records by column and value in the "example" table:  
  
  
 DELETE /api.php?table=example&column=age&value=25&api\_key=your\_api\_key  
   
Delete records by comparison:  
  
  
 DELETE /api.php?table=example&column=age&value=25&comparison=>&api\_key=your\_api\_key  
   
Remember to replace your\_api\_key with your actual API key.  
   
  
  
  
**[SIZE=6]MagicApi library[/SIZE]**  
# B4X Library Documentation  
  
**## Description**  
This library provides methods for performing CRUD (Create, Read, Update, Delete) operations on an API. It is designed to interact with an API that uses JSON as the data exchange format.  
  
**## Installation**  
1. Download the **MagicApi.b4xlib** library file.  
2. Copy the **MagicApi.b4xlib** file to the additional libraries folder in your B4X development environment.  
  
**## Initialization**  
Before using the library methods, you need to initialize it by calling the `Initialize` method and providing the following parameters:  
- `CallbackModule` (Object): the name of the callback module where the events handling API responses are located.  
- `cEventname` (String): the base name for the response events.  
- `urlbase` (String): the base URL of the API.  
- `api\_key` (String): The api key defined in the php file.  
  
**## Events**  
The library generates response events for each CRUD operation. These events should be implemented in the specified callback module during initialization.  
  
**### Generated Events**  
- `EventName\_Insertmaps(m As Map, success As Boolean)`  
- `EventName\_Delete(tablename As String, success As Boolean)`  
- `EventName\_DeleteByColumn(tablename As String, success As Boolean)`  
- `EventName\_Update(tablename As String, success As Boolean)`  
- `EventName\_UpdateByColumn(tablename As String, success As Boolean)`  
- `EventName\_SearchforId(m As Map, success As Boolean)`  
- `EventName\_GetTable(x As List, success As Boolean)`  
- `EventName\_Search(x As List, success As Boolean)`  
  
**## Methods  
  
[SIZE=5]Insertmaps(maps As Map, tablename As String)[/SIZE]**  
  
Performs an insertion operation on the specified table of the API.  

```B4X
Dim data As Map  
data.Initialize  
data.Put("Column1", "Value1")  
data.Put("Column2", "Value2")  
MagicApi.Insertmaps(data, "table")
```

  
  
[HEADING=2]Delete(tablename As String, id As String)[/HEADING]  
Deletes a record from the specified table of the API using the ID.  

```B4X
MagicApi.Delete("table", "12")
```

  
  
[HEADING=2]DeleteByColumn(tablename As String, column As String, value As String)[/HEADING]  
Deletes records from the specified table of the API using a column and a value.  

```B4X
MagicApi.DeleteByColumn("table", "column", "value")
```

  
  
[HEADING=2]DeleteByColumn\_comparison(tablename As String, column As String, value As String,comparison As String)[/HEADING]  
Deletes records from the specified table of the API using a column and a value and comparison <,>,<=,>=.  

```B4X
MagicApi.DeleteByColumn_comparison("table", "age", "20",">")
```

  
  
[HEADING=2]Update(tablename As String, id As String, data As Map)[/HEADING]  
Updates a record in the specified table of the API using the ID and the provided data.  

```B4X
Dim data As Map  
data.Initialize  
data.Put("Column1", "NewValue1")  
data.Put("Column2", "NewValue2")  
MagicApi.Update("table", "12", data)
```

  
  
[HEADING=2]UpdateByColumn(tablename As String, column As String, value As String, data As Map)[/HEADING]  
Updates records in the specified table of the API using a column, a value, and the provided data.  

```B4X
Dim data As Map  
data.Initialize  
data.Put("Column1", "NewValue1")  
data.Put("Column2", "NewValue2")  
MagicApi.UpdateByColumn("table", "column", "value", data)
```

  
  
[HEADING=2]UpdateByColumn\_comparison(tablename As String, column As String, value As String,comparison As String, data As Map)[/HEADING]  
Updates records in the specified table of the API using a column, a value, and the provided data and comparison <,>,>=,<=.  

```B4X
Dim data As Map  
data.Initialize  
data.Put("Column1", "NewValue1")  
data.Put("Column2", "NewValue2")  
MagicApi.UpdateByColumn_comparison("table", "age", "15",">=", data)
```

  
  
[HEADING=2]SearchforId(tablename As String, id As String)[/HEADING]  
Searches for a record in the specified table of the API using the ID.  

```B4X
'  
MagicApi.SearchforId("table", "123")  
wait for eventname_SearchforId(m As Map, success As Boolean)  
if success = true then  
m.get("Column 1")  
m.get("Column 2")  
else  
  
end if
```

  
  
[HEADING=2]GetTable(tablename As String)[/HEADING]  
Gets all records from the specified table of the API.  

```B4X
MagicApi.GetTable("table")  
Wait For eventname_GetTable(x As List, success As Boolean)  
    For Each col As Map In x  
        col.Get("Column name1")  
        col.Get("Column name 2")  
    Next
```

  
  
[HEADING=2]Search(tablename As String, column As String, value As String)[/HEADING]  
Performs a search in the specified table of the API using a column and a value.  

```B4X
MagicApi.Search("table", "column", "value")  
wait for EventName_Search(x as list, success as Boolean)  
if success = true then  
 For Each col As Map In x  
col.Get("Column name1")  
col.Get("Column name 2")  
next  
else  
  
end if  
  
sub
```

  
  
  
[HEADING=2]Search\_comparison(tablename As String, column As String, value As String,comparison As String)[/HEADING]  
Performs a search in the specified table of the API using a column and a value and comparison.  

```B4X
MagicApi.Search_comparison("table", "age", "35","<=")  
wait for EventName_Search(x as list, success as Boolean)  
if success = true then  
 For Each col As Map In x  
col.Get("Column name1")  
col.Get("Column name 2")  
next  
else  
  
end if  
  
sub
```

  
  
  
[HEADING=1]Complete Example[/HEADING]  
  

```B4X
Sub Process_Globals  
    Private magicApi As MagicApi  
End Sub  
  
Sub Globals  
    ' …  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    ' …  
    magicApi.Initialize(Me, "MyEventName", "http://example.com")  
End Sub  
  
' Implement the events generated by the library  
Sub MyEventName_Insertmaps(m As Map, success As Boolean)  
    ' …  
End Sub  
  
Sub MyEventName_Delete(tablename As String, success As Boolean)  
    ' …  
End Sub  
  
' Implement other generated events…  
  
Sub SomeSub  
    ' Examples of using the library methods  
    Dim data As Map  
    data.Initialize  
    data.Put("Column1", "Value1")  
    data.Put("Column2", "Value2")  
    magicApi.Insertmaps(data, "table")  
  
    magicApi.Delete("table", "123")  
  
    magicApi.DeleteByColumn("table", "column", "value")  
  
    Dim updateData As Map  
    updateData.Initialize  
    updateData.Put("Column1", "NewValue1")  
    updateData.Put("Column2", "NewValue2")  
    magicApi.Update("table", "123", updateData)  
  
    magicApi.UpdateByColumn("table", "column", "value", updateData)  
  
    magicApi.SearchforId("table", "123")  
  
    magicApi.GetTable("table")  
  
    magicApi.Search("table", "column", "value")  
End Sub
```

  
  
  
[HEADING=1]**MagicAPI Module - New Routines**[/HEADING]  
[HEADING=2]**1. InsertOrUpdateMapForColumnValue**[/HEADING]  
**Description**:  
This routine checks whether a record exists in the specified table by searching for a column value. If the record exists, it updates the record; if not, it inserts a new record.  
  
**Parameters**:  
  

- tablename (String): The name of the table where the operation will take place.
- searchColumn (String): The column used for the search.
- searchValue (String): The value to look for in the searchColumn.
- data (Map): The data to insert or update.

**Event Triggered**:  
<EventName>\_InsertOrUpdateMapForColumnValue(message As String, success As Boolean)  
  

- message can be "Insert", "Update", or "Error".
- success indicates if the operation was successful.

---

  
**Example 1: Insert or Update a User Record**  
  

```B4X
Dim userData As Map  
userData.Initialize  
userData.Put("name", "John Doe")  
userData.Put("email", "john.doe@example.com")  
userData.Put("age", 30)  
  
MagicAPI.InsertOrUpdateMapForColumnValue("users", "email", "john.doe@example.com", userData)  
  
Wait For MagicAPI_InsertOrUpdateMapForColumnValue(message As String, success As Boolean)  
  
If success Then  
Select Case message  
Case "Insert" Log("A new user record was inserted.")  
Case "Update" Log("The existing user record was updated.")  
End Select  
Else Log("Error: Unable to perform the operation.")  
End If
```

  
  

---

  
**Example 2: Insert or Update a Product Record**  
  

```B4X
Dim productData As Map  
productData.Initialize  
productData.Put("name", "Wireless Mouse")  
productData.Put("price", 29.99)  
productData.Put("stock", 100)  
  
MagicAPI.InsertOrUpdateMapForColumnValue("products", "name", "Wireless Mouse", productData)  
  
Wait For MagicAPI_InsertOrUpdateMapForColumnValue(message As String, success As Boolean)  
  
If success Then  
Select Case message  
Case "Insert"  
Log("A new product record was inserted.")  
Case "Update"  
Log("The existing product record was updated.")  
End Select  
Else Log("Error: Unable to perform the operation.")  
End If
```

  
  

---

  
[HEADING=2]**2. InsertMultipleMaps**[/HEADING]  
**Description**:  
This routine inserts multiple records into the specified table using a list of maps, where each map represents a record.  
  
**Parameters**:  
  

- ListOfMaps (List): A list of maps containing the data to insert. Each map represents one record.
- TableName (String): The name of the table where the records will be inserted.

**Event Triggered**:  
<EventName>\_Insertmaps(m As Map, success As Boolean)  
  

- m: The map representing the data that was inserted.
- success: Indicates if the operation was successful.

---

  
**Example 1: Insert Multiple User Records**  
  

```B4X
Dim userRecords As List  
userRecords.Initialize  
  
Dim user1 As Map  
user1.Initialize  
user1.Put("name", "Alice")  
user1.Put("email", "alice@example.com")  
user1.Put("age", 25)  
  
Dim user2 As Map  
user2.Initialize  
user2.Put("name", "Bob")  
user2.Put("email", "bob@example.com")  
user2.Put("age", 28)  
  
userRecords.AddAll(Array(user1, user2))  
  
MagicAPI.InsertMultipleMaps(userRecords, "users")  
  
Wait For MagicAPI_Insertmaps(m As Map, success As Boolean)  
  
If success Then  
Log($"Record inserted: ${m}"$)  
Else Log("Error inserting record.")  
End If
```

  
  

---

  
**Example 2: Insert Multiple Product Records**  
  

```B4X
Dim productRecords As List  
productRecords.Initialize  
  
Dim product1 As Map  
product1.Initialize  
product1.Put("name", "Keyboard")  
product1.Put("price", 49.99)  
product1.Put("stock", 50)  
  
Dim product2 As Map  
product2.Initialize  
product2.Put("name", "Monitor")  
product2.Put("price", 199.99)  
product2.Put("stock", 20)  
  
productRecords.AddAll(Array(product1, product2))  
  
MagicAPI.InsertMultipleMaps(productRecords, "products")  
  
Wait For MagicAPI_Insertmaps(m As Map, success As Boolean)  
  
If success Then  
Log($"Record inserted: ${m}"$)  
Else  
Log("Error inserting record.")  
End If
```

  
  

---

  
[HEADING=2]**Notes**[/HEADING]  

- Both routines provide asynchronous operations, and results are returned via their respective events.
- Error handling is embedded, and failed operations trigger the appropriate event with a success = False.
- Ensure the data maps are properly initialized and contain valid column names and values for the target table.

  
  
[HEADING=1]**MagicFiles Module Documentation**[/HEADING]  
The MagicFiles module is part of the **Magic API** library, designed to facilitate file and folder operations on a server via REST API. It supports functionalities such as uploading, downloading, listing, and deleting files or folders, and is compatible with file selection using ContentChooser in B4A.  
  

---

  
[HEADING=2]**Initialization**[/HEADING]  
[HEADING=3]**1. Initialize**[/HEADING]  
Initializes the MagicFiles module with the necessary parameters to interact with the server.  
  
**Parameters**:  
  

- Callback (Object): The object handling the event callbacks.
- EventName (String): The name of the event that will be triggered upon completion.
- urlbase (String): The base URL of the file server.

```B4X
Dim magicFiles As MagicFiles  
magicFiles.Initialize(Me, "MagicFiles", "https://example.com/api")
```

  
  

---

  
[HEADING=2]**File Operations**[/HEADING]  
[HEADING=3]**2. UploadFile**[/HEADING]  
Uploads a file to the server.  
  
**Parameters**:  
  

- filedir (String): Directory of the file.
- filename (String): Name of the file to upload.

**Event**: <EventName>\_UploadResult(Success As Boolean, FileName As String)  
  

```B4X
magicFiles.UploadFile(File.DirRootExternal, "test.txt")  
  
Sub MagicFiles_UploadResult(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} uploaded successfully"$)  
Else  
Log("Error uploading file")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**3. UploadFileToFolder**[/HEADING]  
Uploads a file to a specific folder on the server.  
  
**Parameters**:  
  

- filedir (String): Directory of the file.
- filename (String): Name of the file to upload.
- targetFolder (String): Destination folder on the server.
- newFileName (String): New name for the file on the server.

**Event**: <EventName>\_UploadToFolderResult(Success As Boolean, FileName As String)  
  

```B4X
magicFiles.UploadFileToFolder(File.DirRootExternal, "test.txt", "myFolder", "renamed.txt")  
  
Sub MagicFiles_UploadToFolderResult(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} uploaded to folder successfully"$)  
Else  
Log("Error uploading file to folder")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**4. UploadFileUri (B4A)**[/HEADING]  
Uploads a file selected using ContentChooser to the server with a custom name.  
  
**Parameters**:  
  

- uri (String): URI of the selected file.
- newFileName (String): Name to save the file as on the server.

**Event**: <EventName>\_UploadResultUri(Success As Boolean, FileName As String)  
  

```B4X
Private Sub Button1_Click  
If chooser.IsInitialized = False Then  
chooser.Initialize("chooser")  
End If  
chooser.Show("image/*", "Choose Image")  
End Sub  
  
Sub chooser_Result(Success As Boolean, Dir As String, FileName As String)  
If Success Then  
magicFiles.UploadFileUri(FileName, "uploaded_image.jpg")  
Else Log("No file selected")  
End If  
End Sub  
  
Sub MagicFiles_UploadResultUri(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} uploaded successfully"$)  
Else  
Log("Error uploading file")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**5. UploadFileUri2 (B4A)**[/HEADING]  
Uploads a file selected using ContentChooser by directly using its full path.  
  
**Parameters**:  
  

- uri (String): URI of the selected file.

**Event**: <EventName>\_UploadResultUri2(Success As Boolean, FileName As String)  
  

```B4X
Private Sub Button1_Click  
If chooser.IsInitialized = False Then  
chooser.Initialize("chooser")  
End If  
chooser.Show("/", "Choose File")  
End Sub  
  
Sub chooser_Result(Success As Boolean, Dir As String, FileName As String)  
If Success Then  
magicFiles.UploadFileUri2(FileName)  
Else  
Log("No file selected")  
End If  
End Sub  
  
Sub MagicFiles_UploadResultUri2(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} uploaded successfully with UploadFileUri2"$)  
Else  
Log("Error uploading file with UploadFileUri2")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**6. ListFiles**[/HEADING]  
Lists all files available on the server.  
  
**Event**: <EventName>\_ListSuccess(Success As Boolean, ListFiles As List)  
  

```B4X
magicFiles.ListFiles  
  
Sub MagicFiles_ListSuccess(Success As Boolean, ListFiles As List)  
If Success Then  
For Each fileName As String In ListFiles  
Log($"File: ${fileName}"$)  
Next  
Else Log("Error listing files")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**7. DeleteFile**[/HEADING]  
Deletes a file from the server.  
  
**Parameters**:  
  

- fileName (String): Name of the file to delete.

**Event**: <EventName>\_DeleteFileSuccess(Success As Boolean, FileName As String)  
  

```B4X
magicFiles.DeleteFile("test.txt")  
  
Sub MagicFiles_DeleteFileSuccess(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} deleted successfully"$)  
Else  
Log("Error deleting file")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**8. DeleteAllFiles**[/HEADING]  
Deletes all files from the server.  
  
**Event**: <EventName>\_DeleteAllSuccess(Success As Boolean)  
  

```B4X
magicFiles.DeleteAllFiles  
  
Sub MagicFiles_DeleteAllSuccess(Success As Boolean)  
If Success Then  
Log("All files deleted successfully")  
Else  
Log("Error deleting all files")  
End If  
End Sub
```

  
  

---

  
[HEADING=2]**Folder Operations**[/HEADING]  
[HEADING=3]**9. CreateFolder**[/HEADING]  
Creates a new folder on the server.  
  
**Parameters**:  
  

- FolderName (String): Name of the folder to create.

**Event**: <EventName>\_CreateFolderSuccess(Success As Boolean, FolderName As String)  
  

```B4X
magicFiles.CreateFolder("newFolder")  
  
Sub MagicFiles_CreateFolderSuccess(Success As Boolean, FolderName As String)  
If Success Then  
Log($"Folder ${FolderName} created successfully"$)  
Else  
Log("Error creating folder")  
End If  
End Sub
```

  
  

---

  
[HEADING=3]**10. MoveFileToFolder**[/HEADING]  
Moves a file to another folder on the server.  
  
**Parameters**:  
  

- FileName (String): Name of the file to move.
- TargetFolder (String): Destination folder.

**Event**: <EventName>\_MoveFileSuccess(Success As Boolean, TargetFolder As String)  
  

```B4X
magicFiles.MoveFileToFolder("test.txt", "destinationFolder")  
  
Sub MagicFiles_MoveFileSuccess(Success As Boolean, TargetFolder As String)  
If Success Then  
Log($"File moved to folder ${TargetFolder} successfully"$)  
Else  
Log("Error moving file")  
End If  
End Sub
```

  
  
[HEADING=2]11. DownloadFile[/HEADING]  
Downloads a file from a server folder to a local directory.  
  
**Parameters:**  
  

- **TargetFolder (String):** Folder on the server where the file is located.
- **FileName (String):** Name of the file to download.
- **SaveDir (String):** Local directory where the file will be saved.
- **SaveFileName (String):** Name to save the file as locally.

**Event:** <EventName>\_DownloadResult(Success As Boolean, FileName As String)  
  

```B4X
magicFiles.DownloadFile("ServerFolder", "example.txt", File.DirRootExternal, "downloaded_example.txt")  
  
Sub MagicFiles_DownloadResult(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} downloaded successfully."$)  
Else  
Log($"Error downloading the file: ${FileName}"$)  
End If  
End Sub
```

  
  

---

  
[HEADING=2]12. DownloadFile2[/HEADING]  
Downloads a file from the server with range and progress tracking support.  
  
**Parameters:**  
  

- **Dir (String):** Folder on the server where the file is located.
- **FileName (String):** Name of the file to download.
- **SaveDir (String):** Local directory where the file will be saved.
- **SaveFileName (String):** Name to save the file as locally.

**Events:**  
  

- <EventName>\_DownloadProgress(CurrentLength As Long, TotalLength As Long)
- <EventName>\_DownloadResult(Success As Boolean, FileName As String)

```B4X
magicFiles.DownloadFile2("ServerFolder", "largefile.zip", File.DirRootExternal, "largefile_local.zip")  
  
Sub MagicFiles_DownloadProgress(CurrentLength As Long, TotalLength As Long)  
Dim Progress As Float = (CurrentLength / TotalLength) * 100  
Log($"Progress: ${Progress}%"$)  
End Sub  
  
Sub MagicFiles_DownloadResult(Success As Boolean, FileName As String)  
If Success Then  
Log($"File ${FileName} downloaded successfully."$)  
Else  
Log($"Error downloading the file: ${FileName}"$)  
End If  
End Sub
```

  
  

---

  
  
  
[HEADING=2]📂 **Important Update for Magic API File Management** 🚀[/HEADING]  
We’re introducing an **enhanced file and folder management system** with the latest version of Magic API! Here's how it works:  
  

---

  
[HEADING=2]**File and Folder Operations in Magic API**[/HEADING]  
1️⃣ **Default Folder: upload**  
  

- All files and folders you create or interact with will be managed inside a new folder named **upload**.
- This folder will be **automatically created** the first time you upload a file.

📍 **Location**: The upload folder will be created in the same directory as the files.php script on your server.  
  

---

  
2️⃣ **Automatic Folder Creation**  
  

- When you add a file to a specific folder, Magic API will **automatically create the folder** if it doesn’t already exist.
- This ensures seamless operations, eliminating the need for manual folder setup.

---

  
[HEADING=2]**Examples**[/HEADING]  
[HEADING=3]**Uploading a File to the Default Folder**[/HEADING]  
When uploading a file without specifying a folder, it will be stored directly in the **upload** folder.  
  

```B4X
MagicFiles.UploadFile(File.DirRootExternal, "example.txt")  
  
Wait For MagicFiles_UploadResult(Success As Boolean, FileName As String)  
  
If Success Then  
Log($"File ${FileName} uploaded successfully to the 'upload' folder."$)  
Else  
Log("Error uploading the file.")  
End If
```

  
  

---

  
[HEADING=3]**Uploading a File to a Specific Folder**[/HEADING]  
If you specify a folder, Magic API will automatically create it if it doesn’t exist.  
  

```B4X
MagicFiles.UploadFileToFolder(File.DirRootExternal, "document.pdf", "tasks", "report.pdf")  
  
Wait For MagicFiles_UploadToFolderResult(Success As Boolean, FileName As String)  
  
If Success Then  
Log($"File ${FileName} uploaded successfully to the 'tasks' folder."$)  
Else  
Log("Error uploading the file.")  
End If
```

  
  

---

  
[HEADING=2]**Why This Update?**[/HEADING]  
✅ **Automated Management**: No need to manually create folders. Magic API does it for you!  
✅ **Simplified Operations**: Focus on your app logic while the API handles the backend file structure.  
✅ **Consistency**: All file operations are neatly organized within the upload folder.  
  

---

  
[HEADING=2]**Note**[/HEADING]  

- All file and folder operations (e.g., uploading, deleting, listing) will now occur inside the **upload** folder for better organization and security.
- If you interact with a folder that doesn’t exist, it will be created automatically.

  
  
? [Download Magic API Now](https://b4xapp.com/item/magic-api-)  
  
Thank you for your enthusiasm and support. Let the Magic API transform your B4X applications into powerful, connected experiences! ?✨