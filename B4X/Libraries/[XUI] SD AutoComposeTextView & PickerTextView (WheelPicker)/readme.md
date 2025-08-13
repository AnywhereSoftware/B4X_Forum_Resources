###  [XUI] SD AutoComposeTextView & PickerTextView (WheelPicker) by Star-Dust
### 12/21/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/105951/)

[HEADING=2]AutoComposeTextView[/HEADING]  
[HEADING=2]PickerTextView (WheelPicker)[/HEADING]  
  
**SD\_AutoComposeTextView  
  
Author:** Star-Dust  
**Version:** 0.03  

- **AutoComposeTextView**

- **Events:**

- **EnterPressed**
- **TextChanged** (Old As String, New As String)

- **Fields:**

- **SearchStartWith** As Boolean

- **Functions:**

- **AddItems** (Items As List) As String
- **BringToFront** As String
- **Class\_Globals** As String
- **ClearItems** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **RemoveViewFromParent** As String
- **RequestFocus** As String
- **SendToBack** As String
- **SetItems** (items As List) As String
- **SetItemsFromSQLite** (Folder As String, FileName As String, TableName As String, FieldName As String) As String
- **SetLayoutAnimated** (Duration As Int, Left As Int, Top As Int, Width As Int, Height As Int) As String

- **Properties:**

- **Color** As Int
- **Font**
- **Height** As Int
- **Left** As Int
- **TextColor** As Int
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

- **PickerTextView**

- **Events:**

- **Click**

- **Functions:**

- **Add** (Element As String) As String
- **BringToFront** As String
- **Class\_Globals** As String
- **ClearItems** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **RemoveViewFromParent** As String
- **RequestFocus** As String
- **SendToBack** As String
- **SetItems** (items As List) As String
- **SetLayoutAnimated** (Duration As Int, Left As Int, Top As Int, Width As Int, Height As Int) As String

- **Properties:**

- **Align** As String
CENTER, LEFT, RIGHT- **Color** As Int
- **Font**
- **Height** As Int
- **Left** As Int
- **SelectedIndex** As Int
- **SelectedItem** As String [read only]
- **TextColor** As Int
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

  
Seach TextFileter in ———- Search TextFilter in StartWith..  
![](https://www.b4x.com/android/forum/attachments/80539) ![](https://www.b4x.com/android/forum/attachments/80540)  
  
**….. PickerTextView**  
  
![](https://www.b4x.com/android/forum/attachments/123620) ![](https://www.b4x.com/android/forum/attachments/137153)