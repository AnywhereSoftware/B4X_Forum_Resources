###  🌼 B4XDaisyCarousel - Modern, Responsive & Tailwind-Inspired Carousels! by Mashiane
### 03/04/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170494/)

Hello Fam!  
  
Are you tired of basic sliders and looking for a way to add modern, beautiful carousels to your Android and iOS applications? I am thrilled to introduce **B4XDaisyCarousel**, a highly customizable, Tailwind-inspired carousel component designed to make your app look spectacular with minimal effort! 🚀  
  
![](https://www.b4x.com/android/forum/attachments/170395) ![](https://www.b4x.com/android/forum/attachments/170396) ![](https://www.b4x.com/android/forum/attachments/170397) ![](https://www.b4x.com/android/forum/attachments/170398) ![](https://www.b4x.com/android/forum/attachments/170399)  
  
**✨ Key Features:**  

- **Flexible Orientations:** Choose between horizontal or vertical scrolling to fit your UI needs.
- **Rich Content Support:** Your carousel items aren't limited to just images! Use the B4XDaisyCarouselItem class to easily embed images, SVGs, or entirely custom B4XViews.
- **Smart Snapping:** Smoothly snap your items to the start, center, or end of the viewport.
- **Modern Styling:** Out-of-the-box support for DaisyUI rounded-box corners, custom padding/gap tokens (e.g., p-4, space-x-4), and dynamic box-shadows (sm, md, lg, xl).
- **Built-In Controls & Autoplay:** Easily toggle overlay navigation buttons (Prev/Next), bottom indicator dots, and fully configurable AutoPlay timers with automatic user-pause detection.

**🛠️ Simple Usage Example:** Adding items to your carousel programmatically is a breeze. Check out this quick snippet:  
  

```B4X
' Assuming you have added a B4XDaisyCarousel named "myCarousel" in the Designer  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
      
    ' 1. Configure Carousel properties (can also be done in Designer)  
    myCarousel.Orientation = "horizontal" ' [2]  
    myCarousel.AutoPlay = True ' [4]  
    myCarousel.AutoPlayInterval = 3000 ' Slides every 3 seconds [1, 4]  
    myCarousel.IndicatorButtons = True ' Show bottom dots [3]  
    myCarousel.ItemGap = 16dip ' [8]  
      
    ' 2. Create and configure a Carousel Item  
    Dim slide1 As B4XDaisyCarouselItem  
    slide1.Initialize(Me, "slide1") ' [9]  
    slide1.ItemType = "image" ' Supports image, svg, or custom [5, 6]  
    slide1.Source = "promo_banner.png" ' [10]  
      
    Dim slide2 As B4XDaisyCarouselItem  
    slide2.Initialize(Me, "slide2")  
    slide2.ItemType = "custom" ' A custom UI panel  
    ' slide2.Container can be populated with your own UI elements here [10]  
      
    ' 3. Add items and refresh the UI  
    myCarousel.AddItem(slide1) ' [11]  
    myCarousel.AddItem(slide2) ' [11]  
    myCarousel.Refresh ' Update the carousel view [11]  
End Sub  
  
' 4. Handle clicks on your items effortlessly  
Private Sub slide1_Click(Tag As Object)  
    Log("Slide 1 clicked!")  
End Sub
```

  
  
Let me know what you think of this component and feel free to share the beautiful UI layouts you build with it! Happy coding!  
  
[MEDIA=youtube]OMh3mOIeDK4[/MEDIA]  
  
**Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>**