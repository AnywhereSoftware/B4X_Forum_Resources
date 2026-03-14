###  🚀 B4XDaisyTimeline: Stunning DaisyUI-Style Timelines for Your Apps! by Mashiane
### 03/10/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170549/)

Hi Fam!  
  
Are you looking for a clean, modern, and highly customizable way to display chronological events, progress steps, or history logs in your apps? I'm excited to introduce **B4XDaisyTimeline**—a powerful custom view that brings the sleek aesthetics of DaisyUI timelines straight to B4X! 🎨✨  
  
![](https://www.b4x.com/android/forum/attachments/170514) ![](https://www.b4x.com/android/forum/attachments/170515) ![](https://www.b4x.com/android/forum/attachments/170516)  
  
  
**🔥 Key Features:**  

- **Flexible Orientations:** Easily switch between vertical and horizontal layouts depending on your UI needs.
- **Rich Customization:** Fully customize Line Colors, Marker Sizes, Marker Colors, and Text Sizes.
- **DaisyUI Theming:** Out-of-the-box support for DaisyUI variants like primary, secondary, accent, info, success, warning, and error.
- **Boxed Items & Shadows:** Elevate your timeline items with beautiful, customizable box shadows (sm, md, lg, xl, 2xl).
- **Custom SVG Icons:** Use the default checkmark or inject your own SVG path data for the middle markers.
- **Compact & Snap Modes:** Toggle Compact mode to push all items to one side, or SnapIcon to snap markers to the start instead of the middle.
- **Dashed Borders:** Easily toggle dashed connecting lines to indicate pending or future steps.

**💻 Quick Usage Example:**  
Here is a simple snippet showing how to initialize a vertical timeline, add boxed items, and apply a custom color variant to the first step:  
  

```B4X
' 1. Declare the component  
Private MyTimeline As B4XDaisyTimeline  
  
' 2. Initialize and add to your parent view (e.g., Root)  
MyTimeline.Initialize(Me, "MyTimeline")  
MyTimeline.AddToParent(Root, 12dip, 20dip, 300dip, 400dip) ' [4, 15]  
MyTimeline.setOrientation("vertical") ' [8]  
  
' 3. Add Timeline Items   
' Parameters: Id, StartText, EndText, BoxOnStart, BoxOnEnd [5]  
MyTimeline.AddItemBox("item1", "1984", "First Macintosh computer", False, True)  
MyTimeline.AddItemBox("item2", "1998", "iMac", False, True)  
MyTimeline.AddItemBox("item3", "2001", "iPod", False, True)  
MyTimeline.AddItemBox("item4", "2007", "iPhone", False, True)  
  
' 4. Customize Specific Items (Optional)  
' Make the first item stand out with a "primary" color variant and a dashed border  
MyTimeline.SetItemVariant("item1", "primary") ' [4, 16]  
MyTimeline.SetItemDashedBorder("item1", True) ' [4, 6]  
  
' Note: You can also mark items as "done" or change their icons!  
MyTimeline.SetItemDone("item1", True) ' [17]
```

  
  
Drop any questions, suggestions, or showcase your own implementations below. Happy coding! 🚀  
  
  
[MEDIA=youtube]V38kp6bCYqk[/MEDIA]  
  
**Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>**