### Use Face ID Touch ID and Passcode by Alexander Stolte
### 03/04/2021
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/128301/)

This is a short tutorial/code snippet on how to successfully implement Touch ID in your app.  
Thanks to [USER=106971]@Semen Matusovskiy[/USER] for his code.  
  
You need this OBJC Code  

```B4X
#IF OBJC  
#import <LocalAuthentication/LocalAuthentication.h>  
- (void) authenticateButtonTapped  
    {  
   __result = -1;   
   LAContext *context = [[LAContext alloc] init];  
   NSError *error = nil;  
   if ([context canEvaluatePolicy: LAPolicyDeviceOwnerAuthentication error: &error])  
       {  
       [context evaluatePolicy: LAPolicyDeviceOwnerAuthentication localizedReason: @"Are you the device owner?" reply: ^(BOOL success, NSError *error)  
           {  
           if (error) { __result = 2; return; };  
           if (success) { __result = 0; } else { __result = 1; };  
           }  
       ];  
       }  
    else  
       { __result = 3; };  
    }  
#End If
```

  
Call it with this:  

```B4X
    Dim no As NativeObject = B4XPages.GetManager.GetTopPage.B4XPage 'if you dont use B4XPages then use "Me"  
    no.RunMethod ("authenticateButtonTapped", Null)  
    Do While result < 0  
        Sleep (50)  
    Loop  
    Select Case result  
        Case 0  
            xui.MsgboxAsync ("Success: You are the device owner", "B4X")  
        Case 1  
            xui.MsgboxAsync ("Error: You are not the device owner", "B4X")  
        Case 2  
            xui.MsgboxAsync ("Error: There was a problem verifying your identity", "B4X")  
        Case 3  
            xui.MsgboxAsync ("Error: Your device cannot authenticate using TouchID", "B4X")  
    End Select
```

  
  
This code asks for the Face ID, if this fails, then you have the choice to enter your pin code.