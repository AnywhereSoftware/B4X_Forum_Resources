### Animation with SetLayoutAnimated (Again) by rraswisak
### 01/09/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/112844/)

Hi All,  
  
This is another example of using **SetLayoutAnimated** method that we can use to create animation. My previous example you can look at [here](https://www.b4x.com/android/forum/threads/animation-with-setlayoutanimated.107852/post-674227).  
  
Here is for main sub:  

```B4X
Sub Animated(l1 As Long, l2 As Long, t1 As Long, t2 As Long)  
    Dim p As B4XView = xui.CreatePanel("")  
    Activity.AddView(p, Rnd(l1,l2), Rnd(t1,t2), 30dip, 30dip)  
    p.SendToBack 'this is optional  
    p.SetColorAndBorder(xui.Color_ARGB(255, Rnd(0,255), Rnd(0,255), Rnd(0,255)), 0dip, xui.Color_White, Rnd(0,20))  
    p.SetLayoutAnimated(1000, Rnd(l1,l2), Rnd(t1,t2), 5dip, 5dip)  
    p.SetVisibleAnimated(1000, False)  
    Sleep(1000)  
    p.RemoveViewFromParent  
End Sub
```

  
  
  
In this sample i want to apply animation to one or any of view around them, i want to show animation when a button (SwiftButton) was clicked;  

```B4X
Sub SwiftButton1_Click  
    Dim l1, l2, t1, t2 As Long  
    Dim btn As SwiftButton = SwiftButton1  
    
    l1 = btn.mBase.Left - 50dip  
    l2 = btn.mBase.Left + btn.mBase.Width + 50dip  
    t1 = btn.mBase.Top - 50dip  
    t2 = btn.mBase.Top + btn.mBase.Height + 50dip  
    
    For i = 1 To 8  
        Animated(l1,l2,t1,t2)  
    Next  
End Sub
```

  
  
This is how it looks:  
![](https://www.b4x.com/android/forum/attachments/87298)  
  
The animated object (bubbles) will keep behind of the view, you can remark the **p.SendToBack** line so the bubble will show above the view.  
  
Another interesting effect when we put the code in **Touch** event;  

```B4X
Sub Activity_Touch (Action As Int, X As Float, Y As Float)  
    Dim l1, l2, t1, t2 As Long  
    
    l1 = x - 100dip  
    l2 = x + 100dip  
    t1 = y - 100dip  
    t2 = y + 100dip  
    
    For i = 1 To 2  
        Animated(l1,l2,t1,t2)  
    Next  
End Sub
```

  
  
This is how it looks:  
![](https://www.b4x.com/android/forum/attachments/87299)  
  
Have a great day…