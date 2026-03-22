###  B4XDaisyHover3d - Bring Interactive, Modern 3D Hover Effects to Your UI! by Mashiane
### 03/18/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170621/)

Hi Fam  
  
Are you looking to add that "wow" factor to your app interfaces? I'm excited to introduce **B4XDaisyHover3d**, a new component that brings highly interactive, modern web-style 3D hover effects straight to your B4X projects! Inspired by DaisyUI components, this view completely transforms passive image galleries or custom layouts into engaging, tactile experiences.  
  
![](https://www.b4x.com/android/forum/attachments/170695) ![](https://www.b4x.com/android/forum/attachments/170697)  
  
**Key Features:**  

- **True 3D Tilt:** Adjust the MaxTilt and Perspective to create realistic depth based on user interaction.
- **Scale & Shine Effects:** Automatically scale up (ScaleOnHover) and apply dynamic highlight sheens (ShineEffect) as the user navigates over the surface.
- **Tailwind/DaisyUI Styling:** Use familiar utility tokens to handle styling! Effortlessly pass strings like rounded-2xl for border radius or p-[15px] for padding.
- **Two Content Modes:** Use ContentType = "image" to easily render high-quality assets, or use ContentType = "custom" to nest complex B4X views inside the 3D surface shell.
- **Drop Shadows & Theming:** Integrated support for dynamic hover shadows (e.g., lg, xl) and background variants.

**Simple Usage Example:**  
Getting started is incredibly easy. Here is a quick snippet demonstrating how to initialize an image card with the 3D hover effect via code:  
  

```B4X
' Ensure you declare the component in Class_Globals  
Private hoverItem As B4XDaisyHover3d  
  
' Initialize and set up the 3D hover view  
hoverItem.Initialize(Me, "hoverItem")  
hoverItem.AddToParent(pnlHost, 10dip, 10dip, 300dip, 400dip)  
  
' Apply Tailwind/DaisyUI style tokens  
hoverItem.Rounded = "rounded-2xl"  
hoverItem.Padding = "p-[15px]"  
hoverItem.setWidth("w-full")  
hoverItem.setHeight("h-[400px]")  
  
' Set the content to display an image  
hoverItem.setContentType("image")  
hoverItem.setImage("my_beautiful_asset.png")  
  
' Apply styling and draw the UI  
hoverItem.Refresh
```

  
  
Drop this component into your next project and watch your UI come to life! Don't forget to handle the click events (hoverItem\_Click) to make these elements functional as well.  
Happy Coding!  
  
  
[MEDIA=youtube]5sivv5IjFOI[/MEDIA]  
  
Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>