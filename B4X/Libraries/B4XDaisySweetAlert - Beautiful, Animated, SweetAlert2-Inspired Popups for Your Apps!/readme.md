###  B4XDaisySweetAlert - Beautiful, Animated, SweetAlert2-Inspired Popups for Your Apps! by Mashiane
### 06/24/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171374/)

Hello Fam! 👋  
  
Are you looking to replace standard, boring system dialog boxes with something more engaging and modern? I'm excited to share the enhanced **B4XDaisySweetAlert** component!  
Heavily inspired by the popular SweetAlert2 library, this B4X wrapper provides stunning, fully customizable modal popups that work seamlessly across your projects. It has been highly optimized to make onboarding incredibly easy for both beginners and veterans alike.  
  
✨ Key Features & Enhancements  

- **Animated Icons:** No external image files needed! The component uses optimized canvas drawing to animate icons natively at ~60fps. Supported built-in icons include: success, error, warning, info, question, and loading.
- **Highly Customizable UI:** Easily change the title, body text, background color, text color, and icon tint natively from the designer or via code.
- **Rich Button Controls:** Configure Confirm, Deny, and Cancel buttons. You can even reverse the button order or add an optional footer text.
- **Auto-Close Timer:** Want a non-intrusive alert? Set TimerMs to auto-dismiss the popup after a set duration.
- **Smart Click Behaviors:** Toggle AllowOutsideClick to decide if tapping the backdrop dismisses the modal.
- **Async/Promise Ready:** Features a ShowAsync resumable sub and resolves states nicely into a custom B4XDaisySweetAlertResult object so you can easily track exactly how the user interacted with the popup.

![](https://www.b4x.com/android/forum/attachments/172024) ![](https://www.b4x.com/android/forum/attachments/172025) ![](https://www.b4x.com/android/forum/attachments/172026) ![](https://www.b4x.com/android/forum/attachments/172027)  
  
  
🛠️ Simple Usage Example (Beginner Friendly!)  
  
It's extremely easy to set up. Below is a simple B4XPage example showing how to initialize the component, modify its properties, show the alert, and trap the result event.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' 1. Declare the component  
    Private mySweetAlert As B4XDaisySweetAlert  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.Color = xui.Color_White  
      
    ' 2. Initialize the component (Pass the Callback, Parent View, and Event Name)  
    mySweetAlert.Initialize(Me, Root, "mySweetAlert") '[14]  
      
    ' Example: Trigger the alert via a button click  
    Dim btn As Button  
    btn.Initialize("btnShowAlert")  
    btn.Text = "Show Alert"  
    Root.AddView(btn, 50dip, 50dip, 200dip, 50dip)  
End Sub  
  
Private Sub btnShowAlert_Click  
    ' 3. Set properties dynamically before showing  
    mySweetAlert.Title = "Delete File?" '[15]  
    mySweetAlert.Text = "You will not be able to revert this!" '[15]  
    mySweetAlert.Icon = "warning" ' Triggers the animated warning icon [15]  
    mySweetAlert.ShowConfirmButton = True '[16]  
    mySweetAlert.ShowCancelButton = True '[7]  
    mySweetAlert.ConfirmButtonText = "Yes, delete it!" '[6]  
    mySweetAlert.AllowOutsideClick = False '[8]  
      
    ' 4. Show the alert asynchronously  
    mySweetAlert.ShowAsync '[12]  
      
    ' 5. Trap the result using Wait For (Beginner friendly async flow)  
    Wait For mySweetAlert_Result (Result As B4XDaisySweetAlertResult) '[2]  
      
    ' 6. Handle the result   
    If Result.IsConfirmed Then '[13]  
        Log("User confirmed the action!")  
          
        ' Show a success followup popup  
        mySweetAlert.Title = "Deleted!"  
        mySweetAlert.Text = "Your file has been deleted."  
        mySweetAlert.Icon = "success"  
        mySweetAlert.ShowCancelButton = False  
        mySweetAlert.ShowAsync  
          
    Else If Result.IsDismissed Then '[13]  
        Log("User canceled or dismissed the alert. Reason: " & Result.Dismiss) '[13]  
    End If  
End Sub
```

  
  
**Pro Tip:** If you ever need to perform a background task (like fetching data or downloading a file), you can call mySweetAlert.showLoading to disable the buttons and display a spinning loading animation, and then call mySweetAlert.hideLoading when you are done!.  
  
Give it a try and let me know your thoughts below! Enjoy building beautiful apps! 🎨  
  
  
[MEDIA=youtube]\_\_B1sNKG8Mc[/MEDIA]