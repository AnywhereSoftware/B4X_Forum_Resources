### Put files in clipboard from non-ui programs by Erel
### 01/25/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170118/)

The standard way to set the clipboard content is with jFX.Clipboard, however this is only available in UI apps.  
An alternative solution based on AWT, which is always available:  

```B4X
Private Sub PutFilesInClipboard (Files As List)  
    Dim FilesList As List  
    FilesList.Initialize  
    For Each f As String In Files  
        Dim jo As JavaObject  
        jo.InitializeNewInstance("java.io.File", Array(f))  
        FilesList.Add(jo)  
    Next  
    Me.As(JavaObject).RunMethod("putFiles", Array(FilesList))  
End Sub  
  
#If Java  
import java.awt.datatransfer.Transferable;  
import java.awt.datatransfer.Clipboard;  
import java.awt.datatransfer.DataFlavor;  
import java.awt.datatransfer.UnsupportedFlavorException;  
import java.awt.Toolkit;  
public static void putFiles(java.util.List files) {  
    Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();  
    Transferable transferable = new Transferable() {  
        private final DataFlavor[] flavors = { DataFlavor.javaFileListFlavor };  
  
        @Override public DataFlavor[] getTransferDataFlavors() { return flavors; }  
  
        @Override public boolean isDataFlavorSupported(DataFlavor flavor) {  
            return DataFlavor.javaFileListFlavor.equals(flavor);  
        }  
  
        @Override public Object getTransferData(DataFlavor flavor) throws UnsupportedFlavorException {  
            if (!isDataFlavorSupported(flavor)) throw new UnsupportedFlavorException(flavor);  
            return files;  
        }  
    };  
    clipboard.setContents(transferable, null);  
}  
#End If
```

  
  
Note that it is not exactly clear in the documentation whether the content will be available after the program ends. Based on my tests on Windows, the content remains valid after the program ends.