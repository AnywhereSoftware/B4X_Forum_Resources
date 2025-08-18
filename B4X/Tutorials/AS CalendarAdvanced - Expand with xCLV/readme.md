###  AS CalendarAdvanced - Expand with xCLV by Alexander Stolte
### 07/14/2022
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/132818/)

![](https://www.b4x.com/android/forum/attachments/116898)  
This is a sample project to demonstrate how to expand or collapse the calendar and at the same time adjust a listview below it.  
<https://www.b4x.com/android/forum/threads/b4x-xui-as-calendaradvanced-%F0%9F%93%85-onerow-fiverow-calendar-expand-and-collapse.128809/>  
  
Make sure you have **V2.07**  

```B4X
Private Sub ASCalendarAdvanced1_HeightChanged(Height As Float)  
'xpnl_main is a panel under the calendar with a xCLV in it  
    'same top a the calendar height  
    xpnl_main.Top = Height  
    xpnl_main.Height = Root.Height - Height  
    'height resize the xCLV  
    If xclv_main.AsView <> Null And xclv_main.AsView.IsInitialized = True Then  
        xclv_main.AsView.Height = xpnl_main.Height  
        xclv_main.Base_Resize(Root.Width,xpnl_main.Height)  
    End If  
End Sub
```