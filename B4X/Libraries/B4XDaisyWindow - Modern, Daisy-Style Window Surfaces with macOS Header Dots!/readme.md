###   B4XDaisyWindow - Modern, Daisy-Style Window Surfaces with macOS Header Dots! by Mashiane
### 02/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170401/)

Hi Fam  
  
Are you looking to give your B4X applications a more modern, polished look with zero hassle? Introducing **B4XDaisyWindow**, a highly customizable and reusable Daisy-style window surface designed to elevate your B4X layouts!  
  
![](https://www.b4x.com/android/forum/attachments/170158) ![](https://www.b4x.com/android/forum/attachments/170159) ![](https://www.b4x.com/android/forum/attachments/170160)  
  
**Visual Structure & Features:** The B4XDaisyWindow component acts as a gorgeous container that gives your UI elements an immediate professional upgrade. It is built with three main visual layers:  
  
1. **An Outer Container:** A rounded, bordered, and elevated shell acting as the window base.  
2. **A Header Strip (Optional):** A sleek top band that can showcase three "window control" dots, perfect for a macOS-like aesthetic.  
3. **A Dedicated Content Panel:** An internal host for any child views you want to place inside the window body.  
  
Here are a few reasons why you'll love it:  
  
• **Customizable Elevation & Depth:** Easily add depth to your user interfaces with built-in shadow levels ranging from none, xs, sm, md, lg, all the way to xl.  
• **Modern Corners:** Take full control of the border radius by choosing modes like rounded-none, rounded-sm, rounded-box, rounded-full, and more.  
• **Interactive Header Controls:** Show or hide the top header area and the three control dots, adjusting their gap, size, and color to fit your app's theme. The control dots are interactive and automatically raise a \_ControlClick(Index As Int) event when tapped, passing an index of 1 (left), 2 (middle), or 3 (right).  
• **Smart Sizing & AutoHeight:** Support for flexible width and height specs (like 100% or 320dip) ensures responsive sizing across screen sizes. Plus, if you enable the AutoHeight property, the component will automatically grow or shrink its height to perfectly fit the children residing inside the content panel.  
  
**Seamless Integration:** Whether you prefer coding programmatically or using the visual designer, B4XDaisyWindow fits seamlessly into your workflow. You can easily add it programmatically using methods like CreateView or AddToParent. When working in the designer, the component intelligently handles child views: any child components that exist on the base view are safely and automatically migrated directly into the internal content panel behind the scenes. You can dynamically add to or clear the content later using AddContentView and ClearContent.  
Give it a try and transform your flat interfaces into structured, elevated masterpieces. Drop any component inside the composable window area and instantly see the difference!  
  
  
[MEDIA=youtube]0wNBmI0kd\_M[/MEDIA]  
  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>