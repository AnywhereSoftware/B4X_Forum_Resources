###  [XUI] AS BottomDatePicker by Alexander Stolte
### 01/15/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/149266/)

This view combines 2 views and makes it quick and easy to let the user select a date.  
  
You need:  

- [AS\_DatePicker](https://www.b4x.com/android/forum/threads/b4x-xui-as-datepicker-fast-navigate-to-a-month-year-decade-century-rangedatepicker.139957/)
- [AS\_DraggableBottomCard](https://www.b4x.com/android/forum/threads/b4x-xui-as-draggable-bottom-card.121219/)

  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/144116)![](https://www.b4x.com/android/forum/attachments/144117)  
  
![](https://www.b4x.com/android/forum/attachments/144118)  
  

```B4X
BottomDatePicker.Initialize(Me,"BottomDatePicker",Root)  
BottomDatePicker.ConfirmationMode = BottomDatePicker.ConfirmationMode_Button  
BottomDatePicker.ShowPicker  
BottomDatePicker.ConfirmationButton.Text = "Confirm Date"
```

  

```B4X
BottomDatePicker.Initialize(Me,"BottomDatePicker",Root)  
   
BottomDatePicker.ConfirmationMode = BottomDatePicker.ConfirmationMode_Button  
BottomDatePicker.ShowPicker  
   
BottomDatePicker.ConfirmationButton.Text = "Confirm Date"  
   
BottomDatePicker.Color = xui.Color_ARGB(255,32, 33, 37)  
BottomDatePicker.TextColor = xui.Color_White
```

  

```B4X
BottomDatePicker.Initialize(Me,"BottomDatePicker",Root)  
   
BottomDatePicker.ConfirmationMode = BottomDatePicker.ConfirmationMode_Button  
BottomDatePicker.ShowPicker  
   
BottomDatePicker.ConfirmationButton.Text = "Confirm Date"  
   
BottomDatePicker.Color = xui.Color_White  
BottomDatePicker.TextColor = xui.Color_Black
```

  
**AS\_BottomDatePicker  
Author: Alexander Stolte  
Version: 1.00**  

- **AS\_BottomDatePicker**

- **Events:**

- **ConfirmButtonClicked**
- **SelectedDateChanged** (Date As Long)
- **SelectedDateRangeChanged** (StartDate As Long, EndDate As Long)

- **Fields:**

- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **getConfirmationButton** As B4XView
- **getConfirmationMode\_Button** As String
- **getConfirmationMode\_SelectionChanged** As String
- **getDatePicker** As b4j.example.as\_datepicker
- **getSelectedDate** As Long
- **getSelectedEndDate** As Long
*Only in Range mode*- **getSelectedStartDate** As Long
- **getSelectMode** As String
- **getSelectMode\_Day** As String
- **getSelectMode\_Range** As String
- **Initialize** (Callback As Object, EventName As String, Parent As B4XView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setColor** (Color As Int) As String
- **setConfirmationMode** (Mode As String) As String
*SelectionChanged - The menu closes when the user has selected a day  
 Button - The menu closes only when the user clicks on the confirmation button  
 Default: SelectionChanged*- **setSelectMode** (Mode As String) As String
- **setTextColor** (Color As Int) As String
- **ShowPicker**

- **Properties:**

- **Color**
- **ConfirmationButton** As B4XView [read only]
- **ConfirmationMode**
*SelectionChanged - The menu closes when the user has selected a day  
 Button - The menu closes only when the user clicks on the confirmation button  
 Default: SelectionChanged*- **ConfirmationMode\_Button** As String [read only]
- **ConfirmationMode\_SelectionChanged** As String [read only]
- **DatePicker** As b4j.example.as\_datepicker [read only]
- **SelectedDate** As Long [read only]
- **SelectedEndDate** As Long [read only]
*Only in Range mode*- **SelectedStartDate** As Long [read only]
- **SelectMode** As String
- **SelectMode\_Day** As String [read only]
- **SelectMode\_Range** As String [read only]
- **TextColor**

**Changelog**  

- **1.00**

- Release

- **1.01**

- BugFix

**Github:** [github.com/StolteX/AS\_BottomDatePicker](https://github.com/StolteX/AS_BottomDatePicker)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)