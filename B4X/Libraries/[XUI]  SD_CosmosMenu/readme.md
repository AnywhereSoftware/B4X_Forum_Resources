### [XUI]  SD_CosmosMenu by Star-Dust
### 05/21/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/140319/)

![](https://www.b4x.com/android/forum/attachments/128806) ![](https://www.b4x.com/android/forum/attachments/129432)  
  
Log  
> **Rel. 1.01**  
> [INDENT]Possibility to choose whether to add a light effect or not[/INDENT]  
> **Rel. 1.02**  
> [INDENT]Possibility to insert the first sphere in the center[/INDENT]  
> **Rel. 1.03**  
> [INDENT]Button animated[/INDENT]

  
**SD\_CosmosMenu  
  
Author:** Star-Dust  
**Version:** 1.03  

- **SD\_CosmosMenu**

- **Events:**

- **Click** (ID As String)
- **LongClick** (ID As String)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **Class\_Globals** As String
- **Clear** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetBase** As B4XView
- **GetItemType** (Id As String) As String
- **Initialize** (Callback As Object, EventName As String) As String
- **Invalidate** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **RemoveItem** (id As String, ForceRefresh As Boolean) As String
- **SetItem** (Id As String, Text As String, TextFont As B4XFont, LightEffect As Boolean, ForceRefresh As Boolean) As String
- **SetItemImage** (Id As String, Image As B4XBitmap, LightEffect As Boolean, ForceRefresh As Boolean) As String
- **Snapshot** As B4XBitmap

- **Properties:**

- **BallDiameter** As Int
- **Height** As Int
- **Left** As Int
- **RotateDegree** As Int
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int