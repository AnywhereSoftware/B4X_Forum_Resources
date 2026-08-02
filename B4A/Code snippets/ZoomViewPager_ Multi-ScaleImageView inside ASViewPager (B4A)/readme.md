### ZoomViewPager: Multi-ScaleImageView inside ASViewPager (B4A) by GeoT
### 07/28/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171666/)

[HEADING=2]📌 Goal & Architecture Overview[/HEADING]  
This implementation demonstrates how to host multiple hardware-accelerated **ScaleImageView** instances inside an **ASViewPager** dynamic gallery.  
  
![](https://www.b4x.com/android/forum/attachments/172633) ![](https://www.b4x.com/android/forum/attachments/172634) ![](https://www.b4x.com/android/forum/attachments/172641)  
  
[**ScaleImageView library by agraham:**](https://www.b4x.com/android/forum/threads/scaleimageview-pan-and-zoom-large-images.102190/#content) A specialized image view designed to display high-resolution or large images cleanly. Its main feature is smooth zooming and panning (pinch-to-zoom and double-tap), allowing users to scale and explore images easily without losing performance or consuming excessive memory.  
  
[**ASViewPager library by Alexander Stolte:**](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/#content) An enhanced, custom ViewPager component used to swipe horizontally between pages or screens. It builds on the standard ViewPager by adding smooth page transitions, better touch gesture handling, and cleaner integration with custom adapters or tabs.  
  
**Quick Takeaway:** Use ScaleImageView for zoomable images and ASViewPager for swipeable screen carousels.  
  
  
Instead of pre-loading heavy bitmaps into memory, each page is created as a lightweight generic xUI panel (xui.CreatePanel), inflating the native viewer on demand.  
  
[ASViewPager Container]  
└── Dynamically Injected Pages ──> [B4XView Container Panel]  
 └── Child (Index 0) ──> [ScaleImageView]  
  
[HEADING=2]🛠️ The Core Injection Pattern[/HEADING]  
Both implementations use the same underlying engine to populate the ASViewPager safely without race conditions:  
  

```B4X
Private Sub ConfigureViewPager  
    ASViewPager1.Clear  
    Sleep(50) ' Critical: Gives the OS time to calculate container physical boundaries  
    
    For c = 0 To NumItems - 1  
        ' 1. Create a cross-platform host panel  
        Dim tmp_xpnl As B4XView = xui.CreatePanel("")  
        tmp_xpnl.SetLayoutAnimated(0, 0, 0, ASViewPager1.Base.Width, ASViewPager1.Base.Height)  
        
        ' 2. Inflate the layout containing ScaleImageView  
        tmp_xpnl.LoadLayout("LayoutViewer")  
        
        ' 3. Configure native view & bind file path  
        Dim siv As ScaleImageView = tmp_xpnl.GetView(0)  
        siv.PanLimit = siv.PAN_LIMIT_INSIDE  
        siv.DoubleTapZoomDuration = 250  
        siv.Orientation = siv.ORIENTATION_USE_EXIF  
        siv.EnableCircle = False  
        siv.ImageFile = File.Combine(ImagesFolder, lstFilenames.Get©)  
        
        ' 4. Inject panel into the viewpager engine  
        ASViewPager1.AddPage(tmp_xpnl, "")  
    Next  
    
    Sleep(0) ' Enforces UI render dispatch before applying index  
    If currentIndex < ASViewPager1.Size Then  
        ASViewPager1.CurrentIndex = currentIndex  
    End If  
End Sub
```

  
  
  
[HEADING=2]🧹 Memory Cleansing & Reset on Swipe (PageChanged)[/HEADING]  
When users zoom in or rotate an image and then swipe to the next photo, leaving the altered view in memory corrupts recycled panels. Intercepting PageChanged forces a clean atomic state reset on the view that just lost focus:  
  

```B4X
Sub ASViewPager1_PageChanged (index As Int)  
    If currentIndex < ASViewPager1.Size And currentIndex <> index Then  
        Try  
            ' Extract previous host panel and its child ScaleImageView  
            Dim pnlPrevious As B4XView = ASViewPager1.GetPanel(currentIndex)  
            Dim siv As ScaleImageView = pnlPrevious.GetView(0)  
            
            ' Reset zoom, pan, and rotation back to default state  
            siv.ResetScaleAndCenter  
            siv.Orientation = 0  
        Catch  
            Log("State reset bypass: " & LastException.Message)  
        Try  
    End If  
    currentIndex = index  
End Sub
```

  
  
  
[HEADING=2]🔄 Device Rotation Behavior Difference[/HEADING]  

- **Activity Version:** Supports full set rotation. When rotating the device, Android recreates the Activity, re-inflating the layout and letting ConfigureViewPager recalculate page dimensions dynamically.
- **B4XPages Version:** The view instance stays alive in memory. The ASViewPager container maintains its original aspect ratios and does not auto-rotate the active set layout, making it ideal for locked-orientation galleries.

[HEADING=2][/HEADING]  
[HEADING=2]⚠️ Current Scope & Future Expansion Capabilities[/HEADING]  
These examples demonstrate the core UI dynamic-injection pattern. However, they include specific functional limits that can be easily expanded:  
  
[HEADING=3]1. Image Source (Asset-Bound)[/HEADING]  

- **Current state:** The examples load images internally from File.DirAssets / File.DirInternal. They do not pick images directly from the user's system photo gallery.
- **How to expand:**

1. **Direct Intent Usage (ACTION\_GET\_CONTENT):** Call the system picker directly with the EXTRA\_ALLOW\_MULTIPLE flag active using JavaObject/Intents to allow selecting single or multiple external images from device storage.
2. **MediaChooser Library:** Integrate the MediaChooser wrapper/library to handle multi-image and video selection through a dedicated media picker interface.

[HEADING=3]2. Live Rotation Persistence[/HEADING]  

- **Current state:** Tapping "Rotate" applies a visual 90º orientation shift via ScaleImageView.Orientation. This change is purely for display in RAM and **is not saved to the physical image file on disk**.
- **How to expand:** To permanently save rotated files, you must process the underlying bitmap using B4X graphics/Canvas routines and write it back using Bitmap.WriteToStream.

[HEADING=3]3. Cropping Limitations[/HEADING]  

- **Current state:** The current examples do not perform cropping operations on the images.
- **How to expand:** Integrate libraries like [**ResizeAndCrop7**](https://www.b4x.com/android/forum/threads/resize-and-crop-image.95001/) by klaus to allow interactive image trimming.

[HEADING=3]4. Combined Crop & Rotation Operations[/HEADING]  

- **Current state:** Rotating and cropping are treated separately and cannot be performed simultaneously within the basic ScaleImageView instance.
- **How to expand:** Integrate specialized libraries like [**xResizeAndCrop**](https://www.b4x.com/android/forum/threads/b4x-xui-xresizeandcrop.100109/) by klaus to allow users to rotate, scale, and crop images simultaneously in a single unified gesture viewport before saving.

  
**[SIZE=6]Notes:[/SIZE]**  

- We need to put these sample images into Assets, inside the project's Files folder
- Assisted by the Gemini AI