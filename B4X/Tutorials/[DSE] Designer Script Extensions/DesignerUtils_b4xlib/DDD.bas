B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Private cvs As B4XCanvas
	Private cvsCreated As Boolean
	Private textSizesSteps() As Float = Array As Float(1, 0.8)
	Public TextWidthGap As Int = 30dip
	Private LayoutsMap As Map 'LayoutParent -> DDDInternalViewsData
	Private ViewsData As Map 'View -> DDDViewData
	Type DDDInternalViewsData (NamesMap As Map, ClassesMap As Map)
	Type DDDViewData (Name As String, Classes As List, LayoutParent As B4XView)
	Public ToolbarPressedColor As Int = 0x6600A3FF
	#if B4A
	Private Stub As Button 'ignored
	#End If
	Private ColorMap As Map
End Sub

Public Sub Initialize
	LayoutsMap.Initialize
	ViewsData.Initialize
	ColorMap = CreateMap("black": xui.Color_Black, _
		"darkgray": xui.Color_DarkGray, _
		"gray": xui.Color_Gray, _
		"lightgray": xui.Color_LightGray, _
		"white": xui.Color_White, _
		"red": xui.Color_Red, _
		"green": xui.Color_Green, _
		"blue": xui.Color_Blue, _
		"yellow": xui.Color_Yellow, _
		"cyan": xui.Color_Cyan, _
		"magenta": xui.Color_Magenta, _
		"transparent": xui.Color_Transparent)
End Sub

Private Sub CreateCVSIfNeeded
	If cvsCreated Then Return
	cvsCreated = True
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 2dip, 2dip)
	cvs.Initialize(p)
End Sub

'Adds a color to the colors mapping.
Public Sub AddColor(Name As String, Value As Int)
	ColorMap.Put(Name.ToLowerCase, Value)
End Sub

'Gets a color from the colors mapping.
Public Sub GetColor(Name As String) As Int
	Return ColorMap.GetDefault(Name.ToLowerCase, xui.Color_Black)
End Sub

'Converts a string hex or name color to an int color.
Private Sub Color(DesignerArgs As DesignerArgs) As String
	Dim Name As String = DesignerArgs.Arguments.Get(0).As(String).ToLowerCase
	If Name.StartsWith("0x") Then
		Return GetIntFromString(Name)
	End If
	Return GetColor(Name)
End Sub

'The panel should include a single label. The label text properties will be used and the label will be removed.
'Parameters: Panel, EventName, [label, tag]+
Private Sub CreateToolbar (DesignerArgs As DesignerArgs)
	Dim pnl As B4XView = DesignerArgs.GetViewFromArgs(0)
	If DesignerArgs.FirstRun Then
		Dim StubLabel As B4XView = pnl.GetView(0)
		StubLabel.RemoveViewFromParent
		Dim EventName As String = DesignerArgs.Arguments.Get(1)
		Dim fnt As B4XFont = StubLabel.Font
		For i = 2 To DesignerArgs.Arguments.Size - 1 Step 2
			Dim text As String = DesignerArgs.Arguments.Get(i)
			Dim tag As String = DesignerArgs.Arguments.Get(i + 1)
			Dim lbl As B4XView = CreateLabel
			lbl.Font = fnt
			lbl.Text = text
			lbl.TextColor = StubLabel.TextColor
			lbl.SetTextAlignment("CENTER", "CENTER")
			lbl.Tag = Array(DesignerArgs.LayoutModule, EventName, tag)
			pnl.AddView(lbl, 0, 0, 40dip, pnl.Height)
		Next
	Else
		For i = 0 To pnl.NumberOfViews - 1
			pnl.GetView(i).Height = pnl.Height
		Next
	End If
End Sub

Private Sub CreateLabel As B4XView
	Dim lbl As Label
	lbl.Initialize("lbl")
	Return lbl
End Sub

#if B4J
Private Sub lbl_MouseClicked (EventData As MouseEvent)
	RaiseToolbarEvent(Sender, Sender.As(B4XView).Tag)
	EventData.Consume
End Sub
#else
Private Sub lbl_Click
	RaiseToolbarEvent(Sender, Sender.As(B4XView).Tag)
End Sub
#End If

Private Sub RaiseToolbarEvent (lbl As B4XView, Data() As Object)
	CallSubDelayed2(Data(0), Data(1) & "_click", Data(2))
	If ToolbarPressedColor <> 0 Then
		lbl.SetColorAnimated(100, xui.Color_Transparent, ToolbarPressedColor)
		Sleep(100)
		lbl.SetColorAnimated(100, ToolbarPressedColor, xui.Color_Transparent)
	End If
End Sub

'Same as B4X Chr keyword. Expects a single codepoint parameter.
Private Sub ToChr(DesignerArgs As DesignerArgs) As String
	Return "" & Chr(GetIntFromString(DesignerArgs.Arguments.Get(0)))
End Sub

Private Sub GetIntFromString (n As String) As Int
	If n.StartsWith("0x") Then
		Return Bit.ParseLong(n.SubString(2), 16)
	End If
	Return n
End Sub

'Returns true if the layout is being created now. Always true in B4A.
Private Sub IsFirstRun(DesignerArgs As DesignerArgs) As Boolean
	Return DesignerArgs.FirstRun
End Sub


'Collects data about the loaded views. The views can be retrieved at runtime with GetViewByName method.
Private Sub CollectViewsData(DesignerArgs As DesignerArgs)
	Dim Data As DDDInternalViewsData = GetViewsData(DesignerArgs.Parent, True)
	For Each s As String In DesignerArgs.ViewsNames
		Dim v As B4XView = DesignerArgs.GetViewByName(s)
		SetViewNameAndParent(Data, v, s, DesignerArgs.Parent)
	Next
End Sub

Private Sub SetViewNameAndParent(Data As DDDInternalViewsData, View As B4XView, Name As String, LayoutParent As B4XView)
	Data.NamesMap.Put(Name, View)
	Dim vd As DDDViewData = GetViewDataImpl(View, True)
	vd.Name = Name
	vd.LayoutParent = LayoutParent
End Sub

'Adds the data for a view added at runtime.
Public Sub AddRuntimeView(View As B4XView, Name As String, LayoutParent As B4XView, Classes As List)
	Dim Data As DDDInternalViewsData = GetViewsData(LayoutParent, True)
	SetViewNameAndParent(Data, View, Name, LayoutParent)
	If Classes.IsInitialized Then
		For Each cls As String In Classes
			AddClassImpl(cls, Data, View)
		Next
	End If
End Sub

'Removes the data that was stored for this layout.
'This is relevant if you previously called AddClass or CollectViewsData.
Public Sub RemoveLayoutData(LayoutParent As B4XView)
	Dim Data As DDDInternalViewsData = GetViewsData(LayoutParent, False)
	If Data = Null Then Return
	For Each v As B4XView In Data.NamesMap.Values
		ViewsData.Remove(v)
	Next
	LayoutsMap.Remove(LayoutParent)
End Sub



'Adds a class attribute to one or more views.
'Parameters: ClassName, One or more views.
Private Sub AddClass(DesignerArgs As DesignerArgs)
	Dim cls As String = DesignerArgs.Arguments.Get(0).As(String).ToLowerCase
	Dim Data As DDDInternalViewsData = GetViewsData(DesignerArgs.Parent, True)
	For i = 1 To DesignerArgs.Arguments.Size - 1
		Dim View As B4XView = DesignerArgs.GetViewFromArgs(i)
		AddClassImpl(cls, Data, View)
	Next
End Sub

Private Sub AddClassImpl(cls As String, Data As DDDInternalViewsData, view As B4XView)
	Dim lst As List = Data.ClassesMap.Get(cls)
	If lst.IsInitialized = False Then
		lst.Initialize
		Data.ClassesMap.Put(cls, lst)
	End If
	lst.Add(view)
	Dim vd As DDDViewData = GetViewDataImpl(view, True)
	vd.Classes.Add(cls)
End Sub

'Get all views with the given class attribute. The attribute is added in the designer script with DDD.AddClass.
Public Sub GetViewsByClass(Class As String) As List
	Class = Class.ToLowerCase
	Dim res As List
	res.Initialize
	For Each data As DDDInternalViewsData In LayoutsMap.Values
		If data.ClassesMap.ContainsKey(Class) Then
			res.AddAll(data.ClassesMap.Get(Class))
		End If
	Next
	Return res
End Sub

'Returns a list with all layout parents (views).
Public Sub GetAllLayoutParents As List
	Dim res As List
	res.Initialize
	For Each v As B4XView In LayoutsMap.Keys
		res.Add(v)
	Next
	Return res
End Sub

'Returns the view's data or Null if not exists. Make sure to call CollectViewsData in the designer script.
Public Sub GetViewData (View As B4XView) As DDDViewData
	Return GetViewDataImpl(View, False)
End Sub



Private Sub GetViewDataImpl(View As B4XView, CreateIfNeeded As Boolean) As DDDViewData
	Dim vd As DDDViewData = ViewsData.Get(View)
	If vd = Null And CreateIfNeeded Then
		Dim vd As DDDViewData
		vd.Initialize
		vd.Classes.Initialize
		ViewsData.Put(View, vd)
	End If
	Return vd
End Sub

Private Sub GetViewsData(parent As B4XView, createIfNeeded As Boolean) As DDDInternalViewsData
	Dim data As DDDInternalViewsData = LayoutsMap.Get(parent)
	If data = Null And createIfNeeded Then
		Dim data As DDDInternalViewsData
		data.Initialize
		data.NamesMap.Initialize
		data.ClassesMap.Initialize
		LayoutsMap.Put(parent, data)
	End If
	Return data
End Sub

'Gets a view by its name. Make sure to call DDD.CollectViewsData in the designer script.
Public Sub GetViewByName(LayoutParent As B4XView, Name As String) As B4XView
	Dim res As B4XView
	Name = Name.ToLowerCase
	Dim data As DDDInternalViewsData = GetViewsData(LayoutParent, False)
	If data <> Null Then
		res = data.NamesMap.Get(Name)
	End If
	Return res
End Sub

'Sets the text size steps that will be used when setting the text with SetTextAndSize. Default value is 1, 0.8.
Private Sub SetTextSizeSteps(DesignerArgs As DesignerArgs)
	If textSizesSteps.Length <> DesignerArgs.Arguments.Size Then
		Dim textSizesSteps(DesignerArgs.Arguments.Size) As Float
	End If
	For i = 0 To textSizesSteps.Length - 1
		textSizesSteps(i) = DesignerArgs.Arguments.Get(i)
	Next
End Sub

'Spreads the controls evenly.
'Parameters: Panel, Maximum size of each control (0 for no maximum), Minimum gap between controls.
Private Sub SpreadControlsHorizontally (DesignerArgs As DesignerArgs)
	Dim Panel As B4XView = DesignerArgs.GetViewFromArgs(0)
	If Panel.IsInitialized = False Then Return
	Dim MaxSize As Int = DesignerArgs.Arguments.Get(1)
	If MaxSize = 0 Then MaxSize = 0x7fffffff
	Dim MinGap As Int = DesignerArgs.Arguments.Get(2)
	Dim AllWidth As Int = Panel.Width
	Dim w As Int = Min(AllWidth / Panel.NumberOfViews - MinGap, MaxSize)
	Dim gap As Int = (AllWidth - Panel.NumberOfViews * w) / Panel.NumberOfViews
	For i = 0 To Panel.NumberOfViews - 1
		Dim v As B4XView = Panel.GetView(i)
		v.SetLayoutAnimated(0, (i + 0.5) * gap + i * w, v.Top, w, v.Height)
	Next
End Sub

'Sets the first text that fits.
'Parameters: View, One or more strings.
'Example: SetText("Wednesday", "Wed", "W")
Private Sub SetText(DesignerArgs As DesignerArgs)
	Dim v As B4XView = DesignerArgs.GetViewFromArgs(0)
	If v.IsInitialized = False Then Return
	Dim Text As String
	Dim fnt As List = Array(v.Font)
	For i = 1 To DesignerArgs.Arguments.Size - 1
		Text = DesignerArgs.Arguments.Get(i)
		If SetTextHelper(v, Text, fnt) Then Exit
	Next
End Sub
'Extends SetText with adjustment of the text size. Note that the second parameter is the base text size.
'Parameters: View, Base text size, One or more strings.
Private Sub SetTextAndSize(DesignerArgs As DesignerArgs)
	Dim v As B4XView = DesignerArgs.GetViewFromArgs(0)
	Dim OriginalTextSize As Int = DesignerArgs.Arguments.Get(1)
	If v.IsInitialized = False Then Return
	Dim Text As String
	Dim fnts As List
	#if B4I
	If v.Font.ToNativeFont.Name.StartsWith(".") Then
		fnts.Initialize
		For Each f As Float In textSizesSteps
			fnts.Add(xui.CreateDefaultFont(OriginalTextSize * f))
		Next
	End If
	#end if
	If fnts.IsInitialized = False Then
		fnts.Initialize
		For Each f As Float In textSizesSteps
			fnts.Add(xui.CreateFont2(v.Font, OriginalTextSize * f))
		Next
	End If
	For i = 2 To DesignerArgs.Arguments.Size - 1
		Text = DesignerArgs.Arguments.Get(i)
		If SetTextHelper(v, Text, fnts) Then Exit
	Next
	v.Text = Text
End Sub

Private Sub SetTextHelper(View As B4XView, text As String, Fonts As List) As Boolean
	CreateCVSIfNeeded
	For Each fnt As B4XFont In Fonts
		Dim width As Int = cvs.MeasureText(text, fnt).Width
		If width + 30dip < View.Width Then
			If Fonts.Size > 1 Then
				View.Font = fnt
			End If
			Return True
		End If
	Next
	Return False
End Sub
