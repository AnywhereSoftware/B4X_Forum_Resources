###  Supabase - Storage Files by Alexander Stolte
### 09/11/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/151199/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
This is a very simple tutorial on how to use the storage file options.  
  
**Upload File**  
Uploads a file to an existing bucket.  

```B4X
    Dim UploadFile As Supabase_StorageFile = xSupabase.Storage.UploadFile("Avatar","test.png")  
    UploadFile.FileBody(xSupabase.Storage.ConvertFile2Binary(File.DirAssets,"test.jpg"))  
    Wait For (UploadFile.Execute) Complete (StorageFile As SupabaseStorageFile)  
    If StorageFile.Error.Success Then  
        Log($"File ${"test.jpg"} successfully uploaded "$)  
    Else  
        Log("Error: " & StorageFile.Error.ErrorMessage)  
    End If
```

  
**Download File**  
Downloads a file.  

```B4X
    Dim DownloadFile As Supabase_StorageFile = xSupabase.Storage.DownloadFile("Avatar","test.png")  
    Wait For (DownloadFile.Execute) Complete (StorageFile As SupabaseStorageFile)  
    If StorageFile.Error.Success Then  
        Log($"File ${"test.jpg"} successfully downloaded "$)  
        ImageView1.SetBitmap(xSupabase.Storage.BytesToImage(StorageFile.FileBody))  
    Else  
        Log("Error: " & StorageFile.Error.ErrorMessage)  
    End If
```

  
**Update File**  
Replaces an existing file at the specified path with a new one.  

```B4X
    Dim UpdateFile As Supabase_StorageFile = xSupabase.Storage.UpdateFile("Avatar","test.png")  
    UpdateFile.FileBody(xSupabase.Storage.ConvertFile2Binary(File.DirAssets,"test2.jpg"))  
    Wait For (UpdateFile.Execute) Complete (StorageFile As SupabaseStorageFile)  
    If StorageFile.Error.Success Then  
        Log($"File ${"test.jpg"} successfully updated "$)  
    Else  
        Log("Error: " & StorageFile.Error.ErrorMessage)  
    End If
```

  
**Delete File**  
comming soon  
<https://www.b4x.com/android/forum/threads/okhttputils2-add-delete3-method-with-bytes-instead-of-an-array.150607/>  
**Move File**  
Moves an existing file to a new path in the same bucket.  
FromPath - The original file path, including the current file name. For example `folder/image.png`  
ToPath - The new file path, including the new file name. For example `folder/image-copy.png`  

```B4X
    Wait For (xSupabase.Storage.MoveFile("Avatar","public/avatar1.png", "private/avatar2.png").Execute) Complete (StorageFile As SupabaseStorageFile)  
    If StorageFile.Error.Success Then  
        Log($"Files successfully moved "$)  
    Else  
        Log("Error: " & StorageFile.Error.ErrorMessage)  
    End If
```

  
**Copy File**  
Copies an existing file to a new path in the same bucket.  
FromPath - The original file path, including the current file name. For example `folder/image.png`  
ToPath - The new file path, including the new file name. For example `folder/image-copy.png`  

```B4X
    Wait For (xSupabase.Storage.CopyFile("Avatar","public/avatar1.png", "private/avatar2.png").Execute) Complete (StorageFile As SupabaseStorageFile)  
    If StorageFile.Error.Success Then  
        Log($"Files successfully copied "$)  
    Else  
        Log("Error: " & StorageFile.Error.ErrorMessage)  
    End If
```

  
**Get Public Url**  
Retrieve public URL  
A simple convenience function to get the URL for an asset in a public bucket. If you do not want to use this function, you can construct the public URL by concatenating the bucket URL with the path to the asset.  
This function does not verify if the bucket is public. If a public URL is created for a bucket which is not public, you will not be able to download the asset.  

```B4X
Log(xSupabase.Storage.GetPublicUrl("Avatar","test.png"))
```

  
**Create signed Url**  
Create signed url to download file without requiring permissions. This URL can be valid for a set number of seconds.  

```B4X
    Wait For (xSupabase.Storage.CreateSignedUrl("Avatar","test.png",60).Execute) Complete (StorageFile As SupabaseStorageFile)  
    If StorageFile.Error.Success Then  
        Log(StorageFile.SignedURL)  
  
        Dim DownloadFile As Supabase_StorageFile = xSupabase.Storage.DownloadFile("Avatar")  
        DownloadFile.Path("test.png")  
        DownloadFile.SignedURL(StorageFile.SignedURL)  
        Wait For (DownloadFile.Execute) Complete (StorageFile As SupabaseStorageFile)  
        If StorageFile.Error.Success Then  
            Log($"File from signed URL successfully downloaded "$)  
            ImageView1.SetBitmap(xSupabase.Storage.BytesToImage(StorageFile.FileBody))  
        Else  
            Log("Error: " & StorageFile.Error.ErrorMessage)  
        End If  
  
    Else  
        Log("Error: " & StorageFile.Error.ErrorMessage)  
    End If
```