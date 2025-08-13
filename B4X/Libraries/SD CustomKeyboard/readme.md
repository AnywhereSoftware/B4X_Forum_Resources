###  SD CustomKeyboard by Star-Dust
### 03/26/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/138438/)

---

  
**[SIZE=5]THIS version is no longer updated and supported. You can continue to use it if you want.  
Or try the [/SIZE]**[**[SIZE=5]new version[/SIZE]**](https://www.b4x.com/android/forum/threads/b4x-sd-customkeyboard-new-version.160116/)**[SIZE=5] with rewritten methods and new features[/SIZE]**  

---

  
**IMPORTANT**   

- depends on [**SD CreativeBackGround**](https://www.b4x.com/android/forum/threads/b4x-xui-sd-creativebackground.125011/) (0.06+) library which must be downloaded
- MaterialIcon font for special characters must be loaded.
Use: **SD\_Keyboard1**.SpecialKeyFont = **xui**.CreateMaterialIcons (16)
  
**SD\_CustomKeyboard  
  
Author:** Star-Dust  
**Version:** 1.20  

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
 *Ck.AddCustomKeyToLastRow("SPACE",32,"SPACE.",32,3,xui.Color\_Red,xui.Color\_White) ' space large 3 key  
 Ck.AddCustomKeyToLastRow("Enter",ck.CodeEnter,"Enter",ck.CodeEnter,1, ,xui.Color\_Green,xui.Color\_White))*- **AddDoubleCharToLastRow** (Keys As String()) As String
 *Char or key: Shift, Canc, Del, Tab, Esc, Next,EraseAll  
 CustomKey.AddRowDoubleCharToLastRow(array as string("Aa","Bb","Cc","Next","Tab","Canc"))  
 CustomKey.AddRowDoubleCharToLastRow(Regex.Split(",","Aa,Bb,Cc,00,11,12,Enter"))*- **AddEmptyRow** As String
- **AddEmptySpaceToLastRow** As String
- **AddKeyToLastRow** (UpperText As String, UpperCode As Int, LowerText As String, LowerCode As Int, size As Int) As String
 *Ck.AddKeytoLastRow("SPACE",32,"SPACE.",32,3) ' space large 3 key  
 Ck.AddKeytoLastRow("",0,"",0,1) ' Empty  
 Ck.AddKeytoLastRow("Enter",ck.CodeEnter,"Enter",ck.CodeEnter,1)*- **AddRow** (Keys As List) As String
 *CustomKey.AddRow(ListOfSingleKey)*- **AddRowDoubleChar** (Keys As String()) As String
 *Char or key: Shift, Canc, Del, Tab, Esc, Next,EraseAll  
 CustomKey.AddRowDoubleChar(array as string("Aa","Bb","Cc","Next","Tab","Canc"))  
 CustomKey.AddRowDoubleChar(Regex.Split(",","Aa,Bb,Cc,00,11,12,Enter"))*- **AddRowSimpleChar** (Keys As String()) As String
 *Char or key: Shift, Canc, Del, Tab, Esc, Next, EraseAll  
 CustomKey.AddRowSimpleChar(array as string("A","B","C","Next","Tab","Canc"))  
 CustomKey.AddRowSimpleChar(Regex.Split(",","A,B,C,0,1,2,Enter"))*- **AddRowStringtoKey** (Strings As String()) As String
 *Don't insert special char: Shift, Canc, Del, Tab, Esc, Next  
 CustomKey.AddRowStringtoKey(array as string("00","000","Hallo"))  
 CustomKey.AddRowStringtoKey(Regex.Split(",","00,000,Hallo"))*- **AddSimpleCharToLastRow** (Keys As String()) As String
 *Char or key: Shift, Canc, Del, Tab, Esc, Next, EraseAll  
 CustomKey.AddSimpleCharToLastRow(array as string("A","B","C","Next","Tab","Canc"))  
 CustomKey.AddSimpleCharToLastRow(Regex.Split(",","A,B,C,0,1,2,Enter"))*- **cEmptyKey** As Type\_SingleKey
- **cKey** (UpperText As String, UpperCode As Int, LowerText As String, LowerCode As Int) As Type\_SingleKey
- **cKeyCustomized** (UpperText As String, UpperCode As Int, LowerText As String, LowerCode As Int, size As Int, BackgroundKeyColor As Int, TextKeyColor As Int) As Type\_SingleKey
- **cKeySized** (UpperText As String, UpperCode As Int, LowerText As String, LowerCode As Int, size As Int) As Type\_SingleKey
- **Class\_Globals** As String
- **Initialize** As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **KeyBoard** As List

- **SD\_Keyboard**

- **Fields:**

- **InsertAlwaysAtEnd** As Boolean
- **keyCanc** As String
- **keyDel** As String
- **keyEnter** As String
- **keyEraseAll** As String
- **keyNext** As String
- **keyShiftDown** As String
- **keyShiftLock** As String
- **keyShiftUp** As String
- **KeyStyle** As Int [write only]
0-Standard; 1-Comics; 2-Heart; 3-Flower; 4-Octagon- **keyTab** As String
- **mBase** As B4XView
- **Tag** As Object
- **TimeLapseMilliSec** As Int

- **Functions:**

- **Add** (TextEditorView As B4XView, NativeEventName As String, CustomizeKeyboard As CustomKey, NextFocus As B4XView) As String
 *——————————— aggiuntivi ————————————*- **Add2** (TextEditorView As B4XView, NativeEventName As String, CustomizeKeyboard As CustomKey, ShiftOn As Boolean, NextFocus As B4XView) As String
- **Class\_Globals** As String
- **ClearKeyboard** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **DrawKeyboard** (V As B4XView) As String
- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String) As String
- **Invalidate** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **SetEvent** (View As EditText, te As TypeED) As String
- **SetupColor** (BackgroundColorKey As Int, TextColorKey As Int, BackgroundColorBoard As  Int)
- **ShifOn** (S As Boolean) As String
- **ShiftStatus** As Boolean
- **Snapshot** As B4XView

- **Properties:**

- **DarkFactor** As Float
*To set the intensity of the dark part of the shadow - normally = 0.85*- **Font**
 *Set Key Font*- **Height** As Int
- **ImageBackground**
- **Left** As Int
- **LightFactor** As Float
 *To set the intensity of the light part of the shadow - normally = 1.15*- **ShowKeyboard** As Boolean
- **SpecialKeyFont**
 *Set Font of SpecilKey - Standard: MaterialIcon*- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

  
  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
  
  
  
B4A, B4J, B4I  
![](https://www.b4x.com/android/forum/attachments/125500) ![](https://www.b4x.com/android/forum/attachments/125501) ![](https://www.b4x.com/android/forum/attachments/125503)![](https://www.b4x.com/android/forum/attachments/128802) ![](https://www.b4x.com/android/forum/attachments/128803)![](https://www.b4x.com/android/forum/attachments/128804)  
  
  
**log release**  

- 1.03
Added **AddRowDouble** method: allows you to enter the value in uppercase and lowercase for each key, for keys with special characters you can establish the character that will show in normal and with the shift- 1.04
Added **ClearKeyboard** method to clear the keyboard with all the associations made with the views
Added **AddRowStringtoKey** method that allows you to associate a complex key with multi-character text. With this method it is not possible to set special keys such as Shift, Canc, Del, Tab, Esc, Next.- 1.05
Added **Vibration** option in design- 1.06
Added new Key: **EraseAll**. Delete all text in the field
Added: **LightFactor** and **DarkFactor** property- 1.07
Now the special keys are created with the **MaterialIcons** font.
It will be possible to change the font of the special characters and the text of the characters
We have updated all the examples with the addition of the MaterialIcons font and added all the missing iOs examples- 1.08
Customized keys with the possibility of establishing their size
Ability to customize the background with an image
Possibility to insert empty spaces between the keys
Possibility to set the StartSelect always at the end- 1.09
Added **AddSimpleCharToLastRow** and **AddRowDoubleCharToLastRow** methods.
Added constants with the numeric code of the special keys: CodeCanc,CodeTab,CodeEnter,CodeEsc,CodeDel,CodeNext,CodeShift,CodeEraseAll
Ability to add custom keys that raise an event other than TextChange
Added new event to TextField or EditText view to handle custom keys that can have a negative value return code. Example: **TextField1\_CustomKey** (Code As Int)- 1.10; 1.11
Fix bugs- 1.12
Added **AddCustomKeyToLastRow** method in CustomKey class to customize single key colors
Added **Add2** method in the SD\_Keyboard class to set the SHIFT key when starting the keyboard- 1.13
Set Shift key by code
Fix bugs- 1.14
Added **AddEmptyKeyToLastRow** method in CustomKey class
Added **cEmptyKey** method in CustomKey class- 1.15
Added **AddEmptyRow** method in CustomKey class- 1.16
Fixed BUGS that gave false warning for missing MaterialIncons font- 1.17
Updated to work with version 0.6 of SD\_CreativeBackGround- 1.18
Added the **SetupColor** method to change the color of the background, buttons and text from code- 1.19
Added **KeyStyle** property- 1.20
Fix bug
  
**Important** depends on [**SD CreativeBackGround**](https://www.b4x.com/android/forum/threads/b4x-xui-sd-creativebackground.125011/) library which must be downloaded