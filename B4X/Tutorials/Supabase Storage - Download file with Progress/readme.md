###  Supabase Storage - Download file with Progress by Alexander Stolte
### 09/11/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/151210/)

<https://www.b4x.com/android/forum/threads/b4x-supabase-the-open-source-firebase-alternative.149855/>  
  
This is a very simple tutorial on how to download a file and show the progress in a progressbar.  
  
![](https://www.b4x.com/android/forum/attachments/145757)  
With my small image there is not much progress, it makes more sense to use this function with larger files.  

```B4X
#If B4J  
Private Sub xlbl_DownloadFile_MouseClicked (EventData As MouseEvent)  
#Else  
Private Sub xlbl_DownloadFile_Click  
#End If  
      
    xui.SetDataFolder("supabase")  
    Wait For (xSupabase.Storage.DownloadFileProgress("Avatar","test.png",Me,"DownloadProfileImage",xui.DefaultFolder).Execute) Complete (StorageFile As SupabaseStorageFile)  
    If StorageFile.Error.Success Then  
        Log($"File ${"test.jpg"} successfully downloaded "$)  
        B4XImageView1.SetBitmap(xSupabase.Storage.BytesToImage(StorageFile.FileBody))  
        If File.Exists(xui.DefaultFolder,"test.png") Then File.Delete(xui.DefaultFolder,"test.png") 'Clean the download path, or do what ever you want  
    Else  
        Log("Error: " & StorageFile.Error.ErrorMessage)  
    End If  
      
End Sub  
  
  
Private Sub DownloadProfileImage_RangeDownloadTracker(Tracker As SupabaseRangeDownloadTracker)  
    If Tracker.CurrentLength > 0 Then  
        Log($"$1.2{Tracker.CurrentLength / 1024 / 1024}MB / $1.2{Tracker.TotalLength / 1024 / 1024}MB"$)  
        AnotherProgressBar1.Value = Tracker.CurrentLength / Tracker.TotalLength * 100  
    End If  
End Sub
```