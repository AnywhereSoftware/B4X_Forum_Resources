###  🌼 B4XDaisyOverlay - Elegant & Customizable Translucent UI Overlays by Mashiane
### 03/04/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170489/)

Hello Fam!  
  
Are you looking for an easy way to dim the background behind a dialog, create custom popups, or add sleek, non-blocking visual surfaces to your views? I want to introduce **B4XDaisyOverlay**, a lightweight yet incredibly versatile class that allows you to layer a translucent surface over any B4XView.  
  
![](https://www.b4x.com/android/forum/attachments/170374) ![](https://www.b4x.com/android/forum/attachments/170375) ![](https://www.b4x.com/android/forum/attachments/170376) ![](https://www.b4x.com/android/forum/attachments/170377) ![](https://www.b4x.com/android/forum/attachments/170378)  
  
**✨ Key Features:**  

- **Flexible Placement:** Use AttachTo(target) to automatically cover a specific view, or AddToParent for explicit X/Y placement.
- **Visual Customization:** Easily adjust the **OverlayColor** and set the **Opacity** from 0.0 (fully transparent) to 1.0 (fully opaque).
- **Rounded Corners:** Apply built-in rounded corner tokens (e.g., rounded-sm, rounded-lg, rounded-full) to match your app's design language.
- **Pass Through Touches:** Want to dim the screen but still let the user click the buttons underneath? Set PassThrough = True and the overlay won't intercept touch events.
- **Close On Click:** Set CloseOnClick = True to automatically hide the overlay and fire the Closed event when the user taps on it—perfect for quick-dismiss popups.
- **Responsive:** Built-in Resize(Width, Height) method ensures your overlay adapts flawlessly during page layout changes.

**🚀 Simple Usage Code Snippet:**  
Here is a quick example of how to initialize, configure, and open an overlay programmatically:  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    ' Declare the overlay instance  
    Private mMyOverlay As B4XDaisyOverlay  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
      
    ' 1. Initialize the overlay with a callback and event prefix  
    mMyOverlay.Initialize(Me, "mMyOverlay")  
      
    ' 2. Attach it to the Root (creating a full-screen overlay)  
    mMyOverlay.AttachTo(Root)  
      
    ' 3. Customize properties (optional)  
    mMyOverlay.setOpacity(0.6)  
    mMyOverlay.setCloseOnClick(True) ' Allows the user to tap to dismiss  
      
    ' 4. Show the overlay  
    mMyOverlay.Open  
End Sub  
  
' — Overlay Events —  
  
' Fired automatically when the overlay is shown  
Private Sub mMyOverlay_Opened(Tag As Object)  
    Log("Overlay is now visible on the screen.")  
End Sub  
  
' Fired when the overlay is dismissed (e.g., via CloseOnClick)  
Private Sub mMyOverlay_Closed(Tag As Object)  
    Log("Overlay has been dismissed by the user.")  
End Sub  
  
' Optional: Handle page resize to keep the overlay covering the whole screen  
Private Sub B4XPage_Resize(Width As Int, Height As Int)  
    If mMyOverlay.IsAttached Then  
        mMyOverlay.Resize(Width, Height)  
    End If  
End Sub
```

  
  
[MEDIA=youtube]bmwt9KihtAI[/MEDIA]  
  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>