###  B4XDaisyAlert - Cross-platform DaisyUI Alert Component by Mashiane
### 02/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170420/)

Hi Fam  
  
I am sharing a new custom view class, B4XDaisyAlert, which ports the versatile Alert component from the DaisyUI library to B4X. It is designed to be highly customizable and easy to integrate into B4A, B4i, and B4J projects.  
  
![](https://www.b4x.com/android/forum/attachments/170238) ![](https://www.b4x.com/android/forum/attachments/170239) ![](https://www.b4x.com/android/forum/attachments/170240)  
   
**Key Features:**  
• **Cross-Platform:** Compatible with B4A, B4i, and B4J (via XUI).  
• **Multiple Styles:** Supports solid, soft, outline, and dash visual styles.  
• **Contextual Variants:** Built-in themes for info, success, warning, and error.  
• **Flexible Sizing:** Accepts standard dip values or Tailwind-like tokens (e.g., "full", "12", "320px").  
• **Dynamic Actions:** Easily add action buttons (e.g., "Accept", "Deny") with responsive layout support.  
• **Icon Support:** Built-in SVG icon handling with automatic or manual coloring.  
  
PS: We are yet to create buttons  
  

```B4X
' Initialize the alert  
Dim alert As B4XDaisyAlert  
alert.Initialize(Me, "alert")  
  
' Configure properties  
alert.Variant = "info"  
alert.AlertStyle = "soft"  
alert.Title = "Update Available"  
alert.Text = "A new version of the application is ready to install."  
alert.IconAsset = "circle-question-regular.svg"  
  
' Add to parent view  
alert.AddToParent(Root, 10dip, 10dip, 300dip, 0)  
  
' Add Action Button  
alert.AddActionButton("Install Now", "install_tag")
```

  
  
[MEDIA=youtube]IOKgwLL2sZM[/MEDIA]  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>