### Upload files with WebView by Erel
### 06/09/2022
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/98623/)

Code requires Android 5+  
  
1. Set a custom WebViewChromeClient. It is implemented with inline Java code.  
  
2. The ShowFile\_Chooser event is raised when the user clicks on a "browse" button.  
  
3. You need to get the file URI with FileProvider and call SendResult.  
Example based on ContentChooser.  

```B4X
Sub ShowFile_Chooser (FilePathCallback As Object, FileChooserParams As Object)  
   cc.Initialize("CC")  
   cc.Show("*/*", "Choose File")  
   Wait For CC_Result (Success As Boolean, Dir As String, FileName As String)  
   Dim jo As JavaObject = Me  
   If Success Then  
       Log(FileName)  
       File.Copy(Dir, FileName, Provider.SharedFolder, "TempFile")  
       jo.RunMethod("SendResult", Array(Provider.GetFileUri("TempFile"), FilePathCallback))  
   Else  
       jo.RunMethod("SendResult", Array(Null, FilePathCallback))  
   End If  
End Sub
```

  
  
Project is attached. Don't miss the manifest editor entries that are required for FileProvider.  
  
Example of requesting the Geolocation permission: <https://www.b4x.com/android/forum/threads/webviewextra-2-2-enable-geolocation.114147/post-712994>