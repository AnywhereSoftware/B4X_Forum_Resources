###  [XUI] AS FlowTabMenu by Alexander Stolte
### 01/29/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/137217/)

The last custom view, for this year,  
a month ago, I felt like creating this view, but had been reluctant to publish it because there is still too little space used for the tabs.  
  
I spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG). :)  
  
It use multi line, if required.  
![](https://www.b4x.com/android/forum/attachments/123577)  
But if you are using 3 tabs, then it fits perfect  
![](https://www.b4x.com/android/forum/attachments/123578)  
Looks better than on the gif  
![](https://www.b4x.com/android/forum/attachments/123579)  

```B4X
ASFlowTabMenu1.AddTab(ASFlowTabMenu1.FontToBitmap(Chr(0xF015),False,20,xui.Color_White),"Home")  
ASFlowTabMenu1.AddTab(ASFlowTabMenu1.FontToBitmap(Chr(0xE7F4),True,20,xui.Color_White),"Notifications")  
ASFlowTabMenu1.AddTab(ASFlowTabMenu1.FontToBitmap(Chr(0xE8B8),True,20,xui.Color_White),"Settings")  
'ASFlowTabMenu1.AddTab(ASFlowTabMenu1.FontToBitmap(Chr(0xF015),False,20,xui.Color_White),"Test 4")
```

  
**ASFlowTabMenu  
Author: Alexander Stolte  
Version: 1.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **ASFlowTabMenu**

- **Events:**

- **TabClick** (index As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddTab** (Icon As B4XBitmap, Text As String) As String
*Add a new tab*- **Class\_Globals** As String
- **CreateASFlowTabMenu\_Tab** (Index As Int, Icon As B4XBitmap, Text As String, TextColor As Int, xFont As B4XFont) As ASFlowTabMenu\_Tab
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getCurrentIndex** As Int
*Gets or sets the current index  
 Sets the current index without animation*- **getGlobalTabProperties** As ASFlowTabMenu\_Tab
*Change this properties before you add tabs*- **getIconHeight** As Float
*Gets or sets the icon Width and Height*- **getSize** As Int
- **GetTabPropertiesAt** (Index As Int) As ASFlowTabMenu\_Tab
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RefreshTabProperties** As String
*If you change Tab Properties then call this function to apply this*- **RemoveTab** (Index As Int) As String
*Removes a tab from a certain index*- **setCurrentIndex** (Index As Int) As String
- **setCurrentIndexAnimated** (Index As Int) As String
*Sets the current index with animation*- **setIconHeight** (Height As Float) As String
*Gets or sets the icon Width and Height*- **SetTabProperties** (Index As Int, TabProperties As ASFlowTabMenu\_Tab) As String
*Call RefreshTabProperties after this*
- **Properties:**

- **CurrentIndex** As Int
*Gets or sets the current index  
 Sets the current index without animation*- **CurrentIndexAnimated**
*Sets the current index with animation*- **GlobalTabProperties** As ASFlowTabMenu\_Tab [read only]
*Change this properties before you add tabs*- **IconHeight** As Float
*Gets or sets the icon Width and Height*- **Size** As Int [read only]

- **ASFlowTabMenu\_Tab**

- **Fields:**

- **Icon** As B4XBitmap
- **Index** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Text** As String
- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
[/SPOILER]  
**Changelog**  

- **1.00**

- Release

- **1.01**

- BugFix on RemoveTab

**Github:** [github.com/StolteX/AS\_FlowTabMenu](https://github.com/StolteX/AS_FlowTabMenu)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)