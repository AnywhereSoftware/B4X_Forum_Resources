###  🌼 B4XDaisyProgress - Elegant, DaisyUI-Inspired Progress Bars! by Mashiane
### 02/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170417/)

Hi Fam  
  
Are you looking to add a touch of modern web design to your B4X applications? I am excited to introduce **B4XDaisyProgress**, a powerful UI component from the DaisyUIKit that brings the clean, vibrant aesthetics of DaisyUI to your projects.  
  
![](https://www.b4x.com/android/forum/attachments/170232) ![](https://www.b4x.com/android/forum/attachments/170233)  
  
Built from the ground up using B4XView and XUI, this component makes creating beautiful, pill-shaped progress bars incredibly simple. It completely abstracts away the complex layout code, letting you control the look and feel effortlessly through Designer Properties.  
  
**Key Features:**  
• **DaisyUI Variants:** Out of the box, B4XDaisyProgress supports the full spectrum of DaisyUI semantic colors. You can easily switch your progress bar's Variant to: primary, secondary, accent, info, success, warning, error, or neutral.  
• **Smart Transparency & Styling:** Just like the real DaisyUI CSS, the background track automatically generates a 20% opacity version of your chosen bar color, giving your UI a polished, cohesive look.  
• **Simple Sizing System:** Stop guessing heights! You can use the Size property to snap your progress bar to predefined heights: xs (8dip), sm (10dip), md (12dip), lg (16dip), and xl (20dip).  
• **Dynamic Rounding:** Whether you are resizing dynamically or setting an explicit width/height, the component guarantees that the rounding stays perfectly pill-shaped. It will never look awkwardly cut off, even when the progress value is very small.  
**Usage Example:** Adding it to your UI is extremely straightforward. In the provided B4XPageProgress example, you can see how to add and configure a progress bar completely via code:  
  

```B4X
Dim p As B4XDaisyProgress  
p.Initialize(Me, "")  
p.AddToParent(content, 10dip, currentY, 200dip, 8dip)  
p.Variant = "primary"  ' Sets color to primary [4]  
p.Value = 40           ' Sets progress value [14]  
p.Size = "lg"          ' Sets size [5, 14]
```

  
  
Give it a try and elevate your app's UI today! Let me know if you have any feature requests or feedback below.  
  
  
[MEDIA=youtube]EwGXl2vRgoc[/MEDIA]  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>