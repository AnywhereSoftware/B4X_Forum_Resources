###  🎨 The B4XDaisySheetModal! 🚀- Create Stunning, Fluid Bottom Sheet & Card Modals! 🚀 by Mashiane
### 07/05/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171471/)

Hello Fam! 👋  
  
Are you looking to add those beautiful, modern bottom sheet modals to your apps? I'm excited to introduce the **B4XDaisySheetModal** component!  
This component brings a highly interactive, native-feeling modal experience to B4X. Whether you need a simple auto-sizing bottom menu or a complex, full-screen interactive sheet with an iOS-style background scale effect, this component handles it all flawlessly.  
  
![](https://www.b4x.com/android/forum/attachments/172213) ![](https://www.b4x.com/android/forum/attachments/172214) ![](https://www.b4x.com/android/forum/attachments/172215) ![](https://www.b4x.com/android/forum/attachments/172216) ![](https://www.b4x.com/android/forum/attachments/172217) ![](https://www.b4x.com/android/forum/attachments/172218)  
  
**✨ Key Features:**  

- **Fluid Snapping Breakpoints:** Snap your modal to specific screen heights (e.g., 25%, 50%, 100%) with physics-based momentum.
- **Card Presentation Effect:** Automatically scales and pushes your background view back (just like iOS) when the modal appears.
- **Nested Scrolling Support:** Add scrolling content inside the modal; pulling down at the top of the scroll seamlessly hands off to dragging the sheet.
- **Highly Customizable:** Tweak the drag handle, backdrop opacity, animations, corner radius, and more directly from the visual designer or via code.
- **Auto-Height:** Have the sheet automatically calculate its own height based on the child views inside it.

---

  
👨‍💻 Beginner-Friendly Usage Example  
Getting started with B4XDaisySheetModal is incredibly easy. Here is a simple snippet showing how to initialize the component, configure its behavior, present it, and catch its events!  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' 1. Declare the component  
    Private smOnline As B4XDaisySheetModal  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
      
    ' 2. Initialize the modal and set the event name  
    smOnline.Initialize(Me, "smOnline")  
      
    ' 3. Add it to your root view (fills the screen)  
    smOnline.AddToParent(Root, 0, 0, Root.Width, Root.Height)  
      
    ' 4. Configure Properties easily via code!  
    smOnline.Breakpoints = "0.0,0.5,1.0" ' Snaps at hidden, 50%, and full height  
    smOnline.InitialBreakpoint = 0.5     ' Opens halfway by default  
    smOnline.Handle = True               ' Shows the drag handle pill at the top  
    smOnline.BackdropOpacity = 50        ' Dims the background behind the sheet  
    smOnline.Rounded = "xl"              ' Nice rounded corners  
    smOnline.Animated = True             ' Enables smooth sliding animations  
End Sub  
  
' 5. Present the modal (e.g., on a button click)  
Private Sub btnShowModal_Click  
    smOnline.Present  
End Sub  
  
' 6. Dismiss the modal programmatically  
Private Sub btnClose_Click  
    ' You can pass data and a role back when dismissing  
    smOnline.Dismiss(Null, "cancel")  
End Sub  
  
' ==========================================  
' 🎣 Trapping Events  
' ==========================================  
  
' Fires whenever the modal snaps to a new breakpoint  
Private Sub smOnline_BreakpointDidChange(Breakpoint As Float)  
    Log("The modal snapped to: " & (Breakpoint * 100) & "%")  
End Sub  
  
' Fires continuously as the user drags the sheet up or down  
Private Sub smOnline_DragMove(Data As Map)  
    Log("Dragging… Current Y position: " & Data.Get("currentY"))  
End Sub  
  
' Fires when the modal finishes closing completely  
Private Sub smOnline_DidDismiss(Role As String, Data As Object)  
    Log("Modal closed with role: " & Role)  
End Sub
```

  
  
Let me know if you have any questions or feature requests! Happy coding! 💻🔥  
  
[MEDIA=youtube]UvIodB6PhqI[/MEDIA]