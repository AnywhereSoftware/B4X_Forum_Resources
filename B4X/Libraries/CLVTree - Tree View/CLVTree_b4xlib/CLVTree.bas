B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.08
@EndOfDesignText@
Sub Class_Globals
	Type CLVTreeItem (Text As Object, Image As B4XBitmap, Tag As Object, Children As List, _
		Parent As CLVTreeItem, InternalExpanded As Boolean, InternalPanel As B4XView)
	Private mCLV As CustomListView
	Public Root As CLVTreeItem
	Public DefaultHeight As Int = 50dip
	Private xui As XUI
	Private Const IndentPerLevel As Int = 20dip
	Private UICache As List
	Private arrowbmp As B4XBitmap
	Private Const LABEL_INDEX = 2, ARROW_INDEX = 0, IMAGE_INDEX = 1, PANELTOUCH_INDEX = 3 As Int
End Sub

Public Sub Initialize (CLV As CustomListView)
	mCLV = CLV
	Root.Initialize
	Root.Children.Initialize
	Root.InternalExpanded = True
	UICache.Initialize
	arrowbmp = xui.LoadBitmapResize(File.DirAssets, "arrow.png", 20dip, 20dip, True)
	mCLV.AnimationDuration = 0
End Sub

'Adds an item to the tree.
'Parent - item will be added to this parent.
'Text - A String or CSBuilder.
'Image - Optional image.
'Tag - Placeholder that can hold any other information needed.
Public Sub AddItem(Parent As CLVTreeItem, Text As Object, Image As B4XBitmap, Tag As Object) As CLVTreeItem
	Dim Item As CLVTreeItem = CreateCLVTreeItem(Text, Image, Tag, Parent)
	Dim height As Int = DefaultHeight
	Parent.Children.Add(Item)
	Item.InternalPanel = xui.CreatePanel("")
	Item.InternalPanel.Color = mCLV.DefaultTextBackgroundColor
	Item.InternalPanel.SetLayoutAnimated(0, 0, 0, mCLV.AsView.Width, height)
	If Parent.InternalExpanded And ItemWasAddedToCLV(Parent) Then
		AddItemToCLV(Item, -1)
		If Parent.Children.Size = 1 Then UpdateExpandIcon(Parent)
	End If
	Return Item
End Sub

Private Sub ItemWasAddedToCLV(Item As CLVTreeItem) As Boolean
	Return IIf(Item = Root, True, Item.InternalPanel.IsInitialized And Item.InternalPanel.Parent.IsInitialized)
End Sub

Private Sub ItemHasUI(Item As CLVTreeItem) As Boolean
	Return Item.InternalPanel.IsInitialized And Item.InternalPanel.NumberOfViews > 0
End Sub

'index = -1 to add as last element.
Private Sub AddItemToCLV(Item As CLVTreeItem, Index As Int)
	Dim ParentIndex As Int = IIf(Item.Parent = Root, -1, mCLV.GetItemFromView(Item.Parent.InternalPanel))
	mCLV.InsertAt(ParentIndex + 1 + CountVisibleChildren(Item.Parent, Index) - IIf(Index = -1, 1, 0), Item.InternalPanel, Item)
	If Item.InternalExpanded Then
		Dim Index As Int
		For Each child As CLVTreeItem In Item.Children
			AddItemToCLV(child, Index)
			Index = Index + 1
		Next
	End If
End Sub

'Removes an item from the tree.
Public Sub RemoveItem(Item As CLVTreeItem)
	RemoveItemFromCLV(Item)
	Item.Parent.Children.RemoveAt(Item.Parent.Children.IndexOf(Item))
	If Item.Parent.Children.Size = 0 Then UpdateExpandIcon(Item.Parent)
End Sub

Private Sub RemoveItemFromCLV(Item As CLVTreeItem)
	If ItemWasAddedToCLV(Item) = False Then Return
	Dim index As Int = mCLV.GetItemFromView(Item.InternalPanel)
	mCLV.RemoveAt(index)
	Item.InternalPanel.Color = Item.InternalPanel.Parent.Color
	Item.InternalPanel.RemoveViewFromParent
	For Each child As CLVTreeItem In Item.Children
		RemoveItemFromCLV(child)
	Next
End Sub

Private Sub CountVisibleChildren(Parent As CLVTreeItem, UpUntilIndex As Int) As Int
	Dim count As Int = IIf(UpUntilIndex = -1, Parent.Children.Size, UpUntilIndex)
	For i = 0 To count - 1
		Dim Item As CLVTreeItem = Parent.Children.Get(i)
		If Item.InternalExpanded Then count = count + CountVisibleChildren(Item, -1)
	Next
	Return count
End Sub


Private Sub CreateCLVTreeItem (Text As Object, Image As B4XBitmap, Tag As Object, Parent As CLVTreeItem) As CLVTreeItem
	Dim t1 As CLVTreeItem
	t1.Initialize
	t1.Text = Text
	t1.Image = Image
	t1.Tag = Tag
	t1.Children.Initialize
	t1.Parent = Parent
	t1.InternalExpanded = True
	Return t1
End Sub

Public Sub CLV_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	For i = 0 To mCLV.Size - 1
		Dim Item As CLVTreeItem = mCLV.GetValue(i)
		If i >= FirstIndex - 3 And i <= LastIndex + 3 Then
			If ItemHasUI(Item) = False Then
				CreateItemUI(Item)
			End If
		Else if ItemHasUI(Item) Then
			UICache.Add(Item.InternalPanel.GetView(0))
			Item.InternalPanel.GetView(0).RemoveViewFromParent
		End If
	Next
End Sub

'Removes all items.
Public Sub Clear
	For i = 0 To mCLV.Size - 1
		Dim Item As CLVTreeItem = mCLV.GetValue(i)
		If ItemHasUI(Item) Then
			UICache.Add(Item.InternalPanel.GetView(0))
			Item.InternalPanel.GetView(0).RemoveViewFromParent
		End If
	Next
	mCLV.Clear
	Root.Children.Clear
End Sub

'Expands all items.
Public Sub ExpandAll
	ExpandOrCollapseAllImpl(Root, True)
	mCLV.Refresh
End Sub
'Collapses all items.
Public Sub CollapseAll
	For i = 0 To mCLV.Size - 1
		Dim raw As CLVItem = mCLV.GetRawListItem(i)
		raw.Panel.GetView(0).Color = raw.Panel.Color
		raw.Panel.GetView(0).RemoveViewFromParent
	Next
	mCLV.Clear
	ExpandOrCollapseAllImpl(Root, False)
	Dim index As Int
	For Each item As CLVTreeItem In Root.Children
		AddItemToCLV(item, index)
		UpdateExpandIcon(item)
		index = index + 1
	Next
	mCLV.Refresh
End Sub

Private Sub ExpandOrCollapseAllImpl(Parent As CLVTreeItem, Expand As Boolean)
	If Expand Then
		ExpandImpl(Parent)
	Else if Parent <> Root Then
		Parent.InternalExpanded = False
	End If
	For Each child As CLVTreeItem In Parent.Children
		ExpandOrCollapseAllImpl(child, Expand)
	Next
End Sub

'Expands an item.
Public Sub ExpandItem(Item As CLVTreeItem)
	ExpandImpl(Item)
	mCLV.Refresh
End Sub

'Collapses an item.
Public Sub CollapseItem(Item As CLVTreeItem)
	If Item = Root Or Item.InternalExpanded = False Then Return
	CollapseImpl(Item)
	mCLV.Refresh
End Sub

Private Sub ExpandImpl(Item As CLVTreeItem)
	If Item = Root Or Item.InternalExpanded = True Then Return
	Item.InternalExpanded = True
	UpdateExpandIcon(Item)
	For i = 0 To Item.Children.Size - 1
		AddItemToCLV(Item.Children.Get(i), i)
	Next
End Sub

Private Sub CollapseImpl(Item As CLVTreeItem)
	Item.InternalExpanded = False
	UpdateExpandIcon(Item)
	For Each child As CLVTreeItem In Item.Children
		RemoveItemFromCLV(child)
	Next
End Sub

Private Sub UpdateExpandIcon (Item As CLVTreeItem)
	If ItemHasUI(Item) = False Then Return
	Dim expandicon As B4XImageView = Item.InternalPanel.GetView(0).GetView(0).Tag
	expandicon.mBase.Visible = Item.Children.Size > 0
	expandicon.mBase.Rotation = IIf(Item.InternalExpanded, 0, 270)
End Sub

'Refreshes the UI. Should be called after modifying the tree state.
Public Sub Refresh
	For i = 0 To mCLV.Size - 1
		Dim item As CLVTreeItem = mCLV.GetValue(i)
		If ItemHasUI(item) Then
			UpdateItemUI(item)
		End If
	Next
	mCLV.Refresh
End Sub

Private Sub CreateItemUI (Item As CLVTreeItem)
	Dim p As B4XView = GetItemUI
	Item.InternalPanel.AddView(p, 0, 0, p.Width, p.Height)
	UpdateItemUI(Item)
End Sub

Private Sub UpdateItemUI (Item As CLVTreeItem)
	Dim indent As Int = GetItemIndent(Item)
	Dim p As B4XView = Item.InternalPanel.GetView(0)
	p.GetView(ARROW_INDEX).Left = indent + 5dip
	Dim image As B4XImageView = p.GetView(IMAGE_INDEX).Tag
	image.mBase.Left = indent + 30dip
	If Item.Image.IsInitialized Then
		image.Bitmap = Item.Image
	Else
		image.Clear
	End If
	Dim lbl As B4XView = p.GetView(LABEL_INDEX)
	lbl.Left = indent + 65dip
	lbl.Width = p.Width - lbl.Left
	XUIViewsUtils.SetTextOrCSBuilderToLabel(lbl, Item.Text)
	p.GetView(PANELTOUCH_INDEX).SetLayoutAnimated(0, 0, 0, indent + 65dip, p.Height)
	UpdateExpandIcon(Item)
End Sub

Private Sub GetItemUI As B4XView
	If UICache.Size > 0 Then
		Dim p As B4XView = UICache.Get(0)
		UICache.RemoveAt(0)
		Return p
	End If
	p = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, mCLV.AsView.Width, DefaultHeight)
	p.AddView(XUIViewsUtils.CreateB4XImageView.mBase, 0, p.Height / 2 - 10dip, 20dip, 20dip)
	p.GetView(ARROW_INDEX).Tag.As(B4XImageView).mBackgroundColor = xui.Color_Transparent
	p.GetView(ARROW_INDEX).Tag.As(B4XImageView).Bitmap = arrowbmp
	p.AddView(XUIViewsUtils.CreateB4XImageView.mBase, 0, p.Height / 2 - 15dip, 30dip, 30dip)
	p.GetView(IMAGE_INDEX).Tag.As(B4XImageView).mBackgroundColor = xui.Color_Transparent
	Dim lbl As B4XView = XUIViewsUtils.CreateLabel
	lbl.Font = mCLV.DesignerLabel.As(B4XView).Font
	lbl.TextColor = mCLV.DesignerLabel.As(B4XView).TextColor
	lbl.SetTextAlignment("CENTER", "LEFT")
	p.AddView(lbl, 0, 0, p.Width, p.Height)
	Dim tp As B4XView = xui.CreatePanel("TouchPanel")
	p.AddView(tp, 0, 0, 0, 0)
	Return p
End Sub
#if B4J
Private Sub TouchPanel_MouseClicked (EventData As MouseEvent)
	EventData.Consume
#else
Private Sub TouchPanel_Click
#End If
	Dim item As CLVTreeItem = mCLV.GetValue(mCLV.GetItemFromView(Sender))
	If item.Children.Size = 0 Then Return
	If Not(item.InternalExpanded) Then
		ExpandImpl(item)
	Else
		CollapseImpl(item)
	End If
	mCLV.Refresh
End Sub

Private Sub GetItemIndent (Item As CLVTreeItem) As Int
	Dim Indent As Int
	Item = Item.Parent
	Do While Item <> Root
		Indent = Indent + IndentPerLevel
		Item = Item.Parent
	Loop
	Return Indent
End Sub
