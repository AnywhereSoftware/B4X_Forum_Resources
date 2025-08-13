###  [XUI] AS ColorChooser by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/110542/)

First, i spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG). :)  
  
Tested on B4A. Based on [xCustomListView](https://www.b4x.com/android/forum/threads/b4x-xui-xcustomlistview-cross-platform-customlistview.84501/).  
**This is the First Version, if you have bugs or features, then ask in the comments.**  
  
![](https://www.b4x.com/android/forum/attachments/84702)  
  
ExtendedLineOnClick = True and False  
![](https://www.b4x.com/android/forum/attachments/85609) ![](https://www.b4x.com/android/forum/attachments/85610)  
  
**Features**  

- Cross platform with the same code
- Add Colors per code
- Add more colors with the "+" button (can be disabled)
- Scrolling (Because it is based on the xCustomListView)
- Automatic detection for Horizontal- or Vertical-List
- and more…

**ASColorChooser  
Author: Alexander Stolte  
Version: 1.2**  

- **ASColorChooser**

- **Events:**

- **AddClicked**
- **ColorClicked** (color As Int)

- **Functions:**

- **AddColor** (color As Int) As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, lbl As Label, Props As Map) As String
*Base type must be Object*- **getAutomatic** As String
- **getHorizontal** As String
- **getRound** As String
- **getSquare** As String
- **getVertical** As String
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **SelectByColor** (color As Int) As String
*Fire not the \_ColorClicked Event*
- **Properties:**

- **Automatic** As String [read only]
- **Horizontal** As String [read only]
- **Round** As String [read only]
- **Square** As String [read only]
- **Vertical** As String [read only]

  
Change log:  

- V1.0

- Release

- V1.1

- Add SelectByColor property

- V1.2

- Add New Property "ExtendedLineOnClick"

If you **like** my work, then [spend me a coffe or two](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)