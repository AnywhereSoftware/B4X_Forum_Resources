B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Background As B4XView
	Private Menu As AS_GlassMenu
	Private CustomMenu As AS_GlassMenu
	Private FilterTarget As B4XView
	Private SizeLabel As B4XView
	Private ItemSize As Int = 3
	Private DemoTheme As String = "Dark"
	Private FavoriteIcon As B4XView
	Private IsFavorite As Boolean
	Private CurrentLayout As String = "grid"
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created(Root1 As B4XView)
	Root = Root1
	B4XPages.SetTitle(Me, "AS GlassMenu")
	Background = xui.CreatePanel("")
	Root.AddView(Background, 0, 0, Root.Width, Root.Height)
	Menu.Initialize(Me, "Menu")
	Menu.CreateViewPerCode(Root, Root.Width - 82dip, 24dip, 58dip, 44dip)
	Menu.Theme = DemoTheme
	Menu.TriggerProperties.MorphOrigin = "Trigger"
	Menu.AddLabel("View as")
	Dim grid As AS_GlassMenu_Item = Menu.AddItem("grid", "Grid", "grid", "grid")
	grid.Subtitle = "Large artwork"
	grid.ShowCheck = True
	grid.Checked = True
	grid.KeepOpen = True
	Dim list As AS_GlassMenu_Item = Menu.AddItem("list", "List", "list", "list")
	list.Subtitle = "Compact rows"
	list.ShowCheck = True
	list.KeepOpen = True
	Menu.AddSeparator
	Menu.AddItem("share", "Share", "share", "share")
	Menu.AddItem("copy", "Copy link", "copy", "copy")
	Dim export As AS_GlassMenu_Item = Menu.AddItem("export", "Export", "folder", "export")
	export.Enabled = False
	Menu.AddSeparator
	Dim delete As AS_GlassMenu_Item = Menu.AddItem("delete", "Delete", "trash", "delete")
	delete.Destructive = True
	CreateCustomDemo
	B4XPage_Resize(Root.Width, Root.Height)
End Sub

Private Sub CreateCustomDemo
	CustomMenu.Initialize(Me, "CustomMenu")
	CustomMenu.CreateViewPerCode(Root, 24dip, 200dip, 280dip, 48dip)
	CustomMenu.Theme = DemoTheme
	CustomMenu.OpenOnPress = False
	CustomMenu.TriggerText = ""
	CustomMenu.TriggerProperties.AccessibilityLabel = "Sort and view options"
	CustomMenu.MotionProperties.Jelly = 1
	CustomMenu.MotionProperties.Damping = 0.9
	CustomMenu.Alignment = "Start"
	Dim add As Label
	add.Initialize("Add")
	add.Text = Chr(0xF067)
	Dim addView As B4XView = add
	addView.Font = xui.CreateFontAwesome(18)
	addView.TextColor = xui.Color_White
	addView.SetTextAlignment("CENTER", "CENTER")
	CustomMenu.TriggerContentPanel.AddView(add, 0, 0, 64dip, 48dip)
	FilterTarget = CustomMenu.CreateTriggerButton(CustomMenu.TriggerContentPanel, 72dip, 0, 136dip, 48dip)
	Dim label As Label
	label.Initialize("")
	Dim title As B4XView = label
	title.Text = "Sort / View"
	title.TextColor = xui.Color_White
	title.Font = xui.CreateDefaultBoldFont(15)
	title.SetTextAlignment("CENTER", "CENTER")
	FilterTarget.AddView(title, 0, 0, 136dip, 48dip)
	Dim favorite As Label
	favorite.Initialize("Favorite")
	favorite.Text = Chr(0xF004)
	FavoriteIcon = favorite
	FavoriteIcon.Font = xui.CreateFontAwesome(18)
	FavoriteIcon.TextColor = xui.Color_White
	FavoriteIcon.SetTextAlignment("CENTER", "CENTER")
	CustomMenu.TriggerContentPanel.AddView(favorite, 216dip, 0, 64dip, 48dip)
	CustomMenu.AddLabel("Sort by")
	Dim name As AS_GlassMenu_Item = CustomMenu.AddItem("name", "Name", "sort", Null)
	name.Checked = True
	name.ShowCheck = True
	name.KeepOpen = True
	Dim newest As AS_GlassMenu_Item = CustomMenu.AddItem("newest", "Newest first", "clock", Null)
	newest.ShowCheck = True
	newest.KeepOpen = True
	CustomMenu.SetItemCallback(1, Me, "SortSelected")
	CustomMenu.SetItemCallback(2, Me, "SortSelected")
	CustomMenu.AddSeparator
	Dim custom As AS_GlassMenu_Item = CustomMenu.AddItem("size", "Artwork size", "", Null)
	custom.KeepOpen = True
	Dim row As B4XView = xui.CreatePanel("")
	row.SetLayoutAnimated(0, 0, 0, 180dip, 58dip)
	Dim smaller As Label
	smaller.Initialize("Smaller")
	smaller.Text = "-"
	Dim smallerView As B4XView = smaller
	smallerView.Font = xui.CreateDefaultFont(24)
	smallerView.TextColor = xui.Color_White
	smallerView.SetTextAlignment("CENTER", "CENTER")
	row.AddView(smaller, 0, 5dip, 44dip, 44dip)
	Dim sizeText As Label
	sizeText.Initialize("")
	SizeLabel = sizeText
	SizeLabel.SetTextAlignment("CENTER", "CENTER")
	SizeLabel.Text = ItemSize
	SizeLabel.TextColor = xui.Color_White
	row.AddView(SizeLabel, 44dip, 5dip, 88dip, 44dip)
	Dim larger As Label
	larger.Initialize("Larger")
	larger.Text = "+"
	Dim largerView As B4XView = larger
	largerView.Font = xui.CreateDefaultFont(24)
	largerView.TextColor = xui.Color_White
	largerView.SetTextAlignment("CENTER", "CENTER")
	row.AddView(larger, 132dip, 5dip, 44dip, 44dip)
	CustomMenu.SetItemContent(4, row, 58dip)
	CustomMenu.AddSeparator
	CustomMenu.AddItem("theme", "Appearance", "heart", Null)
	Dim icon As B4XView = xui.CreatePanel("")
	icon.SetLayoutAnimated(0, 0, 0, 20dip, 20dip)
	Dim canvas As B4XCanvas
	canvas.Initialize(icon)
	canvas.DrawCircle(10dip, 10dip, 8dip, 0xFFFFCB64, True, 0)
	canvas.DrawCircle(10dip, 10dip, 4dip, 0xFFEF7564, True, 0)
	canvas.Invalidate
	canvas.Release
	CustomMenu.SetItemIconView(6, icon)
End Sub

Private Sub B4XPage_Resize(Width As Int, Height As Int)
	If Background.IsInitialized = False Or Width < 1 Or Height < 1 Then Return
	Menu.CloseImmediately
	CustomMenu.CloseImmediately
	Background.SetLayoutAnimated(0, 0, 0, Width, Height)
	DrawScene
	Menu.mBase.SetLayoutAnimated(0, Max(12dip, Width - 82dip), 24dip, 58dip, 44dip)
	Menu.Resize(58dip, 44dip)
	Menu.SetBackdropView(Background)
	CustomMenu.mBase.SetLayoutAnimated(0, Max(12dip, (Width - 280dip) / 2), Max(100dip, Height / 2 - 24dip), 280dip, 48dip)
	CustomMenu.Resize(280dip, 48dip)
	CustomMenu.SetBackdropView(Background)
End Sub

Private Sub DrawScene
	Dim cvs As B4XCanvas
	cvs.Initialize(Background)
	cvs.DrawRect(cvs.TargetRect, 0xFF16233B, True, 0)
	For i = 0 To 10
		Dim color As Int = IIf(i Mod 2 = 0, 0xFF365487, 0xFF376F74)
		cvs.DrawCircle(Background.Width * 0.8 - (i Mod 3) * 95dip, 230dip + i * 60dip, 80dip, color, True, 0)
	Next
	cvs.DrawText("AS GlassMenu", 24dip, 61dip, xui.CreateDefaultBoldFont(24), xui.Color_White, "LEFT")
	cvs.Invalidate
	cvs.Release
End Sub

Private Sub Menu_ItemClick(Index As Int, Item As AS_GlassMenu_Item)
	If Item.Id = "grid" Or Item.Id = "list" Then
		CurrentLayout = Item.Id
		Menu.GetItem(1).Checked = CurrentLayout = "grid"
		Menu.GetItem(2).Checked = CurrentLayout = "list"
		Menu.RefreshMenu
	End If
	Log("ItemClick: " & Index & ", " & Item.Id)
End Sub

Private Sub Menu_OpenChanged(IsOpen As Boolean)
	Log("OpenChanged: " & IsOpen)
End Sub

Private Sub B4XPage_Disappear
	Menu.CloseImmediately
	CustomMenu.CloseImmediately
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	If CustomMenu.HandleBack Then Return False
	Return Not(Menu.HandleBack)
End Sub

#If B4J
Private Sub Add_MouseClicked(EventData As MouseEvent)
#Else
Private Sub Add_Click
#End If
	Log("Add")
End Sub
#If B4J
Private Sub Favorite_MouseClicked(EventData As MouseEvent)
#Else
Private Sub Favorite_Click
#End If
	IsFavorite = Not(IsFavorite)
	FavoriteIcon.TextColor = IIf(IsFavorite, 0xFFFF453A, xui.Color_White)
End Sub
#If B4J
Private Sub Smaller_MouseClicked(EventData As MouseEvent)
#Else
Private Sub Smaller_Click
#End If
	ItemSize = Max(1, ItemSize - 1)
	SizeLabel.Text = ItemSize
End Sub
#If B4J
Private Sub Larger_MouseClicked(EventData As MouseEvent)
#Else
Private Sub Larger_Click
#End If
	ItemSize = Min(9, ItemSize + 1)
	SizeLabel.Text = ItemSize
End Sub
Private Sub SortSelected(Index As Int, Item As AS_GlassMenu_Item)
	CustomMenu.GetItem(1).Checked = Item.Id = "name"
	CustomMenu.GetItem(2).Checked = Item.Id = "newest"
	CustomMenu.RefreshMenu
End Sub
Private Sub CustomMenu_ItemClick(Index As Int, Item As AS_GlassMenu_Item)
	If Item.Id = "theme" Then
		DemoTheme = IIf(DemoTheme = "Dark", "Light", "Dark")
		Menu.Theme = DemoTheme
		CustomMenu.Theme = DemoTheme
		SizeLabel.TextColor = IIf(DemoTheme = "Dark", xui.Color_White, 0xFF202126)
	End If
End Sub
