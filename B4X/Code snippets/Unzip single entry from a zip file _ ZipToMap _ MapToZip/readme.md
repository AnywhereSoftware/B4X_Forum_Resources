###  Unzip single entry from a zip file / ZipToMap / MapToZip by Erel
### 05/15/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/167014/)

B4A + B4J code. Reads the data of a single entry.  

```B4X
'Depends on JavaObject. Returns 0 bytes array if entry not found.  
Private Sub UnzipEntry(ZipPath As String, Entry As String) As Byte()  
    Dim result() As Byte  
    Dim ZipFile As JavaObject  
    ZipFile.InitializeNewInstance("java.util.zip.ZipFile", Array(ZipPath))  
    Dim ZipEntry As JavaObject = ZipFile.RunMethod("getEntry", Array(Entry))  
    If NotInitialized(ZipEntry) Then Return result  
    result = Bit.InputStreamToBytes(ZipFile.RunMethod("getInputStream", Array(ZipEntry)))  
    ZipFile.RunMethod("close", Null)  
    Return result  
End Sub
```

  
  
Usage example:  

```B4X
Sub AppStart (Args() As String)  
    Dim b() As Byte = UnzipEntry("C:\Users\H\Documents\B4X\XUI Views.b4xlib", "manifest.txt")  
    If b.Length = 0 Then  
        Log("entry not found")  
    Else  
        Dim s As String = BytesToString(b, 0, b.Length, "utf8")  
        Log(s)  
    End If  
End Sub
```

  
  
Getting file from subfolder:  

```B4X
Dim b() As Byte = UnzipEntry("C:\Users\H\Documents\B4X\XUI Views.b4xlib", "B4J/B4JTextFlow.bas")
```