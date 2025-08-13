###  [XUI] AS Placeholder View V0.2 BETA by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/103589/)

First, i spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG). :)  
  
This is a B4X variant of the [50 shades of](https://www.b4x.com/android/forum/threads/fiftyshadesof.71956/#content) lib. for android.  
  
This is a beta, because i only test it on B4A, but the code is B4X, it can have bugs on B4I or B4J.  
  
The View need a "Parent" with the views you want to have a shape, the placeholder create a shape of this layout.  
  
![](https://www.b4x.com/android/forum/attachments/78227)![](https://www.b4x.com/android/forum/attachments/78277)  
Property "Automatic Layout Duplicate" = False  
![](https://www.b4x.com/android/forum/attachments/78280)  
  
**ASPlaceholder  
Author: Alexander Stolte  
Version: 0.2 BETA**  

- **ASPlaceholder**

- **Functions:**

- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **getAnimation\_Duration** As Int
- **getAnimation\_Type** As String
- **getANIMATION\_TYPE\_NONE** As String
- **getANIMATION\_TYPE\_TRANSITION** As String
- **getBackground\_Color\_Of\_Shape** As Int
- **Hide** As String
*Stops the animation*- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Placeholder** (ParentView As B4XView) As String
- **setAnimation\_Duration** (Duration As Int) As String
- **setAnimation\_Type** (Animation As String) As String
- **setBackground\_Color\_Of\_Shape** (Color As Int) As String
- **setBackground\_Color\_Of\_Shape\_Array** (Color As Int()) As String
- **Show** As String
- **Start** As String
- **Stop** As String

- **Properties:**

- **Animation\_Duration** As Int
- **Animation\_Type** As String
- **ANIMATION\_TYPE\_NONE** As String [read only]
- **ANIMATION\_TYPE\_TRANSITION** As String [read only]
- **Background\_Color\_Of\_Shape** As Int
- **Background\_Color\_Of\_Shape\_Array**

  
If you have bugs or new features, then write a comment ;)  
  
If you **like** my work, then [spend me a coffe or two](https://www.paypal.me/stoltex) :)  
  
Change log:  
- V0.1 BETA  

- Beta Release

- V0.2 BETA  
  

- Add Property "Automatic Layout Duplicate"
- Add Background\_Color\_Of\_Shape\_Array
- BugFixes

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)