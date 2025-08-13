###  [XUI] AS MsgBox/Dialog by Alexander Stolte
### 02/24/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/99181/)

First, i spend a lot of time in creating views, some views i need by my self, but some views not and to create a high quality view cost a lot of time. If you want to support me, then you can do it [here by Paypal](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG). :)  
  
Hello, I needed a cross platform msgbox and dialog, that I can modify to 100% and here is it!  
  
If you miss a Feature, then let me know! The Class is easy to use with less code.  
You can create this view with the designer or with code.  
  
Features:  
-Fully Customizable  
-Top and Bottom bar can be hidden  
-A Close Button can be visible  
-Show an Icon (Left , Middle or Right to text)  
-Set Title  
-You can Create your own dialog if you hide the top and bottom bar  
-LoadLayout from Layoutfile or with code  
-Customize the Bottom Buttons  
-Dragable  
-asynchronous with wait for  
-show the dialog with text (no layout required)  
  
B4a,B4I and B4J  
![](https://www.b4x.com/android/forum/attachments/74197) ![](https://www.b4x.com/android/forum/attachments/74198) ![](https://www.b4x.com/android/forum/attachments/74196)  
  
You can enable the Drag feature (B4A,B4I and B4J) only on Topbar or only on body  
![](https://www.b4x.com/android/forum/attachments/74206)  
Code Example (B4X):  

```B4X
Private ASMsgBox1 As ASMsgBox  
  
    ASMsgBox1.Initialize(Me,"ASMsgBox1")  
    ASMsgBox1.InitializeWithoutDesigner(Activity,0xFF2F343A,True,True,False)  
    ASMsgBox1.InitializeBottom("Button1","Button2","Button3")  
  
    ASMsgBox1.EnableDrag = ASMsgBox1.DragableTop  
    ASMsgBox1.icon_set_icon(xui.LoadBitmap(File.DirAssets,"b4x.png"))  
    ASMsgBox1.CenterDialog(Activity)  
    ASMsgBox1.CloseButtonVisible = True  
    ASMsgBox1.ShowWithText("Hello B4X!",True)  
  
    Wait For ASMsgBox1_result(res As Int)  
  
  
    If res = ASMsgBox1.POSITIVE  Then  
  
        Log("Postive")  
        Msgbox("test","title")  
    End If  
  
    Wait For (ASMsgBox1.Close(True)) Complete (Closed As Boolean)
```

  
  
**AS MSGBox   
Author: Alexander Stolte  
Version: 1.1**  

- **ASMsgBox**

- **Events:**

- **IconClick**
- **IconLongClick**
- **result** (res As Int)

- **Functions:**

- **CenterDialog** (Parent As B4XView) As String
- **Class\_Globals** As String
- **Close** (animated As Boolean) As ResumableSub
- **DesignerCreateView** (Base As Object, lbl As Label, Props As Map) As String
*Base type must be Object*- **getBase** As B4XView
*gets the base*- **getBottomColor** As Int
- **getBottomTop** As Int
*gets the Bottom of the header*- **getButton1** As B4XView
*Gets the Action Button1 to modify the visual part*- **getButton2** As B4XView
*Gets the Action Button2 to modify the visual part*- **getButton3** As B4XView
*Gets the Action Button3 to modify the visual part*- **getCANCEL** As Int
*button1 left*- **getCloseButtonVisible** As Boolean
*gets or sets close button visible state*- **getContentHeight** As Int
*gets the height of the content area*- **getDragableContent** As Int
- **getDragableDisable** As Int
- **getDragableTop** As Int
- **getEnableDrag** As Int
- **getHeader\_Font\_Size** As Int
*gets or set the Header Font Size*- **getHeader\_Text** As String
*gets or sets the header text*- **getHeaderBottom** As Int
*gets the Bottom of the header*- **getHeaderColor** As Int
- **getIcon\_direction** As String
*gets or sets the icon direction  
 Possible: LEFT, RIGHT and MIDDLE*- **getNEGATIVE** As Int
*button2 middle*- **getPOSITIVE** As Int
*button3 right*- **icon\_border\_width** (border As Int) As String
*possible: 0-5*- **icon\_set\_icon** (icon As B4XBitmap) As String
- **icon\_visible** (visible As Boolean) As String
- **Initialize** (Callback As Object, EventName As String) As String
- **InitializeBottom** (button1 As String, button2 As String, button3 As String) As String
*button1 = negative button2 = close button3 = positive*- **InitializeWithoutDesigner** (parent As B4XView, backgroundcolor As Int, show\_header As Boolean, show\_bottom As Boolean, show\_close\_button As Boolean) As String
*is only needed, if you not use the designer to show this dialog  
 dont forget to set the header and bottom properties if you show the header or bottom*- **IsInitialized** As Boolean
*Tests whether the object has been initialized.*- **LoadLayout** (layout As String) As String
*set the layout for designer*- **LoadLayout2** (p As B4XView) As String
*set a panel as layout*- **setBottomColor** (color As Int) As String
- **setCloseButtonVisible** (visible As Boolean) As String
*gets or sets close button visible state*- **setEnableDrag** (enable As Int) As String
- **setHeader\_Font\_Size** (fontsize As Int) As String
*gets or set the Header Font Size*- **setHeader\_Text** (text As String) As String
*gets or sets the header text*- **setHeaderColor** (color As Int) As String
- **setIcon\_direction** (direction As String) As String
*gets or sets the icon direction  
 Possible: LEFT, RIGHT and MIDDLE*- **Show** (animated As Boolean) As String
- **ShowWithText** (text As String, animated As Boolean) As String
*show the dialog with centered text instead of a panel or layout.*
- **Properties:**

- **Base** As B4XView [read only]
*gets the base*- **BottomColor** As Int
- **BottomTop** As Int [read only]
*gets the Bottom of the header*- **Button1** As B4XView [read only]
*Gets the Action Button1 to modify the visual part*- **Button2** As B4XView [read only]
*Gets the Action Button2 to modify the visual part*- **Button3** As B4XView [read only]
*Gets the Action Button3 to modify the visual part*- **CANCEL** As Int [read only]
*button1 left*- **CloseButtonVisible** As Boolean
*gets or sets close button visible state*- **ContentHeight** As Int [read only]
*gets the height of the content area*- **DragableContent** As Int [read only]
- **DragableDisable** As Int [read only]
- **DragableTop** As Int [read only]
- **EnableDrag** As Int
- **Header\_Font\_Size** As Int
*gets or set the Header Font Size*- **Header\_Text** As String
*gets or sets the header text*- **HeaderBottom** As Int [read only]
*gets the Bottom of the header*- **HeaderColor** As Int
- **Icon\_direction** As String
*gets or sets the icon direction  
 Possible: LEFT, RIGHT and MIDDLE*- **NEGATIVE** As Int [read only]
*button2 middle*- **POSITIVE** As Int [read only]
*button3 right*
In the attachment are 3 examples. (B4A,B4I and B4J)  
  
Notes:  
-B4A: Reflection library and xui  
-B4I: iXUI  
-B4J: jXUI and JavaObject  
  
Have Fun.  
  
Change log:  
- V1.0  

- Release

- V1.1  

- Bug Fixes
- you can now set the height and width, if you "InitializeWithoutDesigner"

  
Have Fun!  
If you **like** my work, then [spend me a coffe or two](http://paypal.me/stoltex) :)  
[![](https://www.b4x.com/android/forum/attachments/paypal-donate-button-png-clipart-png.79848/)](https://www.paypal.com/donate/?hosted_button_id=PBJGJWDDSM6ZG)