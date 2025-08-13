###  AS Settings with AS BottomDatePicker by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/149566/)

In this example it is shown how to realize date entries with the [AS\_Settings](https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/#content) library.  
  
You need [AS\_Settings](https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/#content) **V2.00+** and [AS\_BottomDatePicker](https://www.b4x.com/android/forum/threads/b4x-xui-as-bottomdatepicker.149266/) **V1.01+** for this example.  
  
![](https://www.b4x.com/android/forum/attachments/144739)![](https://www.b4x.com/android/forum/attachments/144740)  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("frm_main")  
    
    B4XPages.SetTitle(Me,"AS Settings Example")  
    
    AS_Settings1.MainPage.AddGroup("Advanced","Advanced Settings")  
    
    AS_Settings1.PropertyProperties.xFont = xui.CreateDefaultFont(16)  
    
    AS_Settings1.MainPage.AddProperty_Chooser("Advanced","PropertyName_1","DatePicker Example","",Null,"",100dip)  
    AS_Settings1.MainPage.AddProperty_Chooser("Advanced","PropertyName_2","Date Range Example","",Null,"",180dip)  
    
    AS_Settings1.MainPage.Create  
    
End Sub  
  
Private Sub B4XPage_KeyboardStateChanged (Height As Float)  
    
    AS_Settings1.Base_Resize(Root.Width,Root.Height - Height)  
    
End Sub  
  
Private Sub AS_Settings1_ValueChanged(Property As AS_Settings_Property, Value As Object)  
    Log("ValueChanged " & Property.PropertyName & ": " & Value)  
End Sub  
  
  
Private Sub AS_Settings1_ChooserTextFieldClicked(Property As AS_Settings_Property)  
    Log("ChooserTextFieldClicked")  
    If Property.PropertyName = "PropertyName_1" Then  
        ShowDatePicker(Property,False)  
    Else If Property.PropertyName = "PropertyName_2" Then  
        ShowDatePicker(Property,True)  
    End If  
    
End Sub  
  
  
Private Sub ShowDatePicker(Property As AS_Settings_Property,isRangeDate As Boolean)  
    
    BottomDatePicker.Initialize(Me,"BottomDatePicker",Root)  
    BottomDatePicker.Tag = Property  
    BottomDatePicker.ConfirmationMode = BottomDatePicker.ConfirmationMode_Button  
    
    If isRangeDate Then  
        BottomDatePicker.SelectMode = BottomDatePicker.SelectMode_Range  
    Else  
        BottomDatePicker.SelectMode = BottomDatePicker.SelectMode_Day  
    End If  
    
    BottomDatePicker.ShowPicker  
    BottomDatePicker.ConfirmationButton.Text = "Confirm Date"  
    
End Sub  
  
Private Sub BottomDatePicker_ConfirmButtonClicked  
    Dim BottomDatePicker As AS_BottomDatePicker = Sender  
    Dim Property As AS_Settings_Property = BottomDatePicker.Tag  
  
    
    If Property.PropertyName = "PropertyName_1" Then  
        Property.Value = BottomDatePicker.SelectedDate  
        Property.DisplayValueText = DateTime.Date(BottomDatePicker.SelectedDate)  
    Else If Property.PropertyName = "PropertyName_2" Then  
        Property.Value = CreateMap("StartDate":BottomDatePicker.SelectedStartDate,"EndDate":BottomDatePicker.SelectedEndDate)  
        Property.DisplayValueText = DateTime.Date(BottomDatePicker.SelectedDate) & "-" & DateTime.Date(BottomDatePicker.SelectedEndDate)  
    End If  
    
    AS_Properties.PutProperty(Property.PropertyName,Property.Value)  
    AS_Properties.PutPropertyDisplayValueText(Property.PropertyName,Property.DisplayValueText)  
    
    AS_Settings1.GetTopPage.Refresh  
  
End Sub
```

  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)