###  [XUI] AS TimePickerDialog based on B4XDialog and AS_TimePicker by Alexander Stolte
### 02/01/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/149354/)

A dialog that prompts the user for the time of day using a [TimePicker](https://www.b4x.com/android/forum/threads/b4x-xui-as-timepicker.140084/).  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/144295)![](https://www.b4x.com/android/forum/attachments/144296)![](https://www.b4x.com/android/forum/attachments/144302)  
  
![](https://www.b4x.com/android/forum/attachments/144297)![](https://www.b4x.com/android/forum/attachments/144298)  

```B4X
Private Sub ShowDialogDarkMode  
   
    TimePickerDialog.Initialize(Root)  
   
    TimePickerDialog.Theming.BackgroundColor = xui.Color_ARGB(255,19, 20, 22)  
    TimePickerDialog.Theming.ClockTextColor = xui.Color_White  
    TimePickerDialog.Theming.DialogButtonTextColor = xui.Color_ARGB(255,20,160,130)  
    TimePickerDialog.Theming.EditTextColor = xui.Color_White  
    TimePickerDialog.Theming.EditTextFocusColor = xui.Color_ARGB(255,20,160,130)  
    TimePickerDialog.Theming.ThumbColor = xui.Color_ARGB(255,20,160,130)  
    TimePickerDialog.Theming.TimePickerBackgroundColor = xui.Color_ARGB(255,32, 33, 37)  
   
    TimePickerDialog.KeyboardEnabled = True  
    TimePickerDialog.TimeFormat = TimePickerDialog.TimeFormat_24h  
   
    Wait For (TimePickerDialog.ShowDialog) Complete (PickerDialogResponse As AS_TimePickerDialog_DialogResponse)  
    If PickerDialogResponse.Result = xui.DialogResponse_Positive Then  
        #If Debug  
        Log("Hour: " & PickerDialogResponse.Hour & " Minute: " & PickerDialogResponse.Minute)  
        #Else  
        xui.MsgboxAsync("Hour: " & PickerDialogResponse.Hour & " Minute: " & PickerDialogResponse.Minute,"")  
        #End If  
    End If  
   
End Sub
```

  

```B4X
Private Sub ShowDialogLightMode  
   
    TimePickerDialog.Initialize(Root)  
   
    TimePickerDialog.Theming.BackgroundColor = xui.Color_White  
    TimePickerDialog.Theming.ClockTextColor = xui.Color_Black  
    TimePickerDialog.Theming.DialogButtonTextColor = xui.Color_ARGB(255,20,160,130)  
    TimePickerDialog.Theming.EditTextColor = xui.Color_Black  
    TimePickerDialog.Theming.EditTextFocusColor = xui.Color_ARGB(255,20,160,130)  
    TimePickerDialog.Theming.ThumbColor = xui.Color_ARGB(255,20,160,130)  
    TimePickerDialog.Theming.TimePickerBackgroundColor = xui.Color_ARGB(255,245,246,247)  
   
    Wait For (TimePickerDialog.ShowDialog) Complete (PickerDialogResponse As AS_TimePickerDialog_DialogResponse)  
    If PickerDialogResponse.Result = xui.DialogResponse_Positive Then  
        #If Debug  
        Log("Hour: " & PickerDialogResponse.Hour & " Minute: " & PickerDialogResponse.Minute)  
        #Else  
        xui.MsgboxAsync("Hour: " & PickerDialogResponse.Hour & " Minute: " & PickerDialogResponse.Minute,"")  
        #End If  
    End If  
   
End Sub
```

  
  
**You need the** [**AS\_TimePicker**](https://www.b4x.com/android/forum/threads/b4x-xui-as-timepicker.140084/) **V1.08+  
  
AS\_TimePickerDialog  
Author: Alexander Stolte  
Version: 1.00**  

- **AS\_TimePickerDialog**

- **Functions:**

- **Class\_Globals** As String
- **getHour** As Int
- **getKeyboardEnabled** As Boolean
- **getMinute** As Int
- **getMinuteSteps** As Int
- **getTimeFormat** As String
- **getTimeFormat\_12h** As String
- **getTimeFormat\_24h** As String
- **Initialize** (Parent As B4XView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setHour** (Hour As Int) As String
- **setKeyboardEnabled** (Enabled As Boolean) As String
- **setMinute** (Minute As Int) As String
- **setMinuteSteps** (Steps As Int) As String
*Indicates in how many steps the selector can be moved  
 Default: 1*- **setTimeFormat** (Format As String) As String
*24h|12h  
 Default: 24h*- **ShowDialog** As ResumableSub
*<code> Wait For (TimePickerDialog.ShowDialog) Complete (PickerDialogResponse As AS\_TimePickerDialog\_DialogResponse)  
 If PickerDialogResponse.Result = xui.DialogResponse\_Positive Then  
 End If</code>*- **Theming** As AS\_TimePickerDialog\_Theming

- **Properties:**

- **Hour** As Int
- **KeyboardEnabled** As Boolean
- **Minute** As Int
- **MinuteSteps** As Int
*Indicates in how many steps the selector can be moved  
 Default: 1*- **TimeFormat** As String
*24h|12h  
 Default: 24h*- **TimeFormat\_12h** As String [read only]
- **TimeFormat\_24h** As String [read only]

- **AS\_TimePickerDialog\_DialogResponse**

- **Fields:**

- **Hour** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Minute** As Int
- **Result** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_TimePickerDialog\_Theming**

- **Fields:**

- **BackgroundColor** As Int
- **ClockTextColor** As Int
- **DialogButtonTextColor** As Int
- **EditTextColor** As Int
- **EditTextFocusColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ThumbColor** As Int
- **TimePickerBackgroundColor** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add get and set DialogYesText

- Default: OK

- Add get and set DialogNoText

- Default: CANCEL

- Add get and set DialogCancelText

- **1.02 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-timepickerdialog-based-on-b4xdialog-and-as_timepicker.149354/post-947703)**)**

- BugFixes
- Add SetDarkMode - Sets the dialog to DarkMode
- Add SetLightMode - Sets the dialog to LightMode

- **1.03**

- Add Close - Closes the Dialog

- **1.04**

- BugFix on TimeFormat\_12h and PM times
- B4J - Buttons should now work

- **1.05**

- Keyboard Type on the TextFields are now numbers

- **1.06 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-timepickerdialog-based-on-b4xdialog-and-as_timepicker.149354/post-974520)**)**

- Add set Date - You can now set the initial time with ticks
- BugFix on TimeFormat\_12h
- Add isPm to AS\_TimePickerDialog\_DialogResponse
- Add Date to AS\_TimePickerDialog\_DialogResponse
- If you are using the TimeFormat 12h then the DialogResponse.Hour returns now 0-12 and you need to check with .isPm if it is am or pm

**Github:** [github.com/StolteX/AS\_TimePickerDialog](https://github.com/StolteX/AS_TimePickerDialog)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)  
**You need the** [**AS\_TimePicker**](https://www.b4x.com/android/forum/threads/b4x-xui-as-timepicker.140084/) **V1.08+**