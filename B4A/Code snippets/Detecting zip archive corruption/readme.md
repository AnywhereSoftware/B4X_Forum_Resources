### Detecting zip archive corruption by mazezone
### 12/17/2023
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/158050/)

Maybe someone could use it. I will be glad if this algorithm is added to the internal Archiver library.  
  

```B4X
Sub ZipIsValid(PathDir As String, NameFile As String) As Boolean  
    Dim MyJO As JavaObject = Me  
    Return MyJO.RunMethod("isValid", Array(File.Combine(PathDir, NameFile)))  
End Sub  
  
#If JAVA  
import java.util.zip.ZipFile;  
import java.util.zip.ZipEntry;  
import java.util.zip.ZipInputStream;  
import java.io.FileInputStream;  
import java.io.IOException;  
import java.util.zip.ZipException;  
  
public boolean isValid(final String namefile) {  
    ZipFile zipfile = null;  
    ZipInputStream zis = null;  
    try {  
        zipfile = new ZipFile(namefile);  
        zis = new ZipInputStream(new FileInputStream(namefile));  
        ZipEntry ze = zis.getNextEntry();  
        if(ze == null) {  
            return false;  
        }  
        while(ze != null) {  
            // if it throws an exception fetching any of the following then we know the file is corrupted.  
            zipfile.getInputStream(ze);  
            ze.getCrc();  
            ze.getCompressedSize();  
            ze.getName();  
            ze = zis.getNextEntry();  
        }  
        return true;  
    } catch (ZipException e) {  
        return false;  
    } catch (IOException e) {  
        return false;  
    } finally {  
        try {  
            if (zipfile != null) {  
                zipfile.close();  
                zipfile = null;  
            }  
        } catch (IOException e) {  
            return false;  
        } try {  
            if (zis != null) {  
                zis.close();  
                zis = null;  
            }  
        } catch (IOException e) {  
            return false;  
        }  
    }  
}  
#End If
```