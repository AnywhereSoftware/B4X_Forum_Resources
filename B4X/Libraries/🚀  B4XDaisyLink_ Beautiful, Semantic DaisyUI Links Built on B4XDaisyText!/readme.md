### 🚀  B4XDaisyLink: Beautiful, Semantic DaisyUI Links Built on B4XDaisyText! by Mashiane
### 03/18/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170622/)

Hello B4X Developers!  
  
Are you looking to add modern, web-style hyperlinks to your mobile or desktop applications? We are excited to showcase the capabilities of **B4XDaisyLink**, a seamless implementation of DaisyUI link classes brought directly into the B4X ecosystem.  
  
  
![](https://www.b4x.com/android/forum/attachments/170698)  
  
Because B4XDaisyLink utilizes our robust **B4XDaisyText** as its core building block, it inherits a wealth of flexible styling properties right out of the box. You no longer have to manually handle text colors, hover states, or underline formatting.  
  
**🌟 Key Features:**  

- **Semantic Variants:** Easily style your links using DaisyUI variants like primary, secondary, accent, neutral, info, success, warning, and error.
- **Built-in Link Behaviors:** Use the Link boolean property to immediately render text as a clickable link and the Underline property to toggle visual underlines.
- **URL Intents:** The dedicated Url property lets you cleanly define a destination URL that handles routing when the link is clicked.
- **Auto Resize & Constraints:** Automatically resizes the height to fit text content seamlessly.

**Usage Example:** Getting started programmatically is incredibly simple. Here is a quick code snippet to set up a primary link component that logs a toast message when clicked, mirroring our B4XPageLink structure:  
  

```B4X
' 1. Declare the component in your Globals or Class_Globals  
Private myLink As B4XDaisyText  
  
' 2. Initialize and add it to your parent container (e.g., pnlHost)  
myLink.Initialize(Me, "myLink")  
myLink.AddToParent(pnlHost, 12dip, 20dip, 200dip, 30dip)  
  
' 3. Configure the link properties  
myLink.Text = "Click here to visit our site"  
myLink.TextSize = "text-lg"  
myLink.Link = True           ' Renders as a clickable link  
myLink.Underline = True      ' Shows underline   
myLink.Variant = "primary"   ' Applies the semantic primary color  
myLink.Url = "https://www.b4x.com"  
  
' 4. Handle the click event!  
Private Sub myLink_Click (Tag As Object)  
    Log("The link was clicked! Tag: " & Tag)  
    #If B4A  
        ToastMessageShow("Navigating to: " & myLink.Url, False)  
    #End If  
End Sub
```

  
  
Let me know what you think of this component and how you plan to use it in your projects. Happy coding!  
  
[MEDIA=youtube]lp5En5sQJuo[/MEDIA]  
  
Related Content  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>