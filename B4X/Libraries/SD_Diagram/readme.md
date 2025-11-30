###  SD_Diagram by Star-Dust
### 11/26/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/169468/)

**SD\_Diagram  
  
Author:** Star-Dust  
**Version:** 1.00  

- **AnimateDiagram**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String)
- **Invalidate**
- **SetBorderSpace** (Xborder As Int, Yborder As Int)
*Imposta margini*- **SetData** (L As List)
*Imposta dati*
- **FlexDiagram**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String)
- **Invalidate**
- **SetBorderSpace** (Xborder As Int, Yborder As Int)
- **SetData** (L As List)

- **Properties:**

- **AnimateLine** As Boolean
- **AnimationDuration** As Int

- **LineDiagram**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String)
- **Invalidate**
- **SetBorderSpace** (Xborder As Int, Yborder As Int)
*<code>LineDiagram.SetBorderSpace(40dip,20dip)</code>*- **SetData** (L As List)
*<code>LineDiagram.SetData(array as double(10.0,100.12,50.15))</code>*
- **Properties:**

- **AnimateLine** As Boolean
- **DelayAnimation** As Int

- **PieDiagram**

- **Functions:**

- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String)
- **Invalidate**
- **SetData** (values As List, optionalColors As List)

- **Properties:**

- **Animate** As Boolean [write only]
- **Duration** As Int [write only]

![](https://www.b4x.com/android/forum/attachments/168602)