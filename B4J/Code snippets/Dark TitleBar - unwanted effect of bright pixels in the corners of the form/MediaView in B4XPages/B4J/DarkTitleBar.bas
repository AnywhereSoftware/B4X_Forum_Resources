B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.3
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Private mDark As Boolean
End Sub

'Apply the whole values to the RootPane style.
Public Sub SetDarkMode(Target As Form, Dark As Boolean, WholeColor As Int)
	mDark = Dark
'	If Target.Showing And mDark Then Target.RootPane.Style = "-fx-background-color: #000000;" '-------------------------------------------------------------------------------- >>>>>>> ADD!
	If Target.Showing And mDark Then Target.RootPane.As(B4XView).Color = WholeColor '------------------------------------------------------------------------------------------ >>>>>>> ADD!
	Dim hwnd As JavaObject = Me.As(JavaObject).RunMethod("getActiveWindow",Null)
	Me.As(JavaObject).RunMethod("setDarkMode",Array(GetStage(Target),mDark,hwnd))
End Sub

Public Sub DarkMode As Boolean
	Return mDark
End Sub

Private Sub GetStage(tForm As Form) As JavaObject
	Return tForm.As(JavaObject).GetField("stage")
End Sub

'Does nothing.  For info
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
