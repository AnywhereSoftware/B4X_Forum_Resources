###  B4XDaisyButton - Bring the Power of Tailwind & DaisyUI to Your B4X Apps! 🎨🚀 by Mashiane
### 03/04/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170487/)

Hey B4X Community! 👋  
  
Are you looking to modernize your app's user interface without spending hours writing complex custom styling code? I'm excited to share the **B4XDaisyButton**, a powerful custom view class that brings the beautiful, utility-first design principles of Tailwind CSS and DaisyUI directly into B4A!  
  
![](https://www.b4x.com/android/forum/attachments/170362) ![](https://www.b4x.com/android/forum/attachments/170363) ![](https://www.b4x.com/android/forum/attachments/170364)  
  
The idea behind this component is simple: incredible aesthetics, minimal effort. Whether you need a standard call-to-action, a subtle text link, or a fully animated loading state, B4XDaisyButton has you covered.  
  
**✨ Key Features Highlight:**  

- **Semantic Color Variants:** Choose from default, neutral, primary, secondary, accent, info, success, warning, or error themes.
- **6 Distinct Styles:** Go beyond solid colors with soft, outline, dash, ghost, and link styles.
- **Dynamic Sizing & Shaping:** Easily adjust scales from xs to xl. Need specific layouts? Toggle Wide, Block, Square, or Circle properties.
- **Built-in Interactivity:** Support for Active and Disabled states, along with an integrated loading spinner for async tasks.
- **SVG Icon Support:** Easily pair your text with customizable SVG icons (or use icon-only square/circle buttons).
- **Ready-to-Use Social Logins:** Includes predefined styling and icons for major platforms like Google, Apple, GitHub, Microsoft, X, MetaMask, WeChat, LinkedIn, and more!.

**💻 Simple Usage Example:**  
Getting started is extremely straightforward. Here is a quick code snippet to add a customized button to your layout programmatically:  
  

```B4X
' 1. Declare the button  
Dim myPrimaryBtn As B4XDaisyButton  
  
' 2. Initialize it with an EventName ("DemoBtn")  
myPrimaryBtn.Initialize(Me, "DemoBtn")  
  
' 3. Add to your parent view (e.g., Root or a Panel)  
myPrimaryBtn.AddToParent(Root, 20dip, 20dip, 120dip, 40dip)  
  
' 4. Customize properties just like DaisyUI!  
myPrimaryBtn.Text = "Click Me!"  
myPrimaryBtn.Variant = "primary"   ' Set semantic color  
myPrimaryBtn.Style = "outline"     ' Apply outline style  
myPrimaryBtn.Size = "md"           ' Set medium size  
myPrimaryBtn.Tag = "custom-tag-1"  ' Optional tag for click handling  
  
' …  
  
' 5. Handle the click event  
Sub DemoBtn_Click(Tag As Object)  
    Log("Button clicked! Tag is: " & Tag)  
    ToastMessageShow("Clicked: " & Tag, False)  
End Sub
```

  
  
  
[MEDIA=youtube]xK6-spGUn\_E[/MEDIA]  
  
  
**Related Content**  
  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>