###  B4XDaisyInput - Modern, Beautiful, and Highly Customizable Text Inputs! (DaisyUI Inspired) by Mashiane
### 06/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171300/)

Hello Fam! 👋  
  
Are you tired of plain, standard text inputs and looking to give your apps a modern, polished look? Allow me to introduce **B4XDaisyInput**, a brand-new custom UI component heavily inspired by the stunning aesthetics of DaisyUI and Tailwind CSS.  
  
This component makes it incredibly easy to create professional-grade data entry forms. Whether you need subtle "ghost" inputs, vibrant "primary" colored fields, or built-in validation features, **B4XDaisyInput** handles it effortlessly.  
  
**Key Features to Supercharge Your UI:**  

- **🎨 Stunning Variants & Colors:** Choose from beautifully themed variants like *ghost, neutral, primary, secondary, accent, info, success, warning,* and *error* to match your app's branding.
- **📏 Adaptive Sizing & Padding:** Easily scale your inputs using standard sizes (*md, lg, xl*) and utilize Tailwind-style spacing options.
- **✨ Floating Labels & Inline Helpers:** Support for modern floating labels, label-left/label-right configurations, and dedicated hint or error text below the input.
- **🔒 Built-In Password Toggles:** Save time with automatic password visibility toggles (eye icons) out of the box.
- **🛡️ Robust Validation:** Built-in regex ValidationPattern, MinLength, MaxLength, and Required properties. The input automatically changes its border state (to success or error colors) based on the user's input.
- **🖼️ SVG Icon Integration:** Effortlessly add left and right-side interactive SVG icons (e.g., search, email, user).

  
![](https://www.b4x.com/android/forum/attachments/171878) ![](https://www.b4x.com/android/forum/attachments/171879) ![](https://www.b4x.com/android/forum/attachments/171880) ![](https://www.b4x.com/android/forum/attachments/171881) ![](https://www.b4x.com/android/forum/attachments/171882)  
  
  
  
**🚀 Quick Usage Example:**  
Here is a simple snippet showing how easy it is to interact with **B4XDaisyInput** once you've added it to your layout via the Designer:  
  

```B4X
' Add this to your Class_Globals  
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' Your custom B4XDaisyInput view  
    Private myEmailInput As B4XDaisyInput  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
      
    ' Programmatically configure your input  
    myEmailInput.LabelAbove = "Email Address"  
    myEmailInput.Placeholder = "Enter your email"  
    myEmailInput.InputType = "email"  
    myEmailInput.Variant = "primary"  
    myEmailInput.FloatingLabel = True  
      
    ' Trigger a UI refresh to apply changes  
    myEmailInput.UpdateTheme   
End Sub  
  
' Event triggered when the user types  
Private Sub myEmailInput_TextChanged (Old As String, New As String)  
    Log("User is typing: " & New)  
End Sub  
  
' Event triggered if you have an icon on the right and the user clicks it  
Private Sub myEmailInput_AppendClick  
    Log("Right icon clicked!")  
End Sub
```

  
  
Stop fighting with complex native properties and give **B4XDaisyInput** a try! It's designed to bring maximum aesthetic value with minimal effort.  
Let me know what you think and feel free to post your UI creations below! 👇  
  
#SharingTheGoodness  
  
[MEDIA=youtube]6ulR2MtZcs8[/MEDIA]