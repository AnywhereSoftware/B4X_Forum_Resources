###  [XUI] AS Onboarding [Payware] by Alexander Stolte
### 04/09/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/162065/)

AS Onboarding is a view you can use to attract first-time users when they land on your app. Or to present new features after a major update, with pictures and descriptions. Or to collect user data at the 1st start of the app, many things are possible.  
  
The View is modular and can also be equipped with your own views, everything can be customized.  
  
**Features**  

- Modular
- Add Images, Titles, Description, BBCode and Customviews
- Control what the user may and may not do

- AllowNext, AllowBack, AllowSkip and AllowFinish

- Add and Remove Pages on the fly
- Dark/Light Mode with fluid transition
- and more

This library is **not free**, because, it cost a lot of time and gray hair to create such views.  
You can buy the view here:  
<https://payhip.com/b/RqfJC>  
With the purchase you will receive a text file containing the password for the b4xlib. , so that later updates can be easily downloaded here in the forum.  
If you have any questions or problems, I am available here in the forum, thanks for your support.  
  
Thanks for your understanding. :)  
  
![](https://www.b4x.com/android/forum/attachments/155420)  
  
**[SIZE=5]Examples[/SIZE]**  

```B4X
    '******* 1. Page ************  
    Dim OnboardingPage1 As AS_OnboardingPage = AS_Onboarding1.AddPage  
   
    Dim OnboardingImage As B4XImageView = OnboardingPage1.AddImage(xui.LoadBitmap(File.DirAssets,"Image1.png"),300dip)  
    OnboardingImage.mBackgroundColor = xui.Color_ARGB(255,32, 33, 37)  
    OnboardingImage.Update  
   
    OnboardingPage1.AddPlaceholder(20dip)  
    OnboardingPage1.AddTitle("Test #1")  
    OnboardingPage1.AddPlaceholder(20dip)  
    OnboardingPage1.AddDescription("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")  
  
  
    '******* 2. Page ************  
    Dim OnboardingPage2 As AS_OnboardingPage = AS_Onboarding1.AddPage  
  
    Dim OnboardingImage As B4XImageView = OnboardingPage2.AddImage(xui.LoadBitmap(File.DirAssets,"Image2.png"),300dip)  
    OnboardingImage.mBackgroundColor = xui.Color_ARGB(255,32, 33, 37)  
    OnboardingImage.Update  
  
    OnboardingPage2.AddPlaceholder(20dip)  
    OnboardingPage2.AddTitle("Test #2")  
    OnboardingPage2.AddPlaceholder(20dip)  
    OnboardingPage2.AddDescription("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.")  
  
  
    '******* Last Page ************  
    Dim OnboardingPage3 As AS_OnboardingPage = AS_Onboarding1.AddPage  
    OnboardingPage3.Name = "LastPage"  
  
    Dim OnboardingImage As B4XImageView = OnboardingPage3.AddImage(xui.LoadBitmap(File.DirAssets,"Image3.png"),300dip)  
    OnboardingImage.mBackgroundColor = xui.Color_ARGB(255,32, 33, 37)  
    OnboardingImage.Update  
  
    OnboardingPage3.AddPlaceholder(20dip)  
    OnboardingPage3.AddTitle("Last Page")  
    OnboardingPage3.AddPlaceholder(20dip)  
    OnboardingPage3.AddDescription("Lorem ipsum dolor sit amet")  
  
    #If B4I  
    AS_Onboarding1.BottomOffset = B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom 'Set a custom bottom offset for the items in the bottom sheet  
    #Else  
    AS_Onboarding1.BottomOffset = 0dip 'Set a custom bottom offset for the items in the bottom sheet  
    #End If  
  
    AS_Onboarding1.Create
```

  
  
[SPOILER="Dependencies/Libraries you need for this view"]  
**B4j**: jXUI,ASViewPager,xCustomListView,BCTextEngine,XUI Views  
**B4a**: XUI,ASViewPager,xCustomListView,BCTextEngine,XUI Views  
**B4i**: iXUI,ASViewPager,xCustomListView,BCTextEngine,XUI Views  
[/SPOILER]  
**AS\_Onboarding  
Author: Alexander Stolte  
Version: 1.00  
[SPOILER="Properties, Functions, Events, etc."][/SPOILER]**[SPOILER="Properties, Functions, Events, etc."]  

- **AS\_Onboarding**

- **Events:**

- **PageChange** (Index As Int, Page As AS\_OnboardingPage)
- **PageChanged** (Index As Int, Page As AS\_OnboardingPage)
- **StartButtonClicked**
- **ThemeChanging**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **AddPage** As AS\_OnboardingPage
- **AllowBack** (Allow As Boolean) As String
*If False then user cannot return to the previous page*- **AllowFinish** (Allow As Boolean) As String
*If False then the start button is deactivated*- **AllowNext** (Allow As Boolean) As String
*If False the user cannot go to the next page and the next button is deactivated*- **AllowSkip** (Allow As Boolean) As String
*If False then the skip button is deactivated*- **Class\_Globals** As String
- **ClearPages** As String
*Clears the pages*- **Create**
*Must be called after all pages have been added*- **CreateAS\_Onboarding\_DescriptioneProperties** (TextColor As Int, xFont As B4XFont, HorizontalTextAlignment As String) As AS\_Onboarding\_DescriptioneProperties
- **CreateAS\_Onboarding\_TitleProperties** (TextColor As Int, xFont As B4XFont, HorizontalTextAlignment As String) As AS\_Onboarding\_TitleProperties
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getBackgroundColor** As Int
- **getBottomBackgroundColor** As Int
*Call Refresh if you change something*- **getBottomHeight** As Float
*Call Refresh if you change something*- **getBottomOffset** As Float
*Set a custom bottom offset for the items in the bottom sheet*- **getBottomPanel** As B4XView
*Gets the bottom background panel*- **getDescriptioneProperties** As AS\_Onboarding\_DescriptioneProperties
- **getDescriptionTextColor** As Int
- **getIndicator** As Boolean
*Show or Hide the Indicator  
 Call Refresh if you change something*- **getIndicatorActiveColor** As Int
*Call Refresh if you change something*- **getIndicatorInactiveColor** As Int
*Call Refresh if you change something*- **getItemType\_BBText** As String
- **getItemType\_Custom** As String
- **getItemType\_Description** As String
- **getItemType\_Image** As String
- **getItemType\_Placeholder** As String
- **getItemType\_Title** As String
- **getNextButtonDisabledColor** As Int
- **getNextButtonDisabledTextColor** As Int
- **getNextButtonEnabledColor** As Int
- **getNextButtonEnabledTextColor** As Int
- **getNextButtonLabel** As B4XView
- **getNextButtonStyle** As String
*Call Refresh if you change something  
 <code>AS\_Onboarding1.NextButtonStyle = AS\_Onboarding1.NextButtonStyle\_Big</code>*- **getNextButtonStyle\_Big** As String
- **getNextButtonStyle\_Small** As String
- **GetPageAt** (Index As Int) As AS\_OnboardingPage
*Gets a page at the specified index*- **getPages** As List
*Gets a list of AS\_Onboarding\_Item  
 Example:  
 <code>  
 For Each Page As AS\_OnboardingPage In AS\_Onboarding1.Pages  
 For Each Item As AS\_Onboarding\_Item In Page.ItemList  
 If Item.ItemType = AS\_Onboarding1.ItemType\_Image Then  
 Dim OnboardingImage As B4XImageView = Item.View  
 OnboardingImage.mBackgroundColor = xui.Color\_ARGB(255,233, 233, 233)  
 OnboardingImage.Update  
 End If  
 Next  
 Next  
 </code>*- **getSize** As Int
*Gets the number of pages*- **getSkipButtonDisabledColor** As Int
- **getSkipButtonDisabledTextColor** As Int
- **getSkipButtonEnabledColor** As Int
- **getSkipButtonEnabledTextColor** As Int
- **getSkipButtonLabel** As B4XView
- **getStartButtonDisabledColor** As Int
- **getStartButtonDisabledTextColor** As Int
- **getStartButtonEnabledColor** As Int
- **getStartButtonEnabledTextColor** As Int
- **getTextSideGap** As Float
*Used for the title, description and BBText*- **getTheme\_Dark** As AS\_Onboarding\_Theme
- **getTheme\_Light** As AS\_Onboarding\_Theme
- **getTitleProperties** As AS\_Onboarding\_TitleProperties
- **getTitleTextColor** As Int
- **getViewPager** As com.stoltex.onboarding.asviewpager
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Refresh** As String
- **RemovePageAt** (Index As Int) As String
*Removes a page at the specified index*- **setBackgroundColor** (BackgroundColor As Int) As String
- **setBottomBackgroundColor** (BottomBackgroundColor As Int) As String
- **setBottomHeight** (BottomHeight As Float) As String
- **setBottomOffset** (Offset As Float) As String
- **setDescriptioneProperties** (DescriptioneProperties As AS\_Onboarding\_DescriptioneProperties) As String
- **setDescriptionTextColor** (DescriptionTextColor As Int) As String
- **setIndicator** (Indicator As Boolean) As String
- **setIndicatorActiveColor** (IndicatorActiveColor As Int) As String
- **setIndicatorInactiveColor** (IndicatorInactiveColor As Int) As String
- **setNextButtonDisabledColor** (NextButtonDisabledColor As Int) As String
- **setNextButtonDisabledTextColor** (NextButtonDisabledTextColor As Int) As String
- **setNextButtonEnabledColor** (NextButtonEnabledColor As Int) As String
- **setNextButtonEnabledTextColor** (NextButtonEnabledTextColor As Int) As String
- **setNextButtonStyle** (NextButtonStyle As String) As String
- **setSkipButtonDisabledColor** (SkipButtonDisabledColor As Int) As String
- **setSkipButtonDisabledTextColor** (SkipButtonDisabledTextColor As Int) As String
- **setSkipButtonEnabledColor** (SkipButtonEnabledColor As Int) As String
- **setSkipButtonEnabledTextColor** (SkipButtonEnabledTextColor As Int) As String
- **setStartButtonDisabledColor** (StartButtonDisabledColor As Int) As String
- **setStartButtonDisabledTextColor** (StartButtonDisabledTextColor As Int) As String
- **setStartButtonEnabledColor** (StartButtonEnabledColor As Int) As String
- **setStartButtonEnabledTextColor** (StartButtonEnabledTextColor As Int) As String
- **setTextSideGap** (TextSideGap As Float) As String
- **setTheme** (Theme As AS\_Onboarding\_Theme)
*The ThemeChanging event is triggered*- **setTitleProperties** (TitleProperties As AS\_Onboarding\_TitleProperties) As String
- **setTitleTextColor** (TitleTextColor As Int) As String

- **Properties:**

- **BackgroundColor** As Int
- **BottomBackgroundColor** As Int
*Call Refresh if you change something*- **BottomHeight** As Float
*Call Refresh if you change something*- **BottomOffset** As Float
*Set a custom bottom offset for the items in the bottom sheet*- **BottomPanel** As B4XView [read only]
*Gets the bottom background panel*- **DescriptioneProperties** As AS\_Onboarding\_DescriptioneProperties
- **DescriptionTextColor** As Int
- **Indicator** As Boolean
*Show or Hide the Indicator  
 Call Refresh if you change something*- **IndicatorActiveColor** As Int
*Call Refresh if you change something*- **IndicatorInactiveColor** As Int
*Call Refresh if you change something*- **ItemType\_BBText** As String [read only]
- **ItemType\_Custom** As String [read only]
- **ItemType\_Description** As String [read only]
- **ItemType\_Image** As String [read only]
- **ItemType\_Placeholder** As String [read only]
- **ItemType\_Title** As String [read only]
- **NextButtonDisabledColor** As Int
- **NextButtonDisabledTextColor** As Int
- **NextButtonEnabledColor** As Int
- **NextButtonEnabledTextColor** As Int
- **NextButtonLabel** As B4XView [read only]
- **NextButtonStyle** As String
*Call Refresh if you change something  
 <code>AS\_Onboarding1.NextButtonStyle = AS\_Onboarding1.NextButtonStyle\_Big</code>*- **NextButtonStyle\_Big** As String [read only]
- **NextButtonStyle\_Small** As String [read only]
- **Pages** As List [read only]
*Gets a list of AS\_Onboarding\_Item  
 Example:  
 <code>  
 For Each Page As AS\_OnboardingPage In AS\_Onboarding1.Pages  
 For Each Item As AS\_Onboarding\_Item In Page.ItemList  
 If Item.ItemType = AS\_Onboarding1.ItemType\_Image Then  
 Dim OnboardingImage As B4XImageView = Item.View  
 OnboardingImage.mBackgroundColor = xui.Color\_ARGB(255,233, 233, 233)  
 OnboardingImage.Update  
 End If  
 Next  
 Next  
 </code>*- **Size** As Int [read only]
*Gets the number of pages*- **SkipButtonDisabledColor** As Int
- **SkipButtonDisabledTextColor** As Int
- **SkipButtonEnabledColor** As Int
- **SkipButtonEnabledTextColor** As Int
- **SkipButtonLabel** As B4XView [read only]
- **StartButtonDisabledColor** As Int
- **StartButtonDisabledTextColor** As Int
- **StartButtonEnabledColor** As Int
- **StartButtonEnabledTextColor** As Int
- **TextSideGap** As Float
*Used for the title, description and BBText*- **Theme**
*The ThemeChanging event is triggered*- **Theme\_Dark** As AS\_Onboarding\_Theme [read only]
- **Theme\_Light** As AS\_Onboarding\_Theme [read only]
- **TitleProperties** As AS\_Onboarding\_TitleProperties
- **TitleTextColor** As Int
- **ViewPager** As com.stoltex.onboarding.asviewpager [read only]

- **AS\_OnboardingPage**

- **Functions:**

- **AddBBText** (Text As String) As com.stoltex.onboarding.bbcodeview
- **AddCustom** (Height As Float) As B4XView
- **AddDescription** (Text As String) As B4XView
- **AddImage** (Image As B4XBitmap, Height As Float) As com.stoltex.onboarding.b4ximageview
- **AddPlaceholder** (Height As Float) As String
- **AddTitle** (Text As String) As String
- **Class\_Globals** As String
- **CreateAS\_Onboarding\_Item** (ItemType As String, View As Object) As AS\_Onboarding\_Item
- **getItemList** As List
- **getName** As String
- **getPageBackgroundColor** As Int
- **Initialize** (MainOnboarding As AS\_Onboarding, BackgroundPanel As B4XView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setName** (Name As String) As String
*Set a Name for a better identification of pages*- **setPageBackgroundColor** (PageBackgroundColor As Int) As String

- **Properties:**

- **ItemList** As List [read only]
- **Name** As String
*Set a Name for a better identification of pages*- **PageBackgroundColor** As Int

- **AS\_OnboardingPageIndicator**

- **Fields:**

- **mBase** As B4XView

- **Functions:**

- **Class\_Globals** As String
- **Create** (Base As B4XView, ActiveColor As Int, InactiveColor As Int) As String
- **getActiveColor** As Int
- **getCount** As Int
- **getCurrentPage** As Int
- **getInactiveColor** As Int
- **Initialize** (Callback As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setActiveColor** (ActiveColor As Int) As String
- **setCount** (c As Int) As String
- **setCurrentPage** (i As Int) As String
- **setInactiveColor** (InactiveColor As Int) As String

- **Properties:**

- **ActiveColor** As Int
- **Count** As Int
- **CurrentPage** As Int
- **InactiveColor** As Int

- **AS\_Onboarding\_DescriptioneProperties**

- **Fields:**

- **HorizontalTextAlignment** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_Onboarding\_Item**

- **Fields:**

- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **ItemType** As String
- **View** As Object

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_Onboarding\_Theme**

- **Fields:**

- **BackgroundColor** As Int
- **BottomBackgroundColor** As Int
- **DescriptionTextColor** As Int
- **IndicatorActiveColor** As Int
- **IndicatorInactiveColor** As Int
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **NextButtonDisabledColor** As Int
- **NextButtonDisabledTextColor** As Int
- **NextButtonEnabledColor** As Int
- **NextButtonEnabledTextColor** As Int
- **SkipButtonDisabledColor** As Int
- **SkipButtonDisabledTextColor** As Int
- **SkipButtonEnabledColor** As Int
- **SkipButtonEnabledTextColor** As Int
- **StartButtonDisabledColor** As Int
- **StartButtonDisabledTextColor** As Int
- **StartButtonEnabledColor** As Int
- **StartButtonEnabledTextColor** As Int
- **TitleTextColor** As Int

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_Onboarding\_TitleProperties**

- **Fields:**

- **HorizontalTextAlignment** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **TextColor** As Int
- **xFont** As B4XFont

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **B4XMainPage**

- **Functions:**

- **Class\_Globals** As String
- **Initialize** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*
[/SPOILER]  
**Changelog**  

- **1.00**

- Release

- **1.01**

- Improvements
- Add get StartButtonLabel

- **1.02**

- BugFix

<https://payhip.com/b/RqfJC>  
Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)  
  
**You need** [**AS\_ViewPager**](https://www.b4x.com/android/forum/threads/b4x-xui-as-viewpager-based-on-xcustomlistview.116709/) **V2.08+ and for B4J** [**jPager**](https://www.b4x.com/android/forum/threads/jpager-viewpager.146255/) **V1.03+**