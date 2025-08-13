###  [XUI] AS Gradients Panel by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/109018/)

First, i spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG). :)  
  
**This is the First Version, if you have bugs, then ask in the comments.**  
  
With this view you can create gradients panels, with dynamic colors and sizes.  
Looks better in real… i found it funny, that a .mp4 with high quality has a smaller size than a .gif  
  
![](https://www.b4x.com/android/forum/attachments/83409) ![](https://www.b4x.com/android/forum/attachments/83410)  
  
**Features**  

- Add View per code
- Change Color at runtime
- Generate random colors
- Gradients with less code
- Click Event

  
**ASGradientsPanel  
Author: Alexander Stolte  
Version: 1.0**  

- **ASGradientsPanel**

- **Events:**

- **Click**

- **Functions:**

- **AddViewPerCode** (Base As B4XView, pcolors As Int(), pOrientation As String) As String
*Adds the view per code, note the Base\_Resize event is not fired on this method, you have to resize the view on your own*- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **generate\_rnd\_clr** As Int
- **GetBase** As B4XView
- **GetBaseGradient** As B4XView
- **getBL\_TR** As String
*Bottom Left - Top Right*- **getBOTTOM\_TOP** As String
- **getBR\_TL** As String
*Bottom Right - Top Left*- **getColors** As Int()
- **getCornerRadius** As Double
- **getLEFT\_RIGHT** As String
- **getOrientations** As String
- **getRECTANGLE** As String
- **getRIGHT\_LEFT** As String
- **getTL\_BR** As String
*Top Left - Bottom Right*- **getTOP\_BOTTOM** As String
- **getTR\_BL** As String
*Top Right - Bottom Left*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **RefreshGradient** As String
*Build the Gradient new based on the mBase width and height*- **RefreshView** As String
*Triggers the Base\_Resize event*- **setColors** (pcolors As Int()) As String
- **setCornerRadius** (pCornerRadius As Double) As String
- **setOrientations** (pOrientation As String) As String

- **Properties:**

- **BL\_TR** As String [read only]
*Bottom Left - Top Right*- **BOTTOM\_TOP** As String [read only]
- **BR\_TL** As String [read only]
*Bottom Right - Top Left*- **Colors** As Int()
- **LEFT\_RIGHT** As String [read only]
- **RECTANGLE** As String [read only]
- **RIGHT\_LEFT** As String [read only]
- **TL\_BR** As String [read only]
*Top Left - Bottom Right*- **TOP\_BOTTOM** As String [read only]
- **TR\_BL** As String [read only]
*Top Right - Bottom Left*
*If you **like** my work, then [spend me a coffe or two](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)*