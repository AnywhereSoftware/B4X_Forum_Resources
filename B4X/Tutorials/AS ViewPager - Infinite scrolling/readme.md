###  AS ViewPager - Infinite scrolling by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/157372/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/>  
  
A small example project on how to achieve endless scrolling in both directions with the as viewpager.  
  
**Important**  
You need AS ViewPager V2.01+  
and for B4J, you need V1.02+ of the [jPager](https://www.b4x.com/android/forum/threads/jpager-viewpager.146255/)  
  
![](https://www.b4x.com/android/forum/attachments/147719)![](https://www.b4x.com/android/forum/attachments/147720)  
The best thing is, it works in both directions  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("frm_main")  
    
    ASViewPager1.LazyLoading = True  
    ASViewPager1.LazyLoadingExtraSize = 4  
    
    For i = 0 To 20  
        Dim tmp_xpnl As B4XView = xui.CreatePanel("tmp_xpnl")  
        tmp_xpnl.Color = xui.Color_ARGB(255,Rnd(1,255),Rnd(1,255),Rnd(1,255))  
        tmp_xpnl.SetLayoutAnimated(0,0,0,ASViewPager1.Base.Width,ASViewPager1.Base.Height)  
        
        ASViewPager1.AddPage(tmp_xpnl,"Test" & i)  
    Next  
    #IF B4A  
    Sleep(250)  
    #Else  
    Sleep(0)  
    #End If  
    ASViewPager1.CurrentIndex = 10  
    ASViewPager1.Commit  
    B4XPages.SetTitle(Me,"Page " & (ASViewPager1.CurrentIndex +1) & "/" & ASViewPager1.Size)  
End Sub  
  
Private Sub ASViewPager1_PageChanged2(NewIndex As Int, OldIndex As Int)  
    If NewIndex <= OldIndex Then  
        If NewIndex <= 2 Then  
            Dim tmp_xpnl As B4XView = xui.CreatePanel("tmp_xpnl")  
            tmp_xpnl.Color = xui.Color_ARGB(255,Rnd(1,255),Rnd(1,255),Rnd(1,255))  
            tmp_xpnl.SetLayoutAnimated(0,0,0,ASViewPager1.Base.Width,ASViewPager1.Base.Height)  
        
            ASViewPager1.AddPageAt(0,tmp_xpnl,"")  
        End If  
    Else  
        If NewIndex = ASViewPager1.Size -2 Then  
            Dim tmp_xpnl As B4XView = xui.CreatePanel("tmp_xpnl")  
            tmp_xpnl.Color = xui.Color_ARGB(255,Rnd(1,255),Rnd(1,255),Rnd(1,255))  
            tmp_xpnl.SetLayoutAnimated(0,0,0,ASViewPager1.Base.Width,ASViewPager1.Base.Height)  
        
            ASViewPager1.AddPage(tmp_xpnl,"")  
        End If  
    End If  
    Sleep(0)  
    B4XPages.SetTitle(Me,"Page " & (NewIndex +1) & "/" & ASViewPager1.Size)  
End Sub  
  
Private Sub ASViewPager1_LazyLoadingAddContent(Parent As B4XView, Value As Object)  
    
    Dim xlbl As B4XView = CreateLabel  
    xlbl.Text = "Lazyloading Label"  
    xlbl.TextColor = xui.Color_White  
    xlbl.Font = xui.CreateDefaultBoldFont(20)  
    xlbl.SetTextAlignment("CENTER","CENTER")  
    Parent.AddView(xlbl,0,Parent.Height/2 - 50dip/2,Parent.Width,50dip)  
    
End Sub  
  
Private Sub CreateLabel As B4XView  
    Dim lbl As Label  
    lbl.Initialize("")  
    Return lbl  
End Sub
```

  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)