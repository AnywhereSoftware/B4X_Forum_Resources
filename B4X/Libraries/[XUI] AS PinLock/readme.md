###  [XUI] AS PinLock by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/102476/)

First, i spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG). :)  
  
This Class is optimized for B4A and B4I, but not for B4J.  
  
**This is the First Version, if you have bugs, then ask in the comments.**  
  
This is a Lock View, to secure private user data in the app, the user must enter a code to get ahead.  
  
![](https://www.b4x.com/android/forum/attachments/77226) ![](https://www.b4x.com/android/forum/attachments/77228) ![](https://www.b4x.com/android/forum/attachments/77227)  
  
You can encrypt the input with the following methods  

- MD5
- SHA-1
- SHA-224
- SHA-256
- SHA-384
- SHA-512
- NONE (the output is 12345678 for example without encryption)

You can set a Salt value to the Hash.  
And so it works:  
1 + Salt Optional = Hash  
2 + Salt Optional = Hash  
3 + Salt Optional = Hash  
4 + Salt Optional = Hash  
  
Hash1 + Hash2 + Hash3 + Hash4 + Salt = Final Hash  
The Final Hash you must save and then you can compare the hash with the user input.  
  
**Features**  

- you can use your own Layout on the Header (header.LoadLayout("tst.bal"))
- background and textcolor color is customizable
- the Fingerprint icon is just a placeholder for your own function like a Fingerprint or a questionmark for help
- MD5,SHA-1,SHA-224,SHA-256,SHA-384 and SHA-512 to encrypt the input
- responsive design, you can rotate the smartphone and it still looks cool :cool:
- 4 or 8 input length
- more…

**Author: Alexander Stolte  
Version: 1.2**  

- **ASPinLocker**

- **Events:**

- **BaseResize**
- **CustomKeyClick**
- **PinReady** (Value As String)

- **Fields:**

- **xpnl\_key\_0** As B4XView
- **xpnl\_key\_1** As B4XView
- **xpnl\_key\_2** As B4XView
- **xpnl\_key\_3** As B4XView
- **xpnl\_key\_4** As B4XView
- **xpnl\_key\_5** As B4XView
- **xpnl\_key\_6** As B4XView
- **xpnl\_key\_7** As B4XView
- **xpnl\_key\_8** As B4XView
- **xpnl\_key\_9** As B4XView
- **xpnl\_key\_delete** As B4XView
- **xpnl\_key\_fingerprint** As B4XView

- **Functions:**

- **Class\_Globals** As String
- **ClearInput** As String
*Reset the input*- **Deny** As String
*Set the Color of Labels in the Code Area to the Deny Color, to show the user that the input was wrong*- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getCodeBackgroundColor** As Int
- **getCodeLength** As Int
*Get or Set the Code Length (4 or 8)*- **getCodeTextColor** As Int
*Get or Set the Code Color (Description Text Color and Code Circels Color)*- **getDenyColor** As Int
*Get or Set the Deny Color (Description Text Color and Code Circels Color)*- **getDescription** As String
*Get or Sets the Description Text (Enter access code)*- **getDescriptionColor** As Int
*Get or Sets the Description Color (Enter access code)*- **getemMD5** As String
- **getemNONE** As String
- **getemSHA1** As String
- **getemSHA224** As String
- **getemSHA256** As String
- **getemSHA384** As String
- **getemSHA512** As String
- **getEncryptMethod** As String
*Get or Set the Encryption Method Valid: MD5 SHA-1 SHA-224 SHA-256 SHA-384 SHA-512 NONE*- **getHeaderColor** As Int
*Get or Sets the Header Background Color*- **getHeaderPanel** As B4XView
*Get the Header Panel, to load your own Layout*- **getKeyboardBackgroundColor** As Int
- **getKeyboardClickColor** As Int
*Get or Set the Keyboard Click Color*- **getKeyboardExtraButtonBackgroundColor** As Int
- **getKeyboardSeperatorColor** As Int
- **getKeyboardTextColor** As Int
- **getSalt** As String
*Get or Set the Salt Value to Secure your User Input more*- **getShowKeyboardSeperator** As Boolean
- **getSuccessColor** As Int
*Get or Set the Success Color (Description Text Color and Code Circels Color)*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setCodeBackgroundColor** (color As Int) As String
- **setCodeLength** (Length As Int) As String
*Get or Set the Code Length (4 or 8)*- **setCodeTextColor** (Color As Int) As String
*Get or Set the Code Color (Description Text Color and Code Circels Color)*- **setDenyColor** (Color As Int) As String
*Get or Set the Deny Color (Description Text Color and Code Circels Color)*- **setDescription** (text As String) As String
*Get or Sets the Description Text (Enter access code)*- **setDescriptionColor** (Color As Int) As String
*Get or Sets the Description Color (Enter access code)*- **setEncryptMethod** (Method As String) As String
*Get or Set the Encryption Method Valid: MD5 SHA-1 SHA-224 SHA-256 SHA-384 SHA-512 NONE*- **setHeaderColor** (Color As Int) As String
*Get or Sets the Header Background Color*- **setKeyboardBackgroundColor** (color As Int) As String
- **setKeyboardClickColor** (Color As Int) As String
*Get or Set the Keyboard Click Color*- **setKeyboardExtraButtonBackgroundColor** (color As Int) As String
- **setKeyboardSeperatorColor** (color As Int) As String
- **setKeyboardTextColor** (color As Int) As String
- **setSalt** (Salt As String) As String
*Get or Set the Salt Value to Secure your User Input more*- **setShowKeyboardSeperator** (show As Boolean) As String
- **setSuccessColor** (Color As Int) As String
*Get or Set the Success Color (Description Text Color and Code Circels Color)*- **Success** As String
*Set the Color of Labels in the Code Area to the Success Color, to show the user that the input was right*
- **Properties:**

- **CodeBackgroundColor** As Int
- **CodeLength** As Int
*Get or Set the Code Length (4 or 8)*- **CodeTextColor** As Int
*Get or Set the Code Color (Description Text Color and Code Circels Color)*- **DenyColor** As Int
*Get or Set the Deny Color (Description Text Color and Code Circels Color)*- **Description** As String
*Get or Sets the Description Text (Enter access code)*- **DescriptionColor** As Int
*Get or Sets the Description Color (Enter access code)*- **emMD5** As String [read only]
- **emNONE** As String [read only]
- **emSHA1** As String [read only]
- **emSHA224** As String [read only]
- **emSHA256** As String [read only]
- **emSHA384** As String [read only]
- **emSHA512** As String [read only]
- **EncryptMethod** As String
*Get or Set the Encryption Method Valid: MD5 SHA-1 SHA-224 SHA-256 SHA-384 SHA-512 NONE*- **HeaderColor** As Int
*Get or Sets the Header Background Color*- **HeaderPanel** As B4XView [read only]
*Get the Header Panel, to load your own Layout*- **KeyboardBackgroundColor** As Int
- **KeyboardClickColor** As Int
*Get or Set the Keyboard Click Color*- **KeyboardExtraButtonBackgroundColor** As Int
- **KeyboardSeperatorColor** As Int
- **KeyboardTextColor** As Int
- **Salt** As String
*Get or Set the Salt Value to Secure your User Input more*- **ShowKeyboardSeperator** As Boolean
- **SuccessColor** As Int
*Get or Set the Success Color (Description Text Color and Code Circels Color)*
Change log:  
- V1.1  

- Add Custom Key Click (Fingerprint Key)
- Add Clear Input to reset the user input
- Add Explanations on the Subs

-V1.2  

- Removes unused variable
- Fix Bug the setDescription property was not showing
- Add CodeColor Property
- Add KeyboardBackgroundColor Porperty
- Add KeyboardTextColor Poperty
- Add KeyboardExtraButtonBackgroundColor
- Remove Seperator Bug with the new seperators
- Add New Designer-Property ShowKeyboardSeperator set to true to show seperators on the numberfields
- Add New Designer-Property KeyboardSeperatorColor set the seperator color for the numberfields
- Add EncryptMethods as return values

If you **like** my work, then [spend me a coffe or two](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)