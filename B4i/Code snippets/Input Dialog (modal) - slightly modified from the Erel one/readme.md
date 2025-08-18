### Input Dialog (modal) - slightly modified from the Erel one by Mike1970
### 12/30/2020
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/126027/)

The original code: <https://www.b4x.com/android/forum/threads/inputdialog-function.52811/post-331242>  
  
I modified the code to be able to add two buttons, and receive the "Success" parameter to distinguish when the user tap on the positive button or cancel button.  
![](https://www.b4x.com/android/forum/attachments/105183)  
  

```B4X
Sub Button1_Click  
    Dim no As NativeObject = Me  
    no.RunMethod("ShowInputDialog::::", Array("Title", "Text", "Cancel", "Confirm"))  
End Sub  
  
Sub InputDialog_Result(Success As Boolean, Text As String)  
    Log(Success)  
    Log(Text)  
End Sub  
  
#If OBJC  
- (void)ShowInputDialog:(NSString*)Title :(NSString*)Message :(NSString*)CancelButtonText :(NSString*)PositiveButtonText{  
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:Title  
      
    /*if (CancelButtonText == @"") {  
        CancelButtonText = nil;  
    }  
      
    if (PositiveButtonText == @"") {  
        PositiveButtonText = nil;  
    }*/  
      
    message:Message delegate:self cancelButtonTitle:CancelButtonText otherButtonTitles:PositiveButtonText, nil];  
      
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;  
    alert.delegate = self;  
    [alert show];  
}  
  
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {  
    if (buttonIndex == 1) {  
        [self.bi raiseEvent:nil event:@"inputdialog_result::" params:@[@1, [[alertView textFieldAtIndex:0] text]]];  
    }  else {  
        [self.bi raiseEvent:nil event:@"inputdialog_result::" params:@[@0, @""]];  
    }  
}  
#End If
```

  
  
Something missing: i commented out a block of code, i wanted to check if the text for the two button are empty.. in that case i wish to set the text to "nil" so the button will not be displayed. I did not managed to get that part working, so if someone knows how to do, let's integrate the snippet by commenting below :D