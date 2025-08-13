### record whit blootooth mic ضبط صدا با میکروفون بلوتوث by MAJID4221577
### 12/07/2023
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/157847/)

```B4X
#Region  Project Attributes  
    #ApplicationLabel: Audio Recording Sample  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private timer1 As Timer  
    Private ProcessStart As Long  
    Private mp As MediaPlayer  
    
    Dim recording As Boolean  
    Private r As Reflector  
    Dim mFileName As String = "1.wav"  
    
End Sub  
  
Sub Globals  
    Dim btnStartRecording As Button  
    Dim btnPlay As Button  
    
    Dim Label1 As Label  
    Dim Process As String  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("1")  
    If FirstTime Then  
        mp.Initialize2("mp")  
        StartServiceAt(AudioRecord,DateTime.Now,True)  
    End If  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub Timer1_Tick  
    Label1.Text = Process & ": " & _  
        Round((DateTime.Now - ProcessStart) / DateTime.TicksPerSecond) & " seconds"  
End Sub  
  
Sub btnStartRecording_Click  
    Process = "Recording"  
    recording = True  
    timer1.Initialize("timer1", 1000)  
    ProcessStart = DateTime.Now  
    timer1.Enabled = True  
    Timer1_Tick  
    btnPlay.Enabled = False  
    StartBluetoothSco  
    CallSub(AudioRecord,"btnStartRecording_Click")  
End Sub  
  
Sub btnStopRecording_Click  
    recording = False  
    timer1.Enabled = False  
    btnPlay.Enabled = True  
    Label1.Text = ""  
    stopBluetoothSco  
    CallSub(AudioRecord,"btnStopRecording_Click")  
End Sub  
  
Sub btnPlay_Click  
    Process = "Playing"  
    timer1.Initialize("timer1", 1000)  
    ProcessStart = DateTime.Now  
    timer1.Enabled = True  
    btnStartRecording.Enabled = False  
    
    mp.Load(File.DirRootExternal, mFileName)  
    mp.Play  
End Sub  
  
Sub btnStopPlay_Click  
    mp.Stop  
    mp_Complete  
End Sub  
  
Sub mp_Complete  
    Log("PlaybackComplete")  
    timer1.Enabled = False  
    btnStartRecording.Enabled = True  
End Sub  
  
Sub StartBluetoothSco()  
   Dim r As Reflector  
  
   r.Target = r.GetContext  
  
   r.Target = r.RunMethod2("getSystemService", "audio", "java.lang.String")  
  
   r.RunMethod("startBluetoothSco")  
  
  
  
   
  
End Sub  
  
Sub stopBluetoothSco()  
   
    Dim r As Reflector  
    r.Target = r.GetContext  
    r.Target = r.RunMethod2("getSystemService", "audio", "java.lang.String")  
    r.RunMethod("stopBluetoothSco")  
     
  
End Sub
```

  
  
Those looking for sound recording code through Bluetooth. This code works  
  
and this Permission  
  
AddPermission(android.permission.MODIFY\_AUDIO\_SETTINGS)  
AddPermission(android.permission.BLUETOOTH)  
AddPermission(android.permission.BLUETOOTH\_ADMIN)  
AddPermission(android.permission.BROADCAST\_STICKY)  
  
مجید دودانگه قیدار