### GIFdecoder Library - Released by Starchild
### 08/07/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/120980/)

I needed to access the frames in a GIF file by their frame index so I could extract and display each frame in any order, as I required, not just play the GIF animation itself.  
  
I found that B4X user **[USER=93785]max123[/USER]** had already begun converting the [B4A library (of the same name)](https://www.b4x.com/android/forum/threads/animated-gif-decode-library.6879/#post-68373) several years ago.   
max123 Original Post: [GifDecoder library for B4J](https://www.b4x.com/android/forum/threads/gifdecoder-library-for-b4j.67403/#post-428353)  
Unfortunately, it remained unfinished as he requested help in resolving the many conversion issues he had en counted, but did not receive any interest from other B4X users.  
  
Although I am "Late to the Party" I have made the necessary changes to get this library running properly under B4J.  
  
See below for the Current Release of jGIFdecoder library.  
  
Here is a simple B4J test project so you can see how easy it is to use.  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
      
    Dim gif As GifDecoder  
    Private img1 As ImageView  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.Show  
    MainForm.BackColor = fx.Colors.LightGray  
    MainForm.Title = "B4J GIFdecoder Test"  
      
    gif.Load(File.DirAssets,"animated.gif")  
  
    Log ("Number of Frames: " & gif.NumberOfFrames)  
    Log ("Width: " & gif.Width)  
    Log ("Height: " & gif.Height)  
    Log ("LoopCount: " & gif.LoopCount)  
      
    img1.Initialize("img1")  
    MainForm.RootPane.AddNode(img1, 50, 50, gif.Width, gif.Height)  
  
    Dim I As Int = 0  
    Do Until False  
        If I = gif.NumberOfFrames Then I = 0  
        img1.SetImage(gif.FrameImage(I))  
        'gif.SaveFrame(I, "C:\Users\me\Desktop\test", "frame" & I & ".png")  
        Dim D As Int = gif.FrameDelay(I)  
        'Log("Delay= " & D)  
        Sleep(D)  
        I=I+1  
    Loop  
      
    gif.DisposeAllFrames  
End Sub
```

  
  
Note: I have included two small GIF files in the project's assets but for the more ambitious , try downloading this [LARGE animated GIF file](https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.dribbble.com%2Fusers%2F212304%2Fscreenshots%2F1140818%2F128-shorter.gif&imgrefurl=https%3A%2F%2Fdribbble.com%2Fshots%2F1140818-Jellyfish-Gif-Wallpaper&tbnid=lwVxMUPuwFVkjM&vet=12ahUKEwiMsJ2uuYjrAhXTMCsKHfDdB_UQMygEegUIARDcAQ..i&docid=EpOM0O8YkObgvM&w=400&h=300&q=large%20gif%20jellyfish&ved=2ahUKEwiMsJ2uuYjrAhXTMCsKHfDdB_UQMygEegUIARDcAQ) and play it with the B4J GifDecoder Test project.