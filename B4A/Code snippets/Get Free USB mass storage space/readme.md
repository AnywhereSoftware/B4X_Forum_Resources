### Get Free USB mass storage space by Blueforcer
### 04/19/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/160596/)

This prints all informations about the attached USB storage.  
  

```B4X
AddPermission(android.permission.READ_EXTERNAL_STORAGE)  
AddReceiverText(USBService,  
<intent-filter>  
    <action android:name="android.intent.action.MEDIA_MOUNTED" />  
    <data android:scheme="file"/>  
</intent-filter>)
```

  
  

```B4X
Sub Service_Start (StartingIntent As Intent)  
    If(StartingIntent.Action = "android.intent.action.MEDIA_MOUNTED") Then  
        Log("Media mounted:")  
   
        Dim jo As JavaObject = StartingIntent  
        Dim StorageVolume As JavaObject = jo.RunMethod("getParcelableExtra", Array As Object("android.os.storage.extra.STORAGE_VOLUME"))  
        Dim VolumePath As String = StorageVolume.RunMethod("getPath", Null)  
        Log("Volume ID: " & StorageVolume.RunMethod("getUuid", Null))  
        Log("Volume State: " & StorageVolume.RunMethod("getState", Null))  
        Log("Volume Path: " & VolumePath)  
   
        Dim context As JavaObject  
        context.InitializeContext  
   
        Log("Volume label: " & StorageVolume.RunMethodJO("getDescription", Array As Object(context)))  
   
        Dim f As JavaObject  
        f.InitializeNewInstance("java.io.File", Array As Object(VolumePath))  
        Dim TotalSpace As Long = f.RunMethod("getTotalSpace", Null)  
        Dim FreeSpace As Long = f.RunMethod("getFreeSpace", Null)  
      
        Log("Total Space: " & FormatFileSize(TotalSpace))  
        Log("Free Space: " & FormatFileSize(FreeSpace))  
    End If  
    Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)  
End Sub  
  
public Sub FormatFileSize(Bytes As Float) As String  
    Private Unit() As String = Array As String(" Byte", " KB", " MB", " GB", " TB", " PB", " EB", " ZB", " YB")  
    If Bytes = 0 Then  
        Return "0 Bytes"  
    Else  
        Private Po, Si As Double  
        Private I As Int  
        Bytes = Abs(Bytes)  
        I = Floor(Logarithm(Bytes, 1024))  
        Po = Power(1024, I)  
        Si = Bytes / Po  
        Return NumberFormat(Si, 1, 3) & Unit(I)  
    End If  
End Sub
```

  
  
Result:  

```B4X
Media mounted:  
Volume ID: 5DC8-9420  
Volume State: mounted  
Volume Path: /storage/5DC8-9420  
Volume label: (String) Transcend  
Total Space: 3.639 GB  
Free Space: 1.689 GB
```