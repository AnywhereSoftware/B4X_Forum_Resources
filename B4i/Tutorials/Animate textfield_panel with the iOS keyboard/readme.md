### Animate textfield/panel with the iOS keyboard by Alexander Stolte
### 04/15/2025
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/166626/)

This post presents an implementation of animations that animate alongside the iOS keyboard animation. Following the method in this post will allow your views to animate smoothly when the iOS keyboard shows and hides.  
  
A big thanks to [USER=1]@Erel[/USER] who provided code to read the UIKeyboardAnimationDurationUserInfoKey when the keyboard opens or closes:  
<https://www.b4x.com/android/forum/threads/get-uikeyboardanimationdurationuserinfokey-and-get-uikeyboardanimationcurveuserinfokey.166554/post-1021633>  
  
[MEDIA=youtube]rjL8DB937sU[/MEDIA]  
  
I have changed the code from the original post so that you can also read the UIKeyboardAnimationCurveUserInfoKey.  
Add this objc code to the end of one of the modules:  

```B4X
#if OBJC  
@end  
@interface B4IViewController (Keyboard2)  
@end  
@implementation B4IViewController (Keyboard2)  
- (void) addWillHide {  
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];  
}  
- (void)keyboardWillShow:(NSNotification *)notification {  
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;  
    [self storeAnimationInfo:notification];  
    [B4IObjectWrapper raiseEvent:self :@"_keyboardstatechanged:" :@[@(keyboardSize.height)]];  
}  
- (void)storeAnimationInfo:(NSNotification*)notification {  
    NSDictionary *userInfo = [notification userInfo];  
    double duration = ((NSNumber*)[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]).doubleValue;  
    NSInteger curve = ((NSNumber*)[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]).integerValue;  
      
    NSMutableDictionary *map = [B4IObjectWrapper getMap:self];  
    map[@"animation_duration"] = @(duration);  
    map[@"animation_curve"] = @(curve);  
}  
  
- (void)keyboardDidHide:(NSNotification *)notification {  
    [self storeAnimationInfo:notification];  
    [B4IObjectWrapper raiseEvent:self :@"_keyboardstatechanged:" :@[@(0)]];  
}  
#end if
```

  
This code also adds the "will hide" event (<https://www.b4x.com/android/forum/threads/keyboard-will-hide-notification.126640/#content>). Note that the KeyboardStateChanged event will be raised twice when the keyboard closes.  
  
This is the code for animating our text field or panel that can be placed directly under the other objc code:  

```B4X
#if OBJC  
@end  
@interface B4IViewController (KeyboardAnimator)  
@end  
@implementation B4IViewController (KeyboardAnimator)  
  
- (void)animateView:(UIView *)view  
       toYPosition:(CGFloat)y  
          duration:(double)duration  
             curve:(NSInteger)curve {  
      
    UIViewAnimationCurve animCurve = (UIViewAnimationCurve)curve;  
  
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc]  
        initWithDuration:duration  
        curve:animCurve  
        animations:^{  
            CGRect frame = view.frame;  
            frame.origin.y = y;  
            view.frame = frame;  
            [self.view layoutIfNeeded];  
    }];  
      
    [animator startAnimation];  
}  
  
#end if
```

  
  
In B4XPage\_Created call this:  

```B4X
#if B4i  
    Dim no As NativeObject = B4XPages.GetNativeParent(Me) 'or Page1 in non-B4XPages project.  
    no.RunMethod("addWillHide", Null)  
#End If
```

  
  
Read out everything and animate the text field:  

```B4X
Private Sub B4XPage_KeyboardStateChanged (Height As Float)  
    m_KeyboardHeight = Height  
    Dim ow As NativeObject  
    Dim duration As Int = ow.Initialize("B4IObjectWrapper").RunMethod("getMap:", Array(B4XPages.GetNativeParent(Me))) _  
        .RunMethod("objectForKey:", Array("animation_duration")).AsNumber * 1000  
    Log("duration in ms: " &  duration)  
    Log("keyboard state changed: " & Height)  
          
    Dim curveIndex As Int = ow.Initialize("B4IObjectWrapper").RunMethod("getMap:", Array(B4XPages.GetNativeParent(Me))) _  
    .RunMethod("objectForKey:", Array("animation_curve")).AsNumber  
    Log("curve: " & curveIndex)  
          
    Dim Page As NativeObject = B4XPages.GetNativeParent(Me)  
    If Height > 0 Then 'Keyboard is open  
        xpnl_AddNewGroup.Top = Root.Height - xpnl_AddNewGroup.Height  
        Page.RunMethod("animateView:toYPosition:duration:curve:", Array(xpnl_AddNewGroup, Root.Top + Root.Height - Height - xpnl_AddNewGroup.Height, duration, curveIndex))  
    Else 'Keyboard is closed  
        Page.RunMethod("animateView:toYPosition:duration:curve:", Array(xpnl_AddNewGroup,Root.Height - xpnl_AddNewGroup.Height - B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom, duration, curveIndex))  
    End If  
          
End Sub
```

  
  
Example project is attached.