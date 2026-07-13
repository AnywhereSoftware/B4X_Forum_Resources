###  B4XDaisySegment by Mashiane
### 07/05/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171469/)

Hello Fam! 👋  
  
I'm excited to share a deep dive into the **B4XDaisySegment** component. If you've been wanting to modernize your UI with sleek, customizable segment buttons, this control is designed specifically to emulate the beautiful styling specs of the Ionic v8 iOS Segment control.  
  
![](https://www.b4x.com/android/forum/attachments/172204) ![](https://www.b4x.com/android/forum/attachments/172205) ![](https://www.b4x.com/android/forum/attachments/172206) ![](https://www.b4x.com/android/forum/attachments/172207) ![](https://www.b4x.com/android/forum/attachments/172208) ![](https://www.b4x.com/android/forum/attachments/172209)  
  
**🌟 Key Features to Attract Your Users:**  

- **Flexible Button Layouts:** Support for icon-start, icon-end, icon-top, icon-bottom, icon-hide, and label-hide.
- **Built-in Theming:** Quickly switch active and background colors using built-in semantic themes (primary, secondary, success, warning, error, etc.).
- **Scrollable Segments:** Perfect for when you have more categories than screen space! Just set Scrollable to True.
- **Rounded Corners & Shadows:** Easily achieve a modern "pill shape" (Rounded = "full") and add depth with different drop shadow elevations (Shadow = "sm", "md", "lg").
- **Custom Content Switchers:** Seamlessly tie the segment events to your app panels to create fluid page-controlled layouts.

**🛠 Beginner-Friendly Usage Example:** Getting started is incredibly simple! Here is a quick code snippet demonstrating how to initialize the segment via code, configure its properties, add your buttons, and trap the user's selection event.  
  

```B4X
' 1. Declare the component and your label/panel in Class_Globals  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private MySegment As B4XDaisySegment  ' Ensure this is added in your designer or initialized in code  
    Private xlblLog As B4XView  
End Sub  
  
' 2. Initialize and configure in B4XPage_Created  
Private Sub B4XPage_Created(Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage") ' Assuming MySegment is on this layout  
      
    ' – Configure Visual Properties –  
    MySegment.ActiveColor = "primary"   ' Sets the active button color theme [7]  
    MySegment.Rounded = "full"          ' Gives the container a modern pill shape [8]  
    MySegment.Shadow = "sm"             ' Adds a subtle drop shadow [8]  
    MySegment.ButtonLayout = "icon-start" ' Positions icons before the text [8]  
      
    ' – Add Buttons to the Segment –  
    ' You can add buttons with Values, Text Labels, and SVG Icon Paths  
    MySegment.AddLabel("opt_home", "Home")           ' Text only [9]  
    MySegment.AddLabel("opt_favs", "Favorites")   
    MySegment.AddLabel("opt_settings", "Settings")   
      
    ' – Refresh the View –  
    ' Always call Refresh after updating properties or adding buttons!  
    MySegment.Refresh [10]  
End Sub  
  
' 3. Trap the Event  
' The component triggers a 'Changed' event passing the selected 'Value' [1]  
Private Sub MySegment_Changed(Value As String)  
    Log("User selected segment: " & Value)  
      
    If xlblLog.IsInitialized Then  
        xlblLog.Text = "Segment Changed: " & Value [11]  
    End If  
      
    ' Example of handling logic based on selection:  
    Select Case Value  
        Case "opt_home"  
            ' Show Home Panel  
        Case "opt_favs"  
            ' Show Favorites Panel  
        Case "opt_settings"  
            ' Show Settings Panel  
    End Select  
End Sub
```

  
  
Jump in and try it out to instantly elevate your app's design! Let me know in the replies how you are using B4XDaisySegment in your projects. Happy coding! 🚀  
  
[MEDIA=youtube]zKHtdbv8\_Jc[/MEDIA]