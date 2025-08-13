###  [XUI] AS CountryPicker by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/157820/)

A phone number prefix, flag emoji, country code picker.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG). :)  
  
You need:  

- [AS\_TextFieldAdvanced](https://www.b4x.com/android/forum/threads/b4x-xui-as-textfieldadvanced-title-information-counter-password-button-prefix-suffix-icons-multiline.141337/)

  
![](https://www.b4x.com/android/forum/attachments/148380) ![](https://www.b4x.com/android/forum/attachments/148381)  
Datasource from:  
[MEDIA=gist]DmytroLisitsyn/1c31186e5b66f1d6c52da6b5c70b12ad[/MEDIA]  
**AS\_CountryPicker  
Author: Alexander Stolte  
Version: 1.00**  

- **AS\_CountryPicker**

- **Events:**

- **ItemClick** (Item As AS\_CountryPicker\_Item)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Base\_Resize** (Width As Double, Height As Double) As String
- **Class\_Globals** As String
- **CreateAS\_CountryPicker\_Item** (FlagEmoji As String, CountryCode As String, DialCode As String, Name As String) As AS\_CountryPicker\_Item
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **FillList** As String
- **GetCountry** As String
- **getCustomListView** As b4a.example3.customlistview
- **getHeaderColor** As Int
- **getHeaderLabel** As B4XView
- **getHeaderSeperator** As B4XView
- **getHeaderTextColor** As Int
- **GetItem** (CountryCode As String) As AS\_CountryPicker\_Item
*Gets an item with the country code  
 Example: "de" to select Germany*- **GetItem2** (DialCode As String) As AS\_CountryPicker\_Item
*Gets an item with the dial code  
 Example: "+49" to select Germany*- **getItemClickColor** As Int
- **getItemColor** As Int
*Call FillList if you change something*- **getItemTextColor** As Int
- **getOwnCountryColor** As Int
*Call FillList if you change something*- **getOwnCountryTextColor** As Int
*Call FillList if you change something*- **getSearchTextField** As com.stoltex.CountryPicker.as\_textfieldadvanced
- **getSeperatorColor** As Int
*Call FillList if you want to change the seperator in the list too*- **getTextFieldColor** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setHeaderColor** (Color As Int) As String
- **setHeaderTextColor** (Color As Int) As String
- **setItemClickColor** (Color As Int) As String
- **setItemColor** (Color As Int) As String
- **setItemTextColor** (Color As Int) As String
*Call FillList if you change something*- **setOwnCountryColor** (Color As Int) As String
- **setOwnCountryTextColor** (Color As Int) As String
- **setSeperatorColor** (Color As Int) As String
- **setTextFieldColor** (Color As Int) As String

- **Properties:**

- **CustomListView** As b4a.example3.customlistview [read only]
- **HeaderColor** As Int
- **HeaderLabel** As B4XView [read only]
- **HeaderSeperator** As B4XView [read only]
- **HeaderTextColor** As Int
- **ItemClickColor** As Int
- **ItemColor** As Int
*Call FillList if you change something*- **ItemTextColor** As Int
*Call FillList if you change something*- **OwnCountryColor** As Int
*Call FillList if you change something*- **OwnCountryTextColor** As Int
*Call FillList if you change something*- **SearchTextField** As com.stoltex.CountryPicker.as\_textfieldadvanced [read only]
- **SeperatorColor** As Int
*Call FillList if you want to change the seperator in the list too*- **TextFieldColor** As Int

- **AS\_CountryPicker\_Item**

- **Fields:**

- **CountryCode** As String
- **DialCode** As String
- **FlagEmoji** As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Name** As String

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
**Changelog**  

- **1.00**

- Release

- **1.01**

- BugFixes

- **1.02**

- Add get and set MyCountryCode

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)