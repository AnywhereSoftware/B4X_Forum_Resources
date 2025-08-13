### Flip View - 3D Flip Animation by Alexander Stolte
### 11/15/2024
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/164142/)

![](https://www.b4x.com/android/forum/attachments/158646)  
  

```B4X
FlipView(xlbl_AddIcon,500,False,True,180,False)
```

  
  

```B4X
Sub FlipView(View As View, DurationMs As Int, xAxis As Boolean, yAxis As Boolean, Angle As Double, Reset As Boolean)  
    Dim no As NativeObject = Me  
    no.RunMethod("flipView:duration:xAxis:yAxis:angle:reset:", Array(View, DurationMs, xAxis, yAxis, Angle * cPI / 180, Reset))  
End Sub
```

  
  

```B4X
#if OBJC  
- (void)flipView:(UIView *)view duration:(int)DurationMs xAxis:(BOOL)xAxis yAxis:(BOOL)yAxis angle:(double)angle reset:(BOOL)resetTransform {  
    [UIView animateWithDuration:DurationMs / 1000.0  
                          delay:0.0f  
                        options:UIViewAnimationOptionCurveEaseOut  
                     animations:^{  
        // Add perspective for a 3D effect  
        CATransform3D transform = CATransform3DIdentity;  
        transform.m34 = -1.0 / 500.0; // Sets the perspective depth  
  
        // Apply rotation based on the specified axes  
        if (xAxis) {  
            transform = CATransform3DRotate(transform, angle, 1.0, 0.0, 0.0); // Rotate around the X-axis  
        }  
        if (yAxis) {  
            transform = CATransform3DRotate(transform, angle, 0.0, 1.0, 0.0); // Rotate around the Y-axis  
        }  
  
        // Apply the 3D transformation to the view's layer  
        view.layer.transform = transform;  
    } completion:^(BOOL finished) {  
        // Reset the transformation if `resetTransform` is true  
        if (resetTransform) {  
            view.layer.transform = CATransform3DIdentity;  
        }  
    }];  
}  
#end if[/CODE]
```