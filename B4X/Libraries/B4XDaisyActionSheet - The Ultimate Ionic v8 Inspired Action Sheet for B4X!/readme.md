###  B4XDaisyActionSheet - The Ultimate Ionic v8 Inspired Action Sheet for B4X! by Mashiane
### 07/05/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/171467/)

Hello Fam!👋  
  
Are you looking to modernize your app's user interface with beautiful, responsive, and highly-customizable action sheets? Look no further!  
Introducing **B4XDaisyActionSheet**, a robust component that brings **100% parity with the Ionic v8 ion-action-sheet**. Whether you are building for Android, iOS, or Desktop, this component will make your bottom-sheet menus look absolutely stunning.  
  
![](https://www.b4x.com/android/forum/attachments/172189) ![](https://www.b4x.com/android/forum/attachments/172190) ![](https://www.b4x.com/android/forum/attachments/172191) ![](https://www.b4x.com/android/forum/attachments/172192) ![](https://www.b4x.com/android/forum/attachments/172193) ![](https://www.b4x.com/android/forum/attachments/172194) ![](https://www.b4x.com/android/forum/attachments/172195)  
  
**✨ Key Features & Highlights:**  

- **Dual Platform Modes:** Seamlessly switch between Material Design (md) and ios rendering modes.
- **Translucent Glass Effects:** Enable stunning frosted-glass aesthetics, perfectly complementing modern UI designs.
- **DaisyUI Theming:** Fully integrate with DaisyUI color variants! Easily set properties like BackgroundColor, ButtonColor, and TextColor using variant names like *primary*, *secondary*, *success*, *warning*, and *error*.
- **Rich Button Customizations:** Support for ghosted or solid buttons, customizable tailwind button sizes (xs, sm, md, lg, xl), and individual button coloring.
- **Strict Interactions:** Need the user to make a choice? Simply set BackdropDismiss to False to force a mandatory selection.

**🛠️ Beginner-Friendly Quick Start Guide:**  
Getting started is incredibly easy. Here is a simple snippet showing how to initialize the action sheet, set up its properties using a Map, add some buttons, and trap the user's selection in the DidDismiss event.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    ' Declare our component  
    Private myActionSheet As B4XDaisyActionSheet  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.Color = xui.Color_White  
  
    ' 1. Initialize the Component  
    ' Pass 'Me' as the callback and an EventName prefix  
    myActionSheet.Initialize(Me, "myActionSheet")  
  
    ' 2. Create the View & Set Properties  
    ' We use CreateMap to pass properties like Header, SubHeader, and Mode [1, 5]  
    myActionSheet.DesignerCreateView(Root, Null, CreateMap( _  
        "Header": "Select Action", _  
        "SubHeader": "What would you like to do?", _  
        "Mode": "md", _  
        "BackdropDismiss": True _  
    ))  
  
    ' 3. Add Buttons (Id, Text, Role, Icon)  
    ' Roles can dictate styling behavior, e.g., "cancel", "destructive", or "" [7]  
    myActionSheet.AddButton("btn_share", "Share", "", "share_icon")  
    myActionSheet.AddButton("btn_delete", "Delete", "destructive", "delete_icon")  
    myActionSheet.AddButton("btn_cancel", "Cancel", "cancel", "cancel_icon")  
      
    ' Optional: Attach custom data to a specific button [8]  
    myActionSheet.SetButtonData("btn_share", "https://b4x.com")  
End Sub  
  
' Trigger this sub from a button click on your page  
Private Sub Button1_Click  
    ' 4. Present the Action Sheet! [9]  
    myActionSheet.Present  
End Sub  
  
' 5. Trap the Dismiss Event  
' This event fires when a button is clicked or the backdrop is tapped [1]  
Private Sub myActionSheet_DidDismiss(Data As Object, Role As String)  
    If Role = "cancel" Or Role = "backdrop" Then  
        Log("Action Sheet was dismissed or cancelled.")  
    Else If Role = "destructive" Then  
        Log("User chose a destructive action!")  
    Else  
        Log("Standard action executed! Data: " & Data)  
    End If  
End Sub
```

  
  
Let me know what you think below, and feel free to share screenshots of how you're styling it in your own apps! Happy coding! 🚀  
  
[MEDIA=youtube]lNXmb5SscQ0[/MEDIA]