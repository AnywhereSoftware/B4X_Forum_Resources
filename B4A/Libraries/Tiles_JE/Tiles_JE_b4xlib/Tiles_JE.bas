B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.3
@EndOfDesignText@
'Version 1.6
'Author: Jerryk

#Event: Click(pId As String, pTag As Object)
#RaisesSynchronousEvents: Click

#DesignerProperty: Key: dTilesType, DisplayName: Tiles Type, FieldType: String, DefaultValue: FilledWidth, List: FilledWidth|FixedWidth 
#DesignerProperty: Key: dTileHeight, DisplayName: Tile Height, FieldType: Int, DefaultValue: 100, MinRange: 10 
#DesignerProperty: Key: dTileWidth, DisplayName: Tile Width, FieldType: Int, DefaultValue: 100, MinRange: 10 
#DesignerProperty: Key: dCornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 5
#DesignerProperty: Key: dGap, DisplayName: Gap Between Tiles, FieldType: Int, DefaultValue: 5
#DesignerProperty: Key: dTilesPerRow, DisplayName: Tiles Per Row, FieldType: Int, DefaultValue: 3, MinRange: 1 
#DesignerProperty: Key: dBackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: dShowSelected, DisplayName: Show Selected, FieldType: String, DefaultValue: tile, List: tile|border|off
#DesignerProperty: Key: dSelectedColor, DisplayName: Selected Color, FieldType: Color, DefaultValue: 0xFFFFFF00
#DesignerProperty: Key: dSelectedWidth, DisplayName: Selected Border Width, FieldType: Int, DefaultValue: 4
#DesignerProperty: Key: dSetMaxHeight, DisplayName: Sets Max Height, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: dShowDefaultBorder, DisplayName: Show Dflt Border, FieldType: Boolean, DefaultValue: False
#DesignerProperty: Key: dBorderColor, DisplayName: Border Color, FieldType: Color, DefaultValue: 0xFFD3D3D3
#DesignerProperty: Key: dBorderWidth, DisplayName: Border Width, FieldType: Int, DefaultValue: 2


Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private dd As DDD
	
	Private baseSV As ScrollView
	Private tilesPanel As Panel
	Private cnt As Int = 0
	Private xpoz, ypoz As Int
	Private lTags As List
	Private mSelectedItem As String
	Type xTag(Type As String, Id As Object, Color As Int, Tag As Object)

	'properties
	Private mTilesType As String = "FilledWidth"
	Private mTileHeight As Int = 100dip
	Private mTileWidth As Int = 100dip
	Private mCornerRadius As Int = 5dip
	Private mGap As Int = 5dip
	Private mTilesPerRow As Int = 3
	Private mBackgroundColor As Int = xui.Color_Black
	Private mShowSelected As String = "tile"
	Private mSelectedColor As Int = xui.Color_Yellow
	Private mSelectedWidth As Int = 4dip
	Private mSetMaxHeight As Boolean = False
	Private mShowDefaultBorder As Boolean = False
	Private mBorderColor As Int = xui.Color_LightGray
	Private mBorderWidth As Int = 2dip
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	dd = B4XPages.MainPage.dd

	lTags.Initialize
	tilesPanel.Initialize("")
	mSelectedItem = "-1"
 End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me

	'read properties	
	mTilesType = Props.GetDefault("dTilesType", "FilledWidth")
	mTileHeight = IntToDIP(Props.GetDefault("dTileHeight", 100))
	mTileWidth = IntToDIP(Props.GetDefault("dTileWidth", 100))
	mCornerRadius = IntToDIP(Props.GetDefault("dCornerRadius", 5))
	mGap = IntToDIP(Props.GetDefault("dGap", 5))
	mTilesPerRow = Props.GetDefault("dTilesPerRow", 3)
	mBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("dBackgroundColor", xui.Color_Black))
	mShowSelected = Props.GetDefault("dShowSelected", "tile")
	mSelectedColor = xui.PaintOrColorToColor(Props.GetDefault("dSelectedColor", xui.Color_Yellow))
	mSelectedWidth = IntToDIP(Props.GetDefault("dSelectedWidth", 4))
	mSetMaxHeight =  Props.GetDefault("dSetMaxHeight", False)
	mShowDefaultBorder = Props.GetDefault("dShowDefaultBorder", False)
	mBorderColor = xui.PaintOrColorToColor(Props.GetDefault("dBorderColor", xui.Color_LightGray))
	mBorderWidth =IntToDIP(Props.GetDefault("dBorderWidth", 2))
	
	InitClass
End Sub

Private Sub InitClass
	baseSV.Initialize(mBase.Height)
	baseSV.Panel.Width = mBase.Width
	baseSV.Panel.Height = mBase.Height
	baseSV.Panel.Color = mBackgroundColor
	baseSV.Color = mBackgroundColor

	mBase.AddView(baseSV, 0, 0, mBase.Width, mBase.Height)
	tilesPanel = baseSV.Panel

	xpoz = mGap
	ypoz = mGap
End Sub

#Region funtions
Public Sub AddToParent(oParent As Object, Left As Int, Top As Int, Width As Int, Height As Int)
	Dim mParent As B4XView
	mParent = oParent

	mBase = xui.CreatePanel("mBase")
	mBase.Tag = Me
	mParent.AddView(mBase, Left, Top, Width, Height)
	
	InitClass
End Sub

Public Sub AddLabel (pId As String, pText As String, pSize As Int, pBackgroundColor As Int, pTag As Object) As Label
	CheckDuplication(pId)
	lTags.Add(pId)
		
	tilesPanel.LoadLayout("_pnlLabel")

	Dim pnl As Panel
	pnl = dd.GetViewByName(tilesPanel, "PanelLabel")
	cnt = cnt + 1

	Dim tTag As xTag
	tTag.Type = "label"
	tTag.Id = pId
	tTag.Color = pBackgroundColor
	tTag.Tag = pTag
	pnl.Tag = tTag

	Dim borderColor, borderWidth As Int
	If mShowDefaultBorder Then
		borderColor = mBorderColor
		borderWidth = mBorderWidth
	Else
		borderColor = pBackgroundColor
		borderWidth = 0dip
	End If
	Dim cd As ColorDrawable
	cd.Initialize2(pBackgroundColor, mCornerRadius, borderWidth, borderColor)
	pnl.Background = cd
	
	pnl.Left = xpoz
	pnl.Top = ypoz
	If mTilesType = "FixedWidth" Then
		Dim xratio As Float = mTileWidth / 100dip
		pnl.Width = pnl.Width * xratio
	Else 'FilledWidth
		pnl.Width = (baseSV.Width - (mGap * (mTilesPerRow + 1))) / mTilesPerRow
	End If
	Dim yratio As Float = mTileHeight / 100dip
	pnl.Height = pnl.Height * yratio

	Dim lbl As Label = pnl.GetView(0)
	lbl.Width = pnl.Width
	lbl.Height = pnl.Height
	lbl.Gravity = Gravity.CENTER
	lbl.TextSize = pSize
	lbl.Text = pText
	
	NewPosition(pnl)
'
	Return lbl
End Sub

Public Sub AddImage (pId As String, pBitmap As String, pBackgroundColor As Int, pTag As Object) As ImageView
	CheckDuplication(pId)
	lTags.Add(pId)

	tilesPanel.LoadLayout("_pnlImage")
	Private pnl As Panel
	pnl = dd.GetViewByName(tilesPanel, "PanelImage")
	cnt = cnt + 1

	Dim tTag As xTag
	tTag.Type = "image"
	tTag.Id = pId
	tTag.Color = pBackgroundColor
	tTag.Tag = pTag
	pnl.Tag = tTag

	Dim borderColor, borderWidth As Int
	If mShowDefaultBorder Then
		borderColor = mBorderColor
		borderWidth = mBorderWidth
	Else
		borderColor = pBackgroundColor
		borderWidth = 0dip
	End If
	Dim cd As ColorDrawable
	cd.Initialize2(pBackgroundColor, mCornerRadius, borderWidth, borderColor)
	pnl.Background = cd

	pnl.Left = xpoz
	pnl.Top = ypoz
	If mTilesType = "FixedWidth" Then
		Dim xratio As Float = mTileWidth / 100dip
		pnl.Width = pnl.Width * xratio
	Else 'FilledWidth
		pnl.Width = (baseSV.Width - (mGap * (mTilesPerRow + 1))) / mTilesPerRow
	End If
	Dim yratio As Float = mTileHeight / 100dip
	pnl.Height = pnl.Height * yratio

	Dim img As ImageView = pnl.GetView(0) 
	img.Width = pnl.Width
	img.Height = pnl.Height
	img.Gravity = Gravity.CENTER
	img.Bitmap = LoadBitmap(File.DirAssets, pBitmap)

	NewPosition(pnl)

	Return img
End Sub

Public Sub AddImageResize (pId As String, pBitmap As String, pBackgroundColor As Int, pWidth As Int, pHeight As Int, pTag As Object) As ImageView
	CheckDuplication(pId)
	lTags.Add(pId)

	tilesPanel.LoadLayout("_pnlImage")
	Private pnl As Panel
	pnl = dd.GetViewByName(tilesPanel, "PanelImage")
	cnt = cnt + 1

	Dim tTag As xTag
	tTag.Type = "image"
	tTag.Id = pId
	tTag.Color = pBackgroundColor
	tTag.Tag = pTag
	pnl.Tag = tTag

	Dim borderColor, borderWidth As Int
	If mShowDefaultBorder Then
		borderColor = mBorderColor
		borderWidth = mBorderWidth
	Else
		borderColor = pBackgroundColor
		borderWidth = 0dip
	End If
	Dim cd As ColorDrawable
	cd.Initialize2(pBackgroundColor, mCornerRadius, borderWidth, borderColor)
	pnl.Background = cd

	pnl.Left = xpoz
	pnl.Top = ypoz
	If mTilesType = "FixedWidth" Then
		Dim xratio As Float = mTileWidth / 100dip
		pnl.Width = pnl.Width * xratio
	Else 'FilledWidth
		pnl.Width = (baseSV.Width - (mGap * (mTilesPerRow + 1))) / mTilesPerRow
	End If
	Dim yratio As Float = mTileHeight / 100dip
	pnl.Height = pnl.Height * yratio

	Dim img As ImageView = pnl.GetView(0)
	img.Width = pnl.Width
	img.Height = pnl.Height
	img.Gravity = Gravity.CENTER
	img.Bitmap = LoadBitmapResize(File.DirAssets, pBitmap, pWidth, pHeight, True)

	NewPosition(pnl)

	Return img
End Sub

Public Sub AddLayout(pId As String, pLayout As String, pBackgroundColor As Int, pTag As Object) As Panel
	CheckDuplication(pId)
	lTags.Add(pId)

	tilesPanel.LoadLayout("_pnlLayout")
	Private pnl As Panel
	pnl = dd.GetViewByName(tilesPanel, "PanelLayout")
	cnt = cnt + 1

	Dim tTag As xTag
	tTag.Type = "layout"
	tTag.Id = pId
	tTag.Color = pBackgroundColor
	tTag.Tag = pTag
	pnl.Tag = tTag

	pnl.Left = xpoz
	pnl.Top= ypoz
	If mTilesType = "FixedWidth" Then
		Dim xratio As Float = mTileWidth / 100dip
		pnl.Width = pnl.Width * xratio
	Else 'FilledWidth
		pnl.Width = (baseSV.Width - (mGap * (mTilesPerRow + 1))) / mTilesPerRow
	End If
	Dim yratio As Float = mTileHeight / 100dip
	pnl.Height = pnl.Height * yratio
		
	pnl.LoadLayout(pLayout)
	
	Dim borderColor, borderWidth As Int
	If mShowDefaultBorder Then
		borderColor = mBorderColor
		borderWidth = mBorderWidth
	Else
		borderColor = pBackgroundColor
		borderWidth = 0dip
	End If
	Dim cd As ColorDrawable
	cd.Initialize2(pBackgroundColor, mCornerRadius, borderWidth, borderColor)
	pnl.Background = cd

	NewPosition(pnl)

	Return pnl
End Sub

'find a tile with a specific tag
Public Sub FindTile(search As String) As Panel
	For Each v As View In tilesPanel.GetAllViewsRecursive
		If v Is Panel Then
			Dim p As Panel = v
			If p.Parent = tilesPanel  Then
				If p.Tag.As(xTag).Id = search Then
					Return p
					Exit
				End If
			End If
		End If
	Next
	Return Null
End Sub

'change default tile color
Public Sub DefaultColor(pId As String, pCol As Int)
	For Each v As View In tilesPanel.GetAllViewsRecursive
		If v Is Panel Then
			Dim p As Panel = v
			If p.Parent = tilesPanel  Then
				If p.Tag.As(xTag).Id = pId Then
					p.Tag.As(xTag).Color = pCol
					Exit
				End If
			End If
		End If
	Next
End Sub

Public Sub RedrawTiles 
	xpoz = mGap
	ypoz = mGap
	For Each v As View In tilesPanel.GetAllViewsRecursive
		If v Is Panel Then
			Dim p As Panel = v
			p.Left = xpoz
			p.Top = ypoz
			If mTilesType = "FixedWidth" Then
				Dim xratio As Float = mTileWidth / 100dip
				p.Width = p.Width * xratio
			Else 'FilledWidth
				p.Width = (baseSV.Width - (mGap * (mTilesPerRow + 1))) / mTilesPerRow
			End If
			Dim yratio As Float = mTileHeight / 100dip
			p.Height = p.Height * yratio

			Select p.Tag.As(xTag).Type
				Case "label"
					Dim lbl As Label = p.GetView(0)
					lbl.Width = p.Width
				Case "image"
					Dim img As ImageView = p.GetView(0)
					img.Width = p.Width
				Case "layout"
			End Select
			
			NewPosition(p)
		End If
	Next
End Sub

Public Sub setSelectedItem(value As String)
	RemoveBorder
	mSelectedItem = value
	If mShowSelected <> "off" Then
		For Each v As View In tilesPanel.GetAllViewsRecursive
			If v Is Panel Then
				Dim p As Panel = v

				If p.Parent = tilesPanel And mSelectedItem <> "-1" Then
					If p.Tag.As(xTag).id = mSelectedItem Then
						Dim col As Int = p.Tag.As(xTag).Color
						Dim cd As ColorDrawable
						If mShowSelected = "border" Then
							cd.Initialize2(col, mCornerRadius, mSelectedWidth, mSelectedColor)
						Else 'tile
							cd.Initialize2(mSelectedColor, mCornerRadius, mSelectedWidth, mSelectedColor)
						End If
						p.Background = cd
						Sleep(10)
						baseSV.ScrollToNow(p.Top - mGap)
						Exit
					End If
				End If
			End If
		Next
	End If
End Sub

Public Sub getSelectedItem As String
	Return mSelectedItem
End Sub
Public Sub DeleteTile(value As String)
	For Each v As View In tilesPanel.GetAllViewsRecursive
		If v Is Panel Then
			Dim p As Panel = v
			If p.Parent = tilesPanel  Then
				If p.Tag.As(xTag).id = value Then
					p.RemoveView
					If value = mSelectedItem Then
						mSelectedItem = "-1"
					End If
					Exit
				End If
			End If
		End If
	Next
	RedrawTiles
End Sub

'sets the view height according to the total height of the tiles 
Public Sub SetMaxHeight
	baseSV.Height = tilesPanel.Height
	mBase.Height = tilesPanel.Height
End Sub

Public Sub CenterHorizontally
	mBase.Left = 50%x - mBase.Width / 2
End Sub
#End Region


Private Sub CheckDuplication (pId As String)
	If lTags.IndexOf(pId) <> -1 Then
		Dim TH As Throwables
		TH.Initialize
		TH.Throw(Throwables_Static.NewIllegalArgumentException("DUPLICATE TAG: " & pId))
	End If
End Sub

Private Sub NewPosition (pnl As Panel)
	tilesPanel.Height = ypoz + pnl.Height + mGap
	Dim jo As JavaObject = tilesPanel
	jo.RunMethod("requestLayout", Null)  'redraw panel
	
	xpoz = xpoz + pnl.Width + mGap
	If xpoz > baseSV.Width  - pnl.Width Then
		xpoz = mGap
		ypoz = ypoz + pnl.Height + mGap
	End If
	
	If mSetMaxHeight Then
		SetMaxHeight
	End If
End Sub

Private Sub tile_Click
	Dim pnl As Panel = Sender
	Dim col As Int = pnl.Tag.As(xTag).Color
	Dim cd As ColorDrawable
	
	RemoveBorder
	Select mShowSelected
		Case "border"
			cd.Initialize2(col, mCornerRadius, mSelectedWidth, mSelectedColor)
			pnl.Background = cd
		Case "tile"
			cd.Initialize2(mSelectedColor, mCornerRadius, mSelectedWidth, mSelectedColor)
			pnl.Background = cd
		Case "off"
	End Select
	
	mSelectedItem = pnl.Tag.As(xTag).id

	If SubExists(mCallBack, mEventName & "_Click") Then
		CallSub3(mCallBack, mEventName & "_Click", pnl.Tag.As(xTag).id, pnl.Tag.As(xTag).Tag)
	End If
End Sub

Private Sub PanelImage_Click
	tile_Click
End Sub

Private Sub PanelLabel_Click
	tile_Click
End Sub

Private Sub PanelLayout_Click
	tile_Click
End Sub

Private Sub RemoveBorder
	For Each v As View In tilesPanel.GetAllViewsRecursive
		If v Is Panel Then
			Dim p As Panel = v

			If p.Parent = tilesPanel And mSelectedItem <> "-1" Then
				If p.Tag.As(xTag).Id = mSelectedItem Then
					Dim col As Int = p.Tag.As(xTag).Color
					Dim borderColor, borderWidth As Int
					If mShowDefaultBorder Then
						borderColor = mBorderColor
						borderWidth = mBorderWidth
					Else
						borderColor = col
						borderWidth = 0dip
					End If
					Dim cd As ColorDrawable
					cd.Initialize2(col, mCornerRadius, borderWidth, borderColor)
					p.Background = cd
					Exit
				End If				
			End If
		End If
	Next
End Sub

#Region properties
Public Sub setWidth(value As Int)
	mBase.Width = value
	baseSV.Width = value
	tilesPanel.Width = value
	baseSV.Panel.Width = value
End Sub
Public Sub getWidth As Int
	Return mBase.Width
End Sub

Public Sub setTilesType(value As String)
	Select Case value
		Case "FilledWidth", "FixedWidth"
			mTilesType = value
		Case Else
			mTilesType = "FilledWidth"
	End Select
End Sub
Public Sub getTilesType As String
	Return mTilesType
End Sub

Public Sub setTileHeight(value As Int)
	mTileHeight = value
End Sub
Public Sub getTileHeight As Int
	Return mTileHeight
End Sub

Public Sub setTileWidth(value As Int)
	mTileWidth = value
End Sub
Public Sub getTileWidth As Int
	Return mTileWidth
End Sub

Public Sub setCornerRadius(value As Int)
	mCornerRadius = value
End Sub
Public Sub getCornerRadius As Int
	Return mCornerRadius
End Sub

Public Sub setGap(value As Int)
	mGap = value
End Sub
Public Sub getGap As Int
	Return mGap
End Sub

Public Sub setTilesPerRow(value As Int)
	mTilesPerRow = value
End Sub
Public Sub getTilesPerRow As Int
	Return mTilesPerRow
End Sub

Public Sub setBackgroundColor(value As Int)
	mBackgroundColor = value
	baseSV.Color = mBackgroundColor
End Sub
Public Sub getBackgroundColor As Int
	Return mBackgroundColor
End Sub

Public Sub setShowSelected(value As String)
	Select Case value
		Case "tile", "border", "off"
			mShowSelected = value
		Case Else
			mShowSelected = "tile"
	End Select
End Sub
Public Sub getShowSelected As String
	Return mShowSelected
End Sub

Public Sub setSelectedColor(value As Int)
	mSelectedColor = value
End Sub
Public Sub getSelectedColor As Int
	Return mSelectedColor
End Sub

Public Sub setSelectedWidth(value As Int)
	mSelectedWidth = value
End Sub
Public Sub getSelectedWidth As Int
	Return mSelectedWidth
End Sub

Public Sub setSetMaxHeight(value As Boolean)
	mSetMaxHeight = value
End Sub
Public Sub getSetMaxHeight As Boolean
	Return mSetMaxHeight
End Sub

Public Sub setShowDefaultBorder(value As Boolean)
	mShowDefaultBorder = value
End Sub
Public Sub getShowDefaultBorder As Boolean
	Return mShowDefaultBorder
End Sub

Public Sub setBorderColor(value As Int)
	mBorderColor = value
End Sub
Public Sub getBorderColor As Int
	Return mBorderColor
End Sub

Public Sub setBorderWidth(value As Int)
	mBorderWidth = value
End Sub
Public Sub getBorderWidth As Int
	Return mBorderWidth
End Sub

'gets Base of the object
Public Sub GetBase As Panel
	Return mBase
End Sub

'gets count of tiles
Public Sub getCount As Int
	Return cnt
End Sub

#End Region

#Region tools
Private Sub IntToDIP(Integer As Int) As Int
	Dim r As Reflector
	Dim mscale As Float
	r.Target = r.GetContext
	r.Target = r.RunMethod("getResources")
	r.Target = r.RunMethod("getDisplayMetrics")
	mscale = r.GetField("density")
  
	Dim DIP As Int
	DIP = Integer * mscale + 0.5
	Return DIP
End Sub
#End Region


