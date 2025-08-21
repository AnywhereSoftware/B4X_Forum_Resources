### VideoRecordApp with FileProvider by Erel
### 01/07/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/101248/)

Requires Audio library v1.70+: <https://www.b4x.com/android/forum/threads/updates-to-internal-libraries.59340/#post-635852>  
  
Based on FileProvider example and class: [Sharing files from your app with File Provider](https://www.b4x.com/android/forum/threads/70458)  
  

```B4X
video.Initialize("video") 'video is a process global VideoRecordApp variable.  
Dim folder As String = Starter.Provider.SharedFolder  
Dim FileName As String = "1.mp4"  
video.Record3(folder, FileName, -1, Starter.Provider.GetFileUri(FileName))  
Wait For Video_RecordComplete (Success As Boolean)  
If Success Then  
   'Example of playing the recorded video  
   Dim in As Intent  
   in.Initialize(in.ACTION_VIEW, "")  
   Starter.Provider.SetFileUriAsIntentData(in, FileName)  
   in.SetType("video/*")  
   StartActivity(in)  
End If
```