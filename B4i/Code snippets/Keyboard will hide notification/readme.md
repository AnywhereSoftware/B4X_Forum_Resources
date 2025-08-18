### Keyboard will hide notification by Erel
### 01/18/2021
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/126640/)

The KeyboardStatePage event is raised before the keyboard becomes visible and after the keyboard is hidden.  
There are cases where you want to do something right before the keyboard is closed. For example, to start moving a view.  
  
1. Add to Main module at the bottom:  

```B4X
#if OBJC  
@end  
@interface B4IViewController (KeyboardWillHide)  
@end  
@implementation B4IViewController (KeyboardWillHide)  
- (void) addWillHide {  
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];  
}  
#end if
```

  
  
2. In B4XPage\_Created:  

```B4X
#if B4i  
Dim no As NativeObject = B4XPages.GetNativeParent(Me) 'or Page1 in non-B4XPages project.  
no.RunMethod("addWillHide", Null)  
#End If
```

  
  
The B4XPage\_KeyboardStateChanged will be raised twice with height = 0.