###  Level Up Your UI: Adding Sleek Skeleton Loading & Shimmer Effects to B4X Apps! by Mashiane
### 02/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170415/)

Hi Fam  
  
Are you tired of basic spinning progress wheels? If you want to give your users a polished, modern app experience while data is loading in the background, it’s time to look at **Skeleton Loading** with animated shimmer effects!  
  
![](https://www.b4x.com/android/forum/attachments/170227)  
  
Using the powerful B4XDaisyDiv and B4XDaisyLabel components, you can now effortlessly toggle beautiful skeleton placeholders.  
**How it Works** Both components come equipped with an IsSkeleton boolean property,. When set to True, the component hides its standard content and brings a dedicated skeleton panel (pnlSkeleton) to the front,.  
  
An internal 16ms timer drives a buttery-smooth 1.8-second (1800ms) animation loop using a cubic ease-in-out curve to sweep a bright shimmer across the screen from left to right,,.  
• **B4XDaisyDiv (Containers & Shapes):** Perfect for mocking up profile images or text blocks. The component draws a solid base rounded rectangle (Color\_RGB(209, 213, 219)) and layers dynamic, clipped shimmer strips (Color\_RGB(243, 244, 246)) over it,,.  
• **B4XDaisyLabel (Text Elements):** Instead of drawing a solid block, labels take a much smarter approach. They render the actual text at 20% opacity. Then, using native Android clipping paths, it draws the fully opaque text *only* within the angled shimmer region as it moves across the screen,. The result is a stunning, readable text shimmer!  
**Quick Example Implementation** You can easily build a "Profile Card" skeleton. For example, you can combine a circular div for an avatar (w-16 h-16 rounded-full) with smaller rectangle divs (w-32 h-4) and standard daisy labels,.  
Toggling the entire loading state on or off is as simple as flipping the boolean on your views:  
  

```B4X
Private Sub ToggleSkeleton(Active As Boolean)  
    ' Toggle basic shapes  
    divAvatar.IsSkeleton = Active  
    divCircle.IsSkeleton = Active  
    divRect.IsSkeleton = Active  
      
    ' Toggle text content  
    lblTitle.IsSkeleton = Active  
    lblSubtitle.IsSkeleton = Active  
End Sub
```

  
  
[MEDIA=youtube]1XGCDdqIPMc[/MEDIA]  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>