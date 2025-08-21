### Delete oldest files, if no free space by peacemaker
### 04/25/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/116846/)

If you collect many files - the storage is full sooner or later.  
Lets clear device's flash memory, and without complex sorting file names and dates by some special data type or classes…  
  

```B4X
'delete oldest files, if storage available space percent is getting low (without type containing the file name and date)  
Sub Delete_OldestFiles(FolderName As String, MaxFreeSpaceLimit As Int)  
    If Get_FreeSpacePercent >= MaxFreeSpaceLimit Then Return  
    Dim Files As List = File.ListFiles(FolderName)  
    If Files.Size = 0 Then Return  
     
    #if debug  
        'testing files from asset  
        For i = 0 To Files.Size - 1  
            Dim fname As String = Files.Get(i)  
            If File.Exists(File.DirInternalCache, fname) = False Then  
                File.Copy(File.DirAssets, fname, File.DirInternalCache, fname)  
            End If  
        Next  
        FolderName = File.DirInternalCache    'test folder  
    #end If  
     
    Dim Dates As List  
    Dates.Initialize  
    Dim const SizePrefixLength As Int = 20  
    For i = 0 To Files.Size - 1  
        Dim fname As String = Files.Get(i)  
        Dim d1 As Long = File.LastModified(FolderName, fname)  
        Dim d2 As String = NumberFormat2(d1, SizePrefixLength, 0, 0, False) & "_" & fname    'text combination of size & name  
        Dates.Add(d2)  
    Next  
    Dates.Sort(True)    'sorting according to the date (and name)  
    For i = 0 To Dates.Size - 1  
        Dim fname As String = Dates.Get(i)  
        fname = fname.SubString(SizePrefixLength + 1)  
        If File.IsDirectory(FolderName, fname) Then Continue  
        File.Delete(FolderName, fname)  
        If Get_FreeSpacePercent >= MaxFreeSpaceLimit Then  
            Exit    'free space is returned  
        End If  
    Next  
    Log("Free space after clearing = " & Get_FreeSpacePercent)  
End Sub  
  
Sub Get_FreeSpacePercent As Int  
    Dim jo As JavaObject  
    jo.InitializeNewInstance("java.io.File", Array(File.DirInternal))  
    Dim u As Long = jo.RunMethod("getUsableSpace", Null)    '"getFreeSpace"  
    Dim t As Long = jo.RunMethod("getTotalSpace", Null)  
    Dim res As Int = (100-((t - u)/t) * 100)  
    Return res  
End Sub
```