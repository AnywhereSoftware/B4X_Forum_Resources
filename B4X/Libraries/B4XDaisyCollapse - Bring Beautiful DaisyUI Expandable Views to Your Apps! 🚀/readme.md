###  B4XDaisyCollapse - Bring Beautiful DaisyUI Expandable Views to Your Apps! 🚀 by Mashiane
### 03/04/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170495/)

Hi Fam!  
  
Are you looking to add modern, elegant, and highly customizable accordion or expandable sections to your app's UI? I'm excited to introduce **B4XDaisyCollapse**!  
Based on the beautiful DaisyUI design system, this collapse component allows you to seamlessly show and hide content with professional styling and smooth state changes.  
  
![](https://www.b4x.com/android/forum/attachments/170401) ![](https://www.b4x.com/android/forum/attachments/170402)  
  
✨ **Key Features:**  

- **DaisyUI Variants:** Fully supports semantic variants like primary, secondary, accent, info, success, warning, and error.
- **Custom Icons:** Built-in expansion indicators (arrow or plus) that can be positioned on the left or right to visually guide your users.
- **Highly Customizable:** Easily tweak border radiuses (rounded-md, rounded-full, etc.), shadows (sm to 2xl), border widths, and title text styling.
- **Nested Content:** Safely add any B4XView into the ContentView container. The component auto-measures your content's height so you don't have to guess dimensions!
- **Responsive Widths:** Works natively with Tailwind-style fraction widths (e.g., w-full, w-1/2, w-1/3).

💻 **Simple Usage Example:** Here's a quick snippet showing how easy it is to interact with the component programmatically:  
  

```B4X
Sub Globals  
    ' Assuming myCollapse is added via the visual designer  
    Private myCollapse As B4XDaisyCollapse  
End Sub  
  
Sub B4XPage_Created (Root1 As B4XView)  
    Root1.LoadLayout("Main")  
  
    ' Configure the title and style programmatically  
    myCollapse.TitleText = "Click to Expand Me!"  
    myCollapse.Variant = "primary"  
    myCollapse.Icon = "arrow"  
  
    ' Create and add content to the collapse container  
    Dim lblContent As Label  
    lblContent.Initialize("")  
    lblContent.Text = "Here is the hidden content revealed!"  
    lblContent.TextSize = 14  
    ' Automatically adapt the text color based on the selected variant  
    lblContent.TextColor = myCollapse.CollapseContent.TextColor  
  
    ' Add the label to the inner content view.  
    ' We use 0dip left because the container automatically provides standard 16dip padding.  
    myCollapse.ContentView.AddView(lblContent, 0, 8dip, myCollapse.ContentView.Width, 36dip)  
End Sub  
  
' Listen for state changes (perfect for repositioning views in a ScrollView!)  
Private Sub myCollapse_StateChanged (Open As Boolean)  
    Log("Collapse state is now open: " & Open)  
End Sub
```

  
  
Let me know what you think and share screenshots of how you use it in your apps! Happy coding! 🚀  
  
[MEDIA=youtube]kd7dvE1GOCc[/MEDIA]  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>