###  RangeDownloader - resumable downloads by Erel
### 08/15/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/133370/)

![](https://www.b4x.com/android/forum/attachments/117742)  
  
RangeDownloader uses http range feature to download the file in chunks. It will resume the download from the previous point, even if the app was previously killed.  
It first sends a HEAD request to test whether this feature is supported.  
Note that you need to delete the target file if you want to restart the download.  
  
Supported by: B4A, B4i and B4J.  
  
Usage example:  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private Downloader As RangeDownloader  
    Private AnotherProgressBar1 As AnotherProgressBar 'XUI Views  
    Private url As String = "https://sabnzbd.org/tests/internetspeed/20MB.bin"  
    Private Label1 As B4XView  
End Sub  
  
Public Sub Initialize  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    xui.SetDataFolder("Download large file")  
    Downloader.Initialize  
    Dim tracker As RangeDownloadTracker = Downloader.CreateTracker  
    Track(tracker)  
    Wait For (Downloader.Download(xui.DefaultFolder, "test2.zip", url, tracker)) Complete (Success As Boolean)  
    Log("Complete, success = " & Success)  
    AnotherProgressBar1.Visible = False  
End Sub  
  
Private Sub Track (Tracker As RangeDownloadTracker)  
    Do While Tracker.Completed = False  
        Sleep(100)  
        Label1.Text = $"$1.2{Tracker.CurrentLength / 1024 / 1024}MB / $1.2{Tracker.TotalLength / 1024 / 1024}MB"$  
        AnotherProgressBar1.Value = Tracker.CurrentLength / Tracker.TotalLength * 100  
    Loop  
End Sub
```