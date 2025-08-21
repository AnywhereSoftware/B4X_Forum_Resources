### SD: ZipLibrary by Star-Dust
### 08/20/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/90652/)

**jSD\_ZipLibray  
  
Author:** Star-Dust  
**Version:** 1.02  

- **SD\_ZipLibray**

- **Functions:**

- **Class\_Globals** As String
- **Initialize** As String
*Inizializza l'oggetto. Puoi aggiungere parametri a questo metodo,se necessario.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Zip** (FilesTxt As String(), FileZip As String)
- **unZip** (FilesZip As String, OutPutFolder As String)
- **unZipList** (FilesZip As String, OutPutFolder As String) As List

ZIP  

```B4X
Dim ZL As SD_ZipLibray  
  
ZL.Initialize  
ZL.Zip(ListFiles,ZipFileName)
```

  
  
UnZip  

```B4X
Dim UnZL As SD_ZipLibray  
  
    UnZL.Initialize  
    UnZL.unZip(ZipFileName,FolderDestination)
```

  
  
  
**N.B.** When you choose the folder where to save the ZIP file, make sure it is a folder that you have write permission