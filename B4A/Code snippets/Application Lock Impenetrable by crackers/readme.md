### Application Lock Impenetrable by crackers by Hamied Abou Hulaikah
### 09/19/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/143021/)

For paid app only.  
Two brains are better than one, three are better than two and so on.  
I implement this code to protect my apps from illegal uses, crackers and hackers who try to unlock my apps functionality without paying me or my agreement.  
My apps are time based, so time is very important flag in my calculation.  
I decide to share it with you, to explore its weakness and increase its complexity and make it impenetrable method used by all of us in our apps.  
Also to extend it to cover non-time based apps protection.  
Let's start:  
 In **manifest** file editor, add this code:  

```B4X
AddReceiverText(applicationlocker,  
    <intent-filter>  
        <action android:name="android.intent.action.TIME_SET"/>  
        <action android:name="android.intent.action.TIMEZONE_CHANGED"/>  
        <action android:name="android.intent.action.TIME_CHANGED"/>  
    </intent-filter>  
)
```

  
Create new service, I named it **applicationlocker** as the following:  

```B4X
#Region  Service Attributes  
    #StartAtBoot: True  
      
#End Region  
  
' Libraries used: ByteConverter, JavaObject, Encryption and DateUtils  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
  
End Sub  
  
Sub Service_Create  
  
End Sub  
  
Sub Service_Start (StartingIntent As Intent)  
    Service.StopAutomaticForeground 'Call this when the background task completes (if there is one)  
  
    If StartingIntent.Action="android.intent.action.TIMEZONE_CHANGED" Or StartingIntent.Action="android.intent.action.TIME_CHANGED" Or StartingIntent.Action="android.intent.action.TIME_SET" Then  
        File.Delete(File.DirInternal,"system")  
    End If  
      
End Sub  
  
Sub Service_Destroy  
  
End Sub  
  
'check app use is legal  
Public Sub islegal() As Boolean  
      
    '1- check if system file exist  
    If (File.Exists(File.DirInternal,"system"))=False Then Return False  
      
    '2- check if file content match the file creation time - not created/copied by illegal user  
    Dim filecontent As String=File.ReadString(File.DirInternal,"system")  
    Dim filecreationtime As Long = GetCreationTime(File.DirInternal,"system")  
    If filecontent<>getMD5(filecreationtime) Then  
        File.Delete(File.DirInternal,"system")  
        Return False  
    End If  
      
    '3- check if usetime ellapsed against device datetime  
    Dim p As Period=DateUtils.PeriodBetween(filecreationtime,DateTime.Now)  
    If p.Months>=1 Then 'used time in months, you can change it according your needs  
        File.Delete(File.DirInternal,"system")  
        Return False  
    End If  
      
    '4- check if device datetime changed  
    'it will be triggered when change happen and delete "system" file in DirInternal  
    'see Service_Start  
      
    '5- check last/maximum transaction date in your app database if time diff larger than legal time  
    'write your code here .. return False if time consumed  
      
    Return True  
      
End Sub  
  
'should be called once - example when app purchase or subscription payment done  
Public Sub createlockfile  
    If File.Exists(File.DirInternal,"system") Then  
        File.Delete(File.DirInternal,"system")  
        Sleep(200)  
        File.WriteString(File.DirInternal,"system",getMD5(GetCreationTime(File.DirInternal,"system")))  
    Else  
        File.WriteString(File.DirInternal,"system",getMD5(GetCreationTime(File.DirInternal,"system")))  
    End If  
End Sub  
  
'Android 26+ by @Erel  
Sub GetCreationTime (Dir As String, FileName As String) As Long  
    Dim Files As JavaObject  
    Files.InitializeStatic("java.nio.file.Files")  
    Dim FileSystems As JavaObject  
    Dim FileSystem As JavaObject = FileSystems.InitializeStatic("java.nio.file.FileSystems").RunMethod("getDefault", Null)  
    Dim Path As JavaObject = FileSystem.RunMethod("getPath", Array(File.Combine(Dir, FileName), Array As String()))  
    Dim BasicFileAttributes As JavaObject  
    BasicFileAttributes.InitializeStatic("java.nio.file.attribute.BasicFileAttributes")  
    Dim LinkOptions As JavaObject  
    LinkOptions.InitializeArray("java.nio.file.LinkOption", Array())  
    Return Files.RunMethodJO("getAttribute", Array(Path, "creationTime", LinkOptions)).RunMethod("toMillis", Null)  
End Sub  
  
Sub getMD5(str As String) As String  
    Dim md As MessageDigest  
    Dim ByteCon As ByteConverter  
    Dim md5hash() As Byte  
    md5hash = md.GetMessageDigest(str.GetBytes("UTF8"),"MD5")  
    Dim md5string As String  
    md5string = ByteCon.HexFromBytes(md5hash)  
    Return md5string  
End Sub
```

  
**Usage:**  

- Call **createlockfile** function **once** when:

- Your app is paid from the beginning (in first run), so the lock file should be created
- In-app purchase or subscription success

- Check **islegal** function everytime you want to check the user is legal
- Note that islegal function step 3 can be modified according your need, in my example I'm assuming time period one month.

**What crackers possible tries:**  

- Delete dirinternal "system" file -> the **islegal** function step 1 disable app use
- Clone "system" file from device to device -> the **islegal** function step 2 disable app use
- If allowed time consumed -> the **islegal** function step 3 disable app use
- Change device datetime -> **Service\_Start** disable app use
- Clone the entire device (including our app) to another device -> that is mean everything will **resumed** from stopped point in previous device -> **useless** cracker trick

  
What other possible tricks crackers think?  
Discussion of this scenario and increasing its strength is useful for all of us and making this code anti-hacker-proven method.