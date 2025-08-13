###  [XUI] AS AutoComplete based on AS SelectionList by Alexander Stolte
### 04/09/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164908/)

This is an AutoComplete view, which is compatible with B4XFloatTextField, AS\_TextFieldAdvanced, EditText (B4A), TextField (B4i) and TextField (B4J)  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
You need:  

- [AS\_SelectionList](https://www.b4x.com/android/forum/threads/b4x-xui-as-selectionlist-single-or-multiple-selection.164050/) **V2.03+**

  
![](https://www.b4x.com/android/forum/attachments/160267) ![](https://www.b4x.com/android/forum/attachments/160295)  
**Setup for B4A**  
Settings you need to make in your B4A project  

1. Go to Main Module
2. Declare ime in the globals

```B4X
Sub Globals  
    Private ime As IME  
End Sub
```

  

1. Initialize and AddHeightChangedEvent to the [ICODE]Activity\_Create[/ICODE] sub

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    Dim pm As B4XPagesManager  
    pm.Initialize(Activity)  
   
    ime.Initialize("IME")  
    ime.AddHeightChangedEvent  
End Sub
```

  
 4. Add the [ICODE]IME\_HeihgtChanged[/ICODE] event  

```B4X
Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)  
    B4XPages.GetManager.RaiseEvent(B4XPages.GetManager.GetTopPage, "B4XPage_KeyboardStateChanged", Array(Activity.Height - NewHeight))  
End Sub
```

  
 5. Add the following in the Manifest Editor  

```B4X
SetActivityAttribute(main, android:windowSoftInputMode, adjustResize|stateHidden)
```

  
**Setup for B4X**  
Add this to the B4XPage you want to use the AS\_AutoComplete  

```B4X
Private Sub B4XPage_Resize (Width As Int, Height As Int)  
    AS_AutoComplete1.Resize(Width,Height)  
End Sub  
  
Private Sub B4XPage_KeyboardStateChanged (Height As Float)  
    AS_AutoComplete1.KeyboardStateChanged(Height)  
End Sub
```

  
**Example**  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private TextField1 As B4XView  
    Private AS_AutoComplete1 As AS_AutoComplete  
  
    Dim sql1 As SQL  
  
End Sub
```

  

```B4X
    AS_AutoComplete1.Initialize(Me,"AS_AutoComplete1",Root,TextField1)  
    AS_AutoComplete1.SetDataSource1(sql1,"dt_Country","name","code")
```

  

```B4X
Private Sub TextField1_TextChanged (Old As String, New As String)  
    AS_AutoComplete1.TextChanged(New)  
End Sub
```

  
**Examples**  
<https://www.b4x.com/android/forum/threads/b4x-as-autocomplete-custom-datasource-and-icons.164919/>  
  
**AS\_AutoComplete  
Author: Alexander Stolte  
Version: 1.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_AutoComplete**

- **Events:**

- **ItemClicked** (Item As AS\_SelectionList\_Item)
- **RequestNewData** (SearchText As String)

- **Fields:**

- **Tag** As Object

- **Functions:**

- **Close**
- **CreateItem** (Text As String, Icon As B4XBitmap, Value As Object) As AS\_SelectionList\_Item
- **Initialize** (Callback As Object, EventName As String, RootPanel As B4XView, InputView As B4XView)
*InputView - Can be any view, e.g. B4XFloatTextField or AS\_TextFieldAdvanced*- **KeyboardStateChanged** (Height As Float)
*The view can automatically keep the items in the list visible even when the keyboard is out  
 And the keyboard remains open when the menu is closed*- **Resize** (Width As Float, Height As Float)
*If the RootPanel resize*- **SetDataSource1** (Database As SQL, TableName As String, SearchColumn As String, ValueColumn As String) As AS\_AutoComplete\_DataSource1
- **SetNewData** (ItemList As List)
- **Show**
- **TextChanged** (Text As String)

- **Properties:**

- **AfterItemClickCoolDown** As Long
*How long should the TextChange event be ignored after an item has been clicked on?  
 Should prevent the autocomplete from opening again as soon as the text is added to the text field  
 Default: 1000 = 1 Second*- **AnimationDuration** As Long
*The duration for the opening and closing animation of the popup  
 Default: 150 - Ticks/Milliseconds*- **AutoCloseOnItemClick** As Boolean
*Should the dialog close automatically when an item is clicked  
 Default: True*- **AutoCloseOnNoResults** As Boolean
*Closes the autocomplete if no search results are found  
 Default: True*- **MaxVisibleItems** As Int
*Default: 5*- **SearchTextHighlightedColor** As Int
- **SuggestionMatchCount** As Int
*The minimum number of matching characters required to trigger suggestions with highlighted matches  
 Default: 2*- **TextField2ListGap** As Float
*The Gap between the TextField and the top of the List  
 Default: 5dip*- **Theme** As AS\_SelectionList\_Theme [write only]
- **Theme\_Dark** As AS\_SelectionList\_Theme [read only]
- **Theme\_Light** As AS\_SelectionList\_Theme [read only]

[/SPOILER]  
**Changelog**  

- **1.00**

- Release

- **1.01**

- New FontToBitmap
- New TextToBitmap
- BugFixes and Improvements

- **1.02**

- New DisableTextChanged - If True then the menu is not opened via the TextChanged property

- e.g. If you assign a text to the TextField in the code, the menu would otherwise be opened

- BugFix DataSource1 had a logic error where duplicate entries were seen

- **1.03**

- New SetCustomLayout - You decide where the Auto complete list should appear
- New StandoutTextField

- Default: True
- If True, the background is darkened and the text field is brought to the foreground
- If False, the list is simply displayed

- The background panel remains transparent and the autocomplete is closed as soon as you click next to the menu

- New get SelectionList

Github: [github.com/StolteX/AS\_AutoComplete](https://github.com/StolteX/AS_AutoComplete)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)