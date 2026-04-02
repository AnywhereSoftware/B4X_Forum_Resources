### B4XDaisyDock: Sleek, Responsive Navigation Inspired by DaisyUI & Tailwind by Mashiane
### 03/31/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170722/)

Hi Fam!  
  
I’m excited to share a new component for the community: **B4XDaisyDock**.  
Taking inspiration from the popular **DaisyUI** and **Tailwind CSS** frameworks, B4XDaisyDock brings professional, responsive navigation to your B4A and B4X projects with ease. No more wrestling with complex layouts for simple navigation bars!  
  
![](https://www.b4x.com/android/forum/attachments/170966) ![](https://www.b4x.com/android/forum/attachments/170967) ![](https://www.b4x.com/android/forum/attachments/170968) ![](https://www.b4x.com/android/forum/attachments/170969)  
  
**Key Features:**  

- **Flexible Sizing:** Uses standard size tokens like **xs, sm, md, lg,** and **xl**.
- **Semantic Variants:** Easily apply functional colors to items, including **Primary, Secondary, Accent, Warning,** and **Error**.
- **Advanced Styling:** Includes built-in support for elevation shadows (up to **2xl**) and corner rounding (up to **full**).
- **Highly Customizable:** Control background colors, text/icon colors, and active item indicators.
- **Robust API:** Programmatically add/clear items, enable/disable specific icons, and handle clicks with ease.

Whether you need a simple bottom bar or a highly stylized menu, B4XDaisyDock is built to adapt to your design needs.  
**Simple Usage Example:  
  

```B4X
' Initialize and add items  
Dim myDock As B4XDaisyDock  
myDock.Initialize(Me, "myDock")  
myDock.Size = "md" ' Options: xs, sm, md, lg, xl  
myDock.Rounded = "full" ' Options: none, sm, md, lg, xl, 2xl, 3xl, full  
  
' Add items with icons (SVG assets)  
myDock.AddItem("home", "Home", "home.svg")  
myDock.AddItem("inbox", "Inbox", "inbox.svg")  
' Add an item with a semantic variant color  
myDock.AddItemWithVariant("settings", "Settings", "settings.svg", "primary")  
  
' Add to your view  
myDock.AddToParent(Root, 0, Root.Height - 64dip, Root.Width, 64dip)  
myDock.ActiveIndex = 0  
  
' Handle clicks  
Sub myDock_ItemClick (ItemId As String)  
    Log("User clicked: " & ItemId)  
End Sub
```

  
  
Let me know what you think!  
  
[MEDIA=youtube]yqMdyAPJQmI[/MEDIA]  
  
  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>**