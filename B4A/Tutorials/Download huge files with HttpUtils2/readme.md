### Download huge files with HttpUtils2 by Erel
### 07/25/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/30220/)

**Better to use: <https://www.b4x.com/android/forum/threads/simple-progress-http-download.127214/#post-796463>**  
  
The attached project includes a slightly modified version of HttpUtils2 and a new service named DownloadService. The purpose of DownloadService is to make it simple to download files of any size.  
  
![](http://www.b4x.com/basic4android/images/SS-2013-06-13_17.34.35.png)  
  
It is very simple to use this service.  
  
Start a download:  

```B4X
Sub btnDownload_Click  
   Dim dd As DownloadData  
   dd.url = link1 '<— download link  
   dd.EventName = "dd"  
   dd.Target = Me  
   CallSubDelayed2(DownloadService, "StartDownload", dd)  
End Sub
```

  
  
Handle the events:  

```B4X
Sub dd_Progress(Progress As Long, Total As Long)  
   ProgressBar1.Progress = Progress / Total * 100  
   Label1.Text = NumberFormat(Progress / 1024, 0, 0) & "KB / " & _  
      NumberFormat(Total / 1024, 0, 0) & "KB"  
End Sub  
  
Sub dd_Complete(Job As HttpJob)  
   Log("Job completed: " & Job.Success)  
   Job.Release  
End Sub
```

  
  
Cancel a download:  

```B4X
Sub btnCancel_Click  
   CallSubDelayed2(DownloadService, "CancelDownload", link1)  
End Sub
```

  
  
DownloadService allows you to download multiple files at once and track the progress of each one of them.  
  
The following libraries are required:  
OkHttp  
StringUtils  
Phone (required in order to acquire a partial lock during the download)  
RandomAccessFile  
  
As this is a modified version of OkHttpUtils2 you should not reference OkHttpUtils2 library. You should instead add the three modules from the attached project. Note that the modified code is in Sub hc\_ResponseSuccess.