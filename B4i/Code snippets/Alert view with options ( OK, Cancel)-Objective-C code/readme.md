### Alert view with options ( OK, Cancel)-Objective-C code by jkhazraji
### 02/17/2025
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/165516/)

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4i Example  
    #Version: 1.0.0  
    'Orientation possible values: Portrait, LandscapeLeft, LandscapeRight and PortraitUpsideDown  
    #iPhoneOrientations: Portrait, LandscapeLeft, LandscapeRight  
    #iPadOrientations: Portrait, LandscapeLeft, LandscapeRight, PortraitUpsideDown  
    #Target: iPhone, iPad  
    #ATSEnabled: True  
    #MinVersion: 8  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public App As Application  
    Public NavControl As NavigationController  
    Private Page1 As Page  
    Private xui As XUI  
End Sub  
  
Private Sub Application_Start (Nav As NavigationController)  
    NavControl = Nav  
    Page1.Initialize("Page1")  
    Page1.RootPanel.LoadLayout("Page1")  
    NavControl.ShowPage(Page1)  
   
End Sub  
  
Sub Button1_Click  
    Dim NativeMe As NativeObject = Me  
    NativeMe.RunMethod("alertShow",Null)  
End Sub  
  
Sub cancel_clicked(msg As String)  
    Log(msg)  
End Sub  
Sub ok_clicked (msg As String)  
    Log(msg)  
End Sub  
#If OBJC  
- (void) alertShow{  
    UIAlertView *alert = [[UIAlertView alloc]  
       initWithTitle:@"Make a choice"  
       message:nil  
       delegate:self  
       cancelButtonTitle:@"Cancel"  
       otherButtonTitles:@"OK", nil];  
    [alert show];  
        
}  
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {  
    if (buttonIndex == 0) {  
        NSLog(@"Cancel Tapped.");  
        [self.bi raiseEvent:nil event:@"cancel_clicked:" params:@[@"Cancel Tapped"]];  
    }  
    else if (buttonIndex == 1) {  
        NSLog(@"OK Tapped. Hello World!");  
        [self.bi raiseEvent:nil event:@"ok_clicked:" params:@[@"OK. Hello World"]];  
    }  
}  
#End if
```

  
  
![](https://www.b4x.com/android/forum/attachments/161556)