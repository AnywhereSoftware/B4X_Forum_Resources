### B4J Copy files to the clipboard. by zed
### 06/29/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/167574/)

I needed a system to copy files to the clipboard just like CTRL-C. I don't think B4J can do it.  
So I did it in JAVA and compiled a .jar file.  
Return a list with the full path and file name (C:\myfolder\myfile.ext) this works with any type of file (txt, pdf, docx, etc…)  
The JAVA code was written with Notepad++ and compiled with a .bat file.  
For those who are interested, here's the procedure. You don't have to do this, as I've attached the JAR file.  
  
Expected file structure for compilation.  
your\_folder/  
│  
├── compile\_clipboard\_jar.bat  
├── src/  
│ └── b4j/  
│ └── helper/  
│ └── ClipboardFileCopier.java  
  

```B4X
package b4j.helper;  
  
import java.awt.*;  
import java.awt.datatransfer.*;  
import java.io.File;  
import java.util.List;  
import java.util.ArrayList;  
  
public class ClipboardFileCopier {  
  
   public static void copyFilesToClipboard(java.util.List<String> filePaths) {  
    java.util.List<File> files = new java.util.ArrayList<>();  
    for (String path : filePaths) {  
        File file = new File(path);  
        if (file.exists()) {  
            files.add(file);  
        }  
    }  
  
    if (!files.isEmpty()) {  
        FileTransferable ft = new FileTransferable(files);  
        Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();  
        clipboard.setContents(ft, null);  
    }  
}  
  
      
  
    static class FileTransferable implements Transferable {  
        private final List<File> files;  
  
        public FileTransferable(List<File> files) {  
            this.files = files;  
        }  
  
        public DataFlavor[] getTransferDataFlavors() {  
            return new DataFlavor[] { DataFlavor.javaFileListFlavor };  
        }  
  
        public boolean isDataFlavorSupported(DataFlavor flavor) {  
            return DataFlavor.javaFileListFlavor.equals(flavor);  
        }  
  
        public Object getTransferData(DataFlavor flavor) {  
            return files;  
        }  
    }  
}
```

  
  

```B4X
@echo off  
setlocal  
  
:: Directory containing the Java file  
set SRC_DIR=src  
:: Output directory for compiled classes  
set BIN_DIR=bin  
:: Final JAR file name  
set JAR_NAME=ClipboardFileCopier.jar  
:: Package name + main class  
set MAIN_CLASS=b4j.helper.ClipboardFileCopier  
  
:: Creation of folder if necessary  
if not exist %BIN_DIR% mkdir %BIN_DIR%  
  
:: Compiling the Java class  
echo Compiling the Java class…  
javac -encoding UTF-8 -d %BIN_DIR% %SRC_DIR%\b4j\helper\ClipboardFileCopier.java  
  
:: Creation of the MANIFEST file  
echo Manifest-Version: 1.0> manifest.txt  
echo Main-Class: %MAIN_CLASS%>> manifest.txt  
  
:: Creating the JAR file  
echo creating the JAR file…  
jar cfm %JAR_NAME% manifest.txt -C %BIN_DIR% .  
  
:: Cleaning  
del manifest.txt  
  
echo.  
echo ✅ Done! The file %JAR_NAME% is ready.  
pause
```

  
  
For B4J  
Put the JAR file in the additional libraries folder.  
  
Add  

```B4X
#AdditionalJar: ClipboardFileCopier.jar
```

  
  
and use  

```B4X
Private Sub CopyToClipboard(l As List)  
    Dim jo As JavaObject  
    jo.InitializeStatic("b4j.helper.ClipboardFileCopier")  
    jo.RunMethod("copyFilesToClipboard", Array(l))  
End Sub
```

  
  
Have fun