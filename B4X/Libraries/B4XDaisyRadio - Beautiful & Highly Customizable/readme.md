###  B4XDaisyRadio - Beautiful & Highly Customizable by Mashiane
### 06/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171302/)

Hello Fam! 👋  
  
Are you looking to bring a modern, polished aesthetic to your application's forms and settings pages? Meet **B4XDaisyRadio**, a brand new, highly customizable radio button component that brings beautiful, modern design principles directly to your B4X projects!  
  
**✨ Key Features:**  

- **9 Built-in Color Variants:** Choose from neutral, primary, secondary, accent, info, success, warning, or error themes right out of the box to perfectly match your app's style.
- **5 Size Options:** Whether you need a compact UI or a massive, accessible button, you can easily select from xs, sm, md, lg, or xl sizes.
- **Intelligent Grouping:** Say goodbye to manual state management! Simply assign a GroupName via the designer. The component automatically walks the parent chain to uncheck any sibling radios sharing the same group name, seamlessly handling nested sub-containers and fieldsets without crashing.
- **Shadows & Elevations:** Add visual depth with customizable shadow levels ranging from none all the way up to 2xl.
- **Total Customization:** Fully override the checked and unchecked background colors, border colors, and the center dot text color to fit your exact custom branding requirements.
- **Flexible Alignments:** Easily position your text labels to the start (right side of the radio) or the end (left side of the radio).

![](https://www.b4x.com/android/forum/attachments/171886) ![](https://www.b4x.com/android/forum/attachments/171887) ![](https://www.b4x.com/android/forum/attachments/171888)  
  
  
**💻 Simple Usage Example:**  
Here is a quick example of how to implement and use the component in your code:  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' 1. Declare the component (Assuming you added it via the Designer)  
    Private rAccent As B4XDaisyRadio   
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainLayout")   
  
    ' 2. You can manipulate properties programmatically or rely on the Designer [1, 9, 10]  
    rAccent.GroupName = "ThemeOptions"  
    rAccent.Text = "Accent Radio"  
End Sub  
  
' 3. Handle the Checked event to trigger your logic [1, 11]  
Private Sub rAccent_Checked(Checked As Boolean)  
    If Checked Then  
        Log("The Accent Radio was successfully selected!")  
    End If  
End Sub
```

  
  
Let me know what you think in the replies below, and feel free to share screenshots of how you're styling **B4XDaisyRadio** in your own apps!  
  
#SharingTheGoodness  
  
  
[MEDIA=youtube]Hur7Vk6ICtY[/MEDIA]