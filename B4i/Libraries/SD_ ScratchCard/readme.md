### SD: ScratchCard by Star-Dust
### 01/14/2025
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/100227/)

I created a new view / panel that simulates the effect of scratch cards.  
Create a panel from code that design and you can hook other views that will be visible after the user has passed the finger on the surface.  
  
It has all the properties of a panel and also returns the native panel.  
  
**iSD\_Scratchcard  
  
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

- **AddToParent** (Parent As B4IPanelWrapper\*, Left As Int, Top As Int, Width As Int, Height As Int) As NSString\*
- **AddView** (View As B4IViewWrapper\*, Left As Int, Top As Int, Width As Int, Height As Int) As NSString\*
- **BringToFront** As NSString\*
- **CalcRelativeKeyboardHeight** (KeyboardHeight As Double) As Double
- **Class\_Globals** As NSString\*
- **Clear** As NSString\*
- **DesignerCreateView** (Base As B4IPanelWrapper\*, Lbl As B4ILabelWrapper\*, Props As B4IMap\*) As NSString\*
- **FillingPercentage** As Double
*Value -> 0.0 to 100.0*- **GetView** (Index As Int) As B4IViewWrapper\*
- **Initialize** (ba As B4I\*, Callback As NSObject\*, EventName As NSString\*) As NSString\*
- **IsInitialized** As BOOL
*Verifica se l'oggetto sia stato inizializzato.*- **LoadLayout** (layoutFile As NSString\*) As NSString\*
- **Panel** As B4IPanelWrapper\*
- **RemoveAllViews** As NSString\*
- **RemoveViewFromParent** As NSString\*
- **RemoViewAt** (Index As Int) As NSString\*
- **RequestFocus** As NSString\*
- **ResignFocus** As BOOL
- **Scartch** (Enabled As BOOL) As NSString\*
 *Default is Enabled*- **SendToBack** As NSString\*
- **SetLayoutAnimated** (Duration As Int, Left As Int, Top As Int, Width As Int, Height As Int) As NSString\*
- **SetParallaxEffect** (Vertical As Int, Horizzontal As Int) As NSString\*
- **SetShadow** (Color As Int, OffsetX As Float, OffsetY As Float, Opacity As Float, StaticRect As BOOL) As NSString\*
- **SizeToFit** As NSString\*

- **Properties:**

- **Alfa** As Float
- **Color** As Int
- **Height** As Int
- **IsFocused** As BOOL [read only]
- **Left** As Int
- **Parent** As B4IPanelWrapper\* [read only]
- **Tag** As NSObject\*
- **TintColor** As Int [read only]
- **TintiColor**
- **Top** As Int
- **Visible** As BOOL
- **Width** As Int

  
  
![](https://www.b4x.com/android/forum/attachments/75162)  

```B4X
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'Public variables can be accessed from all modules.  
    Public App As Application  
    Public NavControl As NavigationController  
    Private Page1 As Page  
  
    Private PanelScratchCard1 As PanelScratchCard  
End Sub  
  
Private Sub Application_Start (Nav As NavigationController)  
    'SetDebugAutoFlushLogs(True) 'Uncomment if program crashes before all logs are printed.  
    NavControl = Nav  
    Page1.Initialize("Page1")  
    Page1.Title = "Page 1"  
    Page1.RootPanel.Color = Colors.White  
    NavControl.ShowPage(Page1)  
   
    Page1.RootPanel.LoadLayout("Layout1")  
    PanelScratchCard1.LoadLayout("Layout2")  
End Sub  
  
Sub PA_Touch (Action As Int, Coordinate As String)  
    Dim C() As String = Regex.Split("|",Coordinate)  
    Dim X As Int = C(0)  
    Dim Y As Int = C(1)  
End Sub
```

  
  

---

  

- **Release 0.02** - Added Clear mathod
- **Release 0.03** - Added FillingPercentage method