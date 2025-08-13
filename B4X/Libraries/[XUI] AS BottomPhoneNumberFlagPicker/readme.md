###  [XUI] AS BottomPhoneNumberFlagPicker by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/157781/)

A bottom phone number prefix, flag emoji, country code picker.  
  
You need:  

- [AS\_DraggableBottomCard](https://www.b4x.com/android/forum/threads/b4x-xui-as-draggable-bottom-card.121219/)
- [AS\_WheelPicker **V3.21+**](https://www.b4x.com/android/forum/threads/b4x-xui-as-wheelpicker-spinner-a-modern-single-multiple-choice-picker-view-based-on-xcustomlistview-payware.127505/)

I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/148307)![](https://www.b4x.com/android/forum/attachments/148308)  
  
Datasource from:  
[MEDIA=gist]DmytroLisitsyn/1c31186e5b66f1d6c52da6b5c70b12ad[/MEDIA]  
  

```B4X
    BottomPhoneNumberFlagPicker.Initialize(Me,"BottomPhoneNumberFlagPicker",Root)  
   
    BottomPhoneNumberFlagPicker.Color = xui.Color_ARGB(255,32, 33, 37)  
    BottomPhoneNumberFlagPicker.TextColor = xui.Color_White  
   
    'Selects an item with the dial code  
    BottomPhoneNumberFlagPicker.SelectItem2("+49") 'Example: "+49" to select Germany  
   
    BottomPhoneNumberFlagPicker.ShowPicker
```

  

```B4X
    BottomPhoneNumberFlagPicker.Initialize(Me,"BottomPhoneNumberFlagPicker",Root)  
   
    BottomPhoneNumberFlagPicker.Color = xui.Color_White  
    BottomPhoneNumberFlagPicker.TextColor = xui.Color_Black  
   
    'Selects an item with the country code  
    BottomPhoneNumberFlagPicker.SelectItem(GetCountry) 'Example: "de" to select Germany  
   
    BottomPhoneNumberFlagPicker.ShowPicker
```

  

```B4X
#If B4I  
Private Sub GetCountry As String  
    Dim no As NativeObject  
    Dim s As String  = no.Initialize("NSLocale") _  
        .RunMethod("currentLocale", Null).RunMethod("objectForKey:", Array("kCFLocaleCountryCodeKey")).AsString  
    Return s  
End Sub  
#Else If B4A  
Private Sub GetCountry As String  
    Dim r As Reflector  
    r.Target = r.RunStaticMethod("java.util.Locale", "getDefault", Null, Null)  
    Return r.RunMethod("getCountry")  
End Sub  
#End If
```

  
**AS\_BottomPhoneNumberFlagPicker  
Author: Alexander Stolte  
Version: 1.00**  

- **AS\_BottomPhoneNumberFlagPicker**

- **Events:**

- **ConfirmButtonClicked** (Item As AS\_BottomPhoneNumberFlagPicker\_Item)

- **Fields:**

- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **CreateAS\_BottomPhoneNumberFlagPicker** (FlagEmoji As String, CountryCode As String, DialCode As String, Name As String) As AS\_BottomPhoneNumberFlagPicker\_Item
- **getColor** As Int
- **getTextColor** As Int
- **Initialize** (Callback As Object, EventName As String, Parent As B4XView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SelectItem** (CountryCode As String) As String
*Selects an item with the country code  
 Example: "de" to select Germany*- **SelectItem2** (DialCode As String) As String
*Selects an item with the dial code  
 Example: "+49" to select Germany*- **setColor** (Color As Int) As String
- **setTextColor** (Color As Int) As String
- **ShowPicker**

- **Properties:**

- **Color** As Int
- **TextColor** As Int

- **AS\_BottomPhoneNumberFlagPicker\_Item**

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

- Add GetItem - Gets an item with the country code
- Add GetItem2 - Gets an item with the dial code

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)