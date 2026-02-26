### 🚀   B4XDaisyLoading: Beautiful DaisyUI-Inspired Loading Animations! by Mashiane
### 02/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170414/)

Hi Fam  
  
Are you looking to add sleek, modern, and highly customizable loading indicators to your B4X applications? Look no further! I'm excited to share the **B4XDaisyLoading** component, a custom view class inspired by the popular DaisyUI web framework.  
  
![](https://www.b4x.com/android/forum/attachments/170224) ![](https://www.b4x.com/android/forum/attachments/170225) ![](https://www.b4x.com/android/forum/attachments/170226)  
  
This component allows you to effortlessly drop beautiful, looping loading animations right into your app with standard designer properties.  
  
**🌟 Key Features**  
• **Multiple Styles:** Choose from 6 different loading animations: spinner, dots, ring, ball, bars, and infinity.  
• **Responsive Sizes:** Supports 5 standard sizes: xs, sm, md, lg, and xl. It scales dynamically based on B4XDaisyVariants token dips.  
• **Theming & Colors:** Set colors using standard theme variants (primary, secondary, accent, error, etc.), hex codes, or use currentColor to dynamically match your base content theme.  
• **Smooth Animations:** The engine uses a custom loop capped at ~60fps, calculating animations based on system milliseconds (mCurrentTimeMs) to ensure perfectly smooth transitions regardless of minor device lag.  
• **Custom Speeds:** Want it faster or slower? The Speed property lets you scale the animation speed (100 = normal, 200 = 2x speed).  
**🛠 How It Works** Under the hood, B4XDaisyLoading is built entirely with native **B4XViews**, **Panels**, and **B4XAnimations**.  
• The **Dots** and **Bars** styles use beautifully staggered math (key times and delays) to interpolate their positions and alpha opacities.  
• The **Ring** style interpolates scale and fade dynamically for a rippling effect.  
• The **Spinner** and **Infinity** styles leverage a helper SVG class (B4XDaisySvgIcon) to rotate and offset scalable vector paths.  
**📱 Sample Page Included** The included B4XPageLoading module automatically generates a stunning, scrolling **matrix** of all the loading animations. It iterates through every style and size combination, and displays them side-by-side with all the variant colors (primary, info, success, warning, error, etc.)  
  

```B4X
Dim loading As B4XDaisyLoading  
loading.Initialize(Me, "loading")  
' Add it directly to your parent view  
loading.AddToParent(ParentPanel, Left, Top, SizeDip, SizeDip)   
' Customize it!  
loading.SetStyle("bars")  
loading.SetSize("md")  
loading.SetColor("primary")  
  
Alternatively, just drag and drop it using the Visual Designer and configure the properties right there!  
Let me know what you think of the component, and feel free to share how you end up using it in your apps!
```

  
  
  
[MEDIA=youtube]7IfPqpFc-FQ[/MEDIA]  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>