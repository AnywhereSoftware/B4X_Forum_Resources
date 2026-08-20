B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.5
@EndOfDesignText@
' UI.bas - Declarative UI factory (zero-ceremony entry point).
'
' Contract 2.0 addition. Every function creates, initializes and returns a
' widget, so host code never writes "Dim x As UIxxx" + "x.Initialize" again.
' It also removes the manual SetParent/SetPosition/SetSize/Render ceremony:
' mount any tree with one UI.Show call.
'
' Canonical patterns (full working app: examples/b4a_ui_quickstart):
'
'   ' One widget, mounted full-screen:
'   UI.Show(Activity, UI.Text("Hola").Size(24))
'
'   ' A tree built with the fluent chain (no Dim/Initialize anywhere):
'   UI.Show(Activity, UI.Column(Null) _
'       .Spacing(12dip) _
'       .AddChild(UI.Text("Titulo").Size(20)) _
'       .AddChild(UI.Button("Guardar").OnClick(Me, "Save_Click")))
'
'   ' A tree built from a List (useful for data-driven screens):
'   UI.Show(Activity, UI.Column(MyWidgetsList))
'
'   ' The full app shell: Scaffold + AppBar + Navigator + BottomNavigation:
'   Dim shell As UIScaffold = UI.Scaffold(Navigator) _
'       .AppBar(UI.AppBar("Mi App")) _
'       .BottomNavigationBar(UI.BottomNavigationBar _
'           .AddItem("home", Chr(0xF015), "Inicio") _
'           .OnSelected(Me, "Nav_Selected"))
'   UI.Show(Activity, shell)
'
' Events keep the normal B4A (Target, EventName) contract. The matching sub
' must exist on the target:
'   UIButton / UIFloatingActionButton / UIIcon : Sub Name
'   UIInput.OnTextChanged                     : Sub Name(NewText As String)
'   UIBottomNavigationBar.OnSelected          : Sub Name(Index As Int, Id As String)
' A missing callback is reported through UI.Errors instead of failing silently.
'
' Alignment strings keep the documented contract values (start/center/end,
' stretch, spaceBetween..., min/max) but every widget has working defaults,
' so they can be omitted.

Sub Process_Globals
	Private mDiagnostics As UIDiagnostics
	Private mChildOwner As Map
	Private mRootWidget As Object
End Sub

' ---------------------------------------------------------------------------
' Diagnostics - one shared collector for the whole app. Containers and
' UIWidgetBridge feed it automatically; inspect it with UI.Errors.
' ---------------------------------------------------------------------------

Public Sub Diagnostics As UIDiagnostics
	If mDiagnostics.IsInitialized = False Then mDiagnostics.Initialize
	Return mDiagnostics
End Sub

Public Sub Errors As List
	Return Diagnostics.GetIssues
End Sub

Public Sub HasErrors As Boolean
	Return Diagnostics.HasIssues
End Sub

Public Sub ClearErrors
	Diagnostics.Clear
End Sub

Public Sub ReportError(Operation As String, Message As String)
	Diagnostics.ReportError(Operation, Message)
End Sub

' ---------------------------------------------------------------------------
' Basic widgets
' ---------------------------------------------------------------------------

Public Sub Text(Value As String) As UILabel
	Dim w As UILabel
	w.Initialize.Text(Value)
	Return w
End Sub

Public Sub Button(Value As String) As UIButton
	Dim w As UIButton
	w.Initialize.Text(Value)
	Return w
End Sub

Public Sub Fab(Value As String) As UIFloatingActionButton
	Dim w As UIFloatingActionButton
	w.Initialize.Text(Value)
	Return w
End Sub

Public Sub Input(HintText As String) As UIInput
	Dim w As UIInput
	w.Initialize.Hint(HintText)
	Return w
End Sub

' UIIcon convenience: Unicode glyph by default; FontAwesome/Material helpers
' are provided so the AI does not have to pick the right Initialize variant.
Public Sub Icon(Glyph As String) As UIIcon
	Dim w As UIIcon
	w.Initialize.Unicode(Glyph)
	Return w
End Sub

Public Sub IconFA(Glyph As String) As UIIcon
	Dim w As UIIcon
	w.Initialize.FontAwesome(Glyph)
	Return w
End Sub

Public Sub IconMaterial(Glyph As String) As UIIcon
	Dim w As UIIcon
	w.Initialize.Material(Glyph)
	Return w
End Sub

Public Sub ImageAsset(Name As String) As UIImage
	Dim w As UIImage
	w.Initialize.Asset(Name)
	Return w
End Sub

Public Sub ImageNetwork(Url As String) As UIImage
	Dim w As UIImage
	w.Initialize.Network(Url)
	Return w
End Sub

Public Sub Progress(Percent As Int) As UIProgressBar
	Dim w As UIProgressBar
	w.Initialize.Value(Percent)
	Return w
End Sub

Public Sub Switch(Label As String) As UISwitch
	Dim w As UISwitch
	w.Initialize.Text(Label)
	Return w
End Sub

Public Sub Checkbox(Label As String) As UICheckbox
	Dim w As UICheckbox
	w.Initialize.Text(Label)
	Return w
End Sub

Public Sub Radio(Label As String) As UIRadioButton
	Dim w As UIRadioButton
	w.Initialize.Text(Label)
	Return w
End Sub

Public Sub Space(Size As Int) As UISpace
	Dim w As UISpace
	w.Initialize.Size(Size)
	Return w
End Sub

Public Sub Divider As UIDivider
	Dim w As UIDivider
	w.Initialize
	Return w
End Sub

' ---------------------------------------------------------------------------
' Containers
' ---------------------------------------------------------------------------

' Children can be: a List of widgets, one widget, or Null for the fluent
' AddChild chain.
' for the fluent AddChild chain.
Public Sub Column(Children As Object) As UIColumn
	Dim w As UIColumn
	w.Initialize
	AddChildren(w, AsList(Children))
	Return w
End Sub

Public Sub Row(Children As Object) As UIRow
	Dim w As UIRow
	w.Initialize
	AddChildren(w, AsList(Children))
	Return w
End Sub

Public Sub Stack(Children As Object) As UIStack
	Dim w As UIStack
	w.Initialize
	AddChildren(w, AsList(Children))
	Return w
End Sub

Public Sub Padding(All As Int, Child As Object) As UIPadding
	Dim w As UIPadding
	w.Initialize.All(All).Child(Child)
	Return w
End Sub

Public Sub Card(Child As Object) As UICard
	Dim w As UICard
	w.Initialize.Child(Child)
	Return w
End Sub

Public Sub Center(Child As Object) As UICenter
	Dim w As UICenter
	w.Initialize.Child(Child)
	Return w
End Sub

Public Sub Expanded(Child As Object) As UIExpanded
	Dim w As UIExpanded
	w.Initialize.Child(Child)
	Return w
End Sub

Public Sub Scroll(Child As Object) As UIScrollView
	Dim w As UIScrollView
	w.Initialize.Child(Child)
	Return w
End Sub

Public Sub Visibility(Child As Object) As UIVisibility
	Dim w As UIVisibility
	w.Initialize.Child(Child)
	Return w
End Sub

' ---------------------------------------------------------------------------
' App structure
' ---------------------------------------------------------------------------

Public Sub Scaffold(Body As Object) As UIScaffold
	Dim w As UIScaffold
	w.Initialize.Body(Body)
	Return w
End Sub

Public Sub AppBar(Title As String) As UIAppBar
	Dim w As UIAppBar
	w.Initialize.Title(Title)
	Return w
End Sub

Public Sub BottomNavigationBar As UIBottomNavigationBar
	Dim w As UIBottomNavigationBar
	w.Initialize
	Return w
End Sub

Public Sub Navigator As UINavigator
	Dim w As UINavigator
	w.Initialize
	Return w
End Sub

Public Sub ListView(Data As List) As UIListView
	Dim w As UIListView
	w.Initialize.Items(Data)
	Return w
End Sub

' ---------------------------------------------------------------------------
' State
' ---------------------------------------------------------------------------

Public Sub State(Value As Object) As UIState
	Dim w As UIState
	w.Initialize(Value)
	Return w
End Sub

Public Sub AsyncState As UIAsyncState
	Dim w As UIAsyncState
	w.Initialize
	Return w
End Sub

' ---------------------------------------------------------------------------
' Theme presets - the AI only needs one line; the 95 token properties remain
' available on the returned UITheme for advanced use.
' ---------------------------------------------------------------------------

' Theme presets. Use UI.Theme(UI.THEME_LIGHT) or UI.Theme(UI.THEME_DARK).
Public Sub Theme(Mode As Int) As UITheme
	If Mode = THEME_DARK Then Return ThemeDark
	Return ThemeDefault
End Sub

' Theme mode constants for UI.Theme(Mode). Light = 0, Dark = 1.
Public Sub THEME_LIGHT As Int
	Return 0
End Sub

Public Sub THEME_DARK As Int
	Return 1
End Sub

' Default light theme.
Public Sub ThemeDefault As UITheme
	Dim t As UITheme
	t.Initialize
	Return t
End Sub

Public Sub ThemeDark As UITheme
	Dim t As UITheme
	t.InitializeDark
	Return t
End Sub

Public Sub ThemeWithScheme(SeedColor As Int) As UITheme
	Dim t As UITheme
	t.Initialize
	t.InitializeWithScheme(SeedColor)
	Return t
End Sub

Public Sub ThemeWithSchemeAndMode(SeedColor As Int, Dark As Boolean) As UITheme
	Dim t As UITheme
	t.Initialize
	t.InitializeWithSchemeAndMode(SeedColor, Dark)
	Return t
End Sub

' ---------------------------------------------------------------------------
' Overlays and effects
' ---------------------------------------------------------------------------

Public Sub Snack(MessageText As String) As UISnackBar
	Dim w As UISnackBar
	w.Initialize.Message(MessageText)
	Return w
End Sub

Public Sub Dialog As UIAlertDialog
	Dim w As UIAlertDialog
	w.Initialize
	Return w
End Sub

Public Sub Animation(Target As B4XView) As UIAnimation
	Dim w As UIAnimation
	w.Initialize.TargetView(Target)
	Return w
End Sub

Public Sub Native(View As B4XView, NaturalWidth As Int, NaturalHeight As Int) As UINative
	Dim w As UINative
	w.Initialize(View, NaturalWidth, NaturalHeight)
	Return w
End Sub

' ---------------------------------------------------------------------------
' Mounting - replaces the manual SetParent/SetPosition/SetSize/Render dance.
' ---------------------------------------------------------------------------

' Mounts a widget at the full Root bounds and renders it. Use this for the
' root of an Activity (Activity is a B4XView).
Public Sub Show(Root As B4XView, Widget As Object)
	mRootWidget = Widget
	Mount(Widget, Root, 0, 0, Root.Width, Root.Height)
End Sub

' Alias of Show for the one-expression tree model.
Public Sub Render(Root As B4XView, Widget As Object)
	Show(Root, Widget)
End Sub

' Mounts a widget at explicit bounds and renders it.
Public Sub Mount(Widget As Object, Root As B4XView, Left As Int, Top As Int, Width As Int, Height As Int)
	If Widget = Null Then Return
	Dim bridge As UIWidgetBridge
	bridge.Initialize
	bridge.SetParent(Widget, Root)
	bridge.SetPosition(Widget, Left, Top)
	bridge.SetSize(Widget, Width, Height)
	bridge.Render(Widget)
End Sub

' Re-renders a mounted widget (e.g. after a structural change).
Public Sub Refresh(Widget As Object)
	If Widget = Null Then Return
	Dim bridge As UIWidgetBridge
	bridge.Initialize
	bridge.Render(Widget)
End Sub

' Re-layouts the mounted tree after a widget's content changed (e.g. bound text).
' Prefers re-rendering the UI.Show root so every ancestor re-measures; falls back
' to re-rendering the highest registered owner container.
Public Sub Invalidate(ChangedWidget As Object)
	If mRootWidget <> Null Then
		CallSub(mRootWidget, "Render")
		Return
	End If
	Dim owner As Object = ChildOwner(ChangedWidget)
	Dim topOwner As Object = owner
	Dim current As Object = owner
	Do While current <> Null
		topOwner = current
		current = ChildOwner(current)
	Loop
	If topOwner <> Null Then CallSub(topOwner, "Render")
End Sub

' Permanently releases a mounted widget tree.
Public Sub Unmount(Widget As Object)
	If Widget = Null Then Return
	If mRootWidget = Widget Then mRootWidget = Null
	Dim bridge As UIWidgetBridge
	bridge.Initialize
	bridge.Unmount(Widget)
End Sub


' ---------------------------------------------------------------------------
' Child-owner registry - powers the self-explanatory AddChild diagnostics.
' ---------------------------------------------------------------------------

' Returns the container that currently owns Child, or Null.
Public Sub ChildOwner(Child As Object) As Object
	If mChildOwner = Null Then Return Null
	If mChildOwner.IsInitialized = False Then Return Null
	If Child = Null Then Return Null
	If mChildOwner.ContainsKey(Child) = False Then Return Null
	Return mChildOwner.Get(Child)
End Sub

' Registers Child as owned by Owner. Returns False (and reports the reason)
' when the child already belongs to a different container.
Public Sub RegisterChild(Child As Object, Owner As Object) As Boolean
	If mChildOwner = Null Then
		mChildOwner.Initialize
	End If
	If mChildOwner.IsInitialized = False Then
		mChildOwner.Initialize
	End If
	If Child = Null Then Return False
	If mChildOwner.ContainsKey(Child) Then
		Dim existing As Object = mChildOwner.Get(Child)
		If existing = Owner Then
			Report("AddChild", "the widget was already added to this container")
			Return False
		End If
		Report("AddChild", "the widget already belongs to another container (" & GetType(existing) & "); call UI.Unmount or remove it first")
		Return False
	End If
	mChildOwner.Put(Child, Owner)
	Return True
End Sub

' Removes the ownership entry for Child (called by containers on Unmount).
Public Sub UnregisterChild(Child As Object)
	If mChildOwner = Null Then Return
	If mChildOwner.IsInitialized = False Then Return
	If Child = Null Then Return
	If mChildOwner.ContainsKey(Child) Then mChildOwner.Remove(Child)
End Sub

' Private helper: reports through the shared collector, initializing it if needed.
Private Sub Report(Operation As String, Message As String)
	If mDiagnostics.IsInitialized = False Then mDiagnostics.Initialize
	mDiagnostics.ReportError(Operation, Message)
End Sub


' ---------------------------------------------------------------------------
' Internal helpers
' ---------------------------------------------------------------------------

Private Sub AddChildren(Container As Object, Children As List)
	If Container = Null Then Return
	If Children = Null Then Return
	If Children.IsInitialized = False Then Return
	For Each child As Object In Children
		If child <> Null Then CallSub2(Container, "AddChild", child)
	Next
End Sub

' Accepts Null (empty), a List, a B4A Array(...) of any element type, or a
' single widget. Arrays are read through java.lang.reflect.Array so mixed
' Array(widget1, widget2, ...) literals work without knowing the element type.

' Accepts Null (empty), a List of widgets, or a single widget. The fluent
' AddChild chain is the canonical way to build a tree in one expression.
Private Sub AsList(Value As Object) As List
	Dim result As List
	result.Initialize
	If Value = Null Then Return result
	If Value Is List Then
		Dim items As List = Value
		For Each item As Object In items
			result.Add(item)
		Next
		Return result
	End If
	result.Add(Value)
	Return result
End Sub
