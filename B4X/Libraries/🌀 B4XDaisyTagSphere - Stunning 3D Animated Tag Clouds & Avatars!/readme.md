###  🌀 B4XDaisyTagSphere - Stunning 3D Animated Tag Clouds & Avatars! by Mashiane
### 08/03/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171716/)

Hello B4X Community!  
  
Are you looking to add a touch of modern, interactive 3D animation to your app's user interface? Allow me to introduce the **B4XDaisyTagSphere**!  
This component allows you to effortlessly render a 3D rotating sphere made up of text tags, emojis, or even images and avatars. It calculates the 3D math and handles smooth depth easing (fading elements in the back of the sphere) entirely behind the scenes.  
  
![](https://www.b4x.com/android/forum/attachments/172750) ![](https://www.b4x.com/android/forum/attachments/172752) ![](https://www.b4x.com/android/forum/attachments/172753) ![](https://www.b4x.com/android/forum/attachments/172754)  
  
**Key Features:**  

- **Fully Interactive:** Users can drag to rotate the sphere, and you can easily trap TagTap and TagLongPress events.
- **Auto-Rotation:** Let the sphere spin continuously when idle with customizable speed and friction/fling physics.
- **Rich Media:** Supports standard text lists, emojis, and lists of Bitmaps. It even includes a built-in toggle for **Circular Avatars** with customizable border colors and widths.
- **Highly Customizable:** Tweak the radius, text size, colors, touch sensitivity, and easing curves (easeOut, inQuint, etc.) via code or the visual designer.
- **Custom Draw Event:** Need completely custom visuals? The DrawTag event passes the canvas, coordinates, and depth alpha per frame so you can draw custom shapes, dots, or vector icons exactly where the 3D points sit in space.

---

  
🚀 Quick Start / Usage Example  
  
Here is a beginner-friendly snippet to get this 3D sphere up and running in your project. This factual code shows how to initialize the component, configure its behavior, add some tech tags, and respond to user clicks.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' Declare the component  
    Private myTagSphere As B4XDaisyTagSphere  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.Color = xui.Color_White  
      
    ' 1. Initialize the component (Pass the callback module and event prefix)  
    myTagSphere.Initialize(Me, "myTagSphere") [12]  
      
    ' 2. Add it to your parent view (Parent, Left, Top, Width, Height)  
    myTagSphere.AddToParent(Root, 10dip, 10dip, 300dip, 300dip) [13]  
      
    ' 3. Set visual and behavioral properties  
    myTagSphere.setRadius(1.5) ' 1.0 to 10.0 (Larger value = smaller visual sphere) [14]  
    myTagSphere.setSensitivity(11) ' Drag touch sensitivity [15]  
    myTagSphere.setAutoRotate(True) ' Enable automatic spinning [15]  
    myTagSphere.setAutoSpeed(0.3) ' Set the speed of auto-rotation [16]  
    myTagSphere.setTextSize(15) ' Font size [14]  
    myTagSphere.setTextColor(0xFF374151) ' Text color [14]  
      
    ' 4. Add your data (List of strings)  
    Dim tags As List  
    tags.Initialize  
    tags.AddAll(Array("B4A", "B4i", "B4J", "Flutter", "React", "Python", "SQL")) [17]  
      
    myTagSphere.setItems(tags) [2]  
End Sub  
  
' 5. Trap interactive events!  
  
' Triggered when a user taps a specific tag  
Private Sub myTagSphere_TagTap(Tag As String) [1]  
    Log("User tapped on: " & Tag)  
End Sub  
  
' Triggered when a user long-presses a specific tag  
Private Sub myTagSphere_TagLongPress(Tag As String) [1]  
    Log("User long-pressed on: " & Tag)  
      
    ' Example: Remove the tag dynamically!  
    myTagSphere.removeTag(Tag) [18]  
End Sub
```

  
  
Drop this component into your next project to instantly elevate the UX. Let me know what creative ways you find to use B4XDaisyTagSphere below!  
  
This project is wrapped from this [Github Project](https://github.com/AleksRychkov/tag-sphere)  
  
[MEDIA=youtube]rxLFpUp\_jow[/MEDIA]