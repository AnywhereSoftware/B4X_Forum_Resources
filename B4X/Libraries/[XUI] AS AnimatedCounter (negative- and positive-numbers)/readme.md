###  [XUI] AS AnimatedCounter (negative- and positive-numbers) by Alexander Stolte
### 03/25/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/98107/)

First, i spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
This is a Animated Counter with more Features. The Class is based on [this](https://www.b4x.com/android/forum/threads/b4x-xui-animated-counter.90505/) class from Erel.  
  
Features:  
-Negative Numbers  
-Positive Numbers ;)  
-Compatible with B4A,B4I and B4J  
-The Numbers are Centered  
-Automatic Counting  
  
 B4A, B4I, B4J  
![](https://www.b4x.com/android/forum/attachments/73091) ![](https://www.b4x.com/android/forum/attachments/73092) ![](https://www.b4x.com/android/forum/attachments/73093)  
  
 B4I Automatic Count, B4I +1 Count  
![](https://www.b4x.com/android/forum/attachments/73094) ![](https://www.b4x.com/android/forum/attachments/73095)  
  
**AS\_Animated Counter  
Author: Alexander Stolte  
Version: 2.00**  

- **AS\_AnimatedCounter**

- **Functions:**

- **AddOne** As String
*current value +1*- **AddViewByCode** (Parent As Object, Label As B4XView, Duration As Int, left As Int, top As Int, width As Int, height As Int) As String
- **Class\_Globals** As String
- **CountAnimatedTo** (speed As Int, number2 As Int)
- **DesignerCreateView** (Base As Object, lbl As Label, Props As Map) As String
*Base type must be Object*- **getBaseView** As B4XView
- **getFont** As B4XFont
*Call Refresh if you change something*- **getTextColor** As Int
*Call Refresh if you change something*- **getValue** As Int
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Refresh** As String
- **RemoveOne** As String
*current value -1*- **setFont** (xFont As B4XFont) As String
- **setTextColor** (TextColor As Int) As String
- **setValue** (v As Int) As String
- **setValueWithoutAnimation** (v As Int) As String

- **Properties:**

- **BaseView** As B4XView [read only]
- **Font** As B4XFont
*Call Refresh if you change something*- **TextColor** As Int
*Call Refresh if you change something*- **Value** As Int
- **ValueWithoutAnimation**

Have Fun.  
  
**Change log:**  

- **V1.0**

- Release of the Class

- **V1.01**

- some bug fixes

- **V1.02**

- Add ValueWithoutAnimation - set a value without the animation

- **V1.03**

- B4I and B4J BugFix - The number "0" was displayed too far down

- **2.00**

- **Breaking change** - lib. renamed to AS\_AnimatedCounter - need to be added again in the designer
- Add get and set Font - Call refresh if you change something
- Add get and set TextColor - Call refresh if you change something
- Add Refresh - Refresh the visuals

- **2.01**

- BugFixes B4J animation is now visible

**Github:** [github.com/StolteX/AS\_AnimatedCounter](https://github.com/StolteX/AS_AnimatedCounter)  
  
If you **like** my work, then [spend me a coffe or two](http://paypal.me/stoltex) :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)