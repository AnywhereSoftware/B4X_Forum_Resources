### Disable ViewPager Swipe (Touch) by Mehrzad238
### 05/16/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/167023/)

I use this code if I ever need to disable the touch event of the view pager. It's useful if you wanna create a survey, so users cannot swipe the viewpager.  
  

```B4X
Sub DisableViewPagerSwipe  
    Dim r As Reflector  
    r.Target = Vp  
    r.SetOnTouchListener("Vp_Touch")  
End Sub
```

  
  
  

```B4X
Sub Vp_Touch(View As Object, Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean  
    Return True  
End Sub
```