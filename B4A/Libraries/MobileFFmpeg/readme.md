### MobileFFmpeg by CaptKronos
### 03/04/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/128310/)

This is a small class that shows how to call from B4A the FFMPEG wrapper created by Taner Sener: <https://github.com/tanersener/mobile-ffmpeg>. It seems to work with the latest SDK which apparently causes a problem with this FFMPEG library: <https://www.b4x.com/android/forum/threads/ffmpeg-library-for-b4x-with-inline-java-only.108905/#post-789281>. The class uses the JavaObject library.  
  
Taner has provided packages with different FFMPEG capabilities (and file sizes) so you can use the one that best meets your requirements. I have only used and tested the min package (<https://github.com/tanersener/mobile-ffmpeg/releases/download/v4.4/mobile-ffmpeg-min-4.4.aar>). Copy the required aar file to the Additional Libraries folder and make sure you use a "#AdditionalJar" line that reflects the name of the package you are using.  
  
My class has only exposed some of Taner's wrapper but it should be straightforward to add anything that I have not covered. The following is an example of using the class. It adds an audio track (audio.mp3) to a video (video.mp4). Check the logs for the output. I have also attached the project which includes this code. You will need to add video.mp4 and music.mp3 to the project for it to work.  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4A Example  
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
  
#AdditionalJar: mobile-ffmpeg-min-4.4.LTS.aar  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private aMobileFFMPEG As mobileFFmpeg  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    aMobileFFMPEG.Initialize(Me, "FFMPEG")  
    Dim levels() As Object=aMobileFFMPEG.GetLogLevels  
    Log("Logging levels:")  
    For Each aLevel As Object In levels  
        Log(aLevel)  
    Next  
    Log("Using log level: AV_LOG_WARNING")  
    'if you want to see some log output, set to AV_LOG_INFO or higher  
    aMobileFFMPEG.setLogLevelByConstant("AV_LOG_WARNING")  
    aMobileFFMPEG.enableLogCallback  
    aMobileFFMPEG.enableStatisticsCallback  
    Dim abiName As String=aMobileFFMPEG.GetAbi 'ignore  
    Log("ABI: " & abiName)  
    File.Copy(File.DirAssets, "video.mp4", File.DirInternal, "video.mp4")  
    File.Copy(File.DirAssets, "music.mp3", File.DirInternal, "music.mp3")  
    'adds an audio track to a video  
    Dim theCmd As String="-y -i " & File.Combine(File.DirInternal, "video.mp4") & " -i " & File.Combine(File.DirInternal, "music.mp3") & " -c copy " & File.Combine(File.DirInternal, "videomusic.mp4")  
    Dim id As Long=aMobileFFMPEG.ExecuteAsync(Regex.Split(" ",theCmd))  
    Log("Running with Execution Id: " & id)  
End Sub  
  
Sub FFMPEG_Event(id As Long, retCode As Int)  
    Log("Callback with Execution Id: " & id & " and return code: " & retCode)  
    If File.Exists(File.DirInternal, "videomusic.mp4") Then  
        Log("videomusic.mp4 file size: " & File.Size(File.DirInternal, "videomusic.mp4"))  
    End If  
    MsgboxAsync("Check the logs", "Mobile-FFMPEG test")  
End Sub  
  
Sub FFMPEG_Log(msg As String)  
    Log("log: " & msg)  
End Sub  
  
Sub FFMPEG_Statistics(msg As String)  
    Log("Statistics: " & msg)  
End Sub
```