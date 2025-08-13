### Temporary Files - deleteOnExit by stevel05
### 03/07/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165978/)

For anyone needing to write and manage temporary files I came across the File deleteOnExit method which deletes the named file when the JVM terminates normally. JavaDoc is [here](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/io/File.html#deleteOnExit()) please read it and use with caution. deleteOnExit cannot be removed from the file once set.  
  

```B4X
Public Sub RequestDeleteOnExit(FilePath As String)  
    Dim tFile As JavaObject  
    tFile.InitializeNewInstance("java.io.File",Array(FilePath))  
    tFile.RunMethod("deleteOnExit",Null)  
End Sub
```

  
  
Usage example:  
  

```B4X
RequestDeleteOnExit(File.Combine(File.DirApp,"dialogclose.css"))
```

  
  
Hope it helps.