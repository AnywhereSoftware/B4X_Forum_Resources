###  AS FloatingPanel by Alexander Stolte
### 12/16/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/141754/)

This is a simple panel that can be attached anywhere and opens with an animation.  
More usecases and updates to come ;)  
  
I spend a lot of time in creating views, like this and to create a high quality view cost a lot of time. If you want to support me and further views, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG) or with a [coffee](https://www.buymeacoffee.com/astolte). :)  
  
![](https://www.b4x.com/android/forum/attachments/131368)![](https://www.b4x.com/android/forum/attachments/131369)  
**Examples:**  

```B4X
Dim fp As AS_FloatingPanel  
fp.Initialize(Me,"fp",Root)  
fp.PreSize(200dip,200dip)  
fp.Panel.LoadLayout("frm_Content")  
  
'Open the panel  
fp.Show(0,0,200dip,200dip)  
'or attached on a view  
Dim Top As Float = xlbl_ClickMe.Top + xlbl_ClickMe.Height + 10dip  
fp.Show(xlbl_ClickMe.Left,Top,200dip,200dip)
```

  
**ASFloatingPanel  
Author: Alexander Stolte  
Version: 1.01**  

- **ASFloatingPanel\_ArrowProperties**

- **Fields:**

- **ArrowOrientation** As String
- **Color** As Int
- **Height** As Float
- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **Left** As Float
- **Top** As Float
- **Width** As Float

- **Functions:**

- **Initialize**
*Initializes the fields to their default value.*
- **AS\_FloatingPanel**

- **Events:**

- **Close**

- **Fields:**

- **BackgroundColor** As Int

- **Functions:**

- **Class\_Globals** As String
- **Close**
- **CreateASFloatingPanel\_ArrowProperties** (ArrowOrientation As String, Color As Int, Width As Float, Height As Float, Left As Float, Top As Float) As ASFloatingPanel\_ArrowProperties
- **getArrowOrientation\_Bottom** As String
*The Arrow is on the bottom of the panel*- **getArrowOrientation\_Left** As String
*The Arrow is on the lft of the panel*- **getArrowOrientation\_Right** As String
*The Arrow is on the right of the panel*- **getArrowOrientation\_Top** As String
*The Arrow is on the top of the panel*- **getArrowProperties** As ASFloatingPanel\_ArrowProperties
- **getArrowVisible** As Boolean
- **getOpenOrientation\_BottomTop** As String
*Opens the panel from bottom to top*- **getOpenOrientation\_LeftBottom** As String
*Opens the panel from left to bottom*- **getOpenOrientation\_LeftRight** As String
*Opens the panel from left to right*- **getOpenOrientation\_LeftTop** As String
*Opens the panel from left to top*- **getOpenOrientation\_None** As String
*Opens the panel without slide, but with fade*- **getOpenOrientation\_RightBottom** As String
*Opens the panel from right to bottom*- **getOpenOrientation\_RightLeft** As String
*Opens the panel from right to left*- **getOpenOrientation\_RightTop** As String
*Opens the panel from right to top*- **getOpenOrientation\_TopBottom** As String
*Opens the panel from top to bottom*- **getPanel** As B4XView
- **Initialize** (Callback As Object, EventName As String, Parent As B4XView) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **PreSize** (Width As Float, Height As Float) As String
- **setArrowProperties** (Properties As ASFloatingPanel\_ArrowProperties) As String
- **setArrowVisible** (Visible As Boolean) As String
- **setDuration** (Duration As Long) As String
*Default: 150*- **setOpenOrientation** (Orientation As String) As String
- **Show** (Left As Float, Top As Float, Width As Float, Height As Float)

- **Properties:**

- **ArrowOrientation\_Bottom** As String [read only]
*The Arrow is on the bottom of the panel*- **ArrowOrientation\_Left** As String [read only]
*The Arrow is on the lft of the panel*- **ArrowOrientation\_Right** As String [read only]
*The Arrow is on the right of the panel*- **ArrowOrientation\_Top** As String [read only]
*The Arrow is on the top of the panel*- **ArrowProperties** As ASFloatingPanel\_ArrowProperties
- **ArrowVisible** As Boolean
- **Duration**
*Default: 150*- **OpenOrientation**
- **OpenOrientation\_BottomTop** As String [read only]
*Opens the panel from bottom to top*- **OpenOrientation\_LeftBottom** As String [read only]
*Opens the panel from left to bottom*- **OpenOrientation\_LeftRight** As String [read only]
*Opens the panel from left to right*- **OpenOrientation\_LeftTop** As String [read only]
*Opens the panel from left to top*- **OpenOrientation\_None** As String [read only]
*Opens the panel without slide, but with fade*- **OpenOrientation\_RightBottom** As String [read only]
*Opens the panel from right to bottom*- **OpenOrientation\_RightLeft** As String [read only]
*Opens the panel from right to left*- **OpenOrientation\_RightTop** As String [read only]
*Opens the panel from right to top*- **OpenOrientation\_TopBottom** As String [read only]
*Opens the panel from top to bottom*- **Panel** As B4XView [read only]

**Changelog**  

- **1.00**

- Release

- **1.01 (**[**read more**](https://www.b4x.com/android/forum/threads/b4x-as-floatingpanel.141754/post-901013)**)**

- Add New OpenOrientations

- OpenOrientation\_None

- Opens the panel without slide, but with fade

- OpenOrientation\_LeftTop

- Opens the panel from left to top

- OpenOrientation\_RightTop

- Opens the panel from right to top

- OpenOrientation\_LeftRight

- Opens the panel from left to right

- OpenOrientation\_RightLeft

- Opens the panel from right to left

- OpenOrientation\_TopBottom

- Opens the panel from top to bottom

- OpenOrientation\_BottomTop

- Opens the panel from bottom to top

- Add Arrow
- Add Type ASFloatingPanel\_ArrowProperties

- **1.02**

- BugFixes

- **1.03**

- BugFixes
- Add get and set CloseOnTap

- Default: True

- **1.04**

- BugFix

- **1.05**

- Add get and set CornerRadius

- Default: 10dip

- **1.06**

- B4J BugFix

- **1.07**

- BugFix - The function "Close" works now with CloseOnTap = False

- **1.08**

- B4I Improvements - the entire screen is now used for the background shadow

- When the navigation bar was hidden, there was an area at the top that did not go dark when the menu was opened
- The height of the area is now determined and the gap closed
- B4XPages is now required in B4I

Have Fun :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)