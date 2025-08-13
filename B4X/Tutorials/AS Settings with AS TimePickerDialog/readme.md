###  AS Settings with AS TimePickerDialog by Alexander Stolte
### 02/10/2024
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/149569/)

In this example it is shown how to realize time entries with the [AS\_Settings](https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/#content) library.  
  
You need [AS\_Settings](https://www.b4x.com/android/forum/threads/b4x-xui-as-settings.147435/#content) **V2.00+** and [AS\_TimePickerDialog](https://www.b4x.com/android/forum/threads/b4x-xui-as-timepickerdialog-based-on-b4xdialog-and-as_timepicker.149354/)**V1.02+** for this example.  
  
![](https://www.b4x.com/android/forum/attachments/144743)![](https://www.b4x.com/android/forum/attachments/144742)  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("frm_main")  
    
    B4XPages.SetTitle(Me,"AS Settings Example")  
    
    AS_Settings1.MainPage.AddGroup("Advanced","Advanced Settings")  
      
    AS_Settings1.MainPage.AddProperty_Chooser("Advanced","PropertyName_1","TimePicker Example","",Null,"",110dip)  
    AS_Settings1.MainPage.AddProperty_Custom("Advanced","PropertyName_2","2 TimePickers","",Null,"")  
      
    AS_Settings1.MainPage.Create  
    
End Sub  
  
Private Sub AS_Settings1_ChooserTextFieldClicked(Property As AS_Settings_Property)  
  
        ShowTimePicker(Property)  
      
End Sub  
  
Private Sub ShowTimePicker(Property As AS_Settings_Property)  
      
    TimePicker.Initialize(Root)  
    TimePicker.SetDarkMode  
      
    Wait For (TimePicker.ShowDialog) Complete (PickerDialogResponse As AS_TimePickerDialog_DialogResponse)  
    If PickerDialogResponse.Result = xui.DialogResponse_Positive Then  
  
        If Property.PropertyName = "PropertyName_1" Then  
            Property.Value = CreateMap("Hour":PickerDialogResponse.Hour,"Minute":TimePicker.Minute)  
            Property.DisplayValueText = PickerDialogResponse.Hour & ":" & NumberFormat(PickerDialogResponse.Minute,2,0)  
        End If  
      
        AS_Properties.PutProperty(Property.PropertyName,Property.Value)  
        AS_Properties.PutPropertyDisplayValueText(Property.PropertyName,Property.DisplayValueText)  
      
        AS_Settings1.GetTopPage.Refresh  
  
    End If  
      
End Sub  
  
Private Sub AS_Settings1_CustomDrawProperty(CustomDrawProperty As AS_Settings_CustomDrawProperty)  
      
    If CustomDrawProperty.Property.PropertyName = "PropertyName_2" Then  
          
        Dim m_PropertyValues As Map = IIf(CustomDrawProperty.Property.Value Is Map,CustomDrawProperty.Property.Value,CreateMap("":""))  
          
        Dim BackgroundPanel As B4XView = CustomDrawProperty.PropertyViews.RightBackgroundPanel  
          
        AS_Settings1.GetTopPage.CustomDrawProperty_Add(BackgroundPanel, AS_Settings1.GetTopPage.CustomDrawProperty_AddChooser(Me,"TimeStart"),60dip,AS_Settings1.PropertyProperties.FieldHeight).Text = m_PropertyValues.GetDefault("StartHour","14") & ":" & NumberFormat(m_PropertyValues.GetDefault("StartMinute","00"),2,0)  
        AS_Settings1.GetTopPage.CustomDrawProperty_Add(BackgroundPanel, AS_Settings1.GetTopPage.CustomDrawProperty_AddText(Me,"","-"),20dip,AS_Settings1.PropertyProperties.FieldHeight)  
        AS_Settings1.GetTopPage.CustomDrawProperty_Add(BackgroundPanel, AS_Settings1.GetTopPage.CustomDrawProperty_AddChooser(Me,"TimeEnd"),60dip,AS_Settings1.PropertyProperties.FieldHeight).Text = m_PropertyValues.GetDefault("EndHour","15") & ":" & NumberFormat(m_PropertyValues.GetDefault("EndMinute","00"),2,0)  
          
    End If  
      
End Sub  
  
Private Sub TimeStart_Clicked(Property As AS_Settings_Property,View As Object)  
      
    TimePicker.Initialize(Root)  
    TimePicker.SetDarkMode  
      
    Wait For (TimePicker.ShowDialog) Complete (PickerDialogResponse As AS_TimePickerDialog_DialogResponse)  
    If PickerDialogResponse.Result = xui.DialogResponse_Positive Then  
          
        Dim m_Properties As Map  
        If Property.Value Is Map Then  
            m_Properties = Property.Value  
        Else  
            m_Properties.Initialize  
        End If  
          
        m_Properties.Put("StartHour",PickerDialogResponse.Hour)  
        m_Properties.Put("StartMinute",PickerDialogResponse.Minute)  
        Property.Value = m_Properties  
          
        View.As(B4XView).Text = PickerDialogResponse.Hour & ":" & NumberFormat(PickerDialogResponse.Minute,2,0)  
      
        AS_Properties.PutProperty(Property.PropertyName,Property.Value)  
      
    End If  
      
End Sub  
  
Private Sub TimeEnd_Clicked(Property As AS_Settings_Property,View As Object)  
      
    TimePicker.Initialize(Root)  
    TimePicker.SetDarkMode  
      
    Wait For (TimePicker.ShowDialog) Complete (PickerDialogResponse As AS_TimePickerDialog_DialogResponse)  
    If PickerDialogResponse.Result = xui.DialogResponse_Positive Then  
          
        Dim m_Properties As Map  
        If Property.Value Is Map Then  
            m_Properties = Property.Value  
        Else  
            m_Properties.Initialize  
        End If  
        m_Properties.Put("EndHour",PickerDialogResponse.Hour)  
        m_Properties.Put("EndMinute",PickerDialogResponse.Minute)  
        Property.Value = m_Properties  
          
        View.As(B4XView).Text = PickerDialogResponse.Hour & ":" & NumberFormat(PickerDialogResponse.Minute,2,0)  
      
        AS_Properties.PutProperty(Property.PropertyName,Property.Value)  
      
    End If  
      
End Sub
```

  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.me/stoltex)