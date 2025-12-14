### SD: RollMenu by Star-Dust
### 12/12/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/98779/)

**iSD\_RollMenu  
  
Author:** Star-Dust  
**Version:** 0.01  

- **RollOutMenu**

- **Events:**

- **Click** (ID As String)

- **Fields:**

- **IsOpen** As BOOL
- **SpaceFromTop** As Int
- **TimeAnimation** As Int

- **Functions:**

- **AddImageButton** (Bitmap As B4IBitmap\*, ID As NSString\*) As NSString\*
- **Class\_Globals** As NSString\*
- **Close** (Animation As BOOL)
- **GetPanel** As B4IPanelWrapper\*
 *If you want Add into Panel USE After Initialize*- **Initialize** (ba As B4I\*, EventaName As NSString\*, Me\_CallBack As NSObject\*, RootPanel As B4IPanelWrapper\*, LeftStick As BOOL, HightWidh As Int) As NSString\*
*Initializes the object. You can add parameters to this method if needed.  
 RollOut.Initialize("Roll",Me,Activity,True,60dip)*- **IsInitialized** As BOOL
*Verifica se l'oggetto sia stato inizializzato.*- **Open** (Animation As BOOL)

- **TurnOutMenu**

- **Events:**

- **Click** (ID As String)

- **Fields:**

- **IsOpen** As BOOL
- **SpaceFromTop** As Int
- **TimeAnimation** As Int

- **Functions:**

- **AddImageButton** (Bitmap As B4IBitmap\*, ID As NSString\*) As NSString\*
- **Class\_Globals** As NSString\*
- **Close** (Animation As BOOL)
- **GetPanel** As B4IPanelWrapper\*
- **Initialize** (ba As B4I\*, EventaName As NSString\*, Me\_CallBack As NSObject\*, RootPanel As B4IPanelWrapper\*, LeftStick As BOOL, HightWidh As Int) As NSString\*
*Initializes the object. You can add parameters to this method if needed.  
 RollOut.Initialize("Roll",Me,Activity,True,60dip)*- **IsInitialized** As BOOL
*Verifica se l'oggetto sia stato inizializzato.*- **Open** (Animation As BOOL)

![](https://www.b4x.com/android/forum/attachments/73705)