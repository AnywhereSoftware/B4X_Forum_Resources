###  B4XDaisyDiff: Awesome Before/After Slider Component for Images & Text! 🚀 by Mashiane
### 03/10/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170553/)

Hello Fam! 👋  
  
I'm excited to share a brand new custom UI component to enhance your application's user experience: **B4XDaisyDiff**.  
  
If you've ever needed to showcase a "Before and After" image comparison or a side-by-side text difference, this component handles it beautifully with a simple, interactive drag slider. Inspired by DaisyUI styling, it brings modern CSS-like token properties (such as w-full, rounded-xl, and semantic color variants like primary or success) straight into the B4X Designer.  
  
![](https://www.b4x.com/android/forum/attachments/170527)  
  
**✨ Key Features:**  

- **Dual Modes:** Supports both image and text rendering modes (DiffType).
- **Highly Customizable:** Easily adjust Width, Height, Rounded corners, Shadow, and text sizes using familiar Tailwind-style naming.
- **Interactive Split:** Users can drag the divider seamlessly left and right, starting from a custom default position (e.g., 0.5 for center).
- **Designer Support:** Fully supported in the visual designer with intuitive custom properties.

**🛠️ Simple Usage Code Snippet:** You can add B4XDaisyDiff entirely through the designer, or you can create and configure it programmatically. Here is a quick snippet to get you started with an image comparison:  
  

```B4X
' 1. Declare the component  
Private MyDiff As B4XDaisyDiff  
  
' 2. Initialize and add to your layout  
MyDiff.Initialize(Me, "MyDiff")  
MyDiff.AddToParent(Root, 10dip, 10dip, 300dip, 300dip)  
  
' 3. Configure the DiffType to Image  
MyDiff.setDiffType("image")  
  
' 4. Load your before and after images (ensure they are in the Assets folder)  
MyDiff.setImage1("photo-before.webp")  
MyDiff.setImage2("photo-after.webp")  
  
' 5. Set the initial slider position (0.0 to 1.0)  
MyDiff.setPosition(0.5)
```

  
  
*(Note: For text diffs, you can set DiffType to "text" and use setText1, setText2, and their respective color variants!)*  
I hope this helps you build more engaging UIs! Let me know if you have any questions or feature requests below. Happy coding! 💻✨  
  
[MEDIA=youtube]8v3leTzkiXg[/MEDIA]  
  
  
Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>