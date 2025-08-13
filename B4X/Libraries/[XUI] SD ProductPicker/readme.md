###  [XUI] SD ProductPicker by Star-Dust
### 10/15/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/148238/)

**SD\_ProductPicker  
  
Author:** Star-Dust  
**Version:** 1.07  

- **DiskImagePicker**

- **Events:**

- **BallClicked** (Index As Int)
- **BallLongClicked** (Index As Int)
- **ChangeIndex** (Index As Int)
- **CloveClicked** (Index As Int)

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getInfoTopPosition** As Float
 *value: 0.00 to 1.00*- **getBallFontSize** As Int
- **getCentralBallDept** As Int
 *default = 50dip*- **getInfoFontSize** As Int
- **getPickerIndex** As Int
- **getSize** As Int
- **getTextFontSize** As Int
- **getTextTopPosition** As Float
 *value: 0.00 to 1.00*- **Initialize** (Callback As Object, EventName As String) As String
- **setInfoTopPosition** (S As Float) As String
- **setBallFontSize** (S As Int) As String
- **setCentralBallDept** (S As Int) As String
- **setInfoFontSize** (S As Int) As String
- **setPickerIndex** (T As Int) As String
- **setTextFontSize** (S As Int) As String
- **setTextTopPosition** (S As Float) As String
- **DeleteItem** (Pos As Int) As String
 *DI.DeleteItem(0)*- **AddItem** (Text As String, Info As String, Img As B4XBitmap) As DiskImagePicker
- **ClearList** As String
- **GetItemInfo** (Pos As Int) As String
 *es. Picker.GetItemInfo(0) - Pos: 0 to n-1*- **GetItemText** (Pos As Int) As String
 *es. Picker.GetItemText(0) - Pos: 0 to n-1*- **Invalidate** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **Properties:**

- **InfoTopPosition** As Float
 *value: 0.00 to 1.00*- **BallFontSize** As Int
- **CentralBallDept** As Int
 *default = 50dip*- **InfoFontSize** As Int
- **PickerIndex** As Int
- **Size** As Int [read only]
- **TextFontSize** As Int
- **TextTopPosition** As Float
 *value: 0.00 to 1.00*
- **HorizontalPicker**

- **Events:**

- **ChangeIndex** (Index As Int)
- **Clicked** (Index As Int)
- **LongClicked** (Index As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getInfoTopPosition** As Float
 *value: 0.00 to 1.00*- **getInfoFontSize** As Int
- **getPickerIndex** As Int
- **getSize** As Int
- **getTextFontSize** As Int
- **getTextTopPosition** As Float
 *value: 0.00 to 1.00*- **Initialize** (Callback As Object, EventName As String) As String
- **setInfoTopPosition** (S As Float) As String
- **setInfoFontSize** (S As Int) As String
- **setPickerIndex** (T As Int) As String
- **setTextFontSize** (S As Int) As String
- **setTextTopPosition** (S As Float) As String
- **DeleteItem** (Pos As Int) As String
 *DI.DeleteItem(0)*- **AddItem** (Text As String, Info As String, Img As B4XBitmap) As HorizontalPicker
- **ClearList** As String
- **GetItemInfo** (Pos As Int) As String
 *es. Picker.GetItemInfo(0) - Pos: 0 to n-1*- **GetItemText** (Pos As Int) As String
 *es. Picker.GetItemText(0) - Pos: 0 to n-1*- **Invalidate** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **Properties:**

- **InfoTopPosition** As Float
 *value: 0.00 to 1.00*- **InfoFontSize** As Int
- **PickerIndex** As Int
- **Size** As Int [read only]
- **TextFontSize** As Int
- **TextTopPosition** As Float
 *value: 0.00 to 1.00*
- **HorizontalTextPicker**

- **Events:**

- **ChangeIndex** (Index As Int)
- **Clicked** (Index As Int)
- **LongClicked** (Index As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getInfoTopPosition** As Float
 *value: 0.00 to 1.00*- **getInfoFontSize** As Int
- **getPickerIndex** As Int
- **getSize** As Int
- **getTextFontSize** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **setInfoTopPosition** (S As Float) As String
- **setInfoFontSize** (S As Int) As String
- **setPickerIndex** (T As Int) As String
- **setTextFontSize** (S As Int) As String
- **DeleteItem** (Pos As Int) As String
 *DI.DeleteItem(0)*- **AddItem** (Text As String, Info As String) As HorizontalTextPicker
- **ClearList** As String
- **GetItemInfo** (Pos As Int) As String
 *es. Picker.GetItemInfo(0) - Pos: 0 to n-1*- **GetItemText** (Pos As Int) As String
 *es. Picker.GetItemText(0) - Pos: 0 to n-1*- **Invalidate** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **Properties:**

- **InfoTopPosition** As Float
 *value: 0.00 to 1.00*- **InfoFontSize** As Int
- **PickerIndex** As Int
- **Size** As Int [read only]
- **TextFontSize** As Int

  
  

---

  

- 1.01

- Fix bugs
- Added **CloveClicked** method to DiskImagePicker
- Added **HorizontalPicker** class

- 1.02

- Added in the design the possibility to color the frame of the element at the moment of the click

- 1.03

- Added **LongClicked** event to HorizontalPicker

- 1.04

- Added **BallLongClicked** event to **DiskImagePicker**

- 1.05

- Added **HorizontalTextPicker** (Only text)
- Fix bugs **HorizontalPicker**

- 1.06

- Added **DeleteItem** and **Size**

- 1.07

- Added **GetItemText** and **GetItemInfo**. It allows you to know the content of the text and information in a specific position

---

  
  
  
**![](https://www.b4x.com/android/forum/attachments/142486)  
  
![](https://www.b4x.com/android/forum/attachments/146405)**