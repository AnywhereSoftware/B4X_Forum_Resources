### VideoPlayer - Replaces VideoView by Erel
### 03/27/2022
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/86643/)

iUI8 library [v1.50](https://www.b4x.com/android/forum/threads/updates-to-internal-libraries.48179/#post-548505) includes a new VideoPlayer view. It replaces VideoView from iMedia library.  
  
Apple has deprecated the API that VideoView was based on. VideoPlayer is based on the newer AVPlayerViewController.  
  
It is implemented as a custom view. Using it is simple.  
  
1. Add a reference to iUI8.  
2. Set #MinVersion: 8  
3. Add VideoPlayer with the designer.  
4. Load a video.  
5. Wait for the Ready event.  
6. Optionally call Play to start playing automatically.  
  

```B4X
Private Sub Application_Start (Nav As NavigationController)  
   NavControl = Nav  
   Page1.Initialize("Page1")  
   Page1.RootPanel.LoadLayout("1")  
   NavControl.ShowPage(Page1)  
   VideoPlayer1.LoadVideo(File.DirAssets, "big_buck_bunny.mp4")  
   Wait For VideoPlayer1_Ready (Success As Boolean)  
   If Success Then  
     VideoPlayer1.Play 'to start playing automatically  
   End If  
End Sub
```

  
  
Replace link in the attached example with: <https://bestvpn.org/html5demos/assets/dizzy.mp4>