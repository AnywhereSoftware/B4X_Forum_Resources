### Class media by spsp
### 06/10/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/131456/)

Hi,  
  
An easy way to take/record/choose photo/video/audio with this small class (clMedia.bas).  
  
No permission needed  
  
It uses intents to call default app.  
  
3 constants for media type  
cPhoto = 0  
cVideo=1  
cAudio=2  
  
2 constants for origin  
cNew=0  
cChoose=1  
  
1 method to call with 2 parameters (media type, origin)  
media(cPhoto,cNew)  
  
The 2 properties DirName and FileName contains the path to the media  
  

```B4X
    Dim m As clMedia  
    m.Initialize(Me)  
    wait for (m.media(m.cPhoto,m.cNew)) complete (aresult As Boolean)  
    If aresult Then  
        'copy the media in the internal app folder  
        File.Copy(m.DirName,m.FileName,File.DirInternal,"file")  
        Log("Media size : " & File.Size(File.DirInternal,"file"))  
    End If
```

  
  
Add this lines to your manifest for the file provider  

```B4X
'file provider  
AddApplicationText(  
  <provider  
  android:name="android.support.v4.content.FileProvider"  
  android:authorities="$PACKAGE$.provider"  
  android:exported="false"  
  android:grantUriPermissions="true">  
  <meta-data  
  android:name="android.support.FILE_PROVIDER_PATHS"  
  android:resource="@xml/provider_paths"/>  
  </provider>  
)  
CreateResource(xml, provider_paths,  
   <files-path name="name" path="shared" />  
)
```

  
  
A demo project is attached (media.zip)