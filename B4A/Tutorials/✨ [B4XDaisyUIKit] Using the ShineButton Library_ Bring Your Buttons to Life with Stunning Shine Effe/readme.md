### ✨ [B4XDaisyUIKit] Using the ShineButton Library: Bring Your Buttons to Life with Stunning Shine Effects! ✨ by Mashiane
### 08/05/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/171724/)

**Hello B4Xers!**  
  
This beautiful animation control is originally a lightweight Android UI library created by **ChadCSong on GitHub**. It adds a "shining" effect to buttons similar to Twitter's famous heart animation. We owe a massive thanks to **Johan Schoeman**, who expertly wrapped this library for B4A. So I needed same functionality and without re-inventing the wheel used the same jar library to add the functionality to my app.  
  
**Currently this library is using 4 images and in my todo I need to extend it to use more svg icons and perhaps avatars and other things.**  
  
[SIZE=5]**Key Features:**[/SIZE]  

- **Customizable Shapes:** You can use any PNG mask (like a heart, thumb, smile, or star) as your button shape
- **Vibrant Effects:** Easily adjust the initial button color (BtnColor) and the fill color when clicked (BtnFillColor)
- **Randomized Colors:** Bring your UI to life by enabling the AllowRandomColor property for multi-colored shine particles
- **Smooth Interactivity:** Enjoy fluid animations that can be triggered both by user clicks and programmatically via code (showAnim)

  
Below is a beginner-friendly guide and snippet on how to initialize the component, configure its properties, and trap its events.  
  
[SIZE=5]**🛠️ Simple Usage Code Snippet**[/SIZE]  
  
*Note: To use custom shapes, you must place your PNG file (e.g., "heart.png") inside your B4A project's Objects/res/raw folder [6]. Crucially, make sure to set the image file to read-only so it doesn't get overwritten or deleted during compilation [7].*  
  

```B4X
#Region Globals  
Sub Class_Globals  
    ' 1. Declare the ShineButton component  
    Private sb1 As ShineButton  
    Private mbHeartChecked As Boolean  
End Sub  
#End Region  
  
#Region Initialization  
Public Sub Initialize  
    ' 2. Initialize the component and define the EventName  
    sb1.Initialize("sb1")  
End Sub  
#End Region  
  
#Region Activity/Page Creation  
Private Sub B4XPage_Created(Root1 As B4XView)  
    ' 3. Set visual properties via code  
    ' "heart" references heart.png in the Objects/res/raw folder  
    sb1.ShapeResource = "heart"  
     
    ' You can also configure visual properties based on the library wrapper:  
    ' sb1.AllowRandomColor = True  
    ' sb1.BtnColor = Colors.Gray  
    ' sb1.BtnFillColor = Colors.Red  
    ' sb1.ShineCount = 8  
    ' sb1.EnableFlashing = True  
     
    ' 4. Add the button to your layout or Root here  
    ' Root1.AddView(sb1, 50dip, 50dip, 100dip, 100dip)  
End Sub  
#End Region  
  
#Region Component Events  
' Trap the Check Changed event  
Private Sub sb1_check_changed (check As Boolean)  
    mbHeartChecked = check  
    Log("Button sb1 status = " & check)  
    Log("sb1 (Heart) check_changed = " & check)  
End Sub  
  
' Trap the Button Clicked event  
Private Sub sb1_button_clicked  
    Log("sb1 clicked")  
     
    ' You can optionally trigger the shine animation programmatically at any time:  
    ' sb1.showAnim  
End Sub  
#End Region
```

  
  
**Using it with B4XPages & B4XDaisyUIKit:**  
If you are implementing this via code in B4XPages, you can simply declare your ShineButton in Class\_Globals and initialize it inside your initialization sub. It behaves perfectly when added to a B4XView host panel [8].  
  
Let us know what you think and share the gorgeous animations you create with it! Happy coding! 🚀  
  
[MEDIA=youtube]9mDU20tCynY[/MEDIA]