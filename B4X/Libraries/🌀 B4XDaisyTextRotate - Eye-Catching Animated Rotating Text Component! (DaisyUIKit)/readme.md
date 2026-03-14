###  🌀 B4XDaisyTextRotate - Eye-Catching Animated Rotating Text Component! (DaisyUIKit) by Mashiane
### 03/10/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170550/)

Hello Fam!  
  
Are you looking to add a little dynamic flair to your app interfaces? I'm excited to share a closer look at **B4XDaisyTextRotate**, a brilliant custom view class from the DaisyUIKit module designed to smoothly rotate through a list of text strings. It’s perfect for promotional banners, loading text sequences, or drawing attention to key features in your cross-platform apps!  
  
![](https://www.b4x.com/android/forum/attachments/170518)  
  
**🌟 Key Features Designed for Flexibility:**  

- **DaisyUI Semantic Colors:** Easily match your app's theme by applying standard DaisyUI variants such as primary, secondary, accent, info, success, warning, or error. This automatically styles the rotating text without manual hex codes!
- **Customizable Durations:** You have complete control over how fast the text rotates. The built-in parser lets you set intuitive string values like "3s" for 3 seconds, or "500ms" for rapid half-second transitions.
- **Designer Friendly:** Add it straight from the visual designer with properties for the number of items, duration, and color variants.
- **Interactive:** It supports an interactive click event (\_Click (Tag As Object)), meaning you can trigger actions when the user taps on the rotating text.

**🛠️ Simple Usage Example:** If you prefer adding views programmatically rather than using the visual designer, here is a quick code snippet showing how to get B4XDaisyTextRotate running on your page:  
  

```B4X
' Add to Class_Globals  
Private MyRotatingText As B4XDaisyTextRotate  
  
' Inside B4XPage_Created or Activity_Create  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.Color = xui.Color_RGB(245, 247, 250) ' Background color [6]  
      
    ' 1. Initialize the component (Callback, EventName)  
    MyRotatingText.Initialize(Me, "MyRotatingText") [4]  
      
    ' 2. Add it to your Parent View (Parent, Left, Top, Width, Height)  
    MyRotatingText.AddToParent(Root, 20dip, 50dip, 300dip, 40dip) [3]  
      
    ' 3. Create a list of strings to rotate and set them  
    Dim items As List  
    items.Initialize  
    items.AddAll(Array As String("Welcome to B4X!", "Build Apps Fast", "Cross-Platform UI"))  
    MyRotatingText.SetItems(items) [2]  
      
    ' 4. Customize speed and appearance  
    MyRotatingText.setDuration("2s")       ' Rotates every 2 seconds [3]  
    MyRotatingText.setVariant("primary")   ' Uses DaisyUI primary color [7]  
      
    ' 5. Refresh to apply changes  
    MyRotatingText.Refresh [2]  
End Sub  
  
' Handle the Click Event  
Private Sub MyRotatingText_Click (Tag As Object) [5]  
    Log("The rotating text was clicked!")  
End Sub
```

  
  
Elevate your UI game and grab the attention of your users with this simple but powerful module. Let me know what you build with it in the replies below!  
  
[MEDIA=youtube]dYv\_9xbw0EA[/MEDIA]  
  
**Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>**