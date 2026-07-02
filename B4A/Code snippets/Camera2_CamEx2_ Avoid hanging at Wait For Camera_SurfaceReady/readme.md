### Camera2/CamEx2: Avoid hanging at Wait For Camera_SurfaceReady by b4x-de
### 06/30/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171411/)

Just in case somebody else runs into the same problem, here is the solution that worked for me. I had a timing issue with the Camera2 example / CamEx2 class on B4A.  
  
In my app the camera preview is hosted inside a custom XUI view. The preview panel is resized dynamically before the camera is opened. In some cases the code got stuck in CamEx2 here:  
  

```B4X
Wait For Camera_SurfaceReady
```

  
  
After adding some tracing I found an important detail: The B4X view size and the native Android view size can temporarily differ.  
After calling [ICODE]SetLayout[/ICODE] / [ICODE]SetLayoutAnimated[/ICODE], the B4X view can already report the new [ICODE]Width[/ICODE] / [ICODE]Height[/ICODE], while the native Android view still has the old layout until Android has completed its next layout pass. There are cases where the B4X preview panel already had the expected size, but the native Android view still had the previous size or even no size and CamEx2 already creates the [ICODE]TextureView[/ICODE] during this time slot. The [ICODE]SurfaceTexture[/ICODE] lifecycle can become timing-sensitive.  
  
The workaround that helped me was:  
  

- make sure the native preview panel / TextureView layout is updated before waiting
- call [ICODE]requestLayout[/ICODE] / [ICODE]invalidate[/ICODE]
- and, very importantly, check [ICODE]TextureView.isAvailable[/ICODE] before waiting for [ICODE]Camera\_SurfaceReady[/ICODE]

  
The [ICODE]isAvailable[/ICODE] guard is important because [ICODE]Camera\_SurfaceReady[/ICODE] is an event, not a state. If the [ICODE]TextureView[/ICODE] surface is already available before the [ICODE]Wait For[/ICODE] line is reached, the event will may not be replayed.  
  
Example modification in [ICODE]CamEx2.CreateSurface[/ICODE]:  
  

```B4X
Private Sub CreateSurface As ResumableSub  
    If tv.IsInitialized Then tv.RemoveView  
  
    tv = Camera.CreateSurface  
    mPanel.AddView(tv, 0, 0, mPanel.Width, mPanel.Height)  
    tv.SendToBack  
  
    Dim joPanel As JavaObject = mPanel  
    Dim joTv As JavaObject = tv  
  
    'Request / force the native Android layout to match the B4A panel size.  
    joPanel.RunMethod("layout", Array As Object(0, 0, mPanel.Width, mPanel.Height))  
    joTv.RunMethod("layout", Array As Object(0, 0, mPanel.Width, mPanel.Height))  
  
    joPanel.RunMethod("requestLayout", Null)  
    joPanel.RunMethod("invalidate", Null)  
    joTv.RunMethod("requestLayout", Null)  
    joTv.RunMethod("invalidate", Null)  
  
    'SurfaceReady is an event, not a state.  
    'If the TextureView surface already exists, waiting for the event can hang.  
    Dim SurfaceAvailable As Boolean  
    Try  
        SurfaceAvailable = joTv.RunMethod("isAvailable", Null)  
    Catch  
        SurfaceAvailable = False  
    End Try  
  
    If SurfaceAvailable Then  
        Return True  
    End If  
  
    Wait For Camera_SurfaceReady  
    Return True  
End Sub
```

  
  
In my final app code I moved most of the fix outside CamEx2: before calling [ICODE]PrepareSurface[/ICODE], I wait until the native Android layout of my preview panel matches the B4X panel size. This allows CamEx2 to stay almost unchanged.  
  
However, I still think the [ICODE]isAvailable[/ICODE] guard is a useful defensive check in CamEx2 itself, because it protects against missing the [ICODE]Camera\_SurfaceReady[/ICODE] event if the [ICODE]TextureView[/ICODE] surface is already available.  
  
So in my case the root cause was a timing issue between B4X layout values, the native Android layout pass, and the TextureView [ICODE]SurfaceTexture[/ICODE] callback.