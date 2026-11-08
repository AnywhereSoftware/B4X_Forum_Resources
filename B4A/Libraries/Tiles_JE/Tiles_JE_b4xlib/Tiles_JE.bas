B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.3
@EndOfDesignText@
'Version 1.8
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
#DesignerProperty: Key: dCenterImages, DisplayName: Center Images, FieldType: Boolean, DefaultValue: True


Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object

	Private baseSV As ScrollView
	Private tilesPanel As Panel
	Private tileViews As List
	Private xpoz, ypoz As Double
	Private lTags As List
	Private mSelectedItem As String
	Type tileTag(Type As String, Id As Object, Color As Int, Tag As Object, BaseWidth As Int, BaseHeight As Int)

	'internal constants - values must not change, they are visible through tileTag.Type
	Private Const NO_SELECTION As String = "-1"
	Private Const TYPE_LABEL As String = "label"
	Private Const TYPE_IMAGE As String = "image"
	Private Const TYPE_LAYOUT As String = "layout"
	Private Const TILES_FILLED As String = "FilledWidth"
	Private Const TILES_FIXED As String = "FixedWidth"
	Private Const SELECTED_TILE As String = "tile"
	Private Const SELECTED_BORDER As String = "border"
	Private Const SELECTED_OFF As String = "off"

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
	Private mCenterImages As Boolean = True
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback

	lTags.Initialize
	tileViews.Initialize
	mSelectedItem = NO_SELECTION
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me

	'read properties
	mTilesType = Props.GetDefault("dTilesType", TILES_FILLED)
	mTileHeight = IntToDIP(Props.GetDefault("dTileHeight", 100))
	mTileWidth = IntToDIP(Props.GetDefault("dTileWidth", 100))
	mCornerRadius = IntToDIP(Props.GetDefault("dCornerRadius", 5))
	mGap = IntToDIP(Props.GetDefault("dGap", 5))
	mTilesPerRow = Props.GetDefault("dTilesPerRow", 3)
	mBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("dBackgroundColor", xui.Color_Black))
	'through the setter, so the designer value is validated in one place too
	setShowSelected(Props.GetDefault("dShowSelected", SELECTED_TILE))
	mSelectedColor = xui.PaintOrColorToColor(Props.GetDefault("dSelectedColor", xui.Color_Yellow))
	mSelectedWidth = IntToDIP(Props.GetDefault("dSelectedWidth", 4))
	mSetMaxHeight = Props.GetDefault("dSetMaxHeight", False)
	mShowDefaultBorder = Props.GetDefault("dShowDefaultBorder", False)
	mBorderColor = xui.PaintOrColorToColor(Props.GetDefault("dBorderColor", xui.Color_LightGray))
	mBorderWidth = IntToDIP(Props.GetDefault("dBorderWidth", 2))
	mCenterImages = Props.GetDefault("dCenterImages", True)

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

#Region API
Public Sub AddToParent(oParent As Object, Left As Int, Top As Int, Width As Int, Height As Int)
	Dim mParent As B4XView
	mParent = oParent

	mBase = xui.CreatePanel("mBase")
	mBase.Tag = Me
	mParent.AddView(mBase, Left, Top, Width, Height)

	InitClass
End Sub

Public Sub AddLabel (pId As String, pText As String, pSize As Int, pBackgroundColor As Int, pTag As Object) As Label
	Dim pnl As Panel = CreateTile(pId, TYPE_LABEL, pBackgroundColor, pTag)
	PlaceTile(pnl)
	SetDefaultBackground(pnl, pBackgroundColor)

	Dim lbl As Label
	lbl.Initialize("")
	lbl.Gravity = Gravity.CENTER
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

Public Sub AddLayout(pId As String, pLayout As String, pBackgroundColor As Int, pTag As Object) As Panel
	Dim pnl As Panel = CreateTile(pId, TYPE_LAYOUT, pBackgroundColor, pTag)
	'the tile must have its final size before the user layout is loaded into it (anchors)
	PlaceTile(pnl)
	pnl.LoadLayout(pLayout)
	SetDefaultBackground(pnl, pBackgroundColor)

	NewPosition(pnl)

	Return pnl
End Sub

'find a tile with a specific tag
Public Sub FindTile(search As String) As Panel
	For Each pnl As Panel In tileViews
		If pnl.Tag.As(tileTag).Id = search Then Return pnl
	Next
	Return Null
End Sub

'change default tile color
Public Sub DefaultColor(pId As String, pCol As Int)
	Dim tile As Panel = FindTile(pId)
	If tile.IsInitialized Then
		tile.Tag.As(tileTag).Color = pCol
	End If
End Sub

Public Sub RedrawTiles
	xpoz = mGap
	ypoz = mGap
	For Each pnl As Panel In tileViews
		PlaceTile(pnl)
		LayoutTileContent(pnl)
		NewPosition(pnl)
	Next
End Sub

Public Sub DeleteTile(value As String)
	For i = 0 To tileViews.Size - 1
		Dim pnl As Panel = tileViews.Get(i)
		If pnl.Tag.As(tileTag).Id = value Then
			pnl.RemoveView
			tileViews.RemoveAt(i)
			Dim idx As Int = lTags.IndexOf(value)
			If idx <> -1 Then lTags.RemoveAt(idx)
			If value = mSelectedItem Then mSelectedItem = NO_SELECTION
			Exit
		End If
	Next
	RedrawTiles
End Sub

Public Sub CenterHorizontally
	Dim parent As B4XView = mBase.Parent
	mBase.Left = parent.Width / 2 - mBase.Width / 2
End Sub

'sets the view height according to the total height of the tiles
Public Sub SetMaxHeight
	baseSV.Height = tilesPanel.Height
	mBase.Height = tilesPanel.Height
End Sub

#End Region


#Region internal
'creates a tile panel, registers the id and returns the panel
Private Sub CreateTile (pId As String, pType As String, pBackgroundColor As Int, pTag As Object) As Panel
	CheckDuplication(pId)
	lTags.Add(pId)

	Dim pnl As Panel
	pnl.Initialize("tile")
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

'moves the tile to the current position and scales it according to the tile size properties.
'scaling starts from the tile's base size (see tileTag), never from its current size,
'so repeated calls - e.g. RedrawTiles twice - give the same result instead of compounding.
Private Sub PlaceTile (pnl As Panel)
	Dim tTag As tileTag = pnl.Tag
	Dim tileWidth As Double
	If mTilesType = TILES_FIXED Then
		tileWidth = tTag.BaseWidth * mTileWidth / 100dip
	Else 'FilledWidth
		tileWidth = (baseSV.Width - (mGap * (mTilesPerRow + 1))) / mTilesPerRow
	End If
	tileWidth = Max(1dip, tileWidth)
	Dim tileHeight As Double = Max(1dip, tTag.BaseHeight * mTileHeight / 100dip)
	pnl.SetLayout(xpoz, ypoz, tileWidth, tileHeight)
End Sub

Private Sub AddImageTile (pId As String, pBitmap As String, pBackgroundColor As Int, pTag As Object, pResize As Boolean, pWidth As Int, pHeight As Int) As ImageView
	Dim pnl As Panel = CreateTile(pId, TYPE_IMAGE, pBackgroundColor, pTag)
	PlaceTile(pnl)
	SetDefaultBackground(pnl, pBackgroundColor)

	Dim img As ImageView
	img.Initialize("")
	If mCenterImages Then img.Gravity = Gravity.CENTER Else img.Gravity = Gravity.FILL
	pnl.AddView(img, 0, 0, pnl.Width, pnl.Height)
	Dim bmp As Bitmap
	If pResize Then
		bmp = LoadBitmapResize(File.DirAssets, pBitmap, Min(pWidth, pnl.Width), Min(pHeight, pnl.Height), True)
	Else
		bmp = LoadBitmap(File.DirAssets, pBitmap)
		If bmp.Width > pnl.Width Or bmp.Height > pnl.Height Then
			bmp = LoadBitmapResize(File.DirAssets, pBitmap, pnl.Width, pnl.Height, True)
		End If
	End If
	img.Bitmap = bmp
	LayoutTileContent(pnl)

	NewPosition(pnl)

	Return img
End Sub

Private Sub LayoutTileContent(pnl As Panel)
	If pnl.NumberOfViews = 0 Then Return
	Dim content As B4XView = pnl.GetView(0)
	Select pnl.Tag.As(tileTag).Type
		Case TYPE_LABEL
			content.SetLayoutAnimated(0, 0, 0, pnl.Width, pnl.Height)
		Case TYPE_IMAGE
			'Keep ImageView as large as the tile. Android ImageView.Gravity can then
			'position the drawable and user code can override it after AddImage.
			content.SetLayoutAnimated(0, 0, 0, pnl.Width, pnl.Height)
	End Select
End Sub

'unselected look of a tile
Private Sub SetDefaultBackground (pnl As Panel, pBackgroundColor As Int)
	Dim borderColor, borderWidth As Int
	If mShowDefaultBorder Then
		borderColor = mBorderColor
		borderWidth = mBorderWidth
	Else
		borderColor = pBackgroundColor
		borderWidth = 0dip
	End If
	pnl.As(B4XView).SetColorAndBorder(pBackgroundColor, borderWidth, borderColor, mCornerRadius)
End Sub

'selected look of a tile, does nothing when mShowSelected = "off"
Private Sub SetSelectedBackground (pnl As Panel)
	Dim col As Int = pnl.Tag.As(tileTag).Color
	Select mShowSelected
		Case SELECTED_OFF
			'no highlight
		Case SELECTED_BORDER
			pnl.As(B4XView).SetColorAndBorder(col, mSelectedWidth, mSelectedColor, mCornerRadius)
		Case Else 'SELECTED_TILE and anything unexpected, as the original code did
			pnl.As(B4XView).SetColorAndBorder(mSelectedColor, mSelectedWidth, mSelectedColor, mCornerRadius)
	End Select
End Sub

Private Sub RemoveBorder
	If mSelectedItem = NO_SELECTION Then Return
	Dim tile As Panel = FindTile(mSelectedItem)
	If tile.IsInitialized Then
		SetDefaultBackground(tile, tile.Tag.As(tileTag).Color)
	End If
End Sub

Private Sub CheckDuplication (pId As String)
	If lTags.IndexOf(pId) <> -1 Then
'		Dim TH As Throwables
'		TH.Initialize
'		TH.Throw(Throwables_Static.NewIllegalArgumentException("DUPLICATE TAG: " & pId))
		ThrowError("TILES_JE - DUPLICATE TAG: " & pId)
	End If
End Sub

Private Sub ThrowError(Message As String)
	LogColor("Error: " & Message, 0xffff0000)
    #if B4A or B4J
	Me.As(JavaObject).RunMethod("raiseException", Array(Message))
    #else
    Dim no As NativeObject
    no.Initialize("NSException").RunMethod("raise:format:", Array("", Message))
    #end if
End Sub

#if Java
public static void raiseException(String message) {
    throw new java.lang.RuntimeException(message);
}
#end if

Private Sub NewPosition (pnl As Panel)
	tilesPanel.Height = ypoz + pnl.Height + mGap
	Dim jo As JavaObject = tilesPanel
	jo.RunMethod("requestLayout", Null)  'redraw panel

	xpoz = xpoz + pnl.Width + mGap
	If xpoz > baseSV.Width - pnl.Width Then
		xpoz = mGap
		ypoz = ypoz + pnl.Height + mGap
	End If

	If mSetMaxHeight Then
		SetMaxHeight
	End If
End Sub

Private Sub tile_Click
	Dim pnl As Panel = Sender

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

	Dim tile As Panel = FindTile(mSelectedItem)
	If tile.IsInitialized Then
		SetSelectedBackground(tile)
		Sleep(10)
		baseSV.ScrollToNow(tile.Top - mGap)
	End If
End Sub

Public Sub getSelectedItem As String
	Return mSelectedItem
End Sub

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
		Case TILES_FILLED, TILES_FIXED
			mTilesType = value
		Case Else
			mTilesType = TILES_FILLED
	End Select
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
		baseSV.Color = mBackgroundColor
		tilesPanel.Color = mBackgroundColor
	End If
End Sub
Public Sub getBackgroundColor As Int
	Return mBackgroundColor
End Sub

Public Sub setShowSelected(value As String)
	Select Case value
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
		For Each pnl As Panel In tileViews
			If pnl.Tag.As(tileTag).Type = TYPE_IMAGE And pnl.NumberOfViews > 0 Then
				Dim img As ImageView = pnl.GetView(0)
				If value Then img.Gravity = Gravity.CENTER Else img.Gravity = Gravity.FILL
			End If
		Next
	End If
End Sub

Public Sub getCenterImages As Boolean
	Return mCenterImages
End Sub

'gets Base of the object
Public Sub GetBase As Panel
	Return mBase
End Sub

'gets count of tiles
Public Sub getCount As Int
	Return tileViews.Size
End Sub

Public Sub getIsInitialized As Boolean
	Return mBase.IsInitialized
End Sub
#End Region

#Region tools
Private Sub IntToDIP (Integer As Int) As Int
	'note: DipToCurrent truncates the result, this rounds it - do not replace
	Return Integer * Density + 0.5
End Sub
#End Region
