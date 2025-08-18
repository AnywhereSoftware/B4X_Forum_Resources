### [B4Xlib] SD: GridImage by Star-Dust
### 11/29/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/124931/)

This library adds a view that displays images loaded from local or from the internet (by entering only the url) and arranges them in a grid.  
The clicked image is displayed in double size. The basic size of each cell can be established  
  
**sd\_gridimage  
  
Author:   
Version:** 0.04  

- **GridImage**

- **Events:**

- **LongClick** (ID As String, Open As Boolean)
- **Select** (ID As String, Open As Boolean)

- **Fields:**

- **KeepAspectRatio** As Boolean
- **mBase** As B4XView
- **MovTime** As Int
Animation duration- **Tag** As Object

- **Functions:**

- **AddImage** (ID As String, bmp As B4XBitmap)
- **AddUrlImage** (ID As String, url As String)
- **Clear**
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetID** (Position As Int) As String
- **GetImageID** (ID As String) As B4XBitmap
*Returns the image associated with the ID*- **GetOpenID** As String
*Returns the ID of the image that is stretched, null if all are closed*- **Initialize** (Callback As Object, EventName As String)
- **Invalidate**

- **Properties:**

- **ImageWidth** As Int
*Height/Width image*- **Size** As Int [read only]
*Number of images*
  
![](https://www.b4x.com/android/forum/attachments/103573)