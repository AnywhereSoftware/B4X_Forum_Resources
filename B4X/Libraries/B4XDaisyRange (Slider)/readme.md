###  B4XDaisyRange (Slider) by Mashiane
### 06/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171304/)

Hey Fam! 🌟  
  
Are you looking to add a modern, sleek touch to your app's user interface without spending hours tweaking colors and shapes? Let me introduce you to the **B4XDaisyRange** component!  
Inspired by the popular DaisyUI framework, this custom range slider is designed to be effortlessly stylish and highly flexible, working perfectly inside your B4X applications. Whether you need a subtle volume control, a vibrant progress selector, or an RTL-friendly slider, B4XDaisyRange handles it beautifully.  
  
**✨ Key Features Out of the Box:**  

- **Built-in Variants:** Quickly apply eye-catching color themes using the Variant property, with options like *neutral, primary, secondary, accent, info, success, warning, and error*.
- **Flexible Sizing:** Need a tiny slider or a massive one? Choose from Extra Small (xs) to Extra Large (xl) using the simple Size property.
- **Ultimate Customization:** Not using the built-in themes? No problem! You can set custom TrackColor, ProgressColor, and ThumbColor programmatically or directly via the visual designer.
- **Advanced Control:** Define MinValue and MaxValue (defaulting to 0 and 100), force exact step increments via StepValue (e.g., jumps of 25), disable fills with ShowFill, or enable Right-to-Left (RTL) mode for international layouts where progress fills from right to left.

It is incredibly **beginner-friendly**. You can easily add it through the Visual Designer or create it entirely through code. Here is a quick guide to get you up and running in minutes!  
  
![](https://www.b4x.com/android/forum/attachments/171892) ![](https://www.b4x.com/android/forum/attachments/171893)  
  
  
**👨‍💻 Simple Usage Example (100% Code Approach):**  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' 1. Declare the component  
    Private MySlider As B4XDaisyRange  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.Color = xui.Color_RGB(245, 247, 250) ' Setting a nice background color [5]  
      
    ' 2. Initialize the slider with a callback (Me) and an EventName ("MySlider") [6]  
    MySlider.Initialize(Me, "MySlider")  
      
    ' 3. Add it directly to your Root view (Parent, Left, Top, Width, Height) [7]  
    MySlider.AddToParent(Root, 20dip, 50dip, Root.Width - 40dip, 30dip)  
      
    ' 4. Customize the properties easily!  
    MySlider.setMinValue(0)          ' Set the minimum value [8]  
    MySlider.setMaxValue(100)        ' Set the maximum value [8]  
    MySlider.setValue(50)            ' Set starting position [9]  
    MySlider.setStepValue(10)        ' Slider will snap in increments of 10 [9]  
      
    ' 5. Make it look awesome  
    MySlider.setVariant("success")   ' Gives it a nice green DaisyUI theme [3, 10]  
    MySlider.setSize("lg")           ' Makes the track and thumb larger [2, 10]  
End Sub  
  
' 6. Trap the Changed event to react to user input! [1, 11]  
Private Sub MySlider_Changed(Value As Int)  
    Log("The user slid the thumb! New Value: " & Value) ' [12]  
End Sub
```

  
  
That's it! In just a few lines of code, you have a beautiful, fully functional custom slider.  
  
Let me know what you guys think, and feel free to drop any questions below! Happy coding! 🚀  
  
  
#SharingTheGoodness  
  
[MEDIA=youtube]JV\_YPNWN3b8[/MEDIA]