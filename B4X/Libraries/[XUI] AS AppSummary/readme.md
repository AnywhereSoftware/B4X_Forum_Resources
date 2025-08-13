###  [XUI] AS AppSummary by Alexander Stolte
### 03/31/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/158433/)

This library is used to describe the 3 or 4 most important functions of the app to the user the first time they use it, as an onboarding measure.  
  
The library can also be used as an update log if you have released a major update and want to inform the user which new things are now in the app.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/149292) ![](https://www.b4x.com/android/forum/attachments/149293) ![](https://www.b4x.com/android/forum/attachments/163075)  
**Examples**  

```B4X
    AS_AppSummary1.SetTitleText("Welcome to"," Parcel ","!")  
   
    AS_AppSummary1.AddItem("Supported worldwide","With more than 320 delivery agents supported, you can be sure that your next delivery will be tracked via Parcel.",AS_AppSummary1.FontToBitmap(Chr(0xE894),True,35,AS_AppSummary1.ItemIconProperties.Color),"")  
    AS_AppSummary1.AddItem("Powerful functions","Daily payers, barcode scanners, card support and many other functions make tracking much easier.",AS_AppSummary1.FontToBitmap(Chr(0xF02A),False,35,AS_AppSummary1.ItemIconProperties.Color),"")  
    AS_AppSummary1.AddItem("Push notifications","With a Premium subscription, receive push notifications when there is news about the delivery.",AS_AppSummary1.FontToBitmap(Chr(0xE7F4),True,35,AS_AppSummary1.ItemIconProperties.Color),"")  
   
    AS_AppSummary1.ConfirmButtonText = "Start using Parcel"  
   
    AS_AppSummary1.Refresh
```

  

```B4X
    AS_AppSummary1.SetTitleText("Welcome to"," Parcel ","!")  
   
    Dim Item_Feature1 As AS_AppSummary_Item : Item_Feature1.Initialize  
    Item_Feature1.Name = "Supported worldwide"  
    Item_Feature1.Description = "With more than 320 delivery agents supported, you can be sure that your next delivery will be tracked via Parcel."  
    Item_Feature1.Icon = AS_AppSummary1.FontToBitmap(Chr(0xE894),True,35,AS_AppSummary1.ItemIconProperties.Color)  
    AS_AppSummary1.AddItemAdvanced(Item_Feature1)  
   
    Dim Item_Feature2 As AS_AppSummary_Item : Item_Feature2.Initialize  
    Item_Feature2.Name = "Powerful functions"  
    Item_Feature2.Description = "Daily payers, barcode scanners, card support and many other functions make tracking much easier."  
    Item_Feature2.Icon = AS_AppSummary1.FontToBitmap(Chr(0xF02A),False,35,AS_AppSummary1.ItemIconProperties.Color)  
    AS_AppSummary1.AddItemAdvanced(Item_Feature2)  
   
    Dim Item_Feature3 As AS_AppSummary_Item : Item_Feature2.Initialize  
    Item_Feature3.Name = "Push notifications"  
    Item_Feature3.Description = "With a Premium subscription, receive push notifications when there is news about the delivery."  
    Item_Feature3.Icon = AS_AppSummary1.FontToBitmap(Chr(0xE7F4),True,35,AS_AppSummary1.ItemIconProperties.Color)  
    AS_AppSummary1.AddItemAdvanced(Item_Feature3)  
   
    AS_AppSummary1.ConfirmButtonText = "Start using Parcel"  
   
    AS_AppSummary1.Refresh
```

  
  
**Images, Placeholder, Title and Descriptions**  
<https://www.b4x.com/android/forum/threads/b4x-as-appsummary-images-placeholder-title-and-descriptions.166395/>  
  
**AS\_AppSummary  
Author: Alexander Stolte  
Version: 2.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_AppSummary**

- **Events:**

- **ConfirmButtonClick**
- **CustomDrawItem** (Item As AS\_AppSummary\_Item, ItemViews As AS\_AppSummary\_ItemViews)
- **ItemClicked** (Item As AS\_AppSummary\_Item)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddItem** (Name As String, Description As String, Icon As B4XBitmap, Value As Object) As AS\_AppSummary\_Item
- **AddItemAdvanced** (Item As AS\_AppSummary\_Item)
- **Base\_Resize** (Width As Double, Height As Double)
- **ClearItems**
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **GetItemAt** (Index As Int) As AS\_AppSummary\_Item
- **GetItemViews** (Value As Object) As AS\_AppSummary\_ItemViews
*Gets the item views for a value*- **GetItemViews2** (Index As Int) As AS\_AppSummary\_ItemViews
*Gets the item views for a index*- **Initialize** (Callback As Object, EventName As String)
- **Refresh**
- **SetTitleText** (Text1 As String, ColoredText As String, Text2 As String)

- **Properties:**

- **BackgroundColor** As Int
*Call Refresh if you change something*- **ConfirmButton** As B4XView [read only]
- **ConfirmButtonColor** As Int
*Call Refresh if you change something*- **ConfirmButtonText** As String [write only]
- **ConfirmButtonTextColor** As Int
*Call Refresh if you change something*- **HapticFeedback** As Boolean
- **ItemDescriptionTextColor** As Int
*Call Refresh if you change something*- **ItemIconProperties** As AS\_AppSummary\_ItemIconProperties [read only]
*Call Refresh if you change something*- **ItemNameTextColor** As Int
*Call Refresh if you change something*- **Theme** As AS\_AppSummary\_Theme [write only]
- **Theme\_Dark** As AS\_AppSummary\_Theme [read only]
- **Theme\_Light** As AS\_AppSummary\_Theme [read only]
- **ThemeChangeTransition** As String
*Fade or None*- **TitleColoredTextColor** As Int
*Call SetTitleText if you change this property*- **TitleGap** As Float
*Gap between list and title  
 Default: 20dip  
 Call Refresh if you change something*- **TitleTextColor** As Int
*Call SetTitleText if you change this property*- **TitleTop** As Float
*Default: 100dip  
 Call Refresh if you change something*
[/SPOILER]  
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add AddItemAdvanced
- Add get ConfirmButton
- Title Text BugFix

- **2.00 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-xui-as-appsummary.158433/post-1008534)**)**

- BugFixes
- **Breaking Change** - Add Parameter "Value" to AddItem
- Changed the items base to xCustomListView

- You can now add as many items as you like, it is scrollable

- Add get and set TitleTop
- Add get and set TitleGap - Gap between list and title
- Add set Theme
- Add get Theme\_Dark
- Add get Theme\_Light
- Add Designer Property ThemeChangeTransition

- Default: Fade

- Add GetItemAt
- Add Event ItemClicked
- Add Designer Property HapticFeedback

- Default: True

- Add Event CustomDrawItem
- Add Type AS\_AppSummary\_ItemViews
- Add GetItemViews - Gets the item views for a value
- Add GetItemViews2 - Gets the item views for a index

- **2.01**

- New Designer Property ItemBackground

- Default: None
- Card - The item is displayed as a card with round borders

- New Type AS\_AppSummary\_CardProperties
- BugFix Title is now multiline
- BugFixes and Improvements

- **2.02**

- BugFixes and Improvements
- Change Default Value to "None" for the ThemeChangeTransition property
- New AddImageItem
- New AddDescriptionItem
- New AddTitleItem
- New AddPlaceholder
- New CreateViewPerCode
- New Type AS\_AppSummary\_ImageItem
- New Type AS\_AppSummary\_TitleItem
- New Type AS\_AppSummary\_TitleProperties
- New Type AS\_AppSummary\_DescriptionItem
- New Type AS\_AppSummary\_DescriptionProperties

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)