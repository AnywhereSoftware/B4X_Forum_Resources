### External Storage - Simple Example by rodmcm
### 05/13/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/117681/)

Enclosed is a simple call to storage , creating a directory and copying files from DirInternal using ExternalStorage Class  
Distilled from several sources, especially Manfred's work.  
  
  

```B4X
'Creates folder in the destination folder selected  
'Copies file from DirInternal  
Sub FiletoExtStorage(DirName As String,FileToCopy As String)  
        Dim inpstr As InputStream          = File.OpenInput(File.DirInternal,FileToCopy)         'Create an Inputstream from the Sourcefile to copy  
  
        Dim DirName1 As ExternalFile     = Storage.FindDirOrCreate(Storage.Root, DirName)       'creates the folder  
        Dim destfile As ExternalFile     = Storage.CreateNewFile(DirName1,FileToCopy)           'create the file  
        Dim os As OutputStream             = Storage.OpenOutputStream(destfile)                    'Create an Outputstream to the destfile  
          
        File.Copy2(inpstr,os)                                                                  'Copy file  
        inpstr.Close                                                                        'Close inputstr  
        os.Close                                                                              'Close Outputstream  
End Sub  
  
  
Sub SetTestFiles  
    FileName1= "RodTest1.txt"  
    File.WriteString(File.DirInternal, FileName1, "jaklsdjalksdjalskdjasld")                 
      
    Filename2= "RodTest2.txt"  
    File.WriteString(File.DirInternal, Filename2, "qwertyqwerty")                 
      
End Sub  
  
  
Sub btnTest_Click  
    SetTestFiles  
    Storage.SelectDir(True)  
    Wait For Storage_ExternalFolderAvailable  
    FiletoExtStorage("Terminations",FileName1)            ' Directory and File to Send  
    FiletoExtStorage("Terminations",Filename2)            ' Directory and File to Send  
End Sub
```

  
  
Added this to Class which was from another contributor  

```B4X
Public Sub FindDirOrCreate(Parent As ExternalFile, Name As String) As ExternalFile  
    Dim f As ExternalFile = FindFile(Parent, Name)  
    If f.IsInitialized = False Then  
        Return DocumentFileToExternalFile(Parent.Native.RunMethod("createDirectory", Array(Name)))  
    Else  
        Return f  
    End If  
End Sub
```