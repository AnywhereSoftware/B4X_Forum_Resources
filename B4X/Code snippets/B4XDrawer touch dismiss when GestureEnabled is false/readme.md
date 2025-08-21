###  B4XDrawer touch dismiss when GestureEnabled is false by Andrew (Digitwell)
### 11/13/2019
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/111350/)

I'm not sure if this is a feature of not, but I noticed that if the GestureEnabled flag is set to False, touching on the dark part of the screen 'outside' of the drawer does not dismiss the drawer.  
  
To enable this, you need to add a a couple of lines to the start of the **Base\_onTouchEvent** sub  

```B4X
'Before  
  If mEnabled = False then return False  
'After  
  If mEnabled = False Then  
        CancelDrawer  
        Return False  
    End If
```

  
  

```B4X
private Sub CancelDrawer  
    If IsOpen Then  
        setLeftOpen(False)  
    End If  
End Sub
```

  
  
For the iOS version, you need to Add CancelDrawer to Sub **Pan\_Event**  

```B4X
    Select state  
        Case 1 'began  
            If mEnabled = False Then  
                CancelDrawer  
                CancelGesture(rec)  
                Return  
            End If
```