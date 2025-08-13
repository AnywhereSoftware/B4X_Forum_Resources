###  [XUI] AS BottomWheelDateTimePicker based on AS_WheelDateTimePicker by Alexander Stolte
### 01/12/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/165050/)

This view makes it easy to quickly provide a good looking date and time picker, based on the [AS\_WheelDateTimePicker](https://www.b4x.com/android/forum/threads/b4x-as-wheeldatetimepicker-based-on-aswheelpicker.141588/), built into a ready to use bottom menu.  
  
You need:  

- [AS\_DraggableBottomCard](https://www.b4x.com/android/forum/threads/b4x-xui-as-draggable-bottom-card.121219/) **V1.14+**
- [AS\_WheelPicker](https://www.b4x.com/android/forum/threads/b4x-xui-as-wheelpicker-spinner-a-modern-single-multiple-choice-picker-view-based-on-xcustomlistview-payware.127505/) **V3.24+**
- [AS\_WheelDateTimePicker](https://www.b4x.com/android/forum/threads/b4x-as-wheeldatetimepicker-based-on-aswheelpicker.141588/) **V1.17+**

I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
**![](https://www.b4x.com/android/forum/attachments/160725) ![](https://www.b4x.com/android/forum/attachments/160724)  
  
![](https://www.b4x.com/android/forum/attachments/160726) ![](https://www.b4x.com/android/forum/attachments/160727)  
  
TimePicker Example**  

```B4X
Private Sub OpenSheetTimePicker(DarkMode As Boolean)  
    BottomWheelDateTimePicker.Initialize(Me,"BottomWheelDateTimePicker",Root)  
    
    BottomWheelDateTimePicker.Theme = IIf(DarkMode,BottomWheelDateTimePicker.Theme_Dark,BottomWheelDateTimePicker.Theme_Light)  
    BottomWheelDateTimePicker.ActionButtonVisible = True  
    
    BottomWheelDateTimePicker.PickerType = BottomWheelDateTimePicker.PickerType_TimePicker  
    BottomWheelDateTimePicker.TimePicker_TimeUnit = True 'Show TimePicker_HourShortText and TimePicker_MinuteShortText  
    BottomWheelDateTimePicker.TimePicker_ShowAMPM = False  
'    BottomWheelDateTimePicker.TimePicker_TimeDivider = True  
'    BottomWheelDateTimePicker.TimePicker_ShowDate = True  
'    BottomWheelDateTimePicker.TimePicker_HourShortText = "hour"  
'    BottomWheelDateTimePicker.TimePicker_MinuteShortText = "min"  
'    BottomWheelDateTimePicker.Hour = 13 'Only Works in Release mode  
'    BottomWheelDateTimePicker.Minute = 46 'Only Works in Release mode  
    BottomWheelDateTimePicker.ShowPicker  
    
    BottomWheelDateTimePicker.ActionButton.Text = "Choose"  
    
    Wait For BottomWheelDateTimePicker_ActionButtonClicked  
    
    #If Debug  
    Log($"Hour: ${BottomWheelDateTimePicker.Hour} Minute: ${BottomWheelDateTimePicker.Minute}"$)  
    #Else  
    xui.MsgboxAsync($"Hour: ${BottomWheelDateTimePicker.Hour} Minute: ${BottomWheelDateTimePicker.Minute}"$,"TimePicker")   
    #End If  
  
    BottomWheelDateTimePicker.HidePicker  
    
End Sub
```

  
**DatePicker Example**  

```B4X
Private Sub OpenSheetDatePicker(DarkMode As Boolean)  
    BottomWheelDateTimePicker.Initialize(Me,"BottomWheelDateTimePicker",Root)  
    
    BottomWheelDateTimePicker.Theme = IIf(DarkMode,BottomWheelDateTimePicker.Theme_Dark,BottomWheelDateTimePicker.Theme_Light)  
    BottomWheelDateTimePicker.ActionButtonVisible = True  
    
    BottomWheelDateTimePicker.PickerType = BottomWheelDateTimePicker.PickerType_DatePicker  
'    BottomWheelDateTimePicker.DatePicker_MaxDate = DateTime.Now  
'    BottomWheelDateTimePicker.Date = DateUtils.SetDate(2025,1,4)  
    BottomWheelDateTimePicker.ShowPicker  
    
    BottomWheelDateTimePicker.ActionButton.Text = "Choose"  
    
    Wait For BottomWheelDateTimePicker_ActionButtonClicked  
    
    #If Debug  
    Log(DateUtils.TicksToString(BottomWheelDateTimePicker.Date))  
    #Else  
    xui.MsgboxAsync(DateUtils.TicksToString(BottomWheelDateTimePicker.Date),"DatePicker")   
    #End If  
  
    BottomWheelDateTimePicker.HidePicker  
End Sub
```

  
  
**AS\_BottomWheelDateTimePicker  
Author: Alexander Stolte  
Version: 1.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_BottomWheelDateTimePicker**

- **Events:**

- **ActionButtonClicked**
- **Close**

- **Fields:**

- **Tag** As Object

- **Functions:**

- **HidePicker**
- **Initialize** (Callback As Object, EventName As String, Parent As B4XView)
*Initializes the object. You can add parameters to this method if needed.*- **ShowPicker**

- **Properties:**

- **ActionButton** As B4XView [read only]
- **ActionButtonVisible** As Boolean
- **Color** As Int
- **Date** As Long
*Set it after you set the PickerType*- **DatePicker\_MaxDate** As Long
- **DatePicker\_MinDate** As Long
- **DragIndicatorColor** As Int
- **Hour** As Int
- **Minute** As Int
- **PickerType** As String
- **PickerType\_DatePicker** As String [read only]
- **PickerType\_TimePicker** As String [read only]
- **SheetWidth** As Float
*Set the value to greater than 0 to set a custom width  
 Set the value to 0 to use the full screen width  
 Default: 0*- **TextColor** As Int [write only]
- **Theme** As AS\_BottomWheelDateTimePicker\_Theme [write only]
- **Theme\_Dark** As AS\_BottomWheelDateTimePicker\_Theme [read only]
- **Theme\_Light** As AS\_BottomWheelDateTimePicker\_Theme [read only]
- **ThemeChangeTransition\_Fade** As String [read only]
- **ThemeChangeTransition\_None** As String [read only]
- **TimePicker\_HourShortText** As String
- **TimePicker\_MinuteShortText** As String
- **TimePicker\_MinuteSteps** As Int
- **TimePicker\_ShowAMPM** As Boolean
*Show the AM and PM column*- **TimePicker\_ShowDate** As Boolean
*Show the date column in the TimePicker*- **TimePicker\_TimeDivider** As Boolean
*The separator between hour and minute is usually a colon ( : )*- **TimePicker\_TimeUnit** As Boolean
*Display time unit (12hour 05 min) can be changed with the HourShort and MinuteShort property*- **WheelDateTimePicker** As AS\_WheelDateTimePicker [read only]

[/SPOILER]  
**Changelog**  

- **1.00**

- Release

**Github:** [github.com/StolteX/AS\_BottomWheelDateTimePicker](https://github.com/StolteX/AS_BottomWheelDateTimePicker)  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)