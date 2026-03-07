###  🌼 B4XDaisyDivider: Beautiful Tailwind & DaisyUI Inspired Dividers for Your Apps! by Mashiane
### 03/04/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170491/)

Hello Fam!  
  
Are you tired of basic, unstyled lines separating your app's content? I'm excited to share a modern solution: **B4XDaisyDivider**!  
Designed with the popular Tailwind CSS and DaisyUI frameworks in mind, this custom view allows you to effortlessly drop gorgeous, responsive dividers right into your B4XPages or Activities. Whether you are using the Visual Designer or building layouts entirely in code, B4XDaisyDivider gives you unparalleled control over spacing, colors, and embedded text.  
  
![](https://www.b4x.com/android/forum/attachments/170384) ![](https://www.b4x.com/android/forum/attachments/170385)  
  
  
**Key Features:**  

- **Flexible Orientation:** Choose between vertical (classic horizontal lines) or horizontal (side/column dividers).
- **Embedded Text Placements:** Easily add "OR", "Continue", or section titles directly into the divider. You can align the text to the start, default (center), or end.
- **Tailwind Typography:** Size your text effortlessly using standard Tailwind tokens like text-sm, text-lg, or text-3xl.
- **DaisyUI Semantic Colors:** Instantly theme your dividers using built-in variant strings: neutral, primary, secondary, accent, info, success, warning, or error. Or, override them entirely with your own custom BackgroundColor and TextColor.
- **Smart Spacing:** Control the Gap between the line and text, adjust the LineThickness, and apply Tailwind padding/margin tokens (mx-4, py-2) to perfect your box model.
- **Interactive:** It even supports Click events if you want to use the divider as a clickable UI element (complete with object tagging)!
- **Debug Mode:** A handy DebugBorders property lets you visualize the exact bounding boxes of your lines and text while testing your layout.

**Simple Usage Example (In Code):** While you can easily add B4XDaisyDivider via the Visual Designer, here is how you can quickly initialize and add a beautiful "OR" divider programmatically:  
  

```B4X
' Ensure you declare the divider in your Class_Globals  
' Private myDivider As B4XDaisyDivider  
  
Public Sub CreateMyDivider(Parent As B4XView, Width As Int)  
    myDivider.Initialize(Me, "divider")  
      
    ' Add to parent: Parent, Left, Top, Width, Height  
    ' Height is set to 24dip to give it breathing room  
    myDivider.AddToParent(Parent, 10dip, 50dip, Width, 24dip)  
      
    ' Configure the divider properties  
    myDivider.Direction = "vertical" ' Creates a classic horizontal divider line across the screen  
    myDivider.Text = "OR"  
    myDivider.TextSize = "text-sm"  
    myDivider.Placement = "default" ' Centers the text  
    myDivider.Variant = "primary"   ' Applies the DaisyUI Primary color theme  
      
    ' You can optionally set a custom click tag  
    myDivider.Tag = "login_or_divider"  
End Sub  
  
' Catch the click event if needed  
Private Sub divider_Click(Tag As Object)  
    Log("Divider Clicked: " & Tag)  
End Sub
```

  
  
[MEDIA=youtube]DXA7kOlRnKg[/MEDIA]  
  
**Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>**