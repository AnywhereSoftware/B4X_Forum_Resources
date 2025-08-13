### webview to access internal files by cantuma1
### 03/17/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/146882/)

hello all, i'm trying to make an app that displays a website that accesses the phone's internal files. If I use the site from a browser everything works if I view it with webview nothing works  
  
below the code  
  
#Region Project Attributes   
 #ApplicationLabel: B4A Example  
 #VersionCode: 1  
 #VersionName:   
 'SupportedOrientations possible values: unspecified, landscape or portrait.  
 #SupportedOrientations: unspecified  
 #CanInstallToExternalStorage: False  
#End Region  
  
#Region Activity Attributes   
 #FullScreen: False  
 #IncludeTitle: True  
#End Region  
  
Sub Process\_Globals  
 'These global variables will be declared once when the application starts.  
 'These variables can be accessed from all modules.  
   
End Sub  
  
Sub Globals  
 'These global variables will be redeclared each time the activity is created.  
 Private rt As RuntimePermissions  
 Private WebView1 As WebView  
   
 Private WbE As WebViewExtras  
   
 Private ChromeCLient As DefaultWebChromeClient  
   
End Sub  
  
Sub Activity\_Create(FirstTime As Boolean)  
 Activity.LoadLayout("Layout")  
 ' Attività di creazione  
 ' Richiedi i permessi all'utente per la fotocamera e l'accesso ai file interni del telefono  
   
 For Each permission As String In Array(rt.PERMISSION\_CAMERA,rt.PERMISSION\_ACCESS\_FINE\_LOCATION,rt.PERMISSION\_ACCESS\_COARSE\_LOCATION,rt.PERMISSION\_PROCESS\_OUTGOING\_CALLS,rt.PERMISSION\_WRITE\_EXTERNAL\_STORAGE,rt.PERMISSION\_READ\_EXTERNAL\_STORAGE)  
 rt.CheckAndRequest(permission)  
 Wait For Activity\_PermissionResult(permission As String, Result As Boolean)  
 If Result = False Then  
 ToastMessageShow("No permission!", True)  
 Activity.Finish  
 Return  
 End If  
 Next  
   
 ChromeCLient.Initialize("ChromeCLient")  
   
 'Hacemos cosas  
 WbE.SetWebChromeClient(ChromeCLient)  
   
   
 WebView1.JavaScriptEnabled = True  
 'WbE.addJavascriptInterface(WebView1, "B4A")  
 WebView1.LoadUrl("<https://helpman.komtera.lt/chessocr>")  
 ' Aggiungi la WebView all'attività  
 'Activity.AddView(WebView1, 0, 0, 100%x, 100%y)  
  
End Sub  
  
Sub Activity\_Resume  
  
End Sub  
  
Sub Activity\_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub Button1\_Click  
   
End Sub