### [beta] Forcing the app orientation at runtime by Erel
### 03/03/2024
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/159638/)

Add to main module:  

```B4X
#if OBJC  
@end  
@interface B4IAppDelegate (orientation)  
@end  
@implementation B4IAppDelegate (orientation)  
- (UIInterfaceOrientationMask)application:(UIApplication *)application   
  supportedInterfaceOrientationsForWindow:(UIWindow *)window {  
    return [b4i_main new]._morientation;  
}  
#End If
```

  
  

```B4X
Public Sub SetSupportedOrientation(Orientation As Int)  
    mOrientation = Orientation  
    If App.KeyController <> Null Then  
        App.KeyController.As(NativeObject).RunMethod("setNeedsUpdateOfSupportedInterfaceOrientations", Null)  
    End If  
End Sub
```

  
  
And Process\_Globals:  

```B4X
    Public const ORIENTATION_PORTRAIT = 2, ORIENTATION_LANDSCAPE = 24, ORIENTATION_ALL = 30 As Int  
    Private mOrientation As Int = ORIENTATION_ALL 'ignore
```

  
  
Call Main.SetSupportedOrientation to change orientation.  
  
Tested on iOS 17.