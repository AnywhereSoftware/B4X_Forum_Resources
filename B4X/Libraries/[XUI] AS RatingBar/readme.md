###  [XUI] AS RatingBar by Alexander Stolte
### 12/09/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/117543/)

Hey,  
the performance and handling of this view is very nice.  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG). :)  
  
**Features**  

- cross-platform compatible
- responsible
- events
- easy to use

[SPOILER="Dependencies/Libraries you need for this view"]  
**B4j**: jXUI  
**B4a**: XUi,Reflection  
**B4i**: iXUI  
[/SPOILER]  
  
![](https://www.b4x.com/android/forum/attachments/93695)![](https://www.b4x.com/android/forum/attachments/93696)  
![](https://www.b4x.com/android/forum/attachments/93697)  
  
**ASRatingBar  
Author: Alexander Stolte  
Version: 1.03**  

- **ASRatingBar**

- **Events:**

- **RatingChange** (rating As Int)
- **RatingChanged** (rating As Int)

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **FontToBitmap** (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
*<https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250>*- **getCurrentRating** As Int
- **getImage** As B4XBitmap
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setCurrentRating** (rating As Int) As String
- **SetImages** (active\_image As B4XBitmap, inactive\_image As B4XBitmap) As String

- **Properties:**

- **CurrentRating** As Int
- **Image** As B4XBitmap [read only]

**Changelog**  

- **1.00**

- Release

- **1.01**

- Add getBase
- Add public variable Tag

- **1.02**

- B4X Example
- Custom Props explained

- **1.03**

- Add set Enabled - enabled or disabled the touch gesture

- ASRatingBar1.Enabled = False

- **1.04**

- Fix names in designer
- Add set MaximumRating

- **1.05**

- Add TouchStateChanged

- **1.06**

- Better click handling

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)