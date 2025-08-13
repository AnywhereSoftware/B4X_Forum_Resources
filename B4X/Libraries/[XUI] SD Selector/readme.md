###  [XUI] SD Selector by Star-Dust
### 10/13/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/127423/)

**SD\_Selector  
  
Author:** Star-Dust  
**Version:** 0.05  

- **fourSelector**

- **Events:**

- **ChangeValue** (nSelector As Int, Index As Int)
- **CenterClick**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetBase** As B4XView
- **GetItemIndex** (nSelector As Int) As Int
- **GetItemValue** (nSelector As Int) As String
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **SetItemIndex** (nSelector As Int, Index As Int) As String
- **SetItems** (nSelector As Int, ListItem As List) As String
 *nSelector = 0 to 3*- **SetWheelColors** (UpColor As Int, RigthColor As Int, DownColor As Int, LeftColor As Int) As String

- **Properties:**

- **WheelSpeed** As Int
 *Wheel: speed 20-200 slow*
- **fourSelectorPlus**

- **Events:**

- **ChangeValue** (Index As Int, Text As String)
- **CenterClick**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **SetItems** (Item1 As String, Item2 As String, Item3 As String, Item4 As String) As String

- **Properties:**

- **TextFont**As B4XFont
- ****WheelSpeed**** As Int

  
  
![](https://www.b4x.com/android/forum/attachments/133036)![](https://www.b4x.com/android/forum/attachments/133037)