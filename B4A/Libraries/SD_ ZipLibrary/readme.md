### SD: ZipLibrary by Star-Dust
### 09/03/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/90733/)

**SD\_ZipLibray  
  
Author:** Star-Dust  
**Version:** 1.03  

- **SD\_ZipLibrary**

- **Event**

- **finish (**Success as Boolean)

- **Functions:**

- **Class\_Globals** As String
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **unZip** (FileZip As String, OutPutFolder As String) As String
- **unZipList** (FileZip As String) As List
- **Zip** (FilesTxt As String(), FileZip As String) As String

  
**SD\_ZipLibray  
  
Author:** Star-Dust  
**Version:** 1.03  

- **SD\_ZipLibrary**

- **Event**

- **finish (**Success as Boolean)

- **Functions:**

- **Class\_Globals** As String
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **unZip** (FileZip As String, OutPutFolder As String) As String
- **unZipList** (FileZip As String) As List
- **Zip** (FilesTxt As String(), FileZip As String) As String

  
List file in to Zip  

```B4X
Dim UZ As SD_ZipLibrary  
  
    UZ.Initialize  
    Log("File: " & File.Exists(File.DirRootExternal,fileZipName))  
    Dim L As List = UZ.unZipList(File.Combine(File.DirRootExternal,fileZipName))
```

  
  
Unzip  

```B4X
Dim UZ As SD_ZipLibrary  
  
UZ.Initialize  
    UZ.unZip(File.Combine(File.DirRootExternal,fileZipName),File.Combine(File.DirRootExternal,DestinationPath))
```

  
  
  
Zip files  

```B4X
Dim ZL As SD_ZipLibray  
Dim ListFiles as List  
  
ZL.Initialize(Me,"ZL")  
ZL.Zip(ListFiles,ZipFileName)
```

  
  
Wait For  

```B4X
Dim UZ As SD_ZipLibrary  
  
UZ.Initialize  
Log("File: " & File.Exists(File.DirRootExternal,fileZipName))  
Dim L As List = UZ.unZipList(File.Combine(File.DirRootExternal,fileZipName))  
  
Wait For UZ_finish(Success As Boolean)  
Log("result:" &Success)  
Log("Num: " & L.Size)
```