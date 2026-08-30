B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'B4J port of Tiles_JE, based on the B4A 1.7 component.
'The public API is kept close to the Android version while all internal views are JavaFX views.

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
#DesignerProperty: Key: dCenterImages, DisplayName: Center Images, FieldType: Boolean, DefaultValue: False

Sub Class_Globals
	Private mEventName As String
	Private mCallBack As Object
	Public mBase As B4XView
	Private xui As XUI
	Public Tag As Object

	Private baseSV As ScrollPane
	Private tilesPanel As B4XView
	Private tileViews As List
	Private lTags As List
	Private xpoz, ypoz As Double
	Private mSelectedItem As String

	Type tileTag(Type As String, Id As Object, Color As Int, Tag As Object, BaseWidth As Int, BaseHeight As Int, ContentWidth As Double, ContentHeight As Double)

	Private Const NO_SELECTION As String = "-1"
	Private Const TYPE_LABEL As String = "label"
	Private Const TYPE_IMAGE As String = "image"
	Private Const TYPE_LAYOUT As String = "layout"
	Private Const TILES_FILLED As String = "FilledWidth"
	Private Const TILES_FIXED As String = "FixedWidth"
	Private Const SELECTED_TILE As String = "tile"
	Private Const SELECTED_BORDER As String = "border"
	Private Const SELECTED_OFF As String = "off"

	Private mTilesType As String = TILES_FILLED
	Private mTileHeight As Int = 100dip
	Private mTileWidth As Int = 100dip
	Private mCornerRadius As Int = 5dip
	Private mGap As Int = 5dip
	Private mTilesPerRow As Int = 3
	Private mBackgroundColor As Int = 0xFFFFFFFF
	Private mShowSelected As String = SELECTED_TILE
	Private mSelectedColor As Int = 0xFFFFFF00
	Private mSelectedWidth As Int = 4dip
	Private mSetMaxHeight As Boolean = False
	Private mShowDefaultBorder As Boolean = False
	Private mBorderColor As Int = 0xFFD3D3D3
	Private mBorderWidth As Int = 2dip
	Private mCenterImages As Boolean = False
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	lTags.Initialize
	tileViews.Initialize
	mSelectedItem = NO_SELECTION
End Sub

'Base type must be Object for custom views created by the B4J designer.
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me

	mTilesType = Props.GetDefault("dTilesType", TILES_FILLED)
	mTileHeight = IntToDIP(Props.GetDefault("dTileHeight", 100))
	mTileWidth = IntToDIP(Props.GetDefault("dTileWidth", 100))
	mCornerRadius = IntToDIP(Props.GetDefault("dCornerRadius", 5))
	mGap = IntToDIP(Props.GetDefault("dGap", 5))
	mTilesPerRow = Max(1, Props.GetDefault("dTilesPerRow", 3))
	mBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("dBackgroundColor", xui.Color_White))
	setShowSelected(Props.GetDefault("dShowSelected", SELECTED_TILE))
	mSelectedColor = xui.PaintOrColorToColor(Props.GetDefault("dSelectedColor", xui.Color_Yellow))
	mSelectedWidth = IntToDIP(Props.GetDefault("dSelectedWidth", 4))
	mSetMaxHeight = Props.GetDefault("dSetMaxHeight", False)
	mShowDefaultBorder = Props.GetDefault("dShowDefaultBorder", False)
	mBorderColor = xui.PaintOrColorToColor(Props.GetDefault("dBorderColor", xui.Color_LightGray))
	mBorderWidth = IntToDIP(Props.GetDefault("dBorderWidth", 2))
	mCenterImages = Props.GetDefault("dCenterImages", False)

	InitClass
End Sub

Private Sub InitClass
	baseSV.Initialize("")
	baseSV.FitToWidth = False
	baseSV.Pannable = True
	baseSV.SetHScrollVisibility("NEVER")
	baseSV.SetVScrollVisibility("AS_NEEDED")

	tilesPanel = xui.CreatePanel("")
	tilesPanel.SetLayoutAnimated(0, 0, 0, mBase.Width, Max(mBase.Height, 1dip))
	tilesPanel.Color = mBackgroundColor
	baseSV.InnerNode = tilesPanel

	Dim sv As B4XView = baseSV
	sv.Color = mBackgroundColor
	mBase.AddView(sv, 0, 0, mBase.Width, mBase.Height)
	xpoz = mGap
	ypoz = mGap
End Sub

#Region API
Public Sub AddToParent(oParent As Object, Left As Int, Top As Int, Width As Int, Height As Int)
	Dim mParent As B4XView = oParent
	mBase = xui.CreatePanel("mBase")
	mBase.Tag = Me
	mParent.AddView(mBase, Left, Top, Width, Height)
	InitClass
End Sub

Public Sub AddLabel (pId As String, pText As String, pSize As Int, pBackgroundColor As Int, pTag As Object) As Label
	Dim pnl As B4XView = CreateTile(pId, TYPE_LABEL, pBackgroundColor, pTag)
	PlaceTile(pnl)
	SetDefaultBackground(pnl, pBackgroundColor)

	Dim lbl As Label
	lbl.Initialize("")
	lbl.Alignment = "CENTER"
	lbl.TextSize = pSize
	lbl.Text = pText
	pnl.AddView(lbl, 0, 0, pnl.Width, pnl.Height)

	NewPosition(pnl)
	Return lbl
End Sub

Public Sub AddImage (pId As String, pBitmap As String, pBackgroundColor As Int, pTag As Object) As ImageView
	Return AddImageTile(pId, pBitmap, pBackgroundColor, pTag, False, 0, 0)
End Sub

Public Sub AddImageResize (pId As String, pBitmap As String, pBackgroundColor As Int, pWidth As Int, pHeight As Int, pTag As Object) As ImageView
	Return AddImageTile(pId, pBitmap, pBackgroundColor, pTag, True, pWidth, pHeight)
End Sub

'Loads a B4J designer layout (.bjl) into a tile.
Public Sub AddLayout(pId As String, pLayout As String, pBackgroundColor As Int, pTag As Object) As Pane
	Dim pnl As B4XView = CreateTile(pId, TYPE_LAYOUT, pBackgroundColor, pTag)
	PlaceTile(pnl)
	pnl.LoadLayout(pLayout)
	SetDefaultBackground(pnl, pBackgroundColor)
	NewPosition(pnl)
	Return pnl.As(Pane)
End Sub

Public Sub FindTile(search As String) As Pane
	For Each pnl As B4XView In tileViews
		If pnl.Tag.As(tileTag).Id = search Then Return pnl.As(Pane)
	Next
	Return Null
End Sub

Public Sub DefaultColor(pId As String, pCol As Int)
	Dim tile As Pane = FindTile(pId)
	If tile.IsInitialized Then
		Dim bv As B4XView = tile
		Dim tt As tileTag = bv.Tag
		tt.Color = pCol
		bv.Tag = tt
	End If
End Sub

Public Sub RedrawTiles
	xpoz = mGap
	ypoz = mGap
	For Each pnl As B4XView In tileViews
		PlaceTile(pnl)
		LayoutTileContent(pnl)
		NewPosition(pnl)
	Next
End Sub

Public Sub DeleteTile(value As String)
	For i = 0 To tileViews.Size - 1
		Dim pnl As B4XView = tileViews.Get(i)
		If pnl.Tag.As(tileTag).Id = value Then
			pnl.RemoveViewFromParent
			tileViews.RemoveAt(i)
			lTags.RemoveAt(lTags.IndexOf(value))
			If value = mSelectedItem Then mSelectedItem = NO_SELECTION
			Exit
		End If
	Next
	RedrawTiles
End Sub

Public Sub CenterHorizontally
	Dim parentWidth As Double = mBase.Parent.Width
	mBase.Left = parentWidth / 2 - mBase.Width / 2
End Sub

Public Sub SetMaxHeight
	Dim totalHeight As Double = Max(1dip, tilesPanel.Height)
	baseSV.PrefHeight = totalHeight
	mBase.Height = totalHeight
End Sub
#End Region

#Region internal
Private Sub CreateTile (pId As String, pType As String, pBackgroundColor As Int, pTag As Object) As B4XView
	CheckDuplication(pId)
	lTags.Add(pId)

	Dim pnl As B4XView = xui.CreatePanel("tile")
	Dim tTag As tileTag
	tTag.Type = pType
	tTag.Id = pId
	tTag.Color = pBackgroundColor
	tTag.Tag = pTag
	tTag.BaseWidth = 100dip
	tTag.BaseHeight = 100dip
	pnl.Tag = tTag
	tilesPanel.AddView(pnl, 0, 0, tTag.BaseWidth, tTag.BaseHeight)
	tileViews.Add(pnl)
	Return pnl
End Sub

Private Sub PlaceTile (pnl As B4XView)
	Dim tTag As tileTag = pnl.Tag
	Dim tileWidth As Double
	If mTilesType = TILES_FIXED Then
		tileWidth = tTag.BaseWidth * mTileWidth / 100dip
	Else
		tileWidth = (AvailableWidth - (mGap * (mTilesPerRow + 1))) / mTilesPerRow
	End If
	tileWidth = Max(1dip, tileWidth)
	Dim tileHeight As Double = Max(1dip, tTag.BaseHeight * mTileHeight / 100dip)
	pnl.SetLayoutAnimated(0, xpoz, ypoz, tileWidth, tileHeight)
End Sub

Private Sub AvailableWidth As Double
	Return Max(1dip, mBase.Width - 16dip)
End Sub

Private Sub AddImageTile (pId As String, pBitmap As String, pBackgroundColor As Int, pTag As Object, pResize As Boolean, pWidth As Int, pHeight As Int) As ImageView
	Dim pnl As B4XView = CreateTile(pId, TYPE_IMAGE, pBackgroundColor, pTag)
	PlaceTile(pnl)
	SetDefaultBackground(pnl, pBackgroundColor)

	Dim img As ImageView
	img.Initialize("")
	img.PreserveRatio = True
	pnl.AddView(img, 0, 0, pnl.Width, pnl.Height)
	Dim iv As B4XView = img
	Dim bmp As B4XBitmap
	If pResize Then
		bmp = xui.LoadBitmapResize(File.DirAssets, pBitmap, pWidth, pHeight, True)
	Else
		bmp = xui.LoadBitmap(File.DirAssets, pBitmap)
	End If
	iv.SetBitmap(bmp)
	Dim tt As tileTag = pnl.Tag
	tt.ContentWidth = bmp.Width
	tt.ContentHeight = bmp.Height
	pnl.Tag = tt
	LayoutTileContent(pnl)

	NewPosition(pnl)
	Return img
End Sub

Private Sub LayoutTileContent(pnl As B4XView)
	If pnl.NumberOfViews = 0 Then Return
	Dim content As B4XView = pnl.GetView(0)
	Select pnl.Tag.As(tileTag).Type
		Case TYPE_LABEL
			content.SetLayoutAnimated(0, 0, 0, pnl.Width, pnl.Height)
		Case TYPE_IMAGE
			If mCenterImages Then
				Dim tt As tileTag = pnl.Tag
				Dim contentWidth As Double = Max(1dip, tt.ContentWidth)
				Dim contentHeight As Double = Max(1dip, tt.ContentHeight)
				Dim scale As Double = Min(1, Min(pnl.Width / contentWidth, pnl.Height / contentHeight))
				contentWidth = contentWidth * scale
				contentHeight = contentHeight * scale
				content.SetLayoutAnimated(0, (pnl.Width - contentWidth) / 2, (pnl.Height - contentHeight) / 2, contentWidth, contentHeight)
			Else
				content.SetLayoutAnimated(0, 0, 0, pnl.Width, pnl.Height)
			End If
	End Select
End Sub

Private Sub SetDefaultBackground (pnl As B4XView, pBackgroundColor As Int)
	Dim borderColor, borderWidth As Int
	If mShowDefaultBorder Then
		borderColor = mBorderColor
		borderWidth = mBorderWidth
	Else
		borderColor = pBackgroundColor
		borderWidth = 0
	End If
	pnl.SetColorAndBorder(pBackgroundColor, borderWidth, borderColor, mCornerRadius)
End Sub

Private Sub SetSelectedBackground (pnl As B4XView)
	Dim col As Int = pnl.Tag.As(tileTag).Color
	Select mShowSelected
		Case SELECTED_OFF
		Case SELECTED_BORDER
			pnl.SetColorAndBorder(col, mSelectedWidth, mSelectedColor, mCornerRadius)
		Case Else
			pnl.SetColorAndBorder(mSelectedColor, mSelectedWidth, mSelectedColor, mCornerRadius)
	End Select
End Sub

Private Sub RemoveBorder
	If mSelectedItem = NO_SELECTION Then Return
	Dim tile As Pane = FindTile(mSelectedItem)
	If tile.IsInitialized Then
		Dim bv As B4XView = tile
		SetDefaultBackground(bv, bv.Tag.As(tileTag).Color)
	End If
End Sub

Private Sub CheckDuplication (pId As String)
	If lTags.IndexOf(pId) <> -1 Then ThrowError("TILES_JE - DUPLICATE TAG: " & pId)
End Sub

Private Sub ThrowError(Message As String)
	Log("Error: " & Message)
	Me.As(JavaObject).RunMethod("raiseException", Array(Message))
End Sub

#if Java
public static void raiseException(String message) {
    throw new java.lang.RuntimeException(message);
}
#end if

Private Sub NewPosition (pnl As B4XView)
	Dim contentHeight As Double = ypoz + pnl.Height + mGap
	tilesPanel.SetLayoutAnimated(0, 0, 0, AvailableWidth, Max(contentHeight, mBase.Height))

	xpoz = xpoz + pnl.Width + mGap
	If xpoz > AvailableWidth - pnl.Width Then
		xpoz = mGap
		ypoz = ypoz + pnl.Height + mGap
	End If

	If mSetMaxHeight Then SetMaxHeight
End Sub

Private Sub tile_MouseClicked (EventData As MouseEvent)
	Dim pnl As B4XView = Sender
	RemoveBorder
	SetSelectedBackground(pnl)
	mSelectedItem = pnl.Tag.As(tileTag).Id
	If SubExists(mCallBack, mEventName & "_Click") Then
		CallSub3(mCallBack, mEventName & "_Click", pnl.Tag.As(tileTag).Id, pnl.Tag.As(tileTag).Tag)
	End If
End Sub
#End Region

#Region properties
Public Sub setSelectedItem(value As String)
	RemoveBorder
	mSelectedItem = value
	If mShowSelected = SELECTED_OFF Or mSelectedItem = NO_SELECTION Then Return

	Dim tile As Pane = FindTile(mSelectedItem)
	If tile.IsInitialized Then
		Dim bv As B4XView = tile
		SetSelectedBackground(bv)
		Dim scrollRange As Double = Max(1dip, tilesPanel.Height - mBase.Height)
		baseSV.VPosition = Min(1, Max(0, (bv.Top - mGap) / scrollRange))
	End If
End Sub

Public Sub getSelectedItem As String
	Return mSelectedItem
End Sub

Public Sub setWidth(value As Int)
	mBase.Width = value
	baseSV.PrefWidth = value
	tilesPanel.Width = AvailableWidth
End Sub

Public Sub getWidth As Int
	Return mBase.Width
End Sub

Public Sub setTilesType(value As String)
	If value = TILES_FIXED Then mTilesType = TILES_FIXED Else mTilesType = TILES_FILLED
End Sub

Public Sub getTilesType As String
	Return mTilesType
End Sub

Public Sub setTileHeight(value As Int)
	mTileHeight = Max(1dip, value)
End Sub

Public Sub getTileHeight As Int
	Return mTileHeight
End Sub

Public Sub setTileWidth(value As Int)
	mTileWidth = Max(1dip, value)
End Sub

Public Sub getTileWidth As Int
	Return mTileWidth
End Sub

Public Sub setCornerRadius(value As Int)
	mCornerRadius = Max(0, value)
End Sub

Public Sub getCornerRadius As Int
	Return mCornerRadius
End Sub

Public Sub setGap(value As Int)
	mGap = Max(0, value)
	If tileViews.Size = 0 Then
		xpoz = mGap
		ypoz = mGap
	End If
End Sub

Public Sub getGap As Int
	Return mGap
End Sub

Public Sub setTilesPerRow(value As Int)
	mTilesPerRow = Max(1, value)
End Sub

Public Sub getTilesPerRow As Int
	Return mTilesPerRow
End Sub

Public Sub setBackgroundColor(value As Int)
	mBackgroundColor = value
	If baseSV.IsInitialized Then
		Dim sv As B4XView = baseSV
		sv.Color = value
		tilesPanel.Color = value
	End If
End Sub

Public Sub getBackgroundColor As Int
	Return mBackgroundColor
End Sub

Public Sub setShowSelected(value As String)
	Select value
		Case SELECTED_TILE, SELECTED_BORDER, SELECTED_OFF
			mShowSelected = value
		Case Else
			mShowSelected = SELECTED_TILE
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
	mSelectedWidth = Max(0, value)
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
	mBorderWidth = Max(0, value)
End Sub

Public Sub getBorderWidth As Int
	Return mBorderWidth
End Sub

Public Sub setCenterImages(value As Boolean)
	mCenterImages = value
	If tileViews.IsInitialized Then
		For Each pnl As B4XView In tileViews
			If pnl.Tag.As(tileTag).Type = TYPE_IMAGE Then LayoutTileContent(pnl)
		Next
	End If
End Sub

Public Sub getCenterImages As Boolean
	Return mCenterImages
End Sub

Public Sub GetBase As Pane
	Return mBase.As(Pane)
End Sub

Public Sub getCount As Int
	Return tileViews.Size
End Sub

Public Sub getIsInitialized As Boolean
	Return mBase.IsInitialized
End Sub
#End Region

#Region tools
Private Sub IntToDIP(Integer As Int) As Int
	Return Integer * xui.Scale + 0.5
End Sub
#End Region
