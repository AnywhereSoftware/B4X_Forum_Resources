###  🎨 🚀 B4XDaisyOTP - Modern, Ionic! by Mashiane
### 07/05/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171473/)

Hello Fam! 👋  
  
Are you building an authentication screen, a banking app, or a secure 2FA portal? Say goodbye to basic text boxes! I am excited to share **B4XDaisyOTP**, a modern set of pin-entry boxes designed to look and act exactly like the beautiful ion-input-otp component from Ionic v8.  
Since mobile devices don't always play nicely with standard web APIs for customized inputs, this component translates that sleek web design into **native B4X views**, giving your users a buttery-smooth, high-quality mobile experience.  
  
![](https://www.b4x.com/android/forum/attachments/172223) ![](https://www.b4x.com/android/forum/attachments/172224) ![](https://www.b4x.com/android/forum/attachments/172225) ![](https://www.b4x.com/android/forum/attachments/172226) ![](https://www.b4x.com/android/forum/attachments/172227) ![](https://www.b4x.com/android/forum/attachments/172228) ![](https://www.b4x.com/android/forum/attachments/172229)  
  
**🔥 Key Features for SEO & UI Dominance:**  

- **Flexible Length & Formats:** Easily set the number of input boxes (from 2 up to 10) and enforce numeric or text keyboard types.
- **Highly Customizable Styling:** Choose from round, soft, or rectangular border shapes, and toggle between outline and solid background fills.
- **Rich Theming:** Integrate with DaisyUI-style variants (primary, secondary, success, error, etc.) for seamless app theming.
- **Smart Interactions:** Supports visual separators (e.g., placing a dash between the 3rd and 4th box) and advanced regex character patterns.
- **Built-in States:** Handles Enabled, ReadOnly, and manual ValidationState styling to highlight errors dynamically.

🛠 Beginner-Friendly Quick Start Guide  
Here is a simple example showing how to initialize the component programmatically, tweak its design, and trap the completion event.  
  

```B4X
Sub Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' 1. Declare the component  
    Private myOtp As B4XDaisyOTP  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
      
    ' 2. Initialize the component and set the Event Name  
    myOtp.Initialize(Me, "myOtp")  
      
    ' 3. Add it to the screen (Parent, Left, Top, Width, Height)  
    ' Height of 0 lets it auto-calculate based on its size properties  
    myOtp.AddToParent(Root, 20dip, 50dip, Root.Width - 40dip, 0)  
      
    ' 4. Customize Properties!  
    myOtp.setLength(6)               ' Set a 6-digit code requirement  
    myOtp.setInputType("number")     ' Force the numeric keyboard  
    myOtp.setShape("round")          ' Give the boxes nice rounded edges  
    myOtp.setVariant("primary")      ' Use your app's primary color  
    myOtp.setSeparators("3")         ' Add a separator after the 3rd box (e.g., 123-456)  
End Sub  
  
' 5. Trap the Input Event (Fires every time a user types or deletes a character)  
Private Sub myOtp_Input(Value As String)  
    Log("User is typing… Current value: " & Value)  
End Sub  
  
' 6. Trap the Complete Event (Fires instantly when all boxes are filled)  
Private Sub myOtp_Complete(Value As String)  
    Log("OTP Fully Entered! Verifying code: " & Value)  
      
    ' Example validation check  
    If Value = "123456" Then  
        myOtp.setValidationState("valid")  
        xui.MsgboxAsync("Code accepted!", "Success")  
    Else  
        myOtp.setErrorText("Invalid code. Try again.") ' Sets state to invalid visually  
        myOtp.setValue("") ' Clear the boxes for retry  
    End If  
End Sub
```

  
  
Let me know what you guys think! Download the component below and give your app's login screens a massive visual upgrade today. Happy coding! 👨‍💻👩‍💻  
  
[MEDIA=youtube]oChzK-ylbfs[/MEDIA]