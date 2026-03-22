###  🌼 B4XDaisyMenu - Stunning, Responsive Tailwind/DaisyUI Style Menus! by Mashiane
### 03/18/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170623/)

Hi Fam  
  
Are you looking to give your apps a massive visual upgrade? Say hello to **B4XDaisyMenu**, a game-changing custom UI component designed to bring the elegance and simplicity of Tailwind CSS and DaisyUI straight into your B4A, B4i, and B4J projects.  
  
![](https://www.b4x.com/android/forum/attachments/170699) ![](https://www.b4x.com/android/forum/attachments/170700) ![](https://www.b4x.com/android/forum/attachments/170701) ![](https://www.b4x.com/android/forum/attachments/170702) ![](https://www.b4x.com/android/forum/attachments/170703) ![](https://www.b4x.com/android/forum/attachments/170704) ![](https://www.b4x.com/android/forum/attachments/170705)  
  
Building beautiful, modern app navigation has never been this easy. Whether you are building mobile sidebars, complex desktop toolbars, or responsive web-like mega menus, B4XDaisyMenu handles it effortlessly.  
  
**🌟 Key Features & Highlights:**  

- **Orientation Flexibility:** Switch seamlessly between vertical and horizontal layouts. Perfect for building responsive interfaces that adapt to screen sizes!
- **Size Customization:** Choose from DaisyUI standard sizes (xs, sm, md, lg, xl) to perfectly match your app's typography and scale.
- **Rich Content Support:** Go beyond basic text! Easily integrate icons, notification badges, and active states. You can even create icon-only sidebars for minimalist designs.
- **Advanced Navigation Structures:** Build deep, nested collapsible submenus, file-tree explorers, or sprawling horizontal mega menus with just a few lines of code.
- **Highly Customizable Styling:** Fine-tune the corner radius (rounded-box, rounded-full), add elevation shadows (sm to 2xl), configure automatic dividers, and even use an elegant ActiveBorder to highlight the user's current selection.
- **Scrollable & Fixed Height:** Need to manage large lists? Constrain the menu to a fixed height (h-48) and the component will automatically handle internal scrolling.

Transform your UI from standard to spectacular. Download the library, plug it into your views, and start designing beautiful app experiences today!  
**💻 Simple Usage Example:**  
Here is a quick snippet showing how easy it is to initialize a menu, add items, configure badges, and attach it to your layout:  
  

```B4X
' Declare your menu  
Dim menu As B4XDaisyMenu  
  
' Initialize the component (passing the callback activity/class and event name)  
menu.Initialize(Me, "menu")  
  
' Configure basic layout and style properties  
menu.Orientation = "vertical"  
menu.Size = "md"  
menu.Dividers = True  
menu.BackgroundColor = xui.Color_RGB(248, 247, 251)  
  
' Add a header title  
menu.AddTitle("Main Menu")  
  
' Add basic items and items with icons/badges  
menu.AddItem("item-home", "Home")  
menu.AddIconItem("item-profile", "Profile", "user-solid.svg")  
menu.AddIconBadgeItem("item-inbox", "Inbox", "inbox.svg", "120", "neutral")  
  
' Create a collapsible submenu  
Dim parent As B4XDaisyMenu = menu.AddSubmenu("item-settings", "Settings", False)  
parent.AddItem("sub-security", "Security")  
parent.AddItem("sub-notifications", "Notifications")  
  
' Add the constructed menu to a host panel (pnlHost) at X=12dip, Y=10dip  
' The width is set to 250dip, and the menu auto-calculates its preferred height  
menu.AddToParent(pnlHost, 12dip, 10dip, 250dip, menu.GetPreferredHeight)
```

  
  
*(You can handle clicks by utilizing the menu\_ItemClick (Tag As Object, Text As String) event!)*  
Let me know what amazing UIs you build with this! Happy coding! 🚀  
  
[MEDIA=youtube]MYd27-VqCh0[/MEDIA]  
  
Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>