### Internet / Website wait for connection and keep trying X times by scottie
### 08/24/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/133690/)

```B4X
#Region  Project Attributes  
    #ApplicationLabel: Wait4Internet  
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
  
  
'Scottie -  wait4internet code  
'  
'I needed a way to Attempt to connect to a website or internet  
'and WAIT until I suscessfully connect or 20 tries  
'  
'the 'wait for'  
'resumable will continue exectution and ALSO wait for jobdone each time its called.  
'thats why I use a timer to check  
'this code uses a timer to check every 2 seconds and 4 connection attempts  
'will finally give up in 20 attempts.  
'  
'in designer create:  edittext1(multi line), button1, button2  
'  
'remember to add to manifest if you plan to use cleartext  
' SetApplicationAttribute(android:usesCleartextTraffic, "true")  
'  
'update:  this code was for a program that runs once and closes.  
'                  Timer.Initialize("Timer",2000)  would normally not be in a button  
  
   
  
  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
      Dim Timer As Timer    
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Private EditText1 As EditText   'for log  
    Dim Connected As Boolean  
    Dim Attempts As Int              '# of attempts to try  
    Dim URL As String = "http://www.google.com"  'website to connect/test  
   
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
   Timer.Initialize("Timer",2000) '2 seconds  
    Button1_Click 'at startup go ahead and test internet  
End Sub  
  
Sub Activity_Resume  
End Sub  
Sub Activity_Pause (UserClosed As Boolean)  
End Sub  
  
  
Sub add2log(a As String)  
    EditText1.Text=EditText1.Text & a & CRLF  
    EditText1.SelectionStart = EditText1.Text.Length 'scroll to end of textbox  
End Sub  
  
  
  
  
'this resumable will continue exectution and ALSO wait for jobdone each time its called.  
' thats why I use a timer to check  
Sub TestMyServer  
    Dim job1 As HttpJob  
    Dim a As String  
  
    add2log("TMS: Connecting……")  
    job1.Initialize("Job1", Me)  
    a = job1.Download (URL) 'website to connect to / test internet connection  
  
    Wait For (job1) JobDone(job1 As HttpJob)  
   
    If job1.Success Then  
        a=job1.GetString  
        add2log("TMS: Connected: " & a)  
        If a <> "" Then Connected=True 'if a isn't blank then I know we connected and internet works  
    Else  
        'if you never connect this section will show up at the end 4 times  
    End If  
   
    job1.Release  
  
End Sub  
  
  
  
  
Sub Timer_Tick   'every 2 seconds  
Attempts=Attempts+1  
  
If Attempts=5 Or Attempts=10 Or Attempts=15 Then 'need to re connect to fully test  
     TestMyServer  
End If  
  
If Attempts >= 20 Then 'try 20 times to connect  
    Timer.Enabled=False  
    add2log(Attempts & ": I gave up. couldn't connect")  
End If  
  
If Connected=False Then  
    add2log(Attempts & ": Did not connect yet")  
Else  
    add2log(Attempts & ": Connected")  
    Timer.Enabled=False  'turn off timer  
    'sub to continue cuz we have internet  remember connected = true  
End If  
  
End Sub  
  
  
  
Sub Button1_Click  
   EditText1.Text=""    'Reset  
   Connected=False        'Reset  
   Attempts=0            'Reset  
 '  Timer.Initialize("Timer",2000) '2 seconds  
   Timer.Enabled=True                 'turn on timer  
   TestMyServer                   'connect to server  
End Sub  
  
  
Private Sub Button2_Click  
    Activity.Finish  
End Sub
```