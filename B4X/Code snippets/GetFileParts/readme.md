###  GetFileParts by LucaMs
### 03/30/2024
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/160198/)

I thought I had used some library, in the past, that provided functions like GetFileExtension and GetFileName. I will search better among my projects but I can't find them at the moment.  
  
This snippet is useful for getting:  
Path, FileName and FileExtension, for convenience in a single custom object.  
  
It should be noted that this snippet takes into account the directory separator symbol of the operating system on which your software will run (in Windows it is the Backslash but in others, such as Linux, it is Slash).  
  

```B4X
Type tFileParts(Path As String, Name As String, Ext As String)
```

  

```B4X
Public Sub GetFileParts(FullFilePath As String) As tFileParts  
    'Gets the directory separator symbol of the system.  
    'On Windows it is Backslash (\) but on others, such as Linux, it is Slash (/).  
    Dim DirSep As String  
     
    #IF B4i  
        DirSep = "/"  
    #Else  
        Dim JO As JavaObject  
        JO.InitializeStatic("java.lang.System")  
        DirSep = JO.RunMethod("getProperty", Array("file.separator"))  
    #End If  
     
    Dim Escape As String = "\"  
  
    Dim Parts() As String  
    Parts = Regex.Split(Escape & DirSep, FullFilePath)  
  
    Dim Path As String = ""  
    Dim Name As String = ""  
    Dim Ext As String = ""  
    Dim LastIndex As Int = Parts.Length - 1  
  
    If LastIndex > 0 Then  
        ' If there is a file name with extension  
        Name = Parts(LastIndex)  
        Dim NameParts() As String = Regex.Split(Escape & ".", Name)  
        If NameParts.Length > 1 Then  
            Ext = NameParts(NameParts.Length - 1)  
            Name = Name.SubString2(0, Name.LastIndexOf("."))  
        End If  
        Path = FullFilePath.SubString2(0, FullFilePath.LastIndexOf(DirSep) + 1)  
    Else  
        ' If only path is provided  
        Path = FullFilePath  
    End If  
  
    Dim Result As tFileParts  
    Result.Initialize  
    Result.Path = Path  
    Result.Name = Name  
    Result.Ext = Ext  
  
    Return Result  
End Sub
```