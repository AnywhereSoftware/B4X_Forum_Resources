### Apple pencil interaction by Blueforcer
### 09/14/2023
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/151350/)

This inline code detects doubletaps on the Apple Pencil  
  

```B4X
Dim no As NativeObject = Me  
no.RunMethod("addPencilDoubleTapRecognizer:", Array(AnyView))  
  
Private Sub PencilDoubleTapped  
    ' This event is raised when a double-tap is detected by the Apple Pencil  
End Sub  
  
#if OBJC  
  
#import <UIKit/UIKit.h>  
  
- (void)addPencilDoubleTapRecognizer:(UIView *)targetView {  
    if (@available(iOS 12.1, *)) {  
        UIPencilInteraction *pencilInteraction = [[UIPencilInteraction alloc] init];  
        pencilInteraction.delegate = self;  
        [targetView addInteraction:pencilInteraction];  
    }  
}  
  
- (void)pencilInteractionDidTap:(UIPencilInteraction *)interaction {  
    // Call back to B4i event  
    [self.bi raiseEvent:nil event:@"pencildoubletapped" params:nil];  
}  
  
#End If
```