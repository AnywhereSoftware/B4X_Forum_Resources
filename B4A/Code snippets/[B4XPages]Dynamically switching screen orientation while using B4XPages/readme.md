### [B4XPages]Dynamically switching screen orientation while using B4XPages by William Lancee
### 12/04/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/136476/)

The idea is to detect orientation dynamically and when it changes - restart the App so that B4XPages is initialized with the new orientation.  
The App state can be saved and reloaded.  
  
Update: It is tested with Android 11 but there may be problems under Android 12, I am investigating.  
Update: It is now tested with Android 12 and works fine.  
<https://www.b4x.com/android/forum/threads/does-this-method-for-restarting-a-b4xpages-app-with-a-different-orientation-work-in-android-8-it-works-in-android-7-0.136393/post-863493>  
  
The Main Module  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: TestOrient  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified   'IMPORTANT  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
'#BridgeLogger: True  
  
Sub Process_Globals  
    Public ActionBarHomeClicked As Boolean  
    Public MyAppState As Map  
  
    Private accelerometer As PhoneSensors    'include Phone library  
    Private accValues() As Float  
    Private LastOrientation As Int  
    Private checkOrientation As Timer  
   
    Private rp As RuntimePermissions        'include RuntimePermissions library  
    Private myDir As String  
    Dim ser As B4XSerializator                'include RandomAccessFile library  
End Sub  
  
Sub Globals  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    MyAppState.Initialize  
    myDir = rp.GetSafeDirDefaultExternal("")  
    If FirstTime = False Then MyAppState = ser.ConvertBytesToObject(File.ReadBytes(myDir, "MyAppState.dat"))  
  
    Dim ph As Phone  
    Dim orientation As String = "Landscape"  
    If Activity.width < Activity.Height Then  
        ph.SetScreenOrientation(7)  
        LastOrientation = 7  
        orientation = "portrait"  
    Else  
        ph.SetScreenOrientation(6)  
        LastOrientation = 6  
    End If  
    Log("Activity started with orientation: " & orientation)  
    accelerometer.Initialize(accelerometer.TYPE_ACCELEROMETER)  
    checkOrientation.Initialize("chkOrient", 333)  
    checkOrientation.Enabled = True  
  
    Dim pm As B4XPagesManager  
    pm.Initialize(Activity)  
End Sub  
  
Sub chkOrient_Tick  
    accelerometer.StartListening("Accelerometer")  
    Sleep(300)  
    accelerometer.StopListening  
End Sub  
  
'The method for sensing orientation change is extracted from @emexes:  
'https://www.b4x.com/android/forum/t…-with-portrait-orientation.106872/post-669094  
Private Sub Accelerometer_SensorChanged (Values() As Float)  
    checkOrientation.Enabled = False  
    accValues = Values  
    Dim X As Float = accValues(0)  
    Dim Y As Float = accValues(1)  
    Dim ThisOrientation As Int = LastOrientation  
    If Abs(Y) > 7 Then ThisOrientation = 7  
    If Abs(X) > 7 Then ThisOrientation = 6  
    If ThisOrientation <> LastOrientation Then  
        File.WriteBytes(myDir, "MyAppState.dat", ser.ConvertObjectToBytes(MyAppState))  
        Activity.Finish  
        StartActivity(Me)  
        LastOrientation = ThisOrientation  
    Else  
        checkOrientation.Enabled = True  
    End If  
End Sub  
  
'Template version: B4A-1.01  
#Region Delegates  
  
Sub Activity_ActionBarHomeClick  
    ActionBarHomeClicked = True  
    B4XPages.Delegate.Activity_ActionBarHomeClick  
    ActionBarHomeClicked = False  
End Sub  
  
Sub Activity_KeyPress (KeyCode As Int) As Boolean  
    Return B4XPages.Delegate.Activity_KeyPress(KeyCode)  
End Sub  
  
Sub Activity_Resume  
    B4XPages.Delegate.Activity_Resume  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
    B4XPages.Delegate.Activity_Pause  
End Sub  
  
Sub Activity_PermissionResult (Permission As String, Result As Boolean)  
    B4XPages.Delegate.Activity_PermissionResult(Permission, Result)  
End Sub  
  
Sub Create_Menu (Menu As Object)  
    B4XPages.Delegate.Create_Menu(Menu)  
End Sub  
  
#if Java  
public boolean _onCreateOptionsMenu(android.view.Menu menu) {  
     processBA.raiseEvent(null, "create_menu", menu);  
     return true;  
   
}  
#End If  
#End Region  
  
'Program code should go into B4XMainPage and other pages.
```

  
  
The B4XMainPage Module  
  

```B4X
#Region Shared Files  
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"  
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True  
#End Region  
  
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip  
  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private Label1 As Label  
End Sub  
  
Public Sub Initialize  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
   
    If Main.MyAppState.size = 0 Then            'The first orientation  
        Main.MyAppState.Put("OrientationCount", 1)  
    Else  
        Main.MyAppState.Put("OrientationCount", 1 + Main.MyAppState.Get("OrientationCount"))  
    End If  
    Label1.Text = IIf(Root.Width>Root.Height, "Now Landscape", "Now Portrait") & " Change # " & Main.MyAppState.Get("OrientationCount").As(Int)  
End Sub
```