Type=Class
Version=2.5
ModulesStructureVersion=1
B4i=true
@EndOfDesignText@
#Event: ItemClick (Index As Int, Value As Object)
#Event: ItemLongClick (Index As Int, Value As Object)
#DesignerProperty: Key: DividerColor, DisplayName: Divider Color, FieldType: Color, DefaultValue: 0xFFA9A9A9
#DesignerProperty: Key: DividerHeight, DisplayName: Divider Height, FieldType: Int, DefaultValue: 2
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFF000000
#DesignerProperty: Key: TextBackgroundColor, DisplayName: Text Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
Sub Class_Globals
	Private EventName As String 'ignore
	Private CallBack As Object 'ignore
	Private mBase As WeakRef
	Private sv As ScrollView
	Private items As List
	Private panels As List
	Private dividerHeight As Float
	Private EventName As String
	Private CallBack As Object
	Public DefaultTextFont As Font
	Public DefaultTextColor As Int
	Public DefaultTextBackgroundColor As Int
	Private HighlightColor As Int = Colors.LightGray
End Sub

Public Sub Initialize (vCallback As Object, vEventName As String)
	EventName = vEventName
	CallBack = vCallback
	items.Initialize
	panels.Initialize
End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	mBase.Value = Base
	sv.Initialize("sv", Base.Width, 0)
	Base.AddView(sv, 0, 0, Base.Width, Base.Height)
	dividerHeight = Props.Get("DividerHeight")
	DefaultTextColor = Props.Get("TextColor")
	DefaultTextBackgroundColor = Props.Get("TextBackgroundColor")
	Base.Color = Props.Get("DividerColor")
	DefaultTextFont = Lbl.Font
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	If Width <> sv.ContentWidth Then
		sv.ContentWidth = Width
		For Each p As Panel In panels
			p.width = Width
			p.GetView(0).width = Width
		Next
	End If
	Dim c As Int = sv.ScrollOffsetY
	sv.SetLayoutAnimated(0, 0, sv.Left, sv.Top, Width, Height)
	SetOffset(c)
End Sub

Public Sub GetBase As Panel 
	Return mBase.Value
End Sub


'Clears all items.
Public Sub Clear
	items.Clear
	panels.Clear
	sv.ContentHeight = 0
	sv.Panel.RemoveAllViews
End Sub

'Returns the number of items.
Public Sub GetSize As Int
	Return items.Size
End Sub

'Returns the Panel stored at the specified index.
Public Sub GetPanel(Index As Int) As Panel
	Dim p As Panel
	p = panels.Get(Index) 'this is the parent panel
	Return p.GetView(0)
End Sub

'Returns the value stored at the specified index.
Public Sub GetValue(Index As Int) As Object
	Return items.Get(Index)
End Sub

'Removes the item at the specified index.
Public Sub RemoveAt(Index As Int)
	Dim removePanel, p As Panel
	removePanel = panels.Get(Index)
	For i = Index + 1 To items.Size - 1
		p = panels.Get(i)
		p.Tag = i - 1
		p.Top = p.Top - removePanel.Height - dividerHeight
	Next
	sv.ContentHeight = sv.ContentHeight - removePanel.Height - dividerHeight
	items.RemoveAt(Index)
	panels.RemoveAt(Index)
	removePanel.RemoveViewFromParent
End Sub

'Adds a custom item at the specified index.
Public Sub InsertAt(Index As Int, Pnl As Panel, ItemHeight As Int, Value As Object)
	'create another panel to handle the click event
	Dim p As Panel
	p.Initialize("panel")
	p.AddView(Pnl, 0, 0, sv.Width, ItemHeight)
	p.Tag = Index
	p.Color = Pnl.Color
	Pnl.Color = Colors.Transparent
	If Index = items.Size Then
		items.Add(Value)
		panels.Add(p)
		Dim top As Int
		If Index = 0 Then top = dividerHeight Else top = sv.Panel.Height
		sv.Panel.AddView(p, 0, top, sv.Width, ItemHeight)
	Else
		Dim top As Int
		If Index = 0 Then
			top = dividerHeight
		Else
			Dim previousPanel As Panel
			previousPanel = panels.Get(Index - 1)
			top = previousPanel.top + previousPanel.Height + dividerHeight
		End If

		Dim p2 As Panel
		For i = Index To panels.Size - 1
			p2 = panels.Get(i)
			p2.top = p2.top + ItemHeight + dividerHeight
			p2.Tag = i + 1
		Next
		items.InsertAt(Index, Value)
		panels.InsertAt(Index, p)
		sv.Panel.AddView(p, 0, top, sv.Width, ItemHeight)
	End If
	sv.ContentHeight = sv.ContentHeight + ItemHeight + dividerHeight
	If items.Size = 1 Then sv.ContentHeight = sv.ContentHeight + dividerHeight
End Sub

Public Sub Add(Pnl As Panel, ItemHeight As Int, Value As Object)
	InsertAt(items.Size, Pnl, ItemHeight, Value)
End Sub

'Adds a text item. The item height will be adjusted based on the text.
Public Sub AddTextItem(Text As String, Value As Object)
	InsertAtTextItem(items.Size, Text, Value)
End Sub

'Inserts a text item at the specified index.
Public Sub InsertAtTextItem(Index As Int, Text As String, Value As Object)
	Dim pnl As Panel
	pnl.Initialize("")
	Dim lbl As Label
	lbl.Initialize("")
	lbl.TextAlignment = lbl.ALIGNMENT_LEFT
	pnl.AddView(lbl, 5dip, 2dip, sv.Width - 5dip, 20dip)
	lbl.Text = Text
	lbl.Multiline = True
	lbl.Font = DefaultTextFont
	lbl.TextColor = DefaultTextColor
	pnl.Color = DefaultTextBackgroundColor
	lbl.SizeToFit
	lbl.Height = Max(50dip, lbl.Height)
	InsertAt(Index, pnl, lbl.Height + 2dip, Value)
End Sub

Private Sub Panel_LongClick
   Dim p As Panel = Sender
   p.GetView(0).Color = HighlightColor
   p.GetView(0).SetColorAnimated(700, Colors.Transparent)
   CallSub3(CallBack, EventName & "_ItemLongClick", p.Tag, items.Get(p.Tag))
End Sub

Private Sub Panel_Click
	Dim p As Panel = Sender
	p.GetView(0).Color = HighlightColor
	p.GetView(0).SetColorAnimated(700, Colors.Transparent)
	CallSub3(CallBack, EventName & "_ItemClick", p.Tag, items.Get(p.Tag))
End Sub


'Scrolls the list to the specified item.
Public Sub JumpToItem(Index As Int)
	Dim top As Int
	Dim p As Panel
	For i = 0 To Min(Index - 1, items.Size - 1)
		p = panels.Get(i)
		top = top + p.Height + dividerHeight
	Next
	SetOffset(top)
End Sub
Private Sub SetOffset(y As Int)
	sv.ScrollOffsetY = Max(0, Min(y, sv.ContentHeight - sv.Height))
End Sub
'Returns the index of the item that holds the given view.
Public Sub GetItemFromView(v As View) As Int
	Dim r As NativeObject
	Dim parent, current As Object
	parent = v
	Do While (parent Is Panel) = False Or sv.Panel <> parent
		current = parent
		r = current
		parent = r.GetField("superview")
	Loop
	v = current
	Return v.Tag
End Sub