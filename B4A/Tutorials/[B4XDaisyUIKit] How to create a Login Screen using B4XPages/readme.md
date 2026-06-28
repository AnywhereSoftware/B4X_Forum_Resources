### [B4XDaisyUIKit] How to create a Login Screen using B4XPages by Mashiane
### 06/25/2026
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/171384/)

Hi Fam!  
  
In this tutorial, we take you through the process of creating a Login Screen using [B4XDaisyUIKit](https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/) components.  
  
![](https://www.b4x.com/android/forum/attachments/172041)  
  
  
Are you looking to build a clean, modern sign-in screen for your next app but aren't sure where to start? Today, I’m sharing a highly beginner-friendly, step-by-step breakdown of a professional login page.  
  
This tutorial focuses on user experience (UX) and responsiveness. We will be using **B4XPages** and **B4XDaisyPageScroll** to ensure our UI fits perfectly on any screen size and orientation.  
  
🌟 What We Are Building  
  
We are creating a modern sign-in page that features:  

- A clean interface with an Email address field and a Password field (including a visibility toggle and helper text).
- "Remember me" and "Forgot password?" utilities.
- Primary "Continue" and secondary "Create account" action buttons.
- **Smart Focus:** Pressing 'Enter' on the email field automatically jumps to the password field, and pressing 'Enter' on the password field jumps to the submit button!.
- **Fully Responsive:** Automatically adjusts when the user rotates their phone.

🧠 The "ELI15" Approach (Explain Like I'm 15)  
  
To make onboarding as easy as possible, the code is heavily commented using the ELI15 philosophy. Let's look at the key functionalities:  
  
**1. Setting up the Basics** Everything starts in Class\_Globals. This is where we declare variables that every Sub in this page can see and use. Root is the top-level panel, and all other views sit on top of it.  
  

```B4X
Sub Class_Globals  
    ' ELI15: Root is the top-level panel of this screen.  
    Private Root As B4XView  
    Private pageScroll As B4XDaisyPageScroll  
End Sub
```

  
  
**2. Building and Managing the UI** We construct the layout in B4XPage\_Created and define a starting Y-position (12% down from the top) in our BuildForm sub to lay out controls neatly.  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    ' Store the root panel reference for later use.  
    Root = Root1  
    ' Initialize the scrollable page  
    pageScroll.Initialize(Me, "pageScroll")  
    pageScroll.AddToParent(Root, 0, 0, Root.Width, Root.Height)  
End Sub  
  
Private Sub BuildForm  
    ' ELI15: Start the content 12% down from the top of the screen.  
    Dim y As Int = (Root.Height * 12) / 100  
    ' … Add controls here …  
End Sub
```

  
  
**3. Handling Screen Rotations Seamlessly** This event triggers automatically whenever the device screen changes size. We just tell our scroll container to match the new size!  
  

```B4X
Private Sub B4XPage_Resize (Width As Int, Height As Int)  
    ' ELI15: Runs when the screen rotates or resizes.  
    If pageScroll.IsInitialized Then  
        pageScroll.Base_Resize(Width, Height)  
    End If  
End Sub
```

  
  
**4. Creating a Great User Experience (Smart Keyboard Navigation)** Nobody likes tapping into every single box manually. We can listen for the 'Enter' key and move the user along automatically.  
  

```B4X
Private Sub txtEmail_EnterPressed(Text As String)  
    ' ELI15: When the user presses Enter in the email field, move focus to the password field.  
    If txtPassword.IsInitialized Then txtPassword.Focus = True  
End Sub  
  
Private Sub txtPassword_EnterPressed(Text As String)  
    ' ELI15: Move focus to the Continue button.  
    If btnSubmit.IsInitialized Then btnSubmit.Focus = True  
End Sub
```

  
  

---

  
💻 Simple Usage Code Snippet Example  
Here is a consolidated, minimal boilerplate based on the concepts above. You can paste this right into a new B4XPage class to kickstart your login screen:  
  

```B4X
B4A=true  
Group=Default Group\Pages  
ModulesStructureVersion=1  
Type=Class  
Version=13.4  
@EndOfDesignText@  
  
'/**  
' * @class KM01SignIn  
' * @description  
' *  Sign-in page for the KUZA app.  
' *  Uses B4XDaisyPageScroll to create a scrollable, responsive layout.  
' */  
#IgnoreWarnings:12  
  
' ELI15: Class_Globals is where we declare variables that every Sub in this page can see and use.  
Sub Class_Globals  
    ' ELI15: Root is the top-level panel of this screen. All other views sit on top of it.  
Private Root As B4XView  
     
    ' ELI15: xui is a cross-platform helper. It gives us a common way to handle colors, layouts, and dialogs across B4A, B4i, and B4J.  
    Private xui As XUI  
     
    ' ELI15: pageScroll is a helper that creates and manages a ScrollView for us, including spacing and auto-sizing.  
Private pageScroll As B4XDaisyPageScroll  
     
    ' ELI15: pnlHost is the inner panel of the ScrollView. Everything added here scrolls with the page.  
Private pnlHost As B4XView  
     
    ' ELI15: txtEmail is the email input field.  
    Private txtEmail As B4XDaisyInput  
     
    ' ELI15: txtPassword is the password input field. It masks typed characters by default.  
    Private txtPassword As B4XDaisyInput  
     
    ' ELI15: btnSubmit is the primary action button that starts the sign-in process.  
    Private btnSubmit As B4XDaisyButton  
  
    ' ELI15: dividerOR is a horizontal line with an 'OR' label that visually separates the two options.  
    Private dividerOR As B4XDaisyDivider  
  
    ' ELI15: btnRegister is a secondary button that opens the registration flow.  
    Private btnRegister As B4XDaisyButton  
    ' ELI15: lnkForgotPassword is a text link for password recovery.  
    Private lnkForgotPassword As B4XDaisyText  
    ' ELI15: chkRememberMe lets the user choose to stay signed in on this device.  
    Private chkRememberMe As B4XDaisyCheckbox  
  
    ' ELI15: avatar is the circular logo/image shown at the top of the screen.  
    Private avatar As B4XDaisyAvatar  
End Sub  
  
''' <summary>  
''' Returns this page instance to B4XPages.  
''' </summary>  
' ELI15: Initialize returns this page instance to B4XPages so it can be managed and shown.  
Public Sub Initialize As Object  
    Return Me  
End Sub  
  
''' <summary>  
''' Called once when the page is first created. Builds the UI layout.  
''' </summary>  
' ELI15: B4XPage_Created runs once when the page is first created. We build the UI layout here.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    ' Store the root panel reference for later use.  
    Root = Root1  
     
    ' ELI15: 1. Set up the scrollable page container so the layout fills the whole screen.  
pageScroll.Initialize(Me, "pageScroll")  
    pageScroll.AddToParent(Root, 0, 0, Root.Width, Root.Height)  
     
    ' ELI15: 2. Get the inner scrollable panel where all controls will be added.  
    pnlHost = pageScroll.Panel  
     
    ' ELI15: 3. Build and position all the form controls.  
    BuildForm  
End Sub  
  
''' <summary>  
''' Called each time the page becomes visible. Focuses the email field.  
''' </summary>  
' ELI15: B4XPage_Appear runs each time the page becomes visible. We focus the email field so the keyboard appears.  
Private Sub B4XPage_Appear  
    ' Notify B4XPages that this page is ready.  
    CallSubDelayed(B4XPages.MainPage, "Page_Ready")  
     
    ' ELI15: Move the cursor into the email field if it is ready.  
    If txtEmail.IsInitialized Then  
        txtEmail.Focus = True  
    End If  
End Sub  
  
''' <summary>  
''' Builds and positions all form controls on the scrollable panel.  
''' </summary>  
' ELI15: BuildForm lays out controls from top to bottom by tracking a 'y' position.  
Private Sub BuildForm  
    ' ELI15: Start the content 12% down from the top of the screen.  
    Dim y As Int = (Root.Height * 12) / 100  
     
    ' ELI15: 0. Add the logo avatar at the top, centered, and load it from the app assets.  
    avatar.Initialize(Me, "avatar")  
    avatar.AddToParent(pnlHost, (pageScroll.UsableWidth - 80dip) / 2, y, 80dip, 80dip)  
    avatar.CenterOnParent = True  
    avatar.setAvatarBitmap(xui.LoadBitmap(File.DirAssets, "kuzamobilitylogo.jpg"), Null)  
    y = y + avatar.GetActualHeight + 8dip  
     
    ' ELI15: 1. Add the centered title below the logo.  
    ' The helper creates a styled label, positions it at coordinate 'y', aligns/centers it if the third  
    ' argument is True, and returns the new vertical coordinate immediately below this title.  
    y = pageScroll.AddSectionTitle("Sign in to your account", y, True)  
     
    ' ELI15: 2. Add the email input field below the title.  
    txtEmail.Initialize(Me, "txtEmail")  
    txtEmail.AddToParent(pnlHost, pageScroll.PagePadding, y, pageScroll.UsableWidth, 40dip)  
    txtEmail.LabelAbove = "Email address"  
    txtEmail.Placeholder = "email@example.com"  
    txtEmail.InputType = "email"  
    txtEmail.Required = True  
    txtEmail.ValidationPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"  
    ' ELI15: Show a 'Next' key on the soft keyboard to move to the password field.  
    txtEmail.ImeOptions = "actionNext"  
     
    ' ELI15: Move the 'y' position down past the email field and its gap.  
    y = y + txtEmail.GetComputedHeight + pageScroll.YGap  
     
    ' ELI15: 3. Add the password input field below the email field.  
    txtPassword.Initialize(Me, "txtPassword")  
    txtPassword.AddToParent(pnlHost, pageScroll.PagePadding, y, pageScroll.UsableWidth, 40dip)  
    txtPassword.LabelAbove = "Password"  
    txtPassword.Placeholder = "Password"  
    txtPassword.HintText = "At least 8 characters"  
    txtPassword.MinLength = 8  
    txtPassword.InputType = "password"  
    txtPassword.PasswordChar = "*"  
    'txtPassword.Text = "password" ' DEBUG ONLY - removed for production  
    txtPassword.Required = True  
    ' txtPassword.MinLength kept at 8 (see above)  
    ' ELI15: Show a 'Done' key on the soft keyboard; pressing it moves focus to the Continue button.  
    txtPassword.ImeOptions = "actionDone"  
     
    ' ELI15: Move the 'y' position down past the password field and its gap.  
    y = y + txtPassword.GetComputedHeight + pageScroll.YGap  
  
    ' ELI15: 3a. (Unused) The password helper text is set via the input component.  
  
    ' ELI15: 3b. (Unused) Forgot password link is placed in the Remember me row instead.  
    ' ELI15: 3c. Add a row with the Remember me checkbox on the left and Forgot password link on the right.  
    Dim rowTop As Int = y  
    Dim rowH As Int = 48dip  
  
    chkRememberMe.Initialize(Me, "chkRememberMe")  
    chkRememberMe.AddToParent(pnlHost, pageScroll.PagePadding, rowTop - 9dip, 160dip, rowH)  
    chkRememberMe.Text = "Remember me"  
    chkRememberMe.Size = "md"  
    chkRememberMe.Checked = False  
  
    lnkForgotPassword.Initialize(Me, "lnkForgotPassword")  
    lnkForgotPassword.AddToParent(pnlHost, pageScroll.PagePadding + 160dip, rowTop, pageScroll.UsableWidth - 160dip, rowH)  
    lnkForgotPassword.Text = "Forgot password?"  
    lnkForgotPassword.Link = True  
    lnkForgotPassword.Underline = True  
    lnkForgotPassword.HAlign = "RIGHT"  
    lnkForgotPassword.TextSize = "text-sm"  
    y = rowTop + rowH + pageScroll.YGap  
     
    ' ELI15: 4. Add the Continue (sign-in) button.  
    btnSubmit.Initialize(Me, "btnSubmit")  
    btnSubmit.AddToParent(pnlHost, pageScroll.PagePadding, y, pageScroll.UsableWidth, 48dip)  
    btnSubmit.Text = "Continue"  
    btnSubmit.Variant = "primary"  
     
    ' ELI15: 5. Add the 'OR' divider between the sign-in and create-account options.  
    ' Place the divider close to the buttons.  
    y = y + btnSubmit.GetComputedHeight + 1dip  
    dividerOR.Initialize(Me, "dividerOR")  
    dividerOR.AddToParent(pnlHost, pageScroll.PagePadding, y, pageScroll.UsableWidth, 20dip)  
    dividerOR.Text = "OR"  
    dividerOR.Margin = "my-0.5"  
    y = y + dividerOR.GetActualHeight + 1dip  
     
    ' ELI15: 6. Add the Create account button as a secondary action.  
    btnRegister.Initialize(Me, "btnRegister")  
    btnRegister.AddToParent(pnlHost, pageScroll.PagePadding, y, pageScroll.UsableWidth, 48dip)  
    btnRegister.Text = "Create account"  
    btnRegister.Variant = "neutral"  
    btnRegister.Style = "outline"  
    y = y + btnRegister.GetComputedHeight + pageScroll.YGap  
     
    ' ELI15: 7. Resize the scroll panel to fit all the controls we added.  
    ' Since we just dynamically added multiple views to pnlHost, the ScrollView needs to know the  
    ' new total height. AutoFit calculates this total height and resizes the scroll canvas  
    ' so that the user can scroll smoothly without cutting off any elements at the bottom.  
    pageScroll.AutoFit  
End Sub  
  
''' <summary>  
''' This event triggers automatically whenever the device screen changes size  
''' (for example, when a user rotates their phone between portrait and landscape modes).  
''' </summary>  
' ELI15: B4XPage_Resize runs when the screen rotates or resizes. We update the scroll container to match.  
Private Sub B4XPage_Resize (Width As Int, Height As Int)  
    ' Update the scroll container to match the new screen size.  
    If pageScroll.IsInitialized Then pageScroll.Base_Resize(Width, Height)  
End Sub  
  
''' <summary>  
''' Called when the Continue button is tapped. Validates inputs and simulates sign-in.  
''' </summary>  
' ELI15: btnSubmit_Click runs when the user taps the Continue button.  
  
''' <summary>  
''' Called when Enter/Next is pressed in the email field. Moves focus to password.  
''' </summary>  
' ELI15: When the user presses Enter in the email field, move focus to the password field.  
Private Sub txtEmail_EnterPressed(Text As String)  
    If txtPassword.IsInitialized Then  
        txtPassword.Focus = True  
    End If  
End Sub  
  
''' <summary>  
''' Called when Enter/Done is pressed in the password field. Moves focus to Continue.  
''' </summary>  
' ELI15: When the user presses Enter in the password field, move focus to the Continue button.  
Private Sub txtPassword_EnterPressed(Text As String)  
    ' ELI15: Move focus to the Continue button.  
    If btnSubmit.IsInitialized Then btnSubmit.Focus = True  
End Sub  
  
Private Sub btnSubmit_Click(Tag As Object)  
    ' ELI15: Check the email field. If it is invalid, focus it and stop.  
    Dim emailValid As Boolean = txtEmail.Validate  
    If emailValid = False Then  
        txtEmail.Focus = True  
        Return  
    End If  
  
    ' ELI15: Check the password field. If it is invalid, focus it and stop.  
    Dim passwordValid As Boolean = txtPassword.Validate  
    If passwordValid = False Then  
        txtPassword.Focus = True  
        Return  
    End If  
    ' ELI15: Show a loading spinner on the Continue button while signing in.  
    btnSubmit.Loading = True  
     
    ' ELI15: Wait briefly to simulate a network call. Replace this with real authentication later.  
    Sleep(2000)  
  
    ' ELI15: Hide the loading spinner once the simulated call finishes.  
    btnSubmit.Loading = False  
End Sub  
  
''' <summary>  
''' Called when the Create account button is tapped. Opens the user-type selection page.  
''' </summary>  
Private Sub btnRegister_Click(Tag As Object)  
    B4XPages.ShowPage("KM01TypeOfUser")  
End Sub  
  
''' <summary>
```

  
  
I hope this helps lower the barrier to entry for beginners looking to make beautiful, functional UI in B4X! Let me know if you have any questions below. Happy Coding! 🚀  
  
  
[MEDIA=youtube]O89YPJEyQvE[/MEDIA]  
  
  
  
**Related Content**  
  
<https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisy-ui-kit-native-components-inspired-by-daisyui-tailwind.170352/>  
  
<https://www.b4x.com/android/forum/threads/b4xdaisyuikit-towards-your-i-know-kung-fu-moment.171381/>