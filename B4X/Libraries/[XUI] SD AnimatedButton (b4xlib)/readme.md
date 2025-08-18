###  [XUI] SD AnimatedButton (b4xlib) by Star-Dust
### 12/29/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/104459/)

**SD\_AnimatedButton  
  
Author:** Star-Dust  
**Version:** 0.03  

- **AnimatedButton**

- **Events:**

- **Click**

- **Fields:**

- **Duration** As Int

- **Functions:**

- **BringToFront**
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetBase**
- **Initialize** (Callback As Object, EventName As String)
- **RequestFocus**
- **SendToBack**
- **Snapshot**

- **Properties:**

- **AnimationFromTop**
- **BorderColor**
- **Color**
- **Enable** As Boolean [write only]
- **Font** As B4XFont [write only]
- **Height** As Int [write only]
- **Left** As Int [write only]
- **Text** As String [write only]
- **Top** As Int [write only]
- **Visible** As Boolean [write only]
- **Width** As Int [write only]

- **ConfirmButton**

- **Events:**

- **Click**
- **LongClick**

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **BringToFront**
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetBase**
- **Initialize** (Callback As Object, EventName As String)
- **RequestFocus**
- **ResetConfirm**
- **SendToBack**
- **Snapshot**

- **Properties:**

- **ButtonConfirmed**
- **Color**
- **Enable** As Boolean [write only]
- **Font** As B4XFont [write only]
- **Height** As Int [write only]
- **Left** As Int [write only]
- **Text** As String [write only]
- **Top** As Int [write only]
- **Visible** As Boolean [write only]
- **Width** As Int [write only]

  
  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
    Private AnimatedButton1 As AnimatedButton  
    Private AnimatedButton2 As AnimatedButton  
    Private AnimatedButton3 As AnimatedButton  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("Layout1")  
  
End Sub  
  
Sub Button1_Click  
    AnimatedButton1.Visible=True  
    AnimatedButton2.Visible=True  
    AnimatedButton3.Visible=True  
End Sub
```

  
  
![](https://www.b4x.com/android/forum/attachments/105135)