### InterApp communication to "Easy Barcode Scanner" by Wong Ka Chun
### 06/21/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/131827/)

Hi,  
  
I recently found an barcode scanner app which can easily be "communicated" with any custom app.  
Since I am developing warehouse apps in which it must process products' barcodes, I thus make use of this barcode scanner app to get the barcode string.  
  
Demo: [MEDIA=youtube]0z4qCPzoqvE[/MEDIA]  
  
libraries used: JavaObject, Phone and Audio  
  
The code snippet is quite straight-forward:  

```B4X
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Private Button1 As Button  
    Private label1 As Label  
    Private ion As Object  
    Private lst As List  
    Private beep As Beeper  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    'Activity.LoadLayout("Layout1")  
    beep.Initialize(300, 1000)  
    If Button1.IsInitialized = False Then  
        Button1.Initialize("Button1")  
        Activity.AddView(Button1, 10dip,10dip,100dip,100dip)  
        Button1.Text = "Click"  
    End If  
    If label1.IsInitialized = False Then  
        label1.Initialize("Label1")  
        Activity.AddView(label1, 10dip,120dip, 90%x, 90%y - 120dip)  
        label1.SingleLine = False  
        label1.TextSize = 20  
        label1.TextColor = Colors.Black  
        label1.Text = ""        
    End If  
    If lst.IsInitialized = False Then  
        lst.Initialize  
    End If  
End Sub  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
Sub Button1_Click    
    Dim isappfound As Boolean = isPackageInstalled("org.magiclen.barcodescanner")  
    If isappfound = False Then  
        MsgboxAsync("please install Easy Barcode Scanner first!", "No barcode app found")  
        Return  
    End If    
    ShowPicker  
End Sub  
  
Sub ShowPicker  
    Dim i As Intent  
    i.Initialize("org.magiclen.barcodescanner.SCAN", "")  
    i.PutExtra("SCAN_MODE", "SCAN_MODE")  
    StartActivityForResult(i)  
End Sub  
  
Sub ion_Event (MethodName As String, Args() As Object) As Object  
    If -1 = Args(0) Then 'resultCode = RESULT_OK  
        beep.beep  
        Dim i As Intent = Args(1)  
        Dim resulttext As String = i.GetExtra("SCAN_RESULT")  
        Dim resulttype As String = i.GetExtra("code_type")  
'        Dim jo As JavaObject = i  
'        Dim uri As String = jo.RunMethod("getParcelableExtra", _  
'               Array As Object("android.intent.extra.ringtone.PICKED_URI"))  
        LogColor("scanned text: "&resulttext, Colors.Blue)        
        LogColor("scanned type: " &resulttype, Colors.Magenta)  
        lst.Add(resulttext & " : " & resulttype)  
        If label1.Text = "" Then            
            label1.Text = $"${lst.Size}. ${resulttext}:${resulttype}"$  
        Else  
            label1.Text = label1.Text & CRLF & $"${lst.Size}. ${resulttext}:${resulttype}"$  
        End If        
    End If  
    Return Null  
End Sub  
  
Sub StartActivityForResult(i As Intent)  
    Dim jo As JavaObject = GetBA  
    ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)  
    jo.RunMethod("startActivityForResult", Array As Object(ion, i))  
End Sub  
  
Sub GetBA As Object  
    'Dim jo As JavaObject = Me  
    'Return jo.RunMethod("getBA", Null)  
    Dim jo As JavaObject  
    Dim cls As String = Me  
    cls = cls.SubString("class ".Length)  
    jo.InitializeStatic(cls)  
    Return jo.GetField("processBA")  
End Sub  
  
Public Sub isPackageInstalled(packagename As String) As Boolean  
    Dim isFound As Boolean = False  
    Dim pm As PackageManager  
    Dim packages As List  
    packages = pm.GetInstalledPackages  
    For i = 0 To packages.Size - 1  
        If packages.Get(i) = packagename Then  
            Log("Good! Package: " & packages.Get(i) & " is found!")  
            isFound = True  
            Exit  
        End If  
    Next  
    Return isFound  
End Sub
```

  
  
P.S.  
App download link: <https://play.google.com/store/apps/details?id=org.magiclen.barcodescanner&hl=en_US&gl=US>  
App source code: <https://github.com/magiclen/Easy-Barcode-Scanner>