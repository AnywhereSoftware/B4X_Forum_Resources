###  AS ViewPager - Auto Play by Alexander Stolte
### 02/17/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/142733/)

In this example project you can see how to add an auto play feautre to the [AS ViewPager](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/).  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/>  

```B4X
Sub Class_Globals  
    Private tmr_AutoPlay As Timer  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    tmr_AutoPlay.Initialize("tmr_AutoPlay",2000)'2 seconds  
    tmr_AutoPlay.Enabled = True  
End Sub  
  
Private Sub tmr_AutoPlay_Tick  
    If ASViewPager1.CurrentIndex = ASViewPager1.Size -1 Then  
        ASViewPager1.CurrentIndex2 = 0  
    Else  
        ASViewPager1.NextPage  
    End If  
End Sub
```