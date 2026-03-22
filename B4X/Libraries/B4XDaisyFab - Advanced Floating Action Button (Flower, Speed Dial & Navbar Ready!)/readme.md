###  B4XDaisyFab - Advanced Floating Action Button (Flower, Speed Dial & Navbar Ready!) by Mashiane
### 03/18/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170620/)

Hi Fam  
  
If you are looking to create modern, interactive, and customizable Floating Action Buttons (FABs) for your apps, look no further than **B4XDaisyFab**. This powerful custom view class brings top-tier UI capabilities directly to your projects.  
  
![](https://www.b4x.com/android/forum/attachments/170692) ![](https://www.b4x.com/android/forum/attachments/170693) ![](https://www.b4x.com/android/forum/attachments/170694)  
  
**Key Features:**  

- **Versatile Layout Modes:** Choose between a standard vertical layout for speed dials, a unique flower layout for a beautiful radial spread, or a toolbar layout. The flower layout keeps a radial pattern while the trigger sits conveniently at the bottom-right.
- **Flexible Placement:** Need the FAB at the bottom right? Or maybe top right sitting above a navbar and expanding downward? B4XDaisyFab supports multiple placement modes including bottom-end, top-start, center, and even anchored or manual positioning.
- **Rich Theming:** It includes built-in variant themes (such as primary, secondary, accent, info, success, warning, error) so your FAB automatically matches your app's design language. You can also specify different variants for the main trigger and child actions.
- **Child Actions with Icons:** Easily add child actions to your FAB that use custom icons. Perfect for quick access menus like a camera, upload, or copy button.
- **Robust Event System:** The component fires precise events, including Click, ActionClick, Opened, and Closed, giving you total control over user interaction. It even supports an optional backdrop that closes the FAB when clicking outside.

**Simple Usage Example:**  
  
Here is a quick snippet to get you started with a standard speed dial setup:  
  

```B4X
' In Globals  
Private Root As B4XView  
Private fab As B4XDaisyFab ' Assuming you added the component via the Visual Designer  
  
' In B4XPage_Created  
Private Sub B4XPage_Created(Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
      
    ' Programmatically add child actions to your FAB  
    ' Syntax: AddAction(TagValue As Object, Variant As String, IconName As String)  
    fab.AddAction("Upload", "info", "upload_icon")  
    fab.AddAction("Camera", "primary", "camera_icon")  
    fab.AddAction("Delete", "error", "delete_icon")  
End Sub  
  
' Handle clicks on the child actions  
Private Sub fab_ActionClick(Index As Int, Tag As Object)  
    Log("User clicked action at index " & Index & " with Tag: " & Tag)  
      
    Select Case Tag  
        Case "Upload"  
            ' Handle upload  
        Case "Camera"  
            ' Handle camera  
        Case "Delete"  
            ' Handle delete  
    End Select  
End Sub
```

  
  
Upgrade your app's navigation and delight your users with these smooth, interactive menus! Let me know if you have any questions or feedback below.  
  
  
[MEDIA=youtube]k4YiHCpiPAY[/MEDIA]  
  
Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>