###  [XUI] AS Timeline by Alexander Stolte
### 01/06/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/149185/)

This view is a simple horizontal timeline view.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/143987)  
![](https://www.b4x.com/android/forum/attachments/143986)  
**AS\_Timeline  
Author: Alexander Stolte  
Version: 1.00**  

- **AS\_Timeline**

- **Events:**

- **SelectionChanged** (Item As AS\_Timeline\_Item)

- **Fields:**

- **g\_ItemProperties** As AS\_Timeline\_ItemProperties
- **lst\_Items** As List
- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddItem** (DataYear As String, DataInfo As String, Value As Object) As String
*Add a item  
 DataYear - Year Text e.g. 1960  
 DataInfo - Description Text  
 Value - whatever you want*- **AddItemAdvanced** (Item As AS\_Timeline\_Item) As String
- **AddItemDuration** (DataYear As String, DataInfo As String, Value As Object, AutoPlayDuration As Int) As String
*Add a item with a custom duration for this item, if you are using auto play  
 DataYear - Year Text e.g. 1960  
 DataInfo - Description Text  
 Value - whatever you want  
 AutoPlayDuration - Duration in milliseconds*- **Class\_Globals** As String
- **CreateAS\_Timeline\_ItemProperties** (UnReachedColor As Int, ReachedColor As Int, UnReachedFont As B4XFont, ReachedFont As B4XFont) As AS\_Timeline\_ItemProperties
- **CreateTimeline** As String
*Call this if you change something or if you want to show it*- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **PauseAutoPlay** As String
*Paused AutoPlay*- **StartAutoPlay** As String
*Starts the AutoPlay*- **StopAutoPlay** As String
*Stops the AutoPlay*
- **AS\_Timeline\_Item**

- **Fields:**

- **DataInfo** As String
- **DataYear** As String
- **Duration** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ItemProperties** As AS\_Timeline\_ItemProperties
- **Value** As Object

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_Timeline\_ItemProperties**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ReachedColor** As Int
- **ReachedFont** As B4XFont
- **UnReachedColor** As Int
- **UnReachedFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add Event CustomDrawItem
- Add get and set Index

- **1.02**

- New SetIndexByValue - Selects the item which value is passed

Github: [github.com/StolteX/AS\_Timeline](http://github.com/StolteX/AS_Timeline)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)