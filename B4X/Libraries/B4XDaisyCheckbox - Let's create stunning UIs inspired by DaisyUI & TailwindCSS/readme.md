###  B4XDaisyCheckbox - Let's create stunning UIs inspired by DaisyUI & TailwindCSS by Mashiane
### 06/17/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171301/)

Hello Fam! 👋  
  
Are you looking to modernize your application's user interface with sleek, contemporary checkboxes? I am excited to introduce the **B4XDaisyCheckbox**, a fully customizable, cross-platform UI component inspired by the popular Tailwind CSS/DaisyUI frameworks.  
  
Gone are the days of boring default checkboxes. With B4XDaisyCheckbox, you can effortlessly design beautiful, responsive forms directly from the B4X Designer or via code!  
**✨ Key Features:**  

- **Rich Color Variants:** Out-of-the-box support for beautiful semantic colors: neutral, primary, secondary, accent, info, success, warning, and error.
- **Perfect Sizing:** Need a tiny checkbox or a massive one? Easily switch between xs, sm, md, lg, and xl sizes.
- **Advanced States:** Fully supports Checked, Unchecked, and Indeterminate states.
- **Drop Shadows & Elevations:** Add depth to your UI with built-in shadow levels (xs to 2xl).
- **Total Customization:** Override default themes by setting your own custom BackgroundColor, BorderColor, and TextColor for both checked and unchecked states.
- **Flexible Labeling:** Position your label text at the start (right) or end (left) of the checkbox effortlessly.

![](https://www.b4x.com/android/forum/attachments/171883) ![](https://www.b4x.com/android/forum/attachments/171884) ![](https://www.b4x.com/android/forum/attachments/171885)  
  
  
**🚀 Simple Usage Example:**  
Here is a quick code snippet to get you started. Add a B4XDaisyCheckbox to your layout via the Designer (e.g., named cbTerms), and control it via code:  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    ' Declare the component added via the Designer  
    Private cbTerms As B4XDaisyCheckbox   
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("Main")  
      
    ' Programmatically configure the checkbox  
    cbTerms.Text = "Accept Terms and Conditions"  
    cbTerms.Variant = "primary"   ' Set color variant to Primary  
    cbTerms.Size = "md"           ' Medium size  
    cbTerms.Checked = False       ' Default state  
    cbTerms.Shadow = "sm"         ' Add a small drop shadow  
End Sub  
  
' Handle the checked event easily!  
Private Sub cbTerms_Checked (Checked As Boolean)  
    If Checked Then  
        Log("User accepted the terms!")  
    Else  
        Log("User revoked the terms.")  
    End If  
End Sub
```

  
  
Let me know what you think in the replies below, and feel free to share screenshots of how you're using **B4XDaisyCheckbox** in your projects! Happy coding! 💻✨  
  
#SharingTheGoodness  
  
  
[MEDIA=youtube]SonbhuVari8[/MEDIA]