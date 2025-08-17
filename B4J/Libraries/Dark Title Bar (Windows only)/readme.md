### Dark Title Bar (Windows only) by stevel05
### 05/01/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166634/)

Another option for a Dark Title Bar  
  
I found some code on [StackOverflow](https://stackoverflow.com/a/76543216/981223) which I got working in B4j:  
  
  
  

![](https://www.b4x.com/android/forum/attachments/163447)

  
It depends on JNA 5 + available on [Github](https://github.com/java-native-access/jna). Although it's probably easier to get them from [Maven Central](https://mvnrepository.com/artifact/net.java.dev.jna)  

```B4X
#AdditionalJar: jna-5.16.0  
#AdditionalJar: jna-platform-5.16.0
```

  
  
I have tested on Win 11, apparently it may work on some versions of Win 10, but I can't test it.  
  
There is not much code:  
  

```B4X
'Static code module  
  
Sub Process_Globals  
    Private mDark As Boolean  
End Sub  
  
Public Sub SetDarkMode(Target As Form, Dark As Boolean)  
    mDark = Dark  
    Dim hwnd As JavaObject = Me.as(JavaObject).RunMethod("getActiveWindow",Null)  
    Me.as(JavaObject).RunMethod("setDarkMode",Array(GetStage(Target),mDark,hwnd))  
End Sub  
  
Public Sub DarkMode As Boolean  
    Return mDark  
End Sub  
  
Private Sub GetStage(tForm As Form) As JavaObject  
    Return tForm.As(JavaObject).GetField("stage")  
End Sub  
  
'Does nothing.  For info  
'Requires JNA jna 5 + available from <link>GitHub|https://github.com/java-native-access/jna</link>  
'Based on code from <link>StackOverflow|https://stackoverflow.com/a/76543216/981223</link>  
'<code>#AdditionalJar: jna-5.16.0  
'#AdditionalJar: jna-platform-5.16.0</code>  
Public Sub Info  
  
End Sub  
  
  
  
#if java  
import com.sun.jna.Native;  
import com.sun.jna.platform.win32.WinDef;  
import javafx.stage.Stage;  
  
import com.sun.jna.Library;  
import com.sun.jna.Native;  
import com.sun.jna.PointerType;  
import com.sun.jna.platform.win32.User32;  
  
  
    public static void setDarkMode(Stage stage, boolean darkMode, WinDef.HWND hwnd) {  
  
        Dwmapi dwmapi = Dwmapi.INSTANCE;  
        WinDef.BOOLByReference darkModeRef = new WinDef.BOOLByReference(new WinDef.BOOL(darkMode));  
  
       int hr = dwmapi.DwmSetWindowAttribute(hwnd, 20, darkModeRef, Native.getNativeSize(WinDef.BOOLByReference.class));  
       if (hr != 0) { // S_OK is 0  
            BA.Log("Mode not applied");  
        }  
    }  
  
     
    public interface Dwmapi extends Library {  
     
        Dwmapi INSTANCE = Native.load("dwmapi", Dwmapi.class);  
     
        int DwmSetWindowAttribute(WinDef.HWND hwnd, int dwAttribute, PointerType pvAttribute, int cbAttribute);  
  
    }  
     
    public static WinDef.HWND getActiveWindow(){  
        return User32.INSTANCE.GetActiveWindow();  
    }  
#End If
```

  
  
But I have created a B4xLib anyway.  
  
You only need to add one line of code after the Form has been shown:  

```B4X
    MainForm.Show  
    DarkTitleBar.SetDarkMode(MainForm, True)
```

  
  
**Updates V0.2**  
 Updated to work with Packager  
  
  
Let me know if it works for you.