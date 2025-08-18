### SD: Menu (with Animation) by Star-Dust
### 10/12/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/80908/)

**(No WRAP, No Java Only B4A)   
  
Guillotine** is just a swivel guillotine panel that could accommodate a menu but also a panel with all sorts of views.  
The **RollOut Menu** and **Side Menu** are instead menus as you see in the Third Example. There is also a video in post # 6  
**TreeMenu** ***(Tree ListView)***: This class allows you to enter a ListView type menu and clicking each item opens a submenu with its entries (if any) and raises the click event  
  
**SD\_Menu  
  
Author:** Star-Dust  
**Version:** 0.07  

- **GhigliottinaPanel**

- **Fields:**

- **Panel** As Panel
- **View** As View

- **Functions:**

- **Class\_Globals** As String
- **Close** (Animation As Boolean) As String
- **GetPanelBase** As Panel
- **GetPanelMenu** As Panel
- **Initialize** (EventName As String, Me\_CallBack As Object) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **IsOpen** As Boolean
- **Open** (Animation As Boolean) As String
- **SetMenuButtonDark** As String
- **SetMenuButtonLight** As String
- **SetPanelColor** (Color As Int) As String
- **SetTextMenu** (Message As String) As String
- **SetTextMenuColor** (Color As Int) As String

- **GhigliottinaView**

- **Events:**

- **Click**
- **LongClick**

- **Fields:**

- **Panel** As Panel

- **Functions:**

- **AddPanel** (MyPanel As Panel) As String
- **Class\_Globals** As String
- **Close** (Animation As Boolean) As String
- **DesignerCreateView** (Base As Panel, Lbl As Label, Props As Map) As String
- **GetPanelBase** As Panel
- **GetPanelMenu** As Panel
- **Initialize** (vCallback As Object, vEventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **IsOpen** As Boolean
- **Open** (Animation As Boolean) As String
- **SetMenuButtonDark** As String
- **SetMenuButtonLight** As String
- **SetPanelColor** (Color As Int) As String
- **SetTextMenu** (Message As String) As String
- **SetTextMenuColor** (Color As Int) As String

- **MenuTree**

- **Events:**

- **Click** (MenuName As String, ID As String)

- **Fields:**

- **BackGroundColor** As Int
- **ExpandableList** As List
- **ImageCloseMenu** As Bitmap
- **ImageOpenMenu** As Bitmap
- **LeafColor** As Int
- **OpenOneOnlyMenu** As Boolean
- **TextColor** As Int
- **TreeColor** As Int

- **Functions:**

- **AddMenuVoice** (Name As String, ID As String, Expanded As Boolean) As String
- **AddRoot** (Name As String) As String
- **AddSubMenuVoice** (Name As String, ID As String, IDMenuVoice As Int) As String
- **Class\_Globals** As String
- **ClearMenu** As String
- **DesignerCreateView** (Base As Panel, Lbl As Label, Props As Map) As String
- **GetBase** As Panel
- **Initialize** (vCallback As Object, vEventName As String) As String
- **Invalidate** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*
- **RollOutMenu**

- **Events:**

- **Click** (ID As String)

- **Fields:**

- **IsOpen** As Boolean
- **TimeAnimation** As Int

- **Functions:**

- **AddImageButton** (Bitmap As Bitmap, ID As String) As String
- **Class\_Globals** As String
- **Close** (Animation As Boolean)
- **GetPanel** As Panel
 *If you want Add into Panel USE After Initialize*- **Initialize** (EventaName As String, Me\_CallBack As Object, LeftStick As Boolean, HightWidh As Int) As String
*Initializes the object. You can add parameters to this method if needed.  
 RollOut.Initialize("Roll",Me,Activity,True,60dip)*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Open** (Animation As Boolean)

- **SideMenu**

- **Events:**

- **Click** (ID As String)

- **Fields:**

- **IsOpen** As Boolean
- **TimeAnimation** As Int

- **Functions:**

- **AddImageButton** (Bitmap As Bitmap, ID As String) As String
- **Class\_Globals** As String
- **Close** (Animation As Boolean)
- **GetPanel** As Panel
- **Initialize** (EventaName As String, Me\_CallBack As Object, LeftStick As Boolean, HightWidh As Int) As String
*Initializes the object. You can add parameters to this method if needed.  
 RollOut.Initialize("Roll",Me,Activity,True,60dip)*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **Open** (Animation As Boolean)

- **Versione02**
*Code module  
 Subs in this code module will be accessible from all modules.*

- **Fields:**

- **Demo** As Boolean

- **Functions:**

- **Process\_Globals** As String

  
  
![](https://www.b4x.com/android/forum/attachments/61244) ![](https://www.b4x.com/android/forum/attachments/61916) ![](https://www.b4x.com/android/forum/attachments/61917)![](https://www.b4x.com/android/forum/attachments/61242) ![](https://www.b4x.com/android/forum/attachments/61243)