###  PocketBase - Deleting files by Alexander Stolte
### 02/11/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/165554/)

<https://www.b4x.com/android/forum/threads/b4x-pocketbase-open-source-backend-in-1-file.165213/>  
  
Please read the official documentation about deleting files in pocketbase:  
<https://pocketbase.io/docs/files-handling/#deleting-files>  
  
There are several ways to delete files with the B4X-Pocketbase SDK.  
  
**[SIZE=5]Delete Specific Files from a Record (DeleteFiles)[/SIZE]**  
Deletes a specific file or multiple files from a record.  

```B4X
    Wait For (xPocketbase.Storage.DeleteFiles("dt_Task","77avq8zn44ck37m","Task_Image",Array As String("test_l586xluw7q.jpg"))) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
**Parameters:**  

- [ICODE]CollectionName[/ICODE]: The name of the collection where the record exists.
- [ICODE]RecordID[/ICODE]: The ID of the record that contains the file.
- [ICODE]ColumnName[/ICODE]: The name of the field where the file is stored.
- [ICODE]DocumentNames[/ICODE]: An array of file names to be deleted.

**[SIZE=5]Delete Individual Files from a Multi-File Field[/SIZE]**  
[SIZE=4]With this function you can delete several file columns at once.[/SIZE]  

```B4X
    Dim UpdateRecord As Pocketbase_DatabaseUpdate = xPocketbase.Database.UpdateData.Collection("dt_Task")  
    UpdateRecord.Update(CreateMap("Task_Image-":"test_6byr5kmo3b.jpg")) 'If you want to delete individual file(s) from a multiple file upload field, you could suffix the field name with - and specify the filename(s) you want to delete  
    Wait For (UpdateRecord.Execute("8u7928b58636n76")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
**Parameters:**  

- [ICODE]CollectionName[/ICODE]: The name of the collection.
- [ICODE]FieldName[/ICODE]: The field that contains the file.
- [ICODE]FileName[/ICODE]: The specific file to be deleted.
- [ICODE]RecordID[/ICODE]: The ID of the record.

**Description:**  

- This method removes **specific files** from a **multi-file upload field**.
- **The** [ICODE]-[/ICODE] **suffix** is used to specify which file(s) should be deleted.

**[SIZE=5]Delete All Files from a Field[/SIZE]**  
Removes **all files** from a file field in a record.  

```B4X
    Dim UpdateRecord As Pocketbase_DatabaseUpdate = xPocketbase.Database.UpdateData.Collection("dt_Task")  
    UpdateRecord.Update(CreateMap("Task_Image":""))  
    Wait For (UpdateRecord.Execute("8u7928b58636n76")) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
**Parameters:**  

- [ICODE]CollectionName[/ICODE]: The name of the collection.
- [ICODE]FieldName[/ICODE]: The field that contains the file.
- [ICODE]RecordID[/ICODE]: The ID of the record.

**Description:**  

- This method **deletes all files** associated with a specific field by setting its value to an **empty string ("")**.

[HEADING=2]**Conclusion**[/HEADING]  
With these three methods, you can manage file deletions in PocketBase efficiently:  
  

1. **DeleteFiles** → Remove specific files using Storage.DeleteFiles().
2. **Delete Individual Files from Multi-File Fields** → Use the - suffix in UpdateData.Update().
3. **Delete All Files** → Set the field value to an **empty string**.