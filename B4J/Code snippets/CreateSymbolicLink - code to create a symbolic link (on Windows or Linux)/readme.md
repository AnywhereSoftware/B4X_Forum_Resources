### CreateSymbolicLink - code to create a symbolic link (on Windows or Linux)  by walt61
### 02/15/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/138471/)

I needed this for a project and didn't find an easier solution (by all means tell me if one exists) so I came up with this code:  
  

```B4X
' Creates a symbolic link  
'  
' IMPORTANT: must be run as Administrator on Windows (or Files.createSymbolicLink in the Java code will fail)  
'  
' Dependencies: the JavaObject library  
'  
' Parms:  
' - linkPath: String: the path of the symbolic link  
' - realFilePath: String: the path of the target file to which 'linkPath' will point  
' - overwriteExisting: True to first delete 'linkPath' if it already exists; if False and 'linkPath' exists, an error occurs  
'  
' Returns: True if the operation succeeded, False if an error occurred (or if running on Windows without Administrator privilege)  
'  
' Example:  
' Dim link As String = "C:\Users\me\Downloads\linktoreal.txt"  
' Dim realfile As String = "C:\Users\me\Downloads\realfilehere.txt"  
' xui.MsgboxAsync("Done; success: " & CreateSymbolicLink(link, realfile, True), "Result")  
'  
' Derived from:  
' - https://www.b4x.com/android/forum/threads/retrieving-file-types.98782/#post-622169  
' - https://www.baeldung.com/java-symlink  
Sub CreateSymbolicLink(linkPath As String, realFilePath As String, overwriteExisting As Boolean) As Boolean  
  
    ' Must run as Administrator on Windows; assumption: drive C: exists  
    Try  
        If File.Exists("c:\", "") Then  
            File.WriteString("c:\", "runasadmin.test", "test")  
            File.Delete("c:\", "runasadmin.test")  
        End If  
    Catch  
        Return False  
    End Try  
  
    Return Me.As(JavaObject).RunMethod("createSymbolicLink", Array(linkPath, realFilePath, overwriteExisting))  
  
End Sub  
  
#if java  
import java.nio.file.*;  
import java.io.*;  
public static Boolean createSymbolicLink(String linkPath, String realFilePath, Boolean overwriteExisting) throws IOException {  
    try {  
        Path target = Paths.get("", realFilePath);  
        Path link = Paths.get("", linkPath);  
        if (overwriteExisting) {  
            if (Files.exists(link)) {  
                Files.delete(link);  
            }  
        }  
        Files.createSymbolicLink(link, target);  
        return true;  
    }  
    catch(Exception e) {  
      return false;  
    }  
}  
#End If
```

  
  
Sample project attached.