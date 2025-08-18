### Share data from your app with ActivityViewController by Erel
### 08/26/2021
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/73159/)

![](https://www.b4x.com/android/forum/attachments/50146)  
  
ActivityViewController allows the user to share data from your app using the standard share dialog.  
It was added in [iPhone library v2.00](https://www.b4x.com/android/forum/threads/updates-to-internal-libraries.48179/page-3#post-464795).  
  
Using it is simple. You need to initialize AVC with one or more items that you want to share and call show:  

```B4X
Sub Page1_Click  
   Dim avc As ActivityViewController  
   avc.Initialize("avc", Array("Some text to share together with an image", LoadBitmap(File.DirAssets, "smiley.png")))  
   avc.Show(Page1, Page1.RootPanel) 'Second parameter is relevant for iPad only. The arrow will point to the view.  
   'avc.Show(B4XPages.GetNativeParent(Me), Root) '<—- B4XPages equivalent code  
   Wait For avc_Complete (Success As Boolean, ActivityType As String)  
   Log($"Success: ${Success}, ActivityType: ${ActivityType}"$)  
End Sub
```

  
  
You can also share files with ActivityViewController.  
  

```B4X
Sub Page1_Click  
   Dim avc As ActivityViewController  
   avc.Initialize("avc", Array(CreateFileUrl(File.DirLibrary, "1.pdf")))  
   avc.Show(Page1, Page1.RootPanel)  
End Sub  
  
'Doesn't work with assets files. You must first copy them.  
Sub CreateFileUrl (Dir As String, FileName As String) As Object  
   Dim no As NativeObject  
   no = no.Initialize("NSURL").RunMethod("fileURLWithPath:", Array(File.Combine(Dir, FileName)))  
   Return no  
End Sub  
  
Sub avc_Complete (Success As Boolean, ActivityType As String)  
   Log($"Success: ${Success}, ActivityType: ${ActivityType}"$)  
End Sub
```