###  🚀 Create Beautiful UI in B4X: B4XDaisyCard Component Tutorial (Tailwind & DaisyUI Inspired) by Mashiane
### 03/04/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170488/)

Hello B4X Community! 👋  
  
I'm excited to share a powerful new UI component to help you build modern, beautiful, and responsive interfaces across all platforms: **B4XDaisyCard**.  
  
![](https://www.b4x.com/android/forum/attachments/170366) ![](https://www.b4x.com/android/forum/attachments/170367) ![](https://www.b4x.com/android/forum/attachments/170368) ![](https://www.b4x.com/android/forum/attachments/170369) ![](https://www.b4x.com/android/forum/attachments/170370) ![](https://www.b4x.com/android/forum/attachments/170371) ![](https://www.b4x.com/android/forum/attachments/170372)  
  
Inspired by Tailwind CSS and DaisyUI, this lean card component allows you to create stunning layouts using a predictable view tree containing a figure (image), body, title, and actions. Whether you prefer using the Visual Designer or programmatic APIs, B4XDaisyCard maps designer properties directly to its backing fields and resolves theme tokens seamlessly  
via B4XDaisyVariants.  
  
**🌟 Key Features:**  

- **5 Responsive Layout Modes:** Easily switch between top, bottom, side, overlay, or none. The side mode automatically adapts the image width based on the container size.
- **Semantic Variants:** Apply beautiful, consistent theming using tokens like primary, secondary, accent, info, success, warning, and error.
- **Highly Customizable:** Adjust the Size (xs to xl), Shadow elevation (none to 2xl), Rounded corners, and border styles (none, border, or dash).
- **Built-in Image & Overlay Support:** Load assets dynamically and apply transparent contrast overlays with ease.
- **Flexible Sub-Components:** Easily access and modify the internal CardBody, CardTitle, and CardActions containers for advanced composition.

**🛠️ Simple Usage Code Snippet:**  
Here is a quick example of how to initialize and configure a card programmatically:  
  

```B4X
Sub Globals  
    Private pnlHost As B4XView  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Main")  
     
    ' 1. Initialize the B4XDaisyCard component  
    Dim myCard As B4XDaisyCard  
    myCard.Initialize(Me, "myCard")  
     
    ' 2. Add it to a parent view (e.g., a panel or ScrollView)  
    ' Left: 20dip, Top: 20dip, Width: 320dip, Height: auto (0 or specify height)  
    myCard.AddToParent(pnlHost, 20dip, 20dip, 320dip, 400dip)  
  
    ' 3. Customize the Card Properties  
    myCard.Title = "Beautiful Cross-Platform Cards" ' Set the title [6]  
    myCard.ImagePath = "sample_image.webp" ' Load an image from DirAssets [11]  
    myCard.Size = "md" ' Set padding and text scaling [12]  
    myCard.Style = "border" ' Apply a border style [2]  
    myCard.LayoutMode = "top" ' Place the image at the top [2]  
    myCard.Shadow = "md" ' Apply medium elevation [3]  
    myCard.Variant = "primary" ' Use the primary semantic color [2]  
     
    ' 4. Add custom body text to the CardBody container  
    Dim lblBody As Label  
    lblBody.Initialize("")  
    Dim xlBody As B4XView = lblBody  
    xlBody.Text = "B4XDaisyCard makes building responsive UIs a breeze. It features a predictable view tree and Tailwind-inspired tokens!"  
    xlBody.TextSize = 14  
    xlBody.TextColor = xui.Color_RGB(51, 65, 85)  
     
    ' Add the label to the CardBody part  
    myCard.CardBody.AddView(xlBody, 0, 0, myCard.CardBody.Width, 60dip)  
     
    ' 5. Add an Action Badge/Button to the CardActions container  
    Dim btnAction As B4XDaisyBadge  
    btnAction.Initialize(Me, "")  
    btnAction.AddToParent(myCard.CardActions, 0, 0, 0, 0)  
    btnAction.Text = "Learn More"  
    btnAction.Variant = "accent"  
     
    ' Force a layout refresh to apply the dynamic content  
    myCard.Base_Resize(myCard.mBase.Width, myCard.mBase.Height)  
End Sub  
  
' Handle the Click Event  
Sub myCard_Click(Tag As Object)  
    Log("Card was clicked!")  
End Sub
```

  
  
  
[MEDIA=youtube]zdHleAPqy0M[/MEDIA]  
  
  
**Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>**