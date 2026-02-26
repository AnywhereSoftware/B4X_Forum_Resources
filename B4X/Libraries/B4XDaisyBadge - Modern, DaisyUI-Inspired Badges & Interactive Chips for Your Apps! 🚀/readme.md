###   B4XDaisyBadge - Modern, DaisyUI-Inspired Badges & Interactive Chips for Your Apps! 🚀 by Mashiane
### 02/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170403/)

Hi Fam  
  
Are you tired of manually coding backgrounds, corner radii, and padding just to make a simple, good-looking notification badge or a tag chip? I'm excited to share a brand new custom view that brings modern web aesthetics straight to your B4X projects: **B4XDaisyBadge**!  
  
Inspired by the incredibly popular **Tailwind CSS** and **DaisyUI** frameworks, B4XDaisyBadge allows you to effortlessly drop stunning, highly customizable badges and chips right into your Designer or create them programmatically.  
  
  
![](https://www.b4x.com/android/forum/attachments/170163) ![](https://www.b4x.com/android/forum/attachments/170164)  
  
  
**🌟 Key Features:**  
• **DaisyUI Color Variants:** Instantly apply semantic colors like primary, secondary, accent, info, success, warning, and error.  
• **Multiple Visual Styles:** Choose from solid, soft, outline, dash, or ghost to perfectly match your app's theme.  
• **Tailwind Sizing & Rounding:** Easily scale your badges (xs, sm, md, lg, xl) and adjust the corner radius using familiar Tailwind tokens (e.g., rounded-full, rounded-md).  
• **Avatars & SVG Icons:** Seamlessly embed images, text avatars, or SVG icons on the left or right side of your badge.  
• **Interactive Toggles & Closable Chips:** Need filter tags? Set Toggle = True to let users check/uncheck chips. Need dismissible tags? Set Closable = True to show a handy 'X' icon.  
• **Auto-Sizing:** Badges can automatically fit their content (fit-content) or be constrained to explicit dimensions.  
**🛠️ Simple Usage Example:**  
  
You can easily configure everything via the Visual Designer, but if you prefer doing it in code, here is a quick snippet to get you started:  
  

```B4X
    ' 1. Initialize the badge  
    Dim myBadge As B4XDaisyBadge  
    myBadge.Initialize(Me, "myBadge")  
     
    ' 2. Configure properties  
    myBadge.setText("New Message")  
    myBadge.setVariant("primary") ' primary, secondary, accent, success, etc.  
    myBadge.setStyle("soft")      ' solid, soft, outline, dash, ghost  
    myBadge.setRounded("rounded-full")  
    myBadge.setIconAsset("bell-solid.svg") ' Optional SVG icon  
     
    ' 3. Add to your layout  
    ' AddToParent(Parent, Left, Top, Width, Height)  
    ' Note: If Width and Height are 0, it will auto-size to fit the content!  
    myBadge.AddToParent(pnlHost, 20dip, 20dip, 0, 0)  
  
  
' Optional: Handle click events!  
Sub myBadge_Click(Tag As Object)  
    Log("Badge was clicked!")  
End Sub  
  
' Optional: Handle toggle checked events!  
Sub myBadge_Checked(Id As String, Checked As Boolean)  
    Log("Badge Toggle State: " & Checked)  
End Sub
```

  
  
[MEDIA=youtube]SPaOIQnV4WM[/MEDIA]  
  
  
**Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>**