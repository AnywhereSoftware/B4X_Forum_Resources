###  [XUI] AS MultiColumnCustomListView based on xCustomListView by Alexander Stolte
### 12/30/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/149584/)

Hello this is a mutli column custom list view. You can add 1-100 columns, the screen is the limit. The items can have different heights.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
**If a stress test is performed on the view, unwanted behavior can occur, but this does not happen in normal operation. Remember to always test in release mode!**  
  
![](https://www.b4x.com/android/forum/attachments/144771)  
[MEDIA=youtube]M87uf-opTms[/MEDIA]  
  
**AS\_MultiColumnCustomListView  
Author: Alexander Stolte  
Version: 1.00**  

- **AS\_MultiColumnCustomListView**

- **Events:**

- **ItemClick** (Index As Int, Value As Object)
- **ItemLongClick** (Index As Int, Value As Object)
- **ReachEnd**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Add** (Pnl As B4XView, Value As Object) As String
*Adds a custom item.*- **Class\_Globals** As String
- **Commit** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getColumnCount** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
- **Properties:**

- **ColumnCount** As Int [read only]

**Changelog**  

- **1.00**

- Release

- **1.01**

- BugFixes

- **1.02**

- Add Clear - Clears all lists

- **1.03**

- Add Designer Property LazyLoading
- Add Designer Property LazyLoadingExtraSize
- Add Event LazyLoadingAddContent
- Add set ColumnCount

- **1.04**

- New ScrollToValue - Scrolls the list to a specified value

- Scrolls the list to a specified value
- Animated - If True the list scrolls smoothlie - If False the list jump to the item
- Returns “True” if the item was found

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)