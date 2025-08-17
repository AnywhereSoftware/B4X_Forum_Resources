###  [XUI] SD XUIView by Star-Dust
### 12/21/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/96178/)

**I'm happy to announce the publication of my new B4XView library.**  
This library adds to the XUi Views the **native views** of the three platforms (Android / IOS / Desktop) so that they can be managed by Design, using them as XUI views without having to change its type in the Globals Sub.  
With this Library the views have the same properties and identical events, and you can also access the original view and more properties, method and animation *not included natively*.  
*This will allow you to reuse the code written for a platform on the others without any changes.*  
Also I'm adding **custom views** and animations *not included natively*.  
  
**[SIZE=4]Included this view[/SIZE]**  
[INDENT]*![](https://www.b4x.com/android/forum/attachments/videoa-gif.71130/)*[/INDENT]  
[INDENT][/INDENT]  
[INDENT]**Other views not included in this list (such as **[XCustomListView](https://www.b4x.com/android/forum/threads/b4x-xui-xcustomlistview-cross-platform-customlistview.84501/#content)** or **[XComboBox](https://www.b4x.com/android/forum/threads/b4x-xui-xcombobox-cross-platform-combobox-with-images.91737/#post-607490), [B4XComboBox](https://www.b4x.com/android/forum/threads/b4x-xui-b4xcombobox-cross-platform-combobox-spinner.89695/#content), [LoadingIndicator](https://www.b4x.com/android/forum/threads/b4x-xui-b4xloadingindicator-loading-indicator.92243/#post-592223), [CicularProgressBar](https://www.b4x.com/android/forum/threads/b4x-xui-custom-view-circularprogressbar.81604/#content), [RadarProgressView](https://www.b4x.com/android/forum/threads/b4x-xui-sd-radarprogressview-with-source-code.93584/#content), [GaugeView](https://www.b4x.com/android/forum/threads/b4x-xui-gauge-view.87435/#content), [RulerPicker](https://www.b4x.com/android/forum/threads/b4x-xui-b4xrulerpicker.92453/#content), [RoundSlider](https://www.b4x.com/android/forum/threads/b4x-xui-roundslider.95465/#content), [CaptchaView](https://www.b4x.com/android/forum/threads/b4x-xui-captcha-view.90601/#content),** etc.. ) will not be included in the future because they already exist. Many sources have been made available just search the forum.**[/INDENT]  
[INDENT][/INDENT]  
**NOTICE**. Unfortunately in the IOS version it occupies more than 500Kb, so I compressed with RAR and then with ZIP. to decompress it, you must use WinRar  
  
**SD\_XUIView  
  
Author:** Star-Dust  
**Version:** 0.16  

- **B4XButton**

- **Events:**

- **DoubleOrLongClick**
- **OneClick**
- **Touch** (Action As Int, Coordinate() As Tp\_Coordinate)

- **Fields:**

- **Action\_Click** As Int
- **Action\_DoubleClick** As Int
- **Action\_Down** As Int
- **Action\_Drag** As Int
- **Action\_LongClick** As Int
- **Action\_LoseTouch** As Int
- **Action\_Up** As Int
- **MinMoveAccept** As Int
- **Tag** As Object

- **Functions:**

- **AddToParent** (PanelToAdd As B4XView, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **B4XObject** As B4XView
- **BringToFront** As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetAllViewsRecursive** As List
- **GetBase** As Panel
- **GetView** (Index As Int) As B4XView
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **NativeObject** As Button
- **RemoveAllViews** As String
- **RemoveViewFromParent** As String
- **RequestFocus** As String
- **ReSetEvent** (Callback As Object, EventName As String) As String
- **Rotate** (AngleX As Float, AngleY As Float, AngleZ As Float) As String
- **SendToBack** As String
- **Snapshot** As B4XView

- **Properties:**

- **Color** As Int
- **Enable** As Boolean
- **Font**
- **Height** As Int
- **Left** As Int
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

- **B4XCalendarPicker**

- **Events:**

- **Click**

- **Fields:**

- **Color** As Int
- **Square** As Boolean
- **Tag** As Object
- **TextColor** As Int
- **TextSize** As Int
- **Title** As String

- **Functions:**

- **BringToFront** As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetAllViewsRecursive** As List
- **GetBase** As Panel
- **GetView** (Index As Int) As B4XView
- **Initialize** (CallBack As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **RemoveViewFromParent** As String
- **RequestFocus** As String
- **ReSetEvent** (Callback As Object, EventName As String) As String
- **Rotate** (AngleX As Float, AngleY As Float, AngleZ As Float) As String
- **SendToBack** As String
- **Snapshot** As B4XView

- **Properties:**

- **Date** As Long
- **Enable** As Boolean
- **Height** As Int
- **Left** As Int
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

- **B4XCheckBox**

- **Events:**

- **Click**

- **Fields:**

- **Action\_Click** As Int
- **Action\_DoubleClick** As Int
- **Action\_Down** As Int
- **Action\_Drag** As Int
- **Action\_LongClick** As Int
- **Action\_LoseTouch** As Int
- **Action\_Up** As Int
- **MinMoveAccept** As Int

- **Functions:**

- **AddToParent** (PanelToAdd As B4XView, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **BringToFront** As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetAllViewsRecursive** As List
- **GetBase** As Panel
- **GetView** (Index As Int) As B4XView
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **RemoveAllViews** As String
- **RemoveViewFromParent** As String
- **RequestFocus** As String
- **ReSetEvent** (Callback As Object, EventName As String) As String
- **Rotate** (AngleX As Float, AngleY As Float, AngleZ As Float) As String
- **SendToBack** As String
- **Snapshot** As B4XView

- **Properties:**

- **Check** As Boolean
- **Color** As Int
- **Enable** As Boolean
- **Font**
- **Height** As Int
- **Left** As Int
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

- **B4XEditText**

- **Events:**

- **DoubleOrLongClick**
- **EnterPressed**
- **FocusChanged**
- **OneClick**
- **TextChanged** (Old As String, New As String)

- **Fields:**

- **Action\_Click** As Int
- **Action\_DoubleClick** As Int
- **Action\_Down** As Int
- **Action\_Drag** As Int
- **Action\_LongClick** As Int
- **Action\_LoseTouch** As Int
- **Action\_Up** As Int
- **Tag** As Object

- **Functions:**

- **AddToParent** (PanelToAdd As B4XView, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **B4XObject** As B4XView
- **BringToFront** As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetAllViewsRecursive** As List
- **GetBase** As Panel
- **GetView** (Index As Int) As B4XView
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **NativeObjct** As EditText
- **RemoveAllViews** As String
- **RemoveViewFromParent** As String
- **RequestFocus** As String
- **ReSetEvent** (Callback As Object, EventName As String) As String
- **Rotate** (AngleX As Float, AngleY As Float, AngleZ As Float) As String
- **SendToBack** As String
- **setSelection** (StartIndex As Int, EndIndex As Int) As String
- **Snapshot** As B4XView

- **Properties:**

- **Color** As Int
- **CursorVisible**
- **Ellipsize** As String
- **Enable** As Boolean
- **Font**
- **ForceDoneButton**
- **Height** As Int
- **Left** As Int
- **SelectionEnd** As Int [read only]
- **SelectionStart** As Int [read only]
- **TextIsEditable**
- **TextIsSelectable**
- **Top** As Int
- **Typeface**
- **Visible** As Boolean
- **Width** As Int

- **B4XLabel**

- **Events:**

- **DoubleOrLongClick**
- **OneClick**
- **Touch** (Action As Int, Coordinate() As Tp\_Coordinate)

- **Fields:**

- **Action\_Click** As Int
- **Action\_DoubleClick** As Int
- **Action\_Down** As Int
- **Action\_Drag** As Int
- **Action\_LongClick** As Int
- **Action\_LoseTouch** As Int
- **Action\_Up** As Int
- **MinMoveAccept** As Int
- **Tag** As Object

- **Functions:**

- **AddToParent** (PanelToAdd As B4XView, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **B4XObject** As B4XView
- **BringToFront** As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetAllViewsRecursive** As List
- **GetBase** As Panel
- **GetView** (Index As Int) As B4XView
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **NativeObject** As Label
- **RemoveViewFromParent** As String
- **RequestFocus** As String
- **ReSetEvent** (Callback As Object, EventName As String) As String
- **Rotate** (AngleX As Float, AngleY As Float, AngleZ As Float) As String
- **SendToBack** As String
- **Snapshot** As B4XView

- **Properties:**

- **Color** As Int
- **Enable** As Boolean
- **Font**
- **Height** As Int
- **Left** As Int
- **TextAppear**
- **TextFind**
- **TextRoll**
- **TextScroll**
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

- **B4XPanel**

- **Events:**

- **DoubleOrLongClick**
- **Moved**
- **OneClick**
- **Resized**
- **Touch** (Action As Int, Coordinate() As Tp\_Coordinate)

- **Fields:**

- **Action\_Click** As Int
- **Action\_DoubleClick** As Int
- **Action\_Down** As Int
- **Action\_Drag** As Int
- **Action\_LongClick** As Int
- **Action\_LoseTouch** As Int
- **Action\_Up** As Int
- **AllSurfaceMove** As Boolean
- **MinMoveAccept** As Int
- **Movible** As Boolean
- **Resizable** As Boolean
- **Tag** As Object

- **Functions:**

- **AddToParent** (PanelToAdd As B4XView, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **AddView** (View As B4XView, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **B4XObject** As B4XView
- **BringToFront** As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **EmbedView** (View As B4XView) As String
- **GetAllViewsRecursive** As List
- **GetBase** As Panel
- **GetView** (Index As Int) As B4XView
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **NativeObject** As Panel
- **RemoveAllViews** As String
- **RemoveViewFromParent** As String
- **RequestFocus** As String
- **ReSetEvent** (Callback As Object, EventName As String) As String
- **Rotate** (AngleX As Float, AngleY As Float, AngleZ As Float) As String
- **SendToBack** As String
- **Snapshot** As B4XView

- **Properties:**

- **Enable** As Boolean
- **Height** As Int
- **Left** As Int
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

- **B4XProgressBar**

- **Fields:**

- **Tag** As Object

- **Functions:**

- **AddToParent** (PanelToAdd As B4XView, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **BringToFront** As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetBase** As Panel
- **GetView** (Index As Int) As B4XView
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **RemoveViewFromParent** As String
- **RequestFocus** As String
- **ReSetEvent** (Callback As Object, EventName As String) As String
- **Rotate** (AngleX As Float, AngleY As Float, AngleZ As Float) As String
- **SendToBack** As String
- **Snapshot** As B4XView

- **Properties:**

- **BackgroundColor**
- **BarColor**
- **Enable** As Boolean
- **Height** As Int
- **Left** As Int
- **Top** As Int
- **Value** As Float
- **Visible** As Boolean
- **Width** As Int

- **B4XSeek\_Bar**

- **Events:**

- **ChangeValue** (Value As Float)

- **Fields:**

- **Tag** As Object

- **Functions:**

- **AddToParent** (PanelToAdd As B4XView, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **BringToFront** As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetBase** As Panel
- **GetView** (Index As Int) As B4XView
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **RemoveViewFromParent** As String
- **RequestFocus** As String
- **ReSetEvent** (Callback As Object, EventName As String) As String
- **Rotate** (AngleX As Float, AngleY As Float, AngleZ As Float) As String
- **SendToBack** As String
- **Snapshot** As B4XView

- **Properties:**

- **Enable** As Boolean
- **Height** As Int
- **Left** As Int
- **Top** As Int
- **Value** As Float
- **Visible** As Boolean
- **Width** As Int

- **Tp\_Coordinate**

- **Fields:**

- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **x** As Int
- **y** As Int

- **Functions:**

- **Initialize**
*Inizializza i campi al loro valore predefinito.*
- **xRadioButton**

- **Events:**

- **Click**

- **Fields:**

- **Action\_Click** As Int
- **Action\_DoubleClick** As Int
- **Action\_Down** As Int
- **Action\_Drag** As Int
- **Action\_LongClick** As Int
- **Action\_LoseTouch** As Int
- **Action\_Up** As Int
- **MinMoveAccept** As Int
- **Tag** As Object

- **Functions:**

- **AddToParent** (PanelToAdd As B4XView, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **BringToFront** As String
- **Class\_Globals** As String
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map) As String
*Base type must be Object*- **GetAllViewsRecursive** As List
- **GetBase** As Panel
- **GetView** (Index As Int) As B4XView
- **Initialize** (Callback As Object, EventName As String) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **RemoveAllViews** As String
- **RemoveViewFromParent** As String
- **RequestFocus** As String
- **ReSetEvent** (Callback As Object, EventName As String) As String
- **Rotate** (AngleX As Float, AngleY As Float, AngleZ As Float) As String
- **SendToBack** As String
- **Snapshot** As B4XView

- **Properties:**

- **Check** As Boolean
- **Color** As Int
- **Enable** As Boolean
- **Font**
- **Height** As Int
- **Left** As Int
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

  
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  
  
For ios download [**here**](https://www.dropbox.com/s/i6om6jh1hu41yky/iSD_XUIView.zip?dl=0)