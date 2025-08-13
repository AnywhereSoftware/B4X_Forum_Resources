### SD: ScratchCard by Star-Dust
### 01/06/2025
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/100221/)

I created a new view / panel that simulates the effect of scratch cards.  
Create a panel from code that design and you can hook other views that will be visible after the user has passed the finger on the surface.  
  
It has all the properties of a panel and also returns the native panel.  
  
**SD\_Scratchcard  
  
Author:** Star-Dust  
**Version:** 0.03  

- **PanelScratchCard**

- **Events:**

- **Click**
- **LongClick**
- **Touch** (Action As Int, Coordinate As String)

- **Fields:**

- **ACTION\_DOWN** As Int
- **ACTION\_MOVE** As Int
- **ACTION\_UP** As Int
- **thickness** As Int

- **Functions:**

- **AddToParent** (Parent As Panel, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **AddView** (View As View, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **BringToFront** As String
- **Class\_Globals** As String
- **Clear** As String
- **DesignerCreateView** (Base As Panel, Lbl As Label, Props As Map) As String
- **FillingPercentage** As Double
*Value -> 0.0 to 100.0*- **Initialize** (Callback As Object, EventName As String) As String
- **Invalidate** As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **LoadLayout** (layoutFile As String) As String
- **Panel** As Panel
- **RemoveAllViews** As String
- **RemoveView** As String
- **RemoviewAt** (Index As Int) As String
- **RequestFocus** As String
- **SendToBack** As String
- **SetBackgroundImage** (Bitmap As Bitmap) As String
- **SetColorAnimated** (Duration As Int, FromColor As Int, ToColor As Int) As String
- **SetLayout** (Left As Int, Top As Int, Width As Int, Height As Int) As String
- **SetLayoutAnimated** (Duration As Int, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **Scratch** (Enabled As Boolean)
Default is Enabled
- **Properties:**

- **Color**
- **Elevation** As Float
- **enabled** As Boolean
- **Height** As Int
- **Left** As Int
- **Parent** As Panel [read only]
- **Tag** As Object
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

![](https://www.b4x.com/android/forum/attachments/75153)  
  
—————————-  
**Rel. 0.02** - Added Clear method  
**Rel. 0.03** - Added FillingPercentage method  
————————–  
  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
    Dim PA As PanelScratchCard  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("Layout1")  
    PA.Initialize(Me,"Pa")  
    PA.AddToParent(Activity,0,0,100%x,100%y)  
    PA.LoadLayout("Layout2")  
    PA.SetBackgroundImage(LoadBitmap(File.DirAssets,"b4a_bubble.png"))  
End Sub  
  
Private Sub ButtonVerify_Click  
    Log(PA.FillingPercentage)  
End Sub
```