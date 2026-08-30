### [b4j] zip/unzip by behnam_tr
### 08/23/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171867/)

pd\_ZipUnZip Library v2.1  
  

```B4X
    dim zp as  PD_ZipUnzip  
     zp.Initialize  
  
   ' zip files/directories  
    Dim File1 As String = File.Combine(File.DirApp,"1.txt")  
    Dim File2 As String = File.Combine(File.DirApp,"2.txt")  
    Dim folder1 As String = File.DirApp&"\testfolder"  
   
    Dim targetFile As String = File.Combine(File.DirApp,"test1.zip")  
   
    setOptions  
   
    Dim success As Boolean = zp.Zip (Array(File1,File2,folder1),targetFile)  
    Log("success : "&success)  
  
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''  
    zp.ZipAsync (Array(File1,File2),targetFile)  
    Wait For ZipAsyncComplete (success As Boolean)  
    If success Then  
        Log("ZIP completed successfully")  
    Else  
        Log("ZIP operation failed")  
    End If
```

  
  
  

```B4X
Sub setOptions  
    'optional  
    zp.CompressionLevel = 1  
    zp.PasswordEnabled = True  
    zp.Password = "12345"  
End Sub
```

  
  
[SPOILER="All Methods"]  
  
// Properties  
  
void setPasswordEnabled(boolean value)  
boolean getPasswordEnabled()  
void setPassword(String value)  
String getPassword()  
void setCompressionLevel(int value)  
int getCompressionLevel()  
  
// ZIP Operations  
boolean Zip(anywheresoftware.b4a.objects.collections.List items, String zipFile)  
boolean Unzip(String zipFile, String destinationDirectory)  
boolean Add(String zipFile, String source, String entryName)  
boolean Remove(String zipFile, String entryName)  
  
  
// Extraction Operations  
boolean Extract(String zipFile, String entryName, String destinationDirectory)  
boolean ExtractFiles(String zipFile, anywheresoftware.b4a.objects.collections.List entries, String destinationDirectory)  
  
  
// Archive Information  
anywheresoftware.b4a.objects.collections.List GetFiles(String zipFile)  
anywheresoftware.b4a.objects.collections.List GetEntries(String zipFile)  
int GetEntryCount(String zipFile)  
long GetSize(String zipFile)  
  
// Password Operations  
boolean IsPasswordProtected(String zipFile)  
boolean IsPasswordCorrect(String zipFile)  
  
  
// Validation and Integrity  
boolean IsValid(String zipFile)  
boolean TestIntegrity(String zipFile)  
  
  
[/SPOILER]