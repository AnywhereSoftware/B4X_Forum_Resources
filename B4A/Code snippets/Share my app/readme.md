### Share my app by AlfaizDev
### 04/26/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/140137/)

Share my app  
You succeeded with me I said I will share it with you  
  

```B4X
Dim JsourceDir As JavaObject  
    JsourceDir.InitializeContext  
    Dim JMsourceDir As JavaObject = JsourceDir.RunMethod("getPackageManager", Null)  
    Dim ApplicationInfo As JavaObject = JMsourceDir.RunMethod("getApplicationInfo", Array(Application.PackageName, 0))  
     
    Dim sourceDir As String=ApplicationInfo.GetField("sourceDir")  
     
    For Each FindNameAppAPK As String In Regex.split("/", sourceDir)  
    '    Log(FindNameAppAPK)  
    Next  
     
    Dim Path As String  
    Dim NewNameAppAPK As String= Application.LabelName & ".apk"  
    Dim SplitsourceDir() As String = Regex.Split(FindNameAppAPK,sourceDir)  
    Path=(SplitsourceDir(0))  
    'Log(Path)  
  
    'Return  
    File.Copy(Path, FindNameAppAPK, Provider.SharedFolder, NewNameAppAPK)  
    Dim in As Intent  
    in.Initialize(in.ACTION_SEND, "")  
    in.SetType("text/plain")  
    in.PutExtra("android.intent.extra.STREAM", Provider.GetFileUri(NewNameAppAPK))  
    in.Flags = 1 'FLAG_GRANT_READ_URI_PERMISSION  
    StartActivity(in)
```

  
  
**Using FileProvider**