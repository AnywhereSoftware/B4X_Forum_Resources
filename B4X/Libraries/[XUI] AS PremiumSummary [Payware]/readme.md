###  [XUI] AS PremiumSummary [Payware] by Alexander Stolte
### 02/26/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/160614/)

With this view you can easily and with little effort list your premium features and make it easier for the customer to choose the right premium package.  
  
This library is **not free**, because, it cost a lot of time and gray hair to create such views.  
You can buy the view here:  
<https://payhip.com/b/M16Wz>  
With the purchase you will receive a zip file containing the b4xlib. and a text file with the password, so that later updates can be easily downloaded here in the forum.  
If you have any questions or problems, I am available here in the forum, thanks for your support.  
  
Thanks for your understanding. :)  
  
![](https://www.b4x.com/android/forum/attachments/152864)  
**Please note that the B4J version is coming later, the view works great with B4A and B4I.**  
  
Complete video guide for setting up and implementing:  
<https://www.b4x.com/android/forum/threads/in-app-subscriptions-with-revenuecat-and-as_premiumsummary-videos.165841/>  
  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4j**: jXUI,xCustomListView  
**B4a**: XUI,xCustomListView,StringUtils  
**B4i**: iXUI,xCustomListView  
[/SPOILER]  
**AS\_PremiumSummary  
Author: Alexander Stolte  
Version: 1.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_PremiumSummary**

- **Events:**

- **ClickableTextClick** (Button As String)
- **CloseButtonClicked**
- **PaidOptionClicked** (Index As Int, PaidOption As AS\_PremiumSummary\_PaidOption)
- **PurchaseButtonClick** (ProductIdentifier As String)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Add\_AppLogo** (Icon As B4XBitmap, Width As Float, Height As Float) As Map
- **Add\_ClickableText** (LeftText As String, MiddleText As String, RightText As String) As Map
- **Add\_Feature\_1** (Title As String, Description As String, Icon As B4XBitmap) As Map
- **Add\_Feature\_2** (Text As String, Icon As B4XBitmap) As Map
- **Add\_PaidOption** (Name As String, DisplayName As String, DisplayPriceText As String, PriceValue As String, isSelected As Boolean) As Map
- **Add\_Placeholder** (Height As Int) As Map
- **Add\_PurchaseButton** (Text As String) As Map
- **Add\_Seperator** (StrokeWidth As Float, Height As Float) As Map
- **Add\_Title** (Text As String, TextAlignmentHorizontal As String, xFont As B4XFont) As Map
- **AddItemToBottomSheet** (Item As Map) As String
- **AddItemToList** (Item As Map) As String
- **Base\_Resize** (Width As Double, Height As Double) As String
- **Class\_Globals** As String
- **Create**
- **CreateAS\_PremiumSummary\_PaidOption** (Name As String, DisplayName As String, PriceText As String, PriceValue As String, BadgeText As String) As AS\_PremiumSummary\_PaidOption
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getAppColor** As Int
- **getAppTextColor** As Int
- **getBackgroundColor** As Int
- **getBottomBackgroundColor** As Int
- **getBottomOffset** As Float
*Set a custom bottom offset for the items in the bottom sheet*- **getFeatureGapBetween** As Float
- **getMainTextColor** As Int
- **getPurchaseButtonText** As String
- **getSecondTextColor** As Int
- **getTheme\_Dark** As AS\_PremiumSummary\_Theme
- **getTheme\_Light** As AS\_PremiumSummary\_Theme
- **Initialize** (Callback As Object, EventName As String) As String
- **isCreated** As Boolean
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setAppColor** (Color As Int) As String
- **setAppLogo** (Icon As B4XBitmap) As String
- **setAppTextColor** (Color As Int) As String
- **setBackgroundColor** (Color As Int) As String
- **setBottomBackgroundColor** (Color As Int) As String
- **setBottomOffset** (Offset As Float) As String
- **setFeatureGapBetween** (Height As Float) As String
- **setMainTextColor** (Color As Int) As String
- **setPurchaseButtonText** (Text As String) As String
- **setSecondTextColor** (Color As Int) As String
- **setTheme** (Theme As AS\_PremiumSummary\_Theme)

- **Properties:**

- **AppColor** As Int
- **AppLogo**
- **AppTextColor** As Int
- **BackgroundColor** As Int
- **BottomBackgroundColor** As Int
- **BottomOffset** As Float
*Set a custom bottom offset for the items in the bottom sheet*- **FeatureGapBetween** As Float
- **MainTextColor** As Int
- **PurchaseButtonText** As String
- **SecondTextColor** As Int
- **Theme**
- **Theme\_Dark** As AS\_PremiumSummary\_Theme [read only]
- **Theme\_Light** As AS\_PremiumSummary\_Theme [read only]

- **AS\_PremiumSummary\_PaidOption**

- **Fields:**

- **BadgeText** As String
- **DisplayName** As String
- **Index** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Name** As String
- **PriceText** As String
- **PriceValue** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_PremiumSummary\_Theme**

- **Fields:**

- **AppColor** As Int
- **AppTextColor** As Int
- **BackgroundColor** As Int
- **BottomBackgroundColor** As Int
- **CloseButtonColor** As Int
- **IconColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **MainTextColor** As Int
- **SecondTextColor** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
[/SPOILER]  
**Changelog**  

- **1.00**

- Release

- **1.01**

- Add Clear - Clears all items
- Add ShowInfo and HideInfo - display a message to the user, e.g. if no connection to the app store could be established
- Add Event InfoButtonClicked

<https://payhip.com/b/M16Wz>  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)