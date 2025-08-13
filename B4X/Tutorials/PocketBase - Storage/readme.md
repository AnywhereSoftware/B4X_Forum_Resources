###  PocketBase - Storage by Alexander Stolte
### 02/11/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/165280/)

<https://www.b4x.com/android/forum/threads/b4x-pocketbase-open-source-backend-in-1-file.165213/#content>  
  
Please read the official documentation about storage in pocketbase:  
<https://pocketbase.io/docs/files-handling/>  
  
**Uploading files**  
To upload files, you must first add a [file field](https://pocketbase.io/docs/files-handling/#uploading-files) to your collection  
  
You can upload one or more files at the same time. If a file field allows several files then also to the same column.  
  
Required parameters:  

- CollectionName

- dt\_Task

- RecordId

- s64f723suu7b1p4

Multiple files:  

```B4X
    Dim lst_Files As List : lst_Files.Initialize  
    lst_Files.Add(Pocketbase_Functions.CreateMultipartFileData(File.DirAssets,"test.jpg","Task_Image",""))  
    lst_Files.Add(Pocketbase_Functions.CreateMultipartFileData(File.DirAssets,"test2.jpg","Task_Image",""))  
   
    Wait For (xPocketbase.Storage.UploadFiles("dt_Task","s64f723suu7b1p4",lst_Files)) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
  
Single file:  

```B4X
    Wait For (xPocketbase.Storage.UploadFile("dt_Task","s64f723suu7b1p4",Pocketbase_Functions.CreateMultipartFileData(File.DirAssets,"test.jpg","Task_Image",""))) Complete (DatabaseResult As PocketbaseDatabaseResult)  
    xPocketbase.Database.PrintTable(DatabaseResult)
```

  
  
If you only want to upload one file, then it doesn't matter which function you use, making 2 out of it was just a nice to have.  
  
**Downloading files**  
Required parameters:  

- CollectionName

- dt\_Task

- RecordId

- s64f723suu7b1p4

- FileName

- test\_76uuo6rx0u.jpg

```B4X
    Wait For (xPocketbase.Storage.DownloadFile("dt_Task","s64f723suu7b1p4","test_76uuo6rx0u.jpg")) Complete (StorageFile As PocketbaseStorageFile)  
    If StorageFile.Error.Success Then  
        Log($"File ${"test.jpg"} successfully downloaded "$)  
        ImageView1.SetBitmap(Pocketbase_Functions.BytesToImage(StorageFile.FileBody))  
    Else  
        Log("Error: " & StorageFile.Error.ErrorMessage)  
    End If
```

  
**Deleting files**  
<https://www.b4x.com/android/forum/threads/b4x-pocketbase-deleting-files.165554/>  
  
**Helper functions**  
I provide a few useful functions that make it even easier to upload a file.  
  
[ICODE]CreateMultipartFileData[/ICODE] creates a MultipartFileData object for file uploads, automatically determining the MIME type if ContentType is empty.  

```B4X
Pocketbase_Functions.CreateMultipartFileData(File.DirAssets,"test.jpg","Task_Image",""))
```

  
  
[ICODE]GetMimeTypeByExtension[/ICODE] returns the MIME type based on the file extension, categorizing images, videos, and audio formats. Logs a warning for unknown types.  

```B4X
Log(Pocketbase_Functions.GetMimeTypeByExtension(".mp4"))
```

  
  
[ICODE]GetFileExt[/ICODE] returns the file extension from a given filename, including the leading dot (.)  

```B4X
Log(Pocketbase_Functions.GetFileExt("TestFile.mp4"))
```

  
  
**MultipartFileData**  
This is the object that is passed to upload a file, you can also use the [ICODE]Pocketbase\_Functions.CreateMultipartFileData(File.DirAssets, “test.jpg”, “Task\_Image”,“”))[/ICODE] function.  

```B4X
    Dim FileData As MultipartFileData  
    FileData.Initialize  
    FileData.Dir = File.DirAssets  
    FileData.FileName = "test.jpg"  
    FileData.KeyName = "Task_Image" 'File Column Name  
    FileData.ContentType = "image/png" 'You can use the Pocketbase_Functions.GetMimeTypeByExtension function
```