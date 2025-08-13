###  AS CardSlider - Text animation by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/153523/)

<https://www.b4x.com/android/forum/threads/b4x-xui-as-cardslider.153204/>  
  
![](https://www.b4x.com/android/forum/attachments/146348)  
  
**Code**  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("frm_main")  
    
    B4XPages.SetTitle(Me,"AS CardSlider")  
    
    AS_CardSlider1.ItemWidth = 100dip  
    
    Dim StartYear As Int = DateTime.GetYear(DateTime.Now) - 10 'Start is 10 Years ago  
    Dim StartIndex As Int = 0 'To set the start index to the current year  
    
    For i = 0 To 21 -1 '20 years  
        
        Dim Year As Int = StartYear + i 'Add one year every loop  
        Dim xpnl As B4XView = xui.CreatePanel("")  
        xpnl.SetLayoutAnimated(0,0,0,AS_CardSlider1.ItemWidth,AS_CardSlider1.mBase.Height)  
        
            
        Dim xlbl_Year As B4XView = CreateLabel("xlbl_Year") 'Creates one label  
        xpnl.AddView(xlbl_Year,0,0,xpnl.Width,xpnl.Height) 'Adds the label to the parent panel  
        xlbl_Year.Text = Year  
        xlbl_Year.SetTextAlignment("CENTER","CENTER")  
        xlbl_Year.Tag = AS_CardSlider1.Size  
        
        If Year = DateTime.GetYear(DateTime.Now) Then  
            StartIndex = i 'Current year  
            xlbl_Year.TextColor = xui.Color_White  
            xlbl_Year.Font = xui.CreateDefaultBoldFont(20)  
            Else  
            xlbl_Year.TextColor = xui.Color_ARGB(80,255,255,255)  
            xlbl_Year.Font = xui.CreateDefaultBoldFont(13)  
        End If  
            
        AS_CardSlider1.AddPage(xpnl,Year)  
        
    Next  
    
    AS_CardSlider1.Index = StartIndex 'Scrolls to the current year  
    
End Sub  
  
Private Sub AS_CardSlider1_PageChanged(OldIndex As Int, NewIndex As Int)  
    AS_CardSlider1.GetPanel(NewIndex).GetView(0).TextColor = xui.Color_White 'Active Item  
    AS_CardSlider1.GetPanel(OldIndex).GetView(0).TextColor = xui.Color_ARGB(80,255,255,255) 'Inactive Item  
    
    
    AS_CardSlider1.GetPanel(NewIndex).GetView(0).SetTextSizeAnimated(250,20) 'Active Item  
    AS_CardSlider1.GetPanel(OldIndex).GetView(0).SetTextSizeAnimated(250,13) 'Inactive Item  
End Sub  
  
#If B4J  
Private Sub xlbl_Year_MouseClicked (EventData As MouseEvent)  
#Else  
Private Sub xlbl_Year_Click  
#End If  
    Dim xlbl_Year As B4XView = Sender  
    AS_CardSlider1.Index = xlbl_Year.Tag 'If we click on a year then scroll to the year  
End Sub  
  
Private Sub CreateLabel(EventName As String) As B4XView  
    Dim lbl As Label  
    lbl.Initialize(EventName)  
    Return lbl  
End Sub
```

  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)