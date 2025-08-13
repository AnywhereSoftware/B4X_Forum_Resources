###  [XUI] AS ButtonSlider V1.0 by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/103960/)

First, i spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG). :)  
  
another week and a new AS View :p with B4X it is too easy to create custom views!  
Tested on B4J and B4A, on B4A it has a bug if you slide too fast, i will fix it soon.  
2 Years ago I dreamed of such a view like this, but I failed to create it. But now after 1h of work, i do it.:)  
  
![](https://www.b4x.com/android/forum/attachments/78604) ![](https://www.b4x.com/android/forum/attachments/78605)  
  
**AS ButtonSlider  
Author: Alexander Stolte  
Version: 1.01**  

- **ASButtonSlider**

- **Events:**

- **DropSlider** (LeftTop As Boolean)
- **LeftTopClick**
- **ReachedLeftTop**
- **ReachedRightBottom**
- **RightBottomClick**

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getButtonOrientation** As String
- **getBUTTONORIENTATION\_HORIZONTAL** As String
- **getBUTTONORIENTATION\_VERTICAL** As String
- **getLeftTopColor** As Int
- **getLeftTopPnl** As B4XView
*Gets the LeftTop Panel to add a label for Text*- **getRightBottomColor** As Int
- **getRightBottomPnl** As B4XView
*Gets the RightBottom Panel to add a label for Text*- **getSliderButtonColor** As Int
- **getSliderButtonPnl** As B4XView
*Gets the SliderButton Panel to add a label for Text*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **setButtonOrientation** (Orientation As String) As String
- **setLeftTopColor** (Color As Int) As String
- **setRightBottomColor** (Color As Int) As String
- **setSliderButtonColor** (Color As Int) As String

- **Properties:**

- **ButtonOrientation** As String
- **BUTTONORIENTATION\_HORIZONTAL** As String [read only]
- **BUTTONORIENTATION\_VERTICAL** As String [read only]
- **LeftTopColor** As Int
- **LeftTopPnl** As B4XView [read only]
*Gets the LeftTop Panel to add a label for Text*- **RightBottomColor** As Int
- **RightBottomPnl** As B4XView [read only]
*Gets the RightBottom Panel to add a label for Text*- **SliderButtonColor** As Int
- **SliderButtonPnl** As B4XView [read only]
*Gets the SliderButton Panel to add a label for Text*
In the attachment are 2 examples. (B4A and B4J)  
If you have bugs or new features, then write a comment ;)  
  
If you **like** my work, then [spend me a coffe or two](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) :)  
  
Change log:  

- **V1.00**

- Release

- **V1.01**

- Over Dragging from the slider is now impossible

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)