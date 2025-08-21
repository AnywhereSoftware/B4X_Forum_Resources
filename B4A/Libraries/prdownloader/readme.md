### prdownloader by somed3v3loper
### 04/22/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/116688/)

Hi   
I wrapped this a while ago but thought it might be helpful to someone else so here it is   
**prdownloader**  
  
**Author:** SMM  
**Version:** 0.01  

- **PRDownloaderConfig**

- **Functions:**

- **Initialize** (DatabaseEnabled As Boolean, ReadTimeout As Int, ConnectTimeout As Int)
- **IsInitialized** As Boolean

- **prdownloader**

- **Fields:**

- **CANCELLED** As String
- **COMPLETED** As String
- **PAUSED** As String
- **QUEUED** As String
- **RUNNING** As String
- **UNKNOWN** As String

- **Functions:**

- **cancel** (downloadId As Int)
- **cancelAll**
- **cleanUp** (days As Int)
- **download** (url As String, dirPath As String, fileName As String) As Int
- **getStatus** (downloadId As Int) As String
- **Initialize** (EventName As String, config As PRDownloaderConfig)
- **pause** (downloadId As Int)
- **resume** (downloadId As Int)

  
  

```B4X
    Dim ownloader As prdownloader  
    Dim config As PRDownloaderConfig  
    config.Initialize(True,30000,30000)  
    downloader.Initialize("eventname",config)  
      
    fixdownloader.download( url,localpath,"filename")
```

  
available events  

```B4X
Sub eventname_onprogress( totalBytes As Long, currentBytes As Long)  
  
end sub  
Sub eventname_onerror(err As Object)  
  
end sub  
Sub eventname_ondownloadcomplete  
  
end sub
```