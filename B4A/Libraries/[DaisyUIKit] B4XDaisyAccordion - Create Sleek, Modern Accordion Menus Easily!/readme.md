### [DaisyUIKit] B4XDaisyAccordion - Create Sleek, Modern Accordion Menus Easily! by Mashiane
### 03/10/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/170552/)

Hello Fam! 👋  
  
Are you looking for an elegant way to organize content in your applications? I am thrilled to introduce the **B4XDaisyAccordion**, a lightweight, responsive, and highly customizable UI component designed to take your app interfaces to the next level.  
  
![](https://www.b4x.com/android/forum/attachments/170524) ![](https://www.b4x.com/android/forum/attachments/170525)  
  
The **B4XDaisyAccordion** acts as a wrapper and manager for your collapsible content (B4XDaisyCollapse), neatly organizing them into a dynamic vertical stack. Here are some of the key features built right into the component to help you optimize your user experience:  

- **Smart Layout Management:** It automatically auto-shrinks to fit its contents and shifts page siblings below it by the delta smoothly and dynamically.
- **OpenOnlyOne Toggle:** Keep your UI uncluttered! If enabled, the accordion ensures that only one collapse item can remain open at a time; expanding one automatically collapses the others.
- **Highly Customizable Styling:** Change the look entirely via Designer Properties! Apply dynamic SpaceY gaps between items, choose border Rounded radii (from rounded-none to rounded-full), and apply elevations natively using the Shadow property (xs up to 2xl).
- **Theme Aware:** Forces the component to re-evaluate its styling against the currently active global theme in real-time with the UpdateTheme method.
- **Flexible Expansion Icons:** Set custom indicator icons (arrow, plus, or none) and position them effortlessly to the left or right of your headers.

**🚀 Simple Usage Example** Adding the component programmatically to your layout is very straightforward. Here is a basic code snippet to get you started:  
  

```B4X
' In Class_Globals  
Private xui As XUI  
Private pnlHost As B4XView ' The parent panel in your layout  
Private myAccordion As B4XDaisyAccordion  
  
' In your initialization sub (e.g., B4XPage_Created)  
' 1. Initialize the Accordion (pass the callback object and event name)  
myAccordion.Initialize(Me, "myAccordion")  
  
' 2. Initialize and configure a collapse item (assuming you have B4XDaisyCollapse available)  
Dim item1 As B4XDaisyCollapse  
item1.Initialize(Me, "item1")  
' Note: You would typically add content to item1 here…  
  
' 3. Add the item to your accordion  
' The accordion will assign a unique group name and ensure it is sized correctly  
myAccordion.AddItem(item1)  
  
' 4. Add the accordion to your Host Panel (Parent, Left, Top, Width, Height)  
myAccordion.AddToParent(pnlHost, 20dip, 50dip, pnlHost.Width - 40dip, 200dip)
```

  
  
By leveraging the **B4XDaisyAccordion**, you can save hours of UI development while providing your users with a modern, smooth, and interactive layout element. Let me know what you think below! Happy coding!  
  
[MEDIA=youtube]vI53OMrlGGA[/MEDIA]  
  
  
Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>