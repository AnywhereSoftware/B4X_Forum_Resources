### File GetCreationTime alternative by Hamied Abou Hulaikah
### 05/21/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/147971/)

[This function](https://www.b4x.com/android/forum/threads/solved-file-creation-date.114038/post-712421) is working great in recent android versions.  
But in older ones not working, I googling and find this working in all android versions:  

```B4X
Public Sub GetCreationTime (Dir As String, FileName As String) As Long  
    DateTime.DateFormat="yyyy-MM-dd"  
    DateTime.TimeFormat="HH:mm:ss"  
    Dim jo As JavaObject  
    'jo.InitializeContext  
    jo.InitializeStatic(Application.PackageName & ".currentmodulename")  
    Dim a As String = jo.RunMethod("filecreate",Array As String(File.Combine(Dir,FileName)))  
    Dim aa() As String=Regex.Split(" ",a)  
    Return DateTime.DateTimeParse(aa(0),aa(1))  
End Sub  
  
#If Java  
import java.io.File;  
import java.text.SimpleDateFormat;  
import java.util.Date;  
import java.util.Locale;  
  
  
public String filecreate(String f) {  
           File file = new File(f);  
        long creationTime = file.lastModified();  
        Date date = new Date(creationTime);  
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault());  
        String formattedDate = sdf.format(date);  
        return formattedDate;  
}  
  
#End If
```