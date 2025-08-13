### [B4Xlib] lmB4XImageView by LucaMs
### 05/13/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/128133/)

Modified version of Erel's B4XImageView - which is inside the "Xui Views" library.  
  
It does not replace that, just add this to the additional libraries folder (B4X) and then choose whether to use in your project this or that.  
  
The changes are two:  
  
1 - I added the Click event - which also takes into account the possible rounding of the image, which is the most important feature of the B4XImageView, perhaps.  
2 - Added also the classic properties: Left, Top, Width, Height.  
  
**V. 2.2.0**  
 Added SaveBitmap.  
 Changed default BackgroundColor to transparent.  
  
**V. 2.1.2** Fixed a bug  
**V. 2.1.1** Fixed a bug in B4i  
**V. 2.1.0** Fixed a bug in B4i  
[This one](https://www.b4x.com/android/forum/threads/lmb4ximageview-error.160337/post-984541). Thank you, [USER=102342]@Alexander Stolte[/USER]  
  
**V. 2.0.0 Please, read** [**post #8**](https://www.b4x.com/android/forum/threads/b4x-b4xlib-lmb4ximageview.128133/post-814093)  
Removed B4A Touch event; it prevented the Click and LongClick events from being triggered.  
Added LongClick event (not in B4J).  
  
**V. 1.2.0** Added Touch event.  
Since the maximum number of parameters that can be passed using CallSub3 is two while the Touch event has three, I had to implement it like this:  

```B4X
Private Sub lmB4XImageView1_Touch (Action As Int, arrXY() As Float)  
    Log("Action: " & Action)  
    Log("X: " & arrXY(0))  
    Log("Y: " & arrXY(1))  
End Sub
```

  
  
  
**V. 1.0.1** Fixed a bug