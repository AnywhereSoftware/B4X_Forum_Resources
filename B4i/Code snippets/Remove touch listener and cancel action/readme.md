### Remove touch listener and cancel action by Erel
### 08/04/2020
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/120896/)

While building the Pleroma client (<https://www.b4x.com/android/forum/threads/b4x-b4xpages-pleroma-mastodon-client-step-1.119426/>), I've encountered several cases where the touch events had some unwanted behavior.  
The reason for this, is that there are multiple stacked views that listen for the touch events: B4XDrawer, xCustomListView (= ScrollView) and panels that hold the modified BBCodeViews.  
  
Two things that help improve the touch events behavior:  
  
1. Removing the built-in click event of CLV.   

```B4X
CLV.Add(pnl, Value)  
#if B4i  
RemoveClickRecognizer(pnl)      
#End If  
  
#if B4i  
Private Sub RemoveClickRecognizer (pnl As B4XView)  
    Dim no As NativeObject = pnl.Parent  
    Dim recs As List = no.GetField("gestureRecognizers")  
    For Each rec As Object In recs  
        no.RunMethod("removeGestureRecognizer:", Array(rec))  
    Next  
End Sub  
#End If
```

  
  
2. Adding a special action value to cancelled touch gestures.   
  
By default, touch events start with ACTION\_DOWN, followed by zero or more ACTION\_MOVE events and end with ACTION\_UP event.   
There are some cases where the ACTION\_UP event happens because the touch gesture was cancelled.  
It can happen, for example, when the user touches a panel inside a ScrollView and starts moving the finger slowly. At some point the ScrollView starts treating it as a "scrolling" gesture and the panel will receive an ACTION\_UP event although the user didn't really lift the finger.  
  
We can change this behavior by adding this code to the main module:  

```B4X
#if OBJC  
@end  
@interface B4IPanelView  (touchcancelled)  
@end  
@implementation B4IPanelView  (touchcancelled)  
  
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {  
        B4I* bi = [self valueForKey:@"bi"];  
        NSString* eventName = [self valueForKey:@"eventName"];  
        for (UITouch *u in touches) {  
            CGPoint p = ;  
            [bi raiseEvent:self event:eventName params:@[@4, @(p.x), @(p.y)]];  
        }  
}  
#End If
```

  
  
It will cause the touch event to be raised with action = 4 and will allow us to treat this differently.