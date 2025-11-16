### Fetch downloader by somed3v3loper
### 11/15/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/169321/)

I have done this as a job but didn't get paid (I don't know why and didn't get a response either ).  
It is basic wrapper for this github project <https://github.com/tonyofrancis/Fetch>  
  
Simple sample :  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: Fetch Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
    #MultiDex : true  
    #AdditionalJar : androidx.room:room-runtime-android  
  
    #AdditionalJar : androidx.arch.core:core-runtime  
    #AdditionalJar : androidx.sqlite:sqlite-android  
    #AdditionalJar : org.jetbrains.kotlinx-kotlinx-coroutines-android  
    #AdditionalJar : org.jetbrains.kotlinx-kotlinx-coroutines-core-jvm  
  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
    Dim fetc As fetch  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    Dim doid As Int  
    Private Label1 As Label  
    Private Label5 As Label  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    fetc.Initialize("fetch",3)     
          
    Dim req As Request  
    Log(Starter.savefolder)  
    req.Initialize("https://la.speedtest.clouvider.net/1g.bin",File.Combine(Starter.savefolder,"1GB.zip"))  
    req.Priority=req.PRIORITY_HIGH  
    req.NetworkType=req.NETWORKTYPE_ALL  
  
      
    doid=req.Id  
    Log(doid)  
  
    fetc.enqueue(req)  
      
End Sub  
  
Sub fetch_errenqueue(err As Object)  
    Log(err)  
End Sub  
  
Sub fetch_onwaitingnetwork(  download As Download)  
    Log("_onwaitingnetwork "&download )  
End Sub  
Sub fetch_onadded(  download As Download)  
    Log("_onadded "&download )  
      
End Sub  
  
Sub fetch_onerror(  download As Download,  err As Object)  
    Log("_onerror "&download & " " &  err)  
End Sub  
Sub fetch_onqueued(  download As Download,  waitingOnNetwork As Boolean)  
        Log("fetch_onqueued "&download &" "& waitingOnNetwork)  
End Sub  
Sub fetch_onprogress(  download As Download,etaInMilliSeconds As Long,downloadedBytesPerSecond As Long)  
    Log(download &" fetch_onprogress" & etaInMilliSeconds& " "&downloadedBytesPerSecond )  
    Label1.Text=Floor(download.DownloadedBytesPerSecond/1024)  
    Label5.Text = (download.EtaInMilliSeconds/1000)  
    Log(download.Status)  
End Sub  
Sub fetch_ondownloadblockupdated(  download As Download,downloadBlock As Object,totalBlocks As Int)  
    Log(download &" fetch_ondownloadblockupdated"& downloadBlock&" " & totalBlocks)  
  
End Sub  
  
Sub fetch_oncompleted(  download As Download)  
    Log(download &" fetch_oncompleted" )  
    Label1.Text="Done"  
    Label5.Text="Done"  
End Sub  
Sub fetch_onpaused(  download As Download)  
    Log(download &" fetch_onpaused" )  
End Sub  
  
Sub fetch_onresumed(  download As Download)  
    Log(download &" fetch_onresumed" )  
End Sub  
  
Sub fetch_oncancelled(  download As Download)  
    Log(download &" fetch_oncancelled" )  
End Sub  
Sub fetch_onremoved(  download As Download)  
    Log(download &" fetch_onremoved" )  
End Sub  
Sub fetch_ondeleted(  download As Download)  
    Log(download &" fetch_ondeleted" )  
End Sub  
  
  
Sub fetch_enqueue(req As Request)  
    Log(req.Id)  
      
End Sub  
Sub Activity_Resume  
  
        If fetc<>Null Then  
            fetc.addListener  
        End If  
          
  
      
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
    If fetc.isClosed=False Then  
        fetc.removeListener  
'        fetc.close  
    End If  
      
  
End Sub  
  
Sub Button1_Click  
    fetc.getDownload(doid)  
    wait For fetch_gotdownload(down As Download)  
    Log(down.Status)  
  
End Sub
```

  
  
Manifest  

```B4X
AddPermission(android.permission.WRITE_EXTERNAL_STORAGE)  
AddPermission(android.permission.READ_EXTERNAL_STORAGE)  
AddPermission(android.permission.ACCESS_NETWORK_STATE)
```

  
  
  
Dependencies from original github project or from here :   
[MEDIA=googledrive]1y6pC59lhSqSAzRkpz897qlR06br0KaIK[/MEDIA]