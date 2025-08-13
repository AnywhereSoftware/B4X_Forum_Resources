###  [XUI] AS BottomAppSummary by Alexander Stolte
### 03/31/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/166400/)

This library makes it easy to quickly show the 3 or 4 most important functions of the app to the user during their first launch, as part of the onboarding process — based on the [AS\_AppSummary](https://www.b4x.com/android/forum/threads/b4x-xui-as-appsummary.158433/), built into a ready to use bottom menu. It can also be used as an update log to highlight key changes after a major update.  
  
You need:  

- [AS\_DraggableBottomCard](https://www.b4x.com/android/forum/threads/b4x-xui-as-draggable-bottom-card.121219/) **V1.14+**
- [AS\_AppSummary](https://www.b4x.com/android/forum/threads/b4x-xui-as-appsummary.158433/) **V2.02+**

I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
   
![](https://www.b4x.com/android/forum/attachments/163094)  
  
   

```B4X
Private Sub OpenSheet(DarkMode As Boolean)  
    BottomAppSummary.Initialize(Me,"BottomAppSummary",Root)  
    BottomAppSummary.Theme = IIf(DarkMode,BottomAppSummary.Theme_Dark,BottomAppSummary.Theme_Light)  
    
    BottomAppSummary.AddImageItem(xui.LoadBitmap(File.DirAssets,"NewFeature.png"),400dip,"")  
    BottomAppSummary.AddPlaceholder(10dip)  
    BottomAppSummary.AddTitleItem("Detailed Task Distribution Overview","")  
    BottomAppSummary.AddPlaceholder(10dip)  
    BottomAppSummary.AddDescriptionItem("Pie chart showing task distribution by category and time range for quick performance insights.","")  
    
    BottomAppSummary.ShowPicker(600dip)  
    
    BottomAppSummary.ConfirmButtonText = "Continue"  
    
End Sub
```

  
  

```B4X
Private Sub OpenSheet(DarkMode As Boolean)  
    BottomAppSummary.Initialize(Me,"BottomAppSummary",Root)  
    BottomAppSummary.Theme = IIf(DarkMode,BottomAppSummary.Theme_Dark,BottomAppSummary.Theme_Light)  
  
    BottomAppSummary.SetTitleText("Welcome to"," Parcel ","!")  
    BottomAppSummary.AddItem("Supported worldwide","With more than 320 delivery agents supported, you can be sure that your next delivery will be tracked via Parcel.",BottomAppSummary.FontToBitmap(Chr(0xE894),True,35,BottomAppSummary.ItemIconProperties.Color),"")  
    BottomAppSummary.AddItem("Powerful functions","Daily payers, barcode scanners, card support and many other functions make tracking much easier.",BottomAppSummary.FontToBitmap(Chr(0xF02A),False,35,BottomAppSummary.ItemIconProperties.Color),"")  
    BottomAppSummary.AddItem("Push notifications","With a Premium subscription, receive push notifications when there is news about the delivery.",BottomAppSummary.FontToBitmap(Chr(0xE7F4),True,35,BottomAppSummary.ItemIconProperties.Color),"")  
  
    BottomAppSummary.ShowPicker(500dip)  
    
    BottomAppSummary.ConfirmButtonText = "Continue"  
    
End Sub
```

  
  
**AS\_BottomAppSummary  
Author: Alexander Stolte  
Version: 1.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER][SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_BottomAppSummary**

- **Events:**

- **ActionButtonClicked**
- **Close**
- **CustomDrawItem** (Item As AS\_AppSummary\_Item, ItemViews As AS\_AppSummary\_ItemViews)
- **ItemClicked** (Item As AS\_AppSummary\_Item)

- **Fields:**

- **Tag** As Object

- **Functions:**

- **AddDescriptionItem** (Text As String, Value As Object) As AS\_AppSummary\_DescriptionItem
- **AddImageItem** (xBitmap As B4XBitmap, Height As Float, Value As Object) As AS\_AppSummary\_ImageItem
- **AddItem** (Name As String, Description As String, Icon As B4XBitmap, Value As Object) As AS\_AppSummary\_Item
- **AddPlaceholder** (Height As Float)
- **AddTitleItem** (Text As String, Value As Object) As AS\_AppSummary\_TitleItem
- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **HidePicker**
- **Initialize** (Callback As Object, EventName As String, Parent As B4XView)
*Initializes the object. You can add parameters to this method if needed.*- **SetTitleText** (Text1 As String, ColoredText As String, Text2 As String)
- **ShowPicker** (BodyHeight As Float)

- **Properties:**

- **AppSummary** As AS\_AppSummary [read only]
- **Color** As Int
- **ConfirmButtonText** As String [write only]
- **DragIndicatorColor** As Int
- **ItemIconProperties** As AS\_AppSummary\_ItemIconProperties [read only]
- **SelectionMode\_Multi** As String [read only]
- **SelectionMode\_Single** As String [read only]
- **SheetWidth** As Float
*Set the value to greater than 0 to set a custom width  
 Set the value to 0 to use the full screen width  
 Default: 0*- **Theme** As AS\_BottomAppSummary\_Theme [write only]
- **Theme\_Dark** As AS\_BottomAppSummary\_Theme [read only]
- **Theme\_Light** As AS\_BottomAppSummary\_Theme [read only]
- **ThemeChangeTransition** As String
*Fade or None*- **ThemeChangeTransition\_Fade** As String [read only]
- **ThemeChangeTransition\_None** As String [read only]

[/SPOILER]  
**Changelog**  

- **1.00**

- Release

**Github:** [github.com/StolteX/AS\_BottomAppSummary](https://github.com/StolteX/AS_BottomAppSummary)  
  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)