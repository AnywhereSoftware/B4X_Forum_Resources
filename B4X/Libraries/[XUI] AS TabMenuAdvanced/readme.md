###  [XUI] AS TabMenuAdvanced by Alexander Stolte
### 04/25/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/140907/)

A container view controller that manages a multiselection interface, where the selection determines which child view controller to display.  
  
This view was developed and structured from scratch :)  
  
i spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/129807)  
![](https://www.b4x.com/android/forum/attachments/130342)  
MiddleButton = True - Designer Property  
**Examples:**  

```B4X
AS_TabMenuAdvanced1.GetTab(2).xTab.BadgeValue = 5 'Sets the Badge Value for the 3. Tab to 5  
AS_TabMenuAdvanced1.GetTab(3).xTab.Enabled = False 'Disabled the 4. Tab  
AS_TabMenuAdvanced1.Refresh 'Commits the changes
```

  
**Example Projects**  
<https://www.b4x.com/android/forum/threads/b4x-as_tabmenuadvanced-aspopupmenu.140928/>  
<https://www.b4x.com/android/forum/threads/b4x-as_tabmenuadvanced-aspopupmenuadvanced.140972/>  
<https://www.b4x.com/android/forum/threads/b4x-as-tabmenuadvanced-designs.141000/>  
<https://www.b4x.com/android/forum/threads/b4x-as_tabmenuadvanced-custom-middle-button.141220/>  
**ASTabMenuAdvanced  
Author: Alexander Stolte  
Version: 1.02**  

- **ASTabMenuAdvanced\_BadgeProperties**

- **Fields:**

- **BackgroundColor** As Int
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **TextFont** As B4XFont
- **TextPadding** As Float

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTabMenuAdvanced\_Tab**

- **Fields:**

- **BadgeValue** As Int
- **Enabled** As Boolean
- **IconDisabled** As B4XBitmap
- **IconSelected** As B4XBitmap
- **IconUnselected** As B4XBitmap
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Tag** As Object
- **Text** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTabMenuAdvanced\_TabIntern**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **xBadgeProperties** As ASTabMenuAdvanced\_BadgeProperties
- **xTab** As ASTabMenuAdvanced\_Tab
- **xTabProperties** As ASTabMenuAdvanced\_TabProperties
- **xTabViews** As ASTabMenuAdvanced\_TabViews

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTabMenuAdvanced\_TabProperties**

- **Fields:**

- **BackgroundColor** As Int
- **DisabledColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SelectedColor** As Int
- **TextFont** As B4XFont
- **TextIconPadding** As Float
- **UnselectedColor** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **ASTabMenuAdvanced\_TabViews**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **xiv\_TabIcon** As B4XView
- **xlbl\_Badge** As B4XView
- **xlbl\_TabText** As B4XView
- **xpnl\_TabBackground** As B4XView

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_TabMenuAdvanced**

- **Events:**

- **TabClick** (Index As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddTab** (Text As String, IconSelected As B4XBitmap, IconUnselected As B4XBitmap) As String
*Text - Pass "" if you dont want Text  
 IconSelected - Pass NULL if you dont want a Icon  
 IconUnselected - Pass NULL if you dont want a Icon  
 If you want to change TabProperties then call this before you add the tab  
 <code>AS\_TabMenuAdvanced1.TabProperties.TextColor = xui.Color\_White</code>*- **AddTabAdvanced** (xTab As ASTabMenuAdvanced\_Tab, xTabProperties As ASTabMenuAdvanced\_TabProperties) As String
*Example:  
 <code>  
 Dim xTab As ASTabMenuAdvanced\_Tab = AS\_TabMenuAdvanced1.CreateASTabMenuAdvanced\_Tab("Test Item",Null,Null)  
 Dim xTabProperties As ASTabMenuAdvanced\_TabProperties = AS\_TabMenuAdvanced1.CreateASTabMenuAdvanced\_TabProperties(xui.CreateDefaultFont(15),xui.Color\_ARGB(255,32, 33, 37),xui.Color\_ARGB(255,45, 136, 121),xui.Color\_ARGB(255,255,255,255),xui.Color\_ARGB(255,60, 64, 67),0)  
 AS\_TabMenuAdvanced1.AddTabAdvanced(xTab,xTabProperties)</code>*- **ChangeColorBasedOnAlphaLevel** (bmp As B4XBitmap, NewColor As Int) As B4XBitmap
- **Class\_Globals** As String
- **CreateASTabMenuAdvanced\_BadgeProperties** (TextColor As Int, TextFont As B4XFont, Height As Float, TextPadding As Float, BackgroundColor As Int) As ASTabMenuAdvanced\_BadgeProperties
- **CreateASTabMenuAdvanced\_Tab** (Text As String, IconSelected As B4XBitmap, IconUnselected As B4XBitmap) As ASTabMenuAdvanced\_Tab
- **CreateASTabMenuAdvanced\_TabIntern** (xTab As ASTabMenuAdvanced\_Tab, xTabProperties As ASTabMenuAdvanced\_TabProperties, xBadgeProperties As ASTabMenuAdvanced\_BadgeProperties, xTabViews As ASTabMenuAdvanced\_TabViews) As ASTabMenuAdvanced\_TabIntern
- **CreateASTabMenuAdvanced\_TabProperties** (TextFont As B4XFont, BackgroundColor As Int, SelectedColor As Int, UnselectedColor As Int, DisabledColor As Int, TextIconPadding As Float) As ASTabMenuAdvanced\_TabProperties
- **CreateASTabMenuAdvanced\_TabViews** (xpnl\_Tab As B4XView, xlbl\_TabText As B4XView, xiv\_TabIcon As B4XView, xlbl\_Badge As B4XView) As ASTabMenuAdvanced\_TabViews
- **CreateImageView** (EventName As String) As B4XView
- **CreateLabel** (EventName As String) As B4XView
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getIndex** As Int
- **GetTab** (Index As Int) As ASTabMenuAdvanced\_TabIntern
*Example:  
 <code>  
 AS\_TabMenuAdvanced1.GetTab(0).xTabProperties.SelectedColor = xui.Color\_Magenta  
 AS\_TabMenuAdvanced1.Refresh</code>*- **getTabProperties** As ASTabMenuAdvanced\_TabProperties
- **GetTabs** As List
*Example:  
 <code>  
 For Each TabIntern As ASTabMenuAdvanced\_TabIntern In AS\_TabMenuAdvanced1.GetTabs  
 Log(TabIntern.xTab.Text)  
 Next</code>*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Refresh** As String
- **RemoveTabAt** (Index As Int) As String
*Removes a tab  
 <code>  
 AS\_TabMenuAdvanced1.RemoveTabAt(2)  
 AS\_TabMenuAdvanced1.Refresh</code>*- **setIndex** (Index As Int) As String

- **Properties:**

- **Index** As Int
- **TabProperties** As ASTabMenuAdvanced\_TabProperties [read only]

**Changelog**  

- **1.00**

- Release

- **1.01**

- xBadge renamed to xBadgeProperties

- **1.02**

- Add GetTabs - Gets a list of tab properties of type ASTabMenuAdvanced\_TabIntern
- Add RemoveTabAt - Removes a tab
- Add Tag Property to Type ASTabMenuAdvanced\_Tab
- Add new Type ASTabMenuAdvanced\_TabViews - contains the control elements of a tab

- **1.03**

- Add LeftPadding to ASTabMenuAdvanced\_BadgeProperties - You can move the badge to left or right with this property
- Add get BadgeProperties - here you can set the global Badge Properties

- **1.04**

- The TabClick Event is now always triggered, even if the tab is already selected
- The BadgeValue Data Type from Type ASTabMenuAdvanced\_Tab is now String

- **1.05**

- Add get and set CornerRadius
- Add new Type ASTabMenuAdvanced\_IndicatorProperties
- Add Designer Property Indicator - If True the Indicator is visible

- Default: False

- BugFixes

- **1.06**

- Add Designer Property MiddleButton - You can now show a middle button

- Default: False
- Limitation: Only an even number of tabs may be present 2,4,6,8,10…

- Add Event MiddleButtonClick
- Add Type ASTabMenuAdvanced\_MiddleButtonProperties

- CustomWidth

- Default: 0

- Add Designer Property BadgeWithoutText - If True then the badges have no text

- Default: False

- **1.07**

- Add Visible to Type ASTabMenuAdvanced\_MiddleButtonProperties - If False then the middle button is not visible, but the space is still kept free

- **1.08**

- Add Designer Property ColorIcons - If false then remains the color of the icon

- Default: True

- **1.09**

- Add Event CustomDrawTab - This ensures that whenever a tab is refreshed, your custom code is also applied

- **1.10**

- BugFix

- **1.11**

- Badge optimizations

- **1.12**

- Add Clear - Clears all tabs

- **1.13**

- BugFix - the badge was not round when the width was smaller than the height
- Add BadgeValue - Sets the badge value without having to call refresh
- set Index no longer needs a "refresh" to be changed

- **1.14**

- BugFix on .Clear

- **1.15**

- BugFix on MiddleButtonProperties.CustomWidth

- **1.16**

- BugFixes

- **1.17**

- Add Designer Property ShapeColor - A thin line on top of the view

- Default: Transparent

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)