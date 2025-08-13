###  SD CustomKeyboard (new version) by Star-Dust
### 01/01/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/160116/)

The **CustomKeyboard** library has made a **leap** in quality to be able to replace the native Android/iOs keyboard and also for the Desktop version.  
Further developments are planned such as the possibility of adding editable fields from Design which are managed by this keyboard.  
  
This required a more radical change, which is why I preferred to abandon the old thread and create a new thread where to insert this updated version, with new examples, avoiding creating confusion between the methods and suggestions given. *The* [***old version***](https://www.b4x.com/android/forum/threads/b4x-sd-customkeyboard.138438/) *will remain but will no longer be supported*  
  

---

  
**[SIZE=5]IMPORTANT[/SIZE]**  

- depends on [**SD CreativeBackGround**](https://www.b4x.com/android/forum/threads/b4x-xui-sd-creativebackground.125011/) (0.06+) library which must be downloaded
- MaterialIcon font for special characters must be loaded. Use: **SD\_Keyboard1**.SpecialKeyFont = **xui**.CreateMaterialIcons (16)

---

  
  
**SD\_CustomKeyboard  
  
Author:** Star-Dust  
**Version:** 2.03  

- **CustomKey**

- **Fields:**

- **CodeCanc** As Int
- **CodeDel** As Int
- **CodeEnter** As Int
- **CodeEraseAll** As Int
- **CodeEsc** As Int
- **CodeNext** As Int
- **CodeShift** As Int
- **CodeTab** As Int

- **Functions:**

- **AddCustomKeyToLastRow** (UpperText As String, UpperCode As Int, LowerText As String, LowerCode As Int, size As Int, BackgroundKeyColor As Int, TextKeyColor As Int) As String
*Customize Key with color  
 <code>Ck.AddCustomKeyToLastRow("SPACE",32,"SPACE.",32,3,xui.Color\_Red,xui.Color\_White) ' space large 3 key</code>  
 <code>Ck.AddCustomKeyToLastRow("Enter",ck.CodeEnter,"Enter",ck.CodeEnter,1, ,xui.Color\_Green,xui.Color\_White))</code>*- **AddCustomKeyToLastRow2** (UpperText As String, UpperCode As Int, LowerText As String, LowerCode As Int, AlternateKeyUpper As Map, AlternateKeyLower As Map, size As Int, BackgroundKeyColor As Int, TextKeyColor As Int) As String
*Customize Key with color and alternative key  
 <code>ck. AddCustomKeyToLastRow2("E",69,"e",101,CreateMap("È":200,"É":201),CreateMap("è":232,"é":233),1,,xui.Color\_Red,xui.Color\_White)</code>*- **AddEmptyRow** As String
 *Can add key with Add…LastRow*- **AddEmptySpaceToLastRow** As String
- **AddKeyToLastRow** (UpperText As String, UpperCode As Int, LowerText As String, LowerCode As Int, size As Int) As String
 *Ck.AddKeytoLastRow("SPACE",32,"SPACE.",32,3) ' space large 3 key  
 Ck.AddKeytoLastRow("",0,"",0,1) ' Empty  
 Ck.AddKeytoLastRow("Enter",ck.CodeEnter,"Enter",ck.CodeEnter,1)*- **AddKeyToLastRow2** (UpperText As String, UpperCode As Int, LowerText As String, LowerCode As Int, AlternateKeyUpper As Map, AlternateKeyLower As Map, size As Int) As String
 *To insert alternative key  
 <code>Ck.AddKeyToLastRow2("E",69,"e",101,CreateMap("È":200,"É":201),CreateMap("è":232,"é":233),1)</code>*- **AddRow** (Keys As List) As String
 *CustomKey.AddRow(ListOfSingleKey)*- **AddSimpleCharToLastRow** (Keys As String()) As String
 *Char or key: Shift, Canc, Del, Tab, Esc, Next, EraseAll  
 <code>CustomKey.AddSimpleCharToLastRow(array as string("A","B","C","Next","Tab","Canc"))</code>  
 <code>CustomKey.AddSimpleCharToLastRow(Regex.Split(",","A,B,C,0,1,2,Enter"))</code>*- **AddSimpleCharToNewRow** (Keys As String()) As String
 *Special Char or key: Shift, Canc, Del, Tab, Esc, Next, EraseAll  
 <code>CustomKey.AddRowSimpleChar(array as string("A","B","C","Next","Tab","Canc"))</code>  
 <code>CustomKey.AddRowSimpleChar(Regex.Split(",","A,B,C,0,1,2,Enter"))</code>*- **AddStringtoKeyToNewRow** (Strings As String()) As String
 *Don't insert special char: Shift, Canc, Del, Tab, Esc, Next  
 <code> CustomKey.AddStringtoKeyToNewRow(array as string("00","000","Hallo"))</code>  
 <code> CustomKey.AddStringtoKeyToNewRow(Regex.Split(",","00,000,Hallo"))</code>*- **AddUpperLowerCharToLastRow** (Keys As String()) As String
 *Char or key: Shift, Canc, Del, Tab, Esc, Next,EraseAll  
 CustomKey.AddUpperLowerCharToLastRow(array as string("Aa","Bb","Cc","Next","Tab","Canc"))  
 CustomKey.AddUpperLowerCharToLastRow(Regex.Split(",","Aa,Bb,Cc,00,11,12,Enter"))*
- **AddUpperLowerCharToNewRow** (Keys As String()) As String
 *Char or key: Shift, Canc, Del, Tab, Esc, Next,EraseAll  
 <code>CustomKey.AddUpperLowerCharToNewRow(array as string("Aa","Bb","Cc","Next","Tab","Canc"))</code>  
 <code>CustomKey.AddUpperLowerCharToNewRow(Regex.Split(",","Aa,Bb,Cc,00,11,12,Enter"))</code>*

- **cEmptyKey** As Type\_SingleKey
- **cKey** (UpperText As String, UpperCode As Int, LowerText As String, LowerCode As Int, AlternateUp As Map, AlternateLo As Map) As Type\_SingleKey
- **cKeyCustomized** (UpperText As String, UpperCode As Int, LowerText As String, LowerCode As Int, size As Int, BackgroundKeyColor As Int, TextKeyColor As Int, AlternateUp As Map, AlternateLo As Map) As Type\_SingleKey
- **cKeySized** (UpperText As String, UpperCode As Int, LowerText As String, LowerCode As Int, size As Int, AlternateUp As Map, AlternateLo As Map) As Type\_SingleKey
- **Class\_Globals** As String
- **Initialize** As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **KeyBoard** As List

- **SD\_Keyboard**

- **Events:**

- **Digit** (Key As String)
- **DigitSpecialKey** (Key As String)

- **Fields:**

- **EventSender** As Object
**InsertAlwaysAtEnd** As Boolean- **keyCanc** As String
- **keyDel** As String
- **keyEnter** As String
- **keyEraseAll** As String
- **keyNext** As String
- **keyShiftDown** As String
- **keyShiftLock** As String
- **keyShiftUp** As String
- **keyTab** As String
- **Tag** As Object
- **TimeLapseMilliSec** As Int

- **Functions:**

- **Class\_Globals** As String
- **ClearKeyboard** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **DrawKeyboard** (V As B4XView) As String
- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String) As String
- **Invalidate** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **SetEvent** (View As EditText, te As TypeED) As String
- **SetKeyboard** (TextEditorView As B4XView, NativeEventName As String, CustomizeKeyboard As CustomKey, ShiftOn As Boolean, NextFocus As B4XView) As String
- **SetupColor** (BackgroundColorKey As Int, TextColorKey As Int, BackgroundColorBoard As Int) As String
- **ShifOn** (S As Boolean) As String
- **ShiftStatus** As Boolean
- **Snapshot** As B4XBitmap

- **Properties:**

- **DarkFactor** As Float
*To set the intensity of the dark part of the shadow - normally = 0.85*- **Font**
 *Set Key Font*- **Height** As Int
- **ImageBackground**
- **KeyStyle**
 *0-Standard; 1-Comics; 2-Heart; 3-Flower; 4-Octagon*- **Left** As Int
- **LightFactor** As Float
 *To set the intensity of the light part of the shadow - normally = 1.15*- **ShowKeyboard** As Boolean
- **SpecialKeyFont**
 *Set Font of SpecilKey - Standard: MaterialIcon*- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

---

  

- **Rel.** 2.01

- Added event **Digit** and **DigitSpecialKey**

- **Rel.** 2.02

- The TextView **Sender** responds when an event is called from the virtual keyboard

- **Rel.** 2.03

- Fix tag bug