B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
' Class Module: AC_WebBridge
' autor: @Abdullcadre (https://www.b4x.com/android/forum/members/abdull-cadre.115614/)
'
' Description: Provides a native bridge between B4X and WebView without external libraries.
' Supports B4A (via ConsoleMessage interception) and B4J (via JSObject injection).

#IgnoreWarnings: 12
Sub Class_Globals
	Private mTarget As Object
	Private mEventName As String
End Sub

' Initializes the bridge with the target module and event prefix.
' Example: Bridge.Initialize(Me, "MyBridge")
Public Sub Initialize (Target As Object, EventName As String)
	mTarget = Target
	mEventName = EventName
End Sub

' Configures the WebView settings and injects the native bridge logic.
Public Sub Setup(WV As WebView)
	Dim jo As JavaObject = Me
	jo.RunMethod("setupNativeBridge", Array(WV))
End Sub

' Executes a JavaScript function in the WebView.
' FunctionName: The name of the JS function to call.
' Parameters: Array of objects to pass as arguments.
Public Sub RunJS(WV As WebView, FunctionName As String, Parameters() As Object)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append(FunctionName).Append("(")
    
	For i = 0 To Parameters.Length - 1
		If i > 0 Then sb.Append(",")
		' Sanitize string to prevent JavaScript syntax errors
		Dim value As String = Parameters(i)
		value = value.Replace("\", "\\").Replace("'", "\'")
		sb.Append("'").Append(value).Append("'")
	Next
    
	sb.Append(")")
    
    #If B4A
    WV.LoadUrl("javascript:" & sb.ToString)
    #End If
    
    #If B4J
	Dim jo As JavaObject = WV
	Dim engine As JavaObject = jo.RunMethod("getEngine", Null)
	engine.RunMethod("executeScript", Array(sb.ToString))
    #End If
End Sub

' Internal callback triggered by the Java layer.
' Dispatches the event to the target B4X module.
Private Sub NativeBridgeCallback(Message As String)
	If SubExists(mTarget, mEventName & "_OnJsMessage") Then
		CallSubDelayed2(mTarget, mEventName & "_OnJsMessage", Message)
	End If
End Sub

#If B4A
#If JAVA
import android.webkit.*;
public void setupNativeBridge(WebView wv) {
    WebSettings s = wv.getSettings();
    s.setJavaScriptEnabled(true);
    s.setDomStorageEnabled(true);
    s.setAllowFileAccess(true);
    
    final anywheresoftware.b4a.BA b = ba; 
    wv.setWebChromeClient(new WebChromeClient() {
        @Override
        public boolean onConsoleMessage(ConsoleMessage consoleMessage) {
            // Intercepts console.log calls from JS to trigger B4X events
            b.raiseEventFromDifferentThread(null, null, 0, "nativebridgecallback", true, new Object[] {consoleMessage.message()});
            return true;
        }
    });
}
#End If
#End If

#If B4J
#If JAVA
import javafx.scene.web.WebView;
import javafx.scene.web.WebEngine;
import netscape.javascript.JSObject;
import javafx.concurrent.Worker;

public void setupNativeBridge(WebView wv) {
    final WebEngine engine = wv.getEngine();
    engine.getLoadWorker().stateProperty().addListener((obs, oldState, newState) -> {
        if (newState == Worker.State.SUCCEEDED) {
            JSObject window = (JSObject) engine.executeScript("window");
            // Injects the bridge object into the browser's global scope
            window.setMember("b4x", this);
        }
    });
}

// B4J requires this method to be public for JSObject visibility
public void NativeBridgeHandler(String msg) {
    ba.raiseEventFromDifferentThread(null, null, 0, "nativebridgecallback", true, new Object[] {msg});
}
#End If
#End If