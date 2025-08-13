###  [B4XDialog] Custom CANCEL ad CONFIRM buttons by GianniGntl
### 08/24/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/149780/)

Hi.  
While developing an application project for a customer, the request to modify the modal B4XDialog emerged.  
![](https://www.b4x.com/android/forum/attachments/145068)  
Specifically, the presence of the cancel cross on the right of the title bar was required (rather than the button at the bottom), and also a single confirmation button centered at the bottom that occupies the entire width of the box.  
![](https://www.b4x.com/android/forum/attachments/145069)  
We don't want to modify the source code, but use the original B4XDialog.bas as-is.  
Investigating the source code, it turns out that the "TitleBar" panel and the command labels are created during the Sub ShowCustom, therefore we have no control over them until the Wait For is executed.  
Here's the trick: we execute the Wait For in a Sub call, and since it returns control to the caller store the ResumableSub Object returned from ShowTemplate(), so we can work on the interface elements when they are already displayed, and finally program Wait(s) for resumable to complete.  

```B4X
' Standard dialog, code taken from docs  
' =====================================  
Private Sub Button1_Click  
    xDialog.Title = "Standard Dialog"  
    
    xListTemplate.Initialize  
    xListTemplate.Options = Array("Cat", "Dog", "Fish", "Crocodile")  
    
    Wait For (xDialog.ShowTemplate(xListTemplate, "OK", "", "Cancel")) Complete (Result As Int)  
    If Result = xui.DialogResponse_Positive Then  
        xDialog.Show($"You selected: ${xListTemplate.As(B4XListTemplate).SelectedItem}"$, "OK", "", "")  
    End If  
End Sub  
  
' Customized dialog: Cancel button sided right on title bar, Confirm button taking full width  
' ===========================================================================================  
Private Sub Button2_Click  
    xDialog.Title = "Custom Dialog"  
      
    xListTemplate.Initialize  
    xListTemplate.Options = Array("Cat", "Dog", "Fish", "Crocodile")  
      
    'xDialog.ButtonsColor = 0xFFFFFFFF  
    xDialog.ButtonsOrder = Array As Int(xui.DialogResponse_Cancel, xui.DialogResponse_Positive, xui.DialogResponse_Negative)  
      
    ' do not Wait For Complete here, but later using a ResumableSub, so we retake control of program flow  
    ' and modify layout after it is created  
    ' specify any text as Cancel object, in this case its a FA boxed X  
    Dim rs As ResumableSub = xDialog.ShowTemplate(xListTemplate, "OK", "", Chr(0xF2D4))  
      
    ' now dialog is waiting for user input, modify on-the-fly  
    Dim titleBar As B4XView = xDialog.TitleBar  
    If titleBar.IsInitialized Then  
        Dim lblCancel As B4XView = xDialog.GetButton(xui.DialogResponse_Cancel)  
        If lblCancel.IsInitialized Then  
            lblCancel.RemoveViewFromParent  
            ' here goes the customization  
            lblCancel.Color = 0  
            lblCancel.TextColor = 0xffffffff  
#If B4J  
            lblCancel.Font = xui.CreateFontAwesome(lblCancel.TextSize * 0.8)  
            lblCancel.As(Button).Alignment = "TOP_RIGHT"  
            titleBar.AddView(lblCancel, titleBar.Width - 40dip, 0, 45dip, titleBar.Height) ' right alignment  
#Else  
            lblCancel.Font = xui.CreateFontAwesome(lblCancel.TextSize * 1.5)  
            titleBar.AddView(lblCancel, titleBar.Width - 31dip, 1dip, 30dip, 30dip) ' right alignment  
#End If  
        End If  
    End If  
    ' customizing Confirm button  
    Dim lblConfirm As B4XView = xDialog.GetButton(xui.DialogResponse_Positive)  
    lblConfirm.SetLayoutAnimated(0, 4dip, lblConfirm.Top, lblConfirm.Left + lblConfirm.Width - 4dip, lblConfirm.Height)  
    lblConfirm.SetColorAndBorder(0xFFFFFFFF, 1dip, 0xFF909090, 3dip)  
      
    Wait For (rs) Complete (Result As Int)  
      
    If Result = xui.DialogResponse_Positive Then  
        xDialog.Show($"You selected: ${xListTemplate.As(B4XListTemplate).SelectedItem}"$, "OK", "", "")  
    End If  
End Sub
```

  
In particular, we reuse the Cancel element (removing from parent ad adding to TitleBar) in order to reuse attached Click event.  
  
Attached is the B4X project; in the layout, two buttons: the first to display the standard dialog, the second for the custom one.  
  
Regards.