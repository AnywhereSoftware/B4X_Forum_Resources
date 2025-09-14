﻿B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.3
@EndOfDesignText@
'Version 1.3
'Author: Jerryk

#Event: Click(Tag as String)
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
#DesignerProperty: Key: dInnerHeight, DisplayName: Inner Height, FieldType: Int, DefaultValue: 500 

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private baseSV As ScrollView
	Private tilesPanel As Panel
	Private xpoz, ypoz As Int
	Private cvs As Canvas
	Private lTags As List
	Type xTag(Tag As Object, Col As Int)

	'Designer properties
	Private mTilesType As String
	Private mTileHeight As Int
	Private mTileWidth As Int
	Private mCornerRadius As Int
	Private mGap As Int
	Private mTilePerRow As Int
	Private mBackgroundColor As Int
	Private mShowSelected As String
	Private mSelectedColor As Int
	Private mSelectedWidth As Int
	Private mSelectedWidth As Int
	Private mInnerHeight As Int

	Private mSelectedItem As String
	Private idx As Int = 0
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
	mBase.Tag = Me

	lTags.Initialize
	Dim bmp As Bitmap
	bmp.InitializeMutable(50dip, 50dip) 'ignore
	cvs.Initialize2(bmp)
		
	mSelectedItem = "-1"
	
	mTilesType = Props.GetDefault("dTilesType", "FilledWidth")
	mTileHeight = IntToDIP(Props.GetDefault("dTileHeight", 100))
	mTileWidth = IntToDIP(Props.GetDefault("dTileWidth", 100))
	mCornerRadius = IntToDIP(Props.GetDefault("dCornerRadius", 5))
	mGap = IntToDIP(Props.GetDefault("dGap", 5))
	mTilePerRow = Props.GetDefault("dTilesPerRow", 3)
	mBackgroundColor = xui.PaintOrColorToColor(Props.GetDefault("dBackgroundColor", xui.Color_Black))
	mShowSelected = Props.GetDefault("dShowSelected", "tile")
	mSelectedColor = xui.PaintOrColorToColor(Props.GetDefault("dSelectedColor", xui.Color_Yellow))
	mSelectedWidth = IntToDIP(Props.GetDefault("dSelectedWidth", 4))
	mInnerHeight = IntToDIP(Props.GetDefault("dInnerHeight", 500))
	
	baseSV.Initialize(mBase.Height)
	baseSV.Color = mBackgroundColor
	baseSV.Panel.Color = mBackgroundColor
	baseSV.Panel.Width = mBase.Width
	baseSV.Panel.Height = mInnerHeight
	
	mBase.AddView(baseSV, 0, 0, mBase.Width , mBase.Height)

	tilesPanel = baseSV.Panel
	xpoz = mGap
	ypoz = mGap
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
End Sub

Public Sub AddLabel (pTag As String, pText As String, pSize As Int, pBackgroundColor As Int) As Label
	CheckDuplication (pTag)
	lTags.Add(pTag)
		
	tilesPanel.LoadLayout("_pnlLabel")

	Dim pnl As Panel
	pnl = tilesPanel.GetView(idx)
	idx = idx + 1

	Dim tTag As xTag
	tTag.Tag = pTag
	tTag.Col = pBackgroundColor
	pnl.Tag = tTag

	Dim cd As ColorDrawable
	cd.Initialize2(pBackgroundColor, mCornerRadius, 0dip, pBackgroundColor)
	pnl.Background = cd
	
	pnl.Left = xpoz
	pnl.Top = ypoz
	If mTilesType = "FixedWidth" Then
		Dim xratio As Float = mTileWidth / 100dip
		pnl.Width = pnl.Width * xratio
	Else 'FilledWidth
		pnl.Width = (baseSV.Width - (mGap * (mTilePerRow + 1))) / mTilePerRow
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

Public Sub AddImage (pTag As String, pBitmap As String, pBackgroundColor As Int) As ImageView
	CheckDuplication (pTag)
	lTags.Add(pTag)

	tilesPanel.LoadLayout("_pnlImage")
	Private pnl As Panel
	pnl = tilesPanel.GetView(idx)
	idx = idx + 1

	Dim tTag As xTag
	tTag.Tag = pTag
	tTag.Col = pBackgroundColor
	pnl.Tag = tTag

	Dim cd As ColorDrawable
	cd.Initialize2(pBackgroundColor, mCornerRadius, 0dip, pBackgroundColor)
	pnl.Background = cd

	pnl.Left = xpoz
	pnl.Top= ypoz
	If mTilesType = "FixedWidth" Then
		Dim xratio As Float = mTileWidth / 100dip
		pnl.Width = pnl.Width * xratio
	Else 'FilledWidth
		pnl.Width = (baseSV.Width - (mGap * (mTilePerRow + 1))) / mTilePerRow
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


Public Sub AddImageResize (pTag As String, pBitmap As String, pBackgroundColor As Int, pWidth As Int, pHeight As Int) As ImageView
	CheckDuplication (pTag)
	lTags.Add(pTag)

	tilesPanel.LoadLayout("_pnlImage")
	Private pnl As Panel
	pnl = tilesPanel.GetView(idx)
	idx = idx + 1

	Dim tTag As xTag
	tTag.Tag = pTag
	tTag.Col = pBackgroundColor
	pnl.Tag = tTag

	Dim cd As ColorDrawable
	cd.Initialize2(pBackgroundColor, mCornerRadius, 0dip, pBackgroundColor)
	pnl.Background = cd

	pnl.Left = xpoz
	pnl.Top= ypoz
	If mTilesType = "FixedWidth" Then
		Dim xratio As Float = mTileWidth / 100dip
		pnl.Width = pnl.Width * xratio
	Else 'FilledWidth
		pnl.Width = (baseSV.Width - (mGap * (mTilePerRow + 1))) / mTilePerRow
	End If
	Dim yratio As Float = mTileHeight / 100dip
	pnl.Height = pnl.Height * yratio

	Dim img As ImageView = pnl.GetView(0)
	img.Width = pnl.Width
	img.Height = pnl.Height
	img.Gravity = Gravity.CENTER
	img.Bitmap = LoadBitmapResize(File.DirAssets, pBitmap, pWidth, pHeight, True)
	NewPosition (pnl)

	Return img
End Sub

Public Sub AddLayout(pTag As String, pLayout As String, pBackgroundColor As Int) As Panel
	CheckDuplication (pTag)
	lTags.Add(pTag)

	tilesPanel.LoadLayout("_pnlLayout")
	Private pnl As Panel
	pnl = tilesPanel.GetView(idx)
	idx = idx + 1

	Dim tTag As xTag
	tTag.Tag = pTag
	tTag.Col = pBackgroundColor
	pnl.Tag = tTag

	pnl.Left = xpoz
	pnl.Top= ypoz
	If mTilesType = "FixedWidth" Then
		Dim xratio As Float = mTileWidth / 100dip
		pnl.Width = pnl.Width * xratio
	Else 'FilledWidth
		pnl.Width = (baseSV.Width - (mGap * (mTilePerRow + 1))) / mTilePerRow
	End If
	Dim yratio As Float = mTileHeight / 100dip
	pnl.Height = pnl.Height * yratio
		
	pnl.LoadLayout(pLayout)
	
	Dim cd As ColorDrawable
	cd.Initialize2(pBackgroundColor, mCornerRadius, 0dip, pBackgroundColor)
	pnl.Background = cd

	NewPosition (pnl)

	Return pnl
End Sub

'find a tile with a specific tag
Public Sub FindTile(search As String) As Panel
	For Each v As View In tilesPanel.GetAllViewsRecursive
		If v Is Panel Then
			Dim p As Panel = v

			If p.Parent = tilesPanel  Then
				If p.Tag.As(xTag).Tag = search Then
					Return p
					Exit
				End If
			End If
		End If
	Next
	Return Null
End Sub

'change default tile color
Public Sub DefaultColor(pTag As String, pCol As Int)
	For Each v As View In tilesPanel.GetAllViewsRecursive
		If v Is Panel Then
			Dim p As Panel = v

			If p.Parent = tilesPanel  Then
				If p.Tag.As(xTag).Tag = pTag Then
					p.Tag.As(xTag).Col = pCol
					Exit
				End If
			End If
		End If
	Next
End Sub

Private Sub CheckDuplication (pTag As String)
	If lTags.IndexOf(pTag) <> -1 Then
		Dim TH As Throwables
		TH.Initialize
		TH.Throw(Throwables_Static.NewIllegalArgumentException("Duplicate tag: " & pTag))
	End If
End Sub

Private Sub NewPosition (pnl As Panel)
	tilesPanel.Height = ypoz + pnl.Height + mGap
	Dim jo As JavaObject = tilesPanel
	jo.RunMethod("requestLayout", Null)
	
	xpoz = xpoz + pnl.Width + mGap
	If xpoz > baseSV.Width  - pnl.Width Then
		xpoz = mGap
		ypoz = ypoz + pnl.Height + mGap
	End If
End Sub

Private Sub tile_Click
	Dim pnl As Panel = Sender
	Dim col As Int = pnl.Tag.As(xTag).Col
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
	
	mSelectedItem = pnl.Tag.As(xTag).Tag

	If SubExists(mCallBack, mEventName & "_Click") Then
		CallSub2(mCallBack, mEventName & "_Click", pnl.Tag.As(xTag).Tag)
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
				If p.Tag.As(xTag).Tag = mSelectedItem Then
					Dim col As Int = p.Tag.As(xTag).Col
					Dim cd As ColorDrawable
					cd.Initialize2(col, mCornerRadius, 0dip, col)
					p.Background = cd
					Exit
				End If				
			End If
		End If
	Next
End Sub

#Region properties
Public Sub setSelectedItem(value As String)
	RemoveBorder
	mSelectedItem = value
	If mShowSelected <> "off" Then
		For Each v As View In tilesPanel.GetAllViewsRecursive
			If v Is Panel Then
				Dim p As Panel = v

				If p.Parent = tilesPanel And mSelectedItem <> "-1" Then
					If p.Tag.As(xTag).Tag = mSelectedItem Then
						Dim col As Int = p.Tag.As(xTag).Col
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


