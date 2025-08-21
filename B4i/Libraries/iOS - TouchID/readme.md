### iOS - TouchID by narek adonts
### 11/05/2019
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/55018/)

Hi All,  
  
This code will allow to use the TouchID (Fingerprint) in your app.  
The example is on a button named Button with click event.  
  
I was thinking to build a class for this but I think this is more comfortable to copy the source and modify the subs.  
  
  

```B4X
#PlistExtra: <key>NSFaceIDUsageDescription</key<string>Uses face id to allow authentication</string>  
Sub Button_Click  
ShowTouchID(Me,"TouchOK", "TouchFail")  
End Sub  
  
  
Sub ShowTouchID(SubHandler As Object, ApprovedSub As String, FailSub As String)  
Dim noMe As NativeObject=Me  
noMe.RunMethod("TouchID:::",Array(SubHandler,ApprovedSub,FailSub))  
End Sub  
  
Sub TouchOK  
Log("Touch Approved")  
End Sub  
  
Sub TouchFail(ErrorDescription As String)  
Log(ErrorDescription)  
End Sub  
  
#If OBJC  
  
#import <LocalAuthentication/LocalAuthentication.h>  
  
-(void)TouchID :(NSObject*)handler :(NSString*) subnameok :(NSString*) subnamefail  
{  
LAContext *myContext = [[LAContext alloc] init];  
NSError *authError = nil;  
NSString *myLocalizedReasonString = @"Used for quick and secure access to the test app";  
if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {  
    [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics  
                  localizedReason:myLocalizedReasonString  
                            reply:^(BOOL success, NSError *error) {  
            if (success) {  
                [self.__c CallSubDelayed:self.bi :handler :(subnameok)];  
            } else {  
                [self.__c CallSubDelayed2:self.bi :handler :(subnamefail) :(error.localizedDescription)];  
            }  
        }];  
} else {  
[self.__c CallSubDelayed2:self.bi :handler :(subnamefail) :(authError.localizedDescription)];  
  
}  
}  
  
  
#End If
```

  
  
  
Ask if you have any questions  
  
Narek