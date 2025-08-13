### PFDateTimePicker Scroll View  iOS Library by Asad
### 01/20/2023
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/145591/)

As Apple Store is not accepting Calendar Type DateTime Picker, So my first step towards ScrollView DateTime picker for iOS.   
**PFDateTimePicker  
  
Author: Asad  
Version:** 0.01  
**B4i.DependsOn=iXUI, iDateUtils, iCustomDialog**  

- **PFDateTimePicker**

- **Events:**

- **SelectedDateChanged** (Date As Long)

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **Initialize** (Callback As Object, EventName As String) As String
- **Invalidate** As String
- **IsInitialized** As Boolean
- **SetDate** (Tick As Long) As String
- **SetDateNow**( ) As String

- **Properties:**

- **DateTimeTicks** As Long (Read Only)
- **BackgroundColor** As Int
- **MaxYear**  As Int
- **MinYear**  As Int
- **Mode** As String