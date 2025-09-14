B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
#region doc
'https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames#X_and_Y
#end region

#region designer
#DesignerProperty: Key: centerLat, DisplayName: Latitude at center, FieldType: float, DefaultValue: 0
#DesignerProperty: Key: centerLng, DisplayName: Longitude at center, FieldType: float, DefaultValue: 0
#DesignerProperty: Key: zoomLevel, DisplayName: Zoom Level, FieldType: int, DefaultValue: 0,MinRange: 0, MaxRange: 17,
#DesignerProperty: Key: compassDirection, DisplayName: Compass Direciton, FieldType: float, DefaultValue: 0,MinRange: 0, MaxRange: 360,
#DesignerProperty: Key: offlineMode, DisplayName: Offline Mode, FieldType: boolean, DefaultValue: true
#DesignerProperty: Key: showMenu, DisplayName: Display Menu, FieldType: boolean, DefaultValue: false
#DesignerProperty: Key: showGrid, DisplayName: Display Grid, FieldType: boolean, DefaultValue: true
#DesignerProperty: Key: showCenter, DisplayName: Display Center, FieldType: boolean, DefaultValue: true
#DesignerProperty: Key: showLandmark, DisplayName: Display Landmark, FieldType: boolean, DefaultValue: false
#DesignerProperty: Key: showCenterLatLng, DisplayName: Display Lat/Lng, FieldType: boolean, DefaultValue: true
#DesignerProperty: Key: showZoom, DisplayName: Display Zoom, FieldType: boolean, DefaultValue: true
#DesignerProperty: Key: showScale, DisplayName: Display Scale, FieldType: boolean, DefaultValue: true
#DesignerProperty: Key: showCompass, DisplayName: Display Compass, FieldType: boolean, DefaultValue: true
#DesignerProperty: Key: showShapes, DisplayName: Display Shapes, FieldType: boolean, DefaultValue: true
#DesignerProperty: Key: showGPS, DisplayName: Display GPS, FieldType: boolean, DefaultValue: true
#DesignerProperty: Key: followGPS, DisplayName: Follow GPS, FieldType: boolean, DefaultValue: false
#DesignerProperty: Key: userAgent, DisplayName: UserAgent for openstreetmap server, FieldType: string, DefaultValue: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0
#DesignerProperty: Key: tileServer, DisplayName: TileServer (end with /), FieldType: string, DefaultValue: https://a.tile.openstreetmap.org/
#event:ready
#event:MenuClicked
#event:ScaleClicked(aScale as double)
#event:CenterlatlngClicked(alatLng as TLatLng)
#event:CenterLatLngChanged(aOldlatLng as TLatLng,aNewLatLng as TLatLng)
#event:zoomLevelChanged(aOldZzoomLEvel as int,aNewZoomLevel)
#event:compassDirectionChanged(aOldDirection as double,aNewDirection as double)
#event:compassClicked(adegres as double)
#event:shapesClicked(aLatLng as TMapLatLng,aShape as object)
#event:mapClicked(aLatLng as TMapLatLng)
#event:gpsClicked(aGPS as TMapGPS)
#end region

#region globals
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private fxui As XUI 'ignore
	Public Tag As Object
	'private constants
	Private const cTileLayerImage As Int=0
	Private const cTileLayerGrid As Int=1
	'private fields
	Private cGPSWidth As Float=30dip
	Private cGPSHeight As Float=30dip
	Private fMapTileManager As clMapTileManager
	Private fMap As TMap
	Private fViewTilesAndTouch As B4XView
	Private fViewTiles As B4XView
	Private fViewTouch As B4XView
	Private fViewCenter As B4XView
	Private fViewLandmark As B4XView
	Private fViewCompass As B4XView
	Private fCompassBitmap(2) As B4XBitmap
	Private fTilesCount As Long
	Private fIsMoving As Boolean=False
	Private fViewCenterLatLng As B4XView
	Private fViewZoom As B4XView
	Private fViewZoomLevel As B4XView
	Private fViewScale As B4XView
	Private fViewScaleValue As B4XView
	Private fViewScaleRuler As B4XView
	Private fViewMenu As B4XView
	Private fLastTouch As TMapPoint
	Private fStartTouch As TMapPoint
	Private fViewCompassImage As B4XView
	Private fViewCompassBearing As B4XView
	Private fViewShapes As B4XView
	Private fShapeCanvas As B4XCanvas
	Private fViewGPS As B4XView
	Private fViewGPSImage As B4XView
End Sub
#end region

#region initialization
Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	fMap.Initialize
	fMap.fShapes.Initialize
	fLastTouch.Initialize
	fStartTouch.Initialize
	fMapTileManager.Initialize
End Sub

'on base resize event
Private Sub Base_Resize (Width As Double, Height As Double)
	If fViewTilesAndTouch.IsInitialized Then
		mBase.RemoveAllViews
		rearrange
		draw
	End If
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	CallSubDelayed2(Me,"LoadLayout",Props)
End Sub

'load layout and raise ready event
private Sub LoadLayout(aProps As Map)
	rearrange
	'init B4XBitmap for compass
	fCompassBitmap(0)=fxui.LoadBitmapResize(File.DirAssets,"compass0.png",fViewCompassImage.Width,fViewCompassImage.Height,True)
	fCompassBitmap(1)=fxui.LoadBitmapResize(File.DirAssets,"compassx.png",fViewCompassImage.Width,fViewCompassImage.Height,True)
	'init map info and options from custom properties
	fMap.Initialize
	fMap.fGPS=coMapUtilities.initGPS(coMapUtilities.initLatLng(0,0),0)
	
	setCenterLatLng(coMapUtilities.initLatLng(aProps.GetDefault("centerLat",0),aProps.GetDefault("centerLng",0)))
	setZoomLevel(aProps.GetDefault("zoomLevel",0))
	setCompassDirection(aProps.GetDefault("compassDirection",0))
	setShowCenter(aProps.GetDefault("showCenter",True))
	setOfflineMode(aProps.GetDefault("offlineMode",False))
	setShowMenu(aProps.GetDefault("showMenu",True))
	setShowGrid(aProps.GetDefault("showGrid",True))
	setShowLandmark(aProps.GetDefault("showLandmark",True))
	setShowCenterLatLng(aProps.GetDefault("showCenterLatLng",True))
	setShowZoom(aProps.GetDefault("showZoom",True))
	setShowScale(aProps.GetDefault("showScale",True))
	setShowCompass(aProps.GetDefault("showCompass",True))
	setShowShapes(aProps.GetDefault("showMarkers",True))
	setShowGPS(aProps.GetDefault("showGPS",True))
	setFollowGPS(aProps.GetDefault("followGPS",false))
	fMapTileManager.userAgent=aProps.GetDefault("userAgent","Mozilla/5.0 (Windows NT 6.1; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0")
	fMapTileManager.tileServer=aProps.GetDefault("tileServer","https://a.tile.openstreetmap.org/")
	'raise event ready
	CallSub(mCallBack,mEventName & "_ready")
End Sub

private Sub rearrange
	mBase.LoadLayout("cvmap")
	'calc diag of map and resize panel
	Dim diag As Double=Sqrt(Power(mBase.Width,2)+Power(mBase.Height,2))
	fViewTilesAndTouch.Width=diag
	fViewTilesAndTouch.Height=diag
	fViewTilesAndTouch.Left=-(fViewTilesAndTouch.Width-mBase.Width)/2
	fViewTilesAndTouch.Top=-(fViewTilesAndTouch.Height-mBase.Height)/2
	fViewTouch.Width=fViewTilesAndTouch.Width
	fViewTouch.Height=fViewTilesAndTouch.Height
	fViewTiles.Width=fViewTilesAndTouch.Width
	fViewTiles.Height=fViewTilesAndTouch.Height
	fViewCenter.Width=fViewTilesAndTouch.Width
	fViewCenter.Height=fViewTilesAndTouch.Height
	fViewLandmark.Width=fViewTilesAndTouch.Width
	fViewLandmark.Height=fViewTilesAndTouch.Height
	fViewShapes.Width=fViewTilesAndTouch.Width
	fViewShapes.Height=fViewTilesAndTouch.Height
	fViewGPS.Width=fViewTilesAndTouch.Width
	fViewGPS.Height=fViewTilesAndTouch.Height
	'draw center on fpanelcenter
	Dim c As B4XCanvas
	c.Initialize(fViewCenter)
	c.DrawCircle(fViewCenter.Width/2,fViewCenter.Height/2,10dip,fxui.Color_Red,False,2dip)
	c.Invalidate
	'draw landmark on fpanellandmark
	Dim c As B4XCanvas
	c.Initialize(fViewLandmark)
	c.DrawLine(fViewLandmark.Width/2,0,fViewLandmark.Width/2,fViewLandmark.Height,fxui.Color_Red,1dip)
	c.DrawLine(0,fViewLandmark.Height/2,fViewLandmark.Width,fViewLandmark.Height/2,fxui.Color_Red,1dip)
	c.Invalidate
	'initialize canvas for shapes
	fShapeCanvas.Initialize(fViewShapes)
End Sub
#end region

#region setter/getter
public sub setUserAgent(avalue as string)
	fmapTileManager.userAgent=avalue
end sub

public sub getUserAgent as string
	return fmapTileManager.userAgent
end sub

public sub setTileServer(avalue as string)
	fmapTileManager.tileServer=avalue
end sub

public sub getTileServer as string
	return fmapTileManager.tileServer
end sub

public Sub setShowMenu(avalue As Boolean)
	fMap.fShowMenu=avalue
	fViewMenu.Visible=avalue
End Sub

public Sub getShowMenu As Boolean
	Return fMap.fShowMenu
End Sub

public Sub setShowGrid(avalue As Boolean)
	fMap.fShowGrid=avalue
	ShowHideTileLayer(cTileLayerGrid,avalue)
End Sub

public Sub getShowGrid As Boolean
	Return fMap.fShowGrid
End Sub

public Sub setShowCenter(avalue As Boolean)
	fMap.fShowCenter=avalue
	fViewCenter.Visible=avalue
End Sub

public Sub getShowCenter As Boolean
	Return fMap.fshowCenter
End Sub

public Sub setShowShapes(avalue As Boolean)
	fMap.fShowShapes=avalue
	fViewShapes.Visible=avalue
End Sub

public Sub getShowShapes As Boolean
	Return fMap.fShowShapes	
End Sub

public Sub setShowGPS(avalue As Boolean)
	fMap.fShowGPS=avalue
	fViewGPS.Visible=avalue
End Sub

public Sub getShowGPS As Boolean
	Return fMap.fShowGPS
End Sub

public Sub setFollowGPS(avalue As Boolean)
	fMap.fFollowGPS=avalue
End Sub

public Sub getFollowGPS As Boolean
	Return fMap.fFollowGPS
End Sub

public Sub setShowLandmark(avalue As Boolean)
	fMap.fShowLandmark=avalue
	fViewLandmark.Visible=avalue
End Sub

public Sub getShowLandmark As Boolean
	Return fMap.fShowLandmark
End Sub

public Sub setShowCenterLatLng(avalue As Boolean)
	fMap.fShowCenterLatLng=avalue
	fViewCenterLatLng.Visible=avalue
End Sub

public Sub getShowCenterLatLng As Boolean
	Return fMap.fShowCenterLatLng
End Sub

public Sub setShowZoom(avalue As Boolean)
	fMap.fShowZoom=avalue
	fViewZoom.Visible=avalue
End Sub

public Sub getShowZoom As Boolean
	Return fMap.fShowZoom
End Sub

public Sub setShowScale(avalue As Boolean)
	fMap.fShowScale=avalue
	fViewScale.Visible=avalue
End Sub

public Sub getShowScale As Boolean
	Return fMap.fShowScale
End Sub

public Sub setOfflineMode(avalue As Boolean)
	fMap.fOfflineMode=avalue
	fMapTileManager.Offline=avalue
End Sub

public Sub getOfflineMode As Boolean
	Return fMap.fOfflineMode
End Sub

public Sub setShowCompass(avalue As Boolean)
	fMap.fShowCompass=avalue
	fViewCompass.Visible=avalue
End Sub

public Sub getShowCompass As Boolean
	Return fMap.fshowCompass
End Sub

Public Sub setZoomLevel(avalue As Int)
	fMap.fZoomLevel=coMapUtilities.validZoomLevel(avalue)
	fViewTiles.RemoveAllViews
	fTilesCount=Power(2,fMap.fZoomLevel)
	fViewZoomLevel.Text=$"${fMap.fZoomLevel}/${coMapUtilities.cMaxZoomLevel}"$
	CallSub2(mCallBack,mEventName & "_zoomLevelChanged",fMap.fZoomLevel)
End Sub

public Sub getZoomLevel As Int
	Return fMap.fZoomLevel
End Sub

Public Sub setCompassDirection(avalue As Double)
	If avalue=fMap.fCompassDirection Then
		Return
	End If
	fMap.fCompassDirection=coMapUtilities.validCompassDirection(avalue)
	update_CompassDirection
End Sub

public Sub getCompassDirection As Double
	Return fMap.fCompassDirection
End Sub

Public Sub setCenterLatLng(avalue As TMapLatLng)
	fMap.fCenterLatLng.fLat=coMapUtilities.validLat(avalue.fLat)
	fMap.fCenterLatLng.fLng=coMapUtilities.validLng(avalue.fLng)
	fViewTiles.removeAllViews
	update_CenterLatLng
End Sub

public Sub getCenterLatLng As TMapLatLng
	Return fMap.fCenterLatLng
End Sub
#end region

#region Show/Hide layer
private Sub ShowHideTileLayer(aLayer As Int,aShowHide As Boolean)
	For i=0 To fViewTiles.NumberOfViews-1
		Dim pt As B4XView=fViewTiles.GetView(i)
		Dim pm As B4XView=pt.GetView(aLayer)
		pm.Visible=aShowHide
	Next
End Sub
#end region

#region draw Map
public Sub draw
	createTiles(fMap.fCenterLatLng,fMap.fZoomLevel)
	update_Scale
	update_CompassDirection
	update_CenterLatLng
	update_shapes
	update_GPS
End Sub
#end region

#region conversion Map, Center, Point, X/Y, Lat/Lng, Tile
'return tile which contains point X/Y
Private Sub PointToTile(aX As Int,aY As Int) As B4XView
	For i=0 To fViewTiles.NumberOfViews-1
		Dim t As B4XView=fViewTiles.GetView(i)
		If (t.Left<=aX) And (t.Left+t.Width>=aX) And (t.Top<=aY) And (t.Top+t.Height>=aY) Then
			Return t
		End If
	Next
	Return Null
End Sub

'return X tile and offset for this lng
public Sub LngToTileX(aLng As Double,aZoom As Int) As TMapTileNumberOffset
	Dim v As Double=(aLng+180)/360*Power(2,aZoom)
	Dim t As TMapTileNumberOffset
	t.Initialize
	t.fTile=Floor(v)
	t.fOffset=(v-t.fTile)*coMapUtilities.cTileSize
	Return t
End Sub

'return Y tile and offset for this lat
public  Sub LatToTileY(aLat As Double,aZoom As Int) As TMapTileNumberOffset
	Dim v As Double=(1-Logarithm(TanD(aLat)+1/CosD(aLat),cE)/cPI)/2*Power(2,aZoom)
	Dim t As TMapTileNumberOffset
	t.Initialize
	t.fTile=Floor(v)
	t.fOffset=(v-t.fTile)*coMapUtilities.cTileSize
	Return t
End Sub

'return lng for X tile and offset
public Sub TileXToLng(aX As Double,aOffsetX As Double,aZoom As Int) As Double
	Dim n As Double=Power(2,aZoom)
	Dim v As Double=(aX+aOffsetX/coMapUtilities.cTileSize)/n*360.0-180.0
	Return v
End Sub

'return lat for Y tile and offset
public Sub TileYToLat(aY As Double,aOffsetY As Double,aZoom As Int) As Double
	Dim n As Double=cPI-2*cPI*(aY+aOffsetY/coMapUtilities.cTileSize)/Power(2,aZoom)
	Dim v As Double=(180.0/cPI*ATan(0.5*(Power(cE,n)-Power(cE,-n))))
	Return v
End Sub

'return the tile (view) which is number X and Y
private Sub XYToTile(aX As Long,aY As Long) As B4XView
	For i=0 To fViewTiles.NumberOfViews-1
		Dim v As B4XView=fViewTiles.GetView(i)
		Dim t As TMapTileXY=v.Tag
		If t.fX=aX And t.fY=aY Then
			Return v
		End If
	Next
	Return Null
End Sub

'return lat/lng from center map
public Sub MapCenterToLatLng As TMapLatLng
	Return PointToLatLng(coMapUtilities.initPoint(fViewTouch.Width/2,fViewTouch.Height/2))
End Sub

'return  TMapPoint from TMapLatLng
public Sub LatLngToPoint(aLatLng As TMapLatLng) As TMapPoint
	'https://www.netzwolf.info/osm/tilebrowser.html?marker.x=12&marker.y=189&tx=1&ty=0&tz=1&ts=256#tile
	Dim v As B4XView=PointToTile(0,0)
	Dim txy As TMapTileXY=v.tag
	Dim gpx As Double=(txy.fX+(-v.Left/coMapUtilities.cTileSize))/Power(2,fMap.fZoomLevel)
	Dim gpy As Double=(txy.fy+(-v.top/coMapUtilities.cTileSize))/Power(2,fMap.fZoomLevel)
	Dim tx As TMapTileNumberOffset=LngToTileX(aLatLng.fLng,fMap.fZoomLevel)
	Dim ty As TMapTileNumberOffset=LatToTileY(aLatLng.fLat,fMap.fZoomLevel)
	Dim ppx As Double=(tx.fTile+(tx.fOffset/coMapUtilities.cTileSize))/Power(2,fMap.fZoomLevel)
	Dim ppy As Double=(ty.fTile+(ty.fOffset/coMapUtilities.cTileSize))/Power(2,fMap.fZoomLevel)
	Dim p As TMapPoint=coMapUtilities.initPoint(fTilesCount*coMapUtilities.cTileSize*(ppx-gpx),fTilesCount*coMapUtilities.cTileSize*(ppy-gpy))
	Return p
End Sub

'return lat/lng from point on map
public Sub PointToLatLng(aPoint As TMapPoint) As TMapLatLng
	Dim ll As TMapLatLng
	ll.Initialize
	Dim ti As B4XView=PointToTile(aPoint.fX,aPoint.fY)
	If ti.IsInitialized Then
		Dim txy As TMapTileXY=ti.tag
		ll.fLng=TileXToLng(txy.fX,aPoint.fX-ti.left,fMap.fZoomLevel)
		ll.fLat=TileYToLat(txy.fy,aPoint.FY-ti.top,fMap.fZoomLevel)
	Else
		Log("pointtolatlng not found "  & aPoint.fX & " | " & aPoint.fy)
		ll.fLat=0
		ll.fLng=0
	End If
	Return ll
End Sub
#end region

#region update_map
public Sub update_Scale
	Dim m As Double=CalcScale(fMap.fCenterLatLng.fLat,fMap.fZoomLevel)
	fViewScale.SetLayoutAnimated(0,5dip,mBase.Height-45dip,138dip,40dip)
	fViewScaleRuler.SetLayoutAnimated(0,5dip,30dip,128dip,5dip)
	fViewScaleValue.SetLayoutAnimated(0,5dip,5dip,128dip,20dip)
	fViewScaleValue.Text=distanceStr(m/2)
End Sub

public Sub update_CompassDirection
	fViewCompassImage.Rotation=fMap.fCompassDirection
	fViewCompassBearing.Text=$"$1.0{fMap.fCompassDirection}°"$
	If fMap.fCompassDirection=0 Then
		fViewCompassImage.SetBitmap(fCompassBitmap(0))
	Else
		fViewCompassImage.SetBitmap(fCompassBitmap(1))
	End If
	fViewTilesAndTouch.Rotation=fMap.fCompassDirection
	CallSub2(mCallBack,mEventName & "_compassDirectionChanged",fMap.fCompassDirection)
End Sub

public Sub update_CenterLatLng
	fViewCenterLatLng.Text=$"Lat : ${NumberFormat2(fMap.fCenterLatLng.fLat,1,5,5,False)} | Lng : ${NumberFormat2(fMap.fCenterLatLng.fLng,1,5,5,False)}"$
	CallSub2(mCallBack,mEventName & "_centerLatLngChanged",fMap.fCenterLatLng)
End Sub
#end region

#region create/draw tiles
'load image and set bitmap to tile
public Sub drawTile(aImageTile As B4XView,aZ As Int,aX As Long,aY As Long)
	wait for (fMapTileManager.getTile(aZ,aX,aY)) complete (result As B4XBitmap)
	Try
		aImageTile.setBitmap(result)
	Catch
		Log(LastException.Message)
	End Try
End Sub

'return tile in interval 0..fTilesCount-1
private Sub checkTile(aTile As Int,aTilesNumber As Int) As Int
	If aTile<0 Then
		aTile=aTilesNumber+aTile
	End If
	Return (aTile Mod aTilesNumber)
End Sub

'add tile
private Sub addTile(aLeft As Int,aTop As Int,aTileX As Long,aTileY As Long,aZ As Int)
	aTileX=checkTile(aTileX,fTilesCount)
	aTileY=checkTile(aTileY,fTilesCount)
	'view for the tile
	Dim xpt As B4XView = fxui.CreatePanel("tile")

	xpt.Tag=coMapUtilities.initTileXY(aTileX,aTileY)
	fViewTiles.AddView(xpt,aLeft,aTop,coMapUtilities.cTileSize,coMapUtilities.cTileSize)
	'view for the tile's image
	Dim iv As ImageView
	iv.Initialize("itile")
	xpt.AddView(iv,0,0,coMapUtilities.cTileSize,coMapUtilities.cTileSize)
	drawTile(iv,aZ,aTileX,aTileY)
	'view for the grid
	Dim pg As B4XView = fxui.CreatePanel("gtile")
	xpt.AddView(pg,0,0,coMapUtilities.cTileSize,coMapUtilities.cTileSize)
	drawGridOnTile(pg)
	pg.Visible=fMap.fShowGrid
End Sub

'draw grid on the tile grid layer
private Sub drawGridOnTile(aView As B4XView)
	Dim c As B4XCanvas
	c.Initialize(aView)
	c.ClearRect(c.TargetRect)
	c.DrawLine(c.TargetRect.Width/2,0,c.TargetRect.Width/2,c.TargetRect.Height,fxui.Color_DarkGray,1dip)
	c.DrawLine(0,c.TargetRect.height/2,c.TargetRect.width,c.TargetRect.Height/2,fxui.Color_DarkGray,1dip)
	c.DrawRect(c.TargetRect,fxui.Color_Black,False,1dip)
	c.invalidate
End Sub

'create all tiles
private Sub createTiles(aLatLng As TMapLatLng,aZoom As Int)
	'retrieve tile X/Y and offset X/Y from lat/lng
	Dim x As TMapTileNumberOffset=LngToTileX(aLatLng.fLng,aZoom)
	Dim y As TMapTileNumberOffset=LatToTileY(aLatLng.fLat,aZoom)
	Dim l As Int=(fViewTiles.Width/2)-x.fOffset
	Dim t As Int=fViewTiles.height/2-y.fOffset

	'check if tile X/Y exists
	Dim txy As B4XView=XYToTile(x.fTile,y.fTile)
	If txy.IsInitialized Then
		'if True, just move tiles
		moveTiles(100,l-txy.Left,t-txy.Top)
	Else
		'else remove all and create all tiles
		'get first left/top tile to draw
		Do While (l>0) 
			l=l-Floor(coMapUtilities.cTileSize)
			x.fTile=x.fTile-1
		Loop
		Do While (t>0) 
			t=t-Floor(coMapUtilities.cTileSize)
			y.fTile=y.fTile-1
		Loop

		'remove all tiles
		fViewTiles.RemoveAllViews
		
		'add all tiles
		Dim ti As Int
		Dim lj As Int
		Dim ty As Int
		Dim tx As Int
		lj=l
		tx=x.fTile
		Do While (lj<fViewTiles.Width) 
			ti=t
			ty=y.fTile
			Do While (ti<fViewTiles.Height) 
				addTile(lj,ti,tx,ty,fMap.fZoomLevel)
				ti=ti+coMapUtilities.cTileSize
				ty=ty+1
			Loop
			lj=lj+coMapUtilities.cTileSize
			tx=tx+1
		Loop
	End If
End Sub
#end region

#region move tiles
'move tiles up and down, remove invisible tiles, add missing visible tiles
Private Sub moveTilesY(aduration As Int,aMoveY As Int)
	Dim ti As TMapTileXY
	Dim y As Int
	Dim r As List
	r.Initialize
	For i=0 To fViewTiles.NumberOfViews-1
		Dim t As B4XView=fViewTiles.GetView(i)
		If t.top+aMoveY+coMapUtilities.cTileSize<0 Then
			r.Add(t)
		Else
			If t.top+aMoveY>fViewTiles.Height Then
				r.Add(t)
			Else
				y=t.top
				t.SetLayoutAnimated(aduration,t.left,t.top+aMoveY,coMapUtilities.cTileSize,coMapUtilities.cTileSize)
				ti=t.tag
				If (y<=0) And (t.top>0) Then
					addTile(t.Left,t.top-coMapUtilities.cTileSize,ti.fX,ti.fy-1,fMap.fZoomLevel)
				Else
					If (y+coMapUtilities.cTileSize>=fViewTiles.height) And (t.top+coMapUtilities.cTileSize<fViewTiles.height) Then
						addTile(t.Left,t.top+coMapUtilities.cTileSize,ti.fX,ti.fy+1,fMap.fZoomLevel)
					End If
				End If
			End If
		End If
	Next
	For Each t As B4XView In r
		t.RemoveViewFromParent
	Next
End Sub

'move tiles left and right, remove invisible tiles, add missing visible tiles
Private Sub moveTilesX(aduration As Int,aMoveX As Int)
	Dim ti As TMapTileXY
	Dim x As Int
	Dim r As List
	r.Initialize
	For i=0 To fViewTiles.NumberOfViews-1
		Dim t As B4XView=fViewTiles.GetView(i)
		If t.Left+aMoveX+coMapUtilities.cTileSize<0 Then
			r.Add(t)
		Else
			If t.Left+aMoveX>fViewTiles.Width Then
				r.Add(t)
			Else
				x=t.left
				t.SetLayoutAnimated(aduration,t.left+aMoveX,t.top,coMapUtilities.cTileSize,coMapUtilities.cTileSize)
				ti=t.tag
				If (x<=0) And (t.Left>0) Then
					addTile(t.Left-coMapUtilities.cTileSize,t.top,ti.fX-1,ti.fy,fMap.fZoomLevel)
				Else
					If (x+coMapUtilities.cTileSize>=fViewTiles.width) And (t.Left+coMapUtilities.cTileSize<fViewTiles.Width) Then
						addTile(t.Left+coMapUtilities.cTileSize,t.top,ti.fX+1,ti.fy,fMap.fZoomLevel)
					End If
				End If
			End If
		End If
	Next
	For Each t As B4XView In r
		t.RemoveViewFromParent
	Next
End Sub

'move tiles
private Sub moveTiles(aduration As Int,aMoveX As Int,aMoveY As Int)
	'move tiles
	moveTilesX(aduration,aMoveX)
	moveTilesY(aduration,aMoveY)
	Dim v As B4XView=fViewTiles.GetView(0)
	#if B4i
		Dim l As Int=Bit.FMod(v.Left, coMapUtilities.cTileSize)
		Dim t As Int=Bit.FMod(v.Top,coMapUtilities.cTileSize)
	#Else 
		Dim l As Int=v.Left Mod coMapUtilities.cTileSize
		Dim t As Int=v.Top Mod coMapUtilities.cTileSize
	#End If
	
	If l<-coMapUtilities.cTileSize Then
		l=l+coMapUtilities.cTileSize
	End If
	If t<-coMapUtilities.cTileSize Then
		t=t+coMapUtilities.cTileSize
	End If
End Sub
#end region

#region Map
Public Sub setMap(aMap As TMap)
	setCenterLatLng(aMap.fCenterLatLng)
	setCompassDirection(aMap.fCompassDirection)
	setZoomLevel(aMap.fZoomLevel)
	setOfflineMode(aMap.fOfflineMode)
	setShowCenter(aMap.fshowCenter)
	setShowCenterLatLng(aMap.fShowCenterLatLng)
	setShowCompass(aMap.fShowCompass)
	setShowGrid(aMap.fShowGrid)
	setShowLandmark(aMap.fShowLandmark)
	setShowShapes(aMap.fShowShapes)
	setShowMenu(aMap.fShowMenu)
	setShowScale(aMap.fShowScale)
	setShowZoom(aMap.fShowZoom)
	fMap.fShapes=aMap.fShapes
End Sub

public Sub getMap As TMap
	Return fMap
End Sub
#end region

#region zoom
'zoom in/out and raise event zoomChanged
private Sub fViewZoomInOut_click
	Dim b As Button=Sender
	setZoomLevel(fMap.fZoomLevel+b.Tag)
	createTiles(fMap.fCenterLatLng,fMap.fZoomLevel)
	update_Scale
	update_shapes
	update_GPS
End Sub

Private Sub fViewZoom_Touch (Action As Int, X As Float, Y As Float) As Boolean
	Return True
End Sub
#end region

#region scale
'format a distance (m or km)
private Sub distanceStr(aDistance As Double) As String
	If aDistance>1000 Then
		Return NumberFormat2(aDistance/1000,1,0,0,False) & "Km"
	Else
		Return NumberFormat2(aDistance,1,0,0,False) & "m"
	End If
End Sub

'calc distance for 128dip (horizontal) at this latitude and this zoom level
private Sub CalcScale(aLatitude As Double,aZoom As Int) As Double
	Return 40075016.686*Cos(aLatitude*cPI/180)/Power(2,aZoom)
End Sub


'raise event scaleClicked
#if B4A or B4i
	Private Sub fViewScale_Click
		Dim ll As TMapLatLng=MapCenterToLatLng
		Dim s As Double=CalcScale(ll.fLat,fMap.fZoomLevel)
		CallSub2(mCallBack,mEventName & "_scaleClicked",s)
	End Sub
#else if b4j
	Private Sub fViewScale_MouseClicked (EventData As MouseEvent)
		Dim ll As TMapLatLng=MapCenterToLatLng
		Dim s As Double=CalcScale(ll.fLat,fMap.fZoomLevel)
		CallSub2(mCallBack,mEventName & "_scaleClicked",s)
	End Sub
#end if
#end region

#region centerLatLng
'raise event latlngClicked
#if B4A  or B4i
	Private Sub fViewCenterLatLng_Click
		CallSub2(mCallBack,mEventName & "_CenterlatlngClicked",fMap.fCenterLatLng)
	End Sub
#else if B4J
	Private Sub fViewCenterLatLng_MouseClicked (EventData As MouseEvent)
		CallSub2(mCallBack,mEventName & "_CenterlatlngClicked",fMap.fCenterLatLng)
	End Sub
#end if
#end region

#region menu
'raise event menuClicked
Private Sub fViewMenu_Click
	CallSub(mCallBack,mEventName & "_menuClicked")
End Sub
#end region

#region compass
'touch compass
Private Sub fViewCompassTouch_Touch (Action As Int, X As Float, Y As Float)
	If Action = fViewCompass.TOUCH_ACTION_MOVE_NOTOUCH Then
		Return
	End If
	#if b4i
		setCompassDirection(Bit.FMod((Round(ATan2D(y-fPanelCompass.Height/2,x-fPanelCompass.Width/2))+90+360), 360))
	#else
		setCompassDirection((Round(ATan2D(y-fViewCompass.Height/2,x-fViewCompass.Width/2))+90+360) Mod 360)
	#End If
End Sub

'click on compass label
#if B4A or B4i
	Private Sub fViewCompassBearing_Click
		CallSub2(mCallBack,mEventName & "_compassClicked",fMap.fCompassDirection)
	End Sub
#Else if B4J
	Private Sub fViewCompassBearing_MouseClicked (EventData As MouseEvent)
		CallSub2(mCallBack,mEventName & "_compassClicked",fMap.fCompassDirection)
	End Sub
#end if

Private Sub fViewCompass_Touch (Action As Int, X As Float, Y As Float) As Boolean
	Return True
End Sub
#end region

#region map
'touch on map
Private Sub fViewTouch_Touch (Action As Int, X As Float, Y As Float) As Boolean
	Select Case Action
		Case 0 'Touch Down
			fLastTouch.fX=X
			fLastTouch.fY=Y
			fStartTouch.fX=X
			fStartTouch.fY=y
		Case 1 'Touch Up
			If X=fStartTouch.fX And Y=fStartTouch.fY Then
				Dim pt As TMapPoint=coMapUtilities.initPoint(X,Y)
				Dim ll As TMapLatLng=PointToLatLng(pt)
				#if b4A
					if fmap.fShowGPS then
						If touchGPS(X,Y) Then
							Dim g As TMapGPS=coMapUtilities.initGPS(ll,fMap.fGPS.fBearing)
							CallSub2(mCallBack,mEventName & "_GPSClicked",g)
							return true
						end if
					end if
				#end if
				If fMap.fshowShapes Then
					Dim l As List=touchInShape(X,Y)
					If l.Size>0 Then
						CallSub3(mCallBack,mEventName & "_shapesClicked",ll,l)
						Return True
					End If
				End If	
				CallSub2(mCallBack,mEventName & "_mapClicked",ll)
				Return True
			End If
		Case 2 'Touch move
			If Not(fIsMoving) Then
				fIsMoving=True
				moveTiles(0,X-fLastTouch.fx,Y-fLastTouch.fy)
				fMap.fCenterLatLng=MapCenterToLatLng
				update_CenterLatLng
				update_Scale
				update_shapes
				#if B4A
					update_GPS
				#end if
				fLastTouch.fX=X
				fLastTouch.fY=y
				fIsMoving=False
			End If
	End Select
	Return False
End Sub
#end region

#region GPS
#if B4a
public Sub GPS_LocationChanged(alocation As Location)
	fMap.fGPS.fLatLng=coMapUtilities.initLatLng(alocation.Latitude,alocation.Longitude)
	fMap.fGPS.fBearing=alocation.Bearing
	update_GPS
End Sub
#end if
public Sub update_GPS
	#if b4a
		Dim pt As TMapPoint=LatLngToPoint(fMap.fGPS.fLatLng)
		fViewGPSImage.SetLayoutAnimated(0,pt.fX-fViewGPSImage.Width/2,pt.fy-fViewGPSImage.Height/2,fViewGPSImage.Width,fViewGPSImage.Height)
		fViewGPSImage.Rotation=fMap.fGPS.fBearing
		if fmap.fFollowGPS then
			fmap.fCenterLatLng=fmap.fgps.fLatLng
			fmap.fCompassDirection=360-fmap.fGPS.fBearing
			createTiles(fMap.fCenterLatLng,fMap.fZoomLevel)
			update_Scale
			update_CompassDirection
			update_CenterLatLng
			update_shapes
		end if
	#Else
		fViewGPSImage.Visible=False
	#end if
End Sub

public Sub touchGPS(aX As Double,aY As Double) As Boolean
	#if b4A
		Dim pt As TMapPoint=coMapUtilities.initPoint(aX,aY)
		Dim r As B4XRect
		r.Initialize(fViewGPSImage.Left,fViewGPSImage.Top,fViewGPSImage.Left+fViewGPSImage.Width,fViewGPSImage.Top+fViewGPSImage.Height)
		Return coMapUtilities.PointInRect(pt,r)
	#else
		Return False
	#end if
End Sub
#end region



#region Shapes
private Sub update_shapes
	fShapeCanvas.ClearRect(fShapeCanvas.TargetRect)
	For Each o As Object In fMap.fShapes
		CallSub(o,"draw")
	Next
	fShapeCanvas.Invalidate
End Sub

private Sub touchInShape(aX As Double,aY As Double) As List
	Dim l As List
	l.Initialize
	Dim p As TMapPoint=coMapUtilities.initPoint(aX,aY)
	For Each o As Object In fMap.fShapes
		If CallSub2(o,"PointInShape",p) Then
			l.Add(o)
		End If
	Next
	Return l
End Sub

public Sub addShapeCircle(aShape As TMapShapeCircle)
	fMap.fShapes.Add(coMapUtilities.instanceShapeCircle(Me,aShape))
End Sub

public Sub addShapeImage(aShape As TMapShapeImage)
	fMap.fShapes.Add(coMapUtilities.instanceShapeImage(Me,aShape))
End Sub

public Sub addShapeLine(aShape As TMapShapeLine)
	fMap.fShapes.Add(coMapUtilities.instanceShapeLine(Me,aShape))
End Sub

public Sub addShapePolygon(aShape As TMapShapePolygon)
	fMap.fShapes.Add(coMapUtilities.instanceShapePolygon(Me,aShape))
End Sub

public Sub removeShape(aShape As Object)
	Dim i As Int=fMap.fShapes.IndexOf(aShape)
	If i>-1 Then
		fMap.fShapes.RemoveAt(i)
	End If
End Sub

public Sub getShapeCanvas As B4XCanvas
	Return fShapeCanvas
End Sub
#end region

#region db
'delete tiles from DB (BoxLatLng, Zoom range) an return how many records have been deleted
public Sub DeleteTilesFromDB(ABoxLatLng As TMapBoxLatLng,aMinZoomLevel As Int,aMaxZoomLevel As Int) As Long
	Try
		Dim r As Long=0
		Dim X1 As Long
		Dim X2 As Long
		Dim Y1 As Long
		Dim Y2 As Long
		For z=aMinZoomLevel To aMaxZoomLevel
			X1=LngToTileX(ABoxLatLng.fLeftTop.fLng,z).ftile
			X2=LngToTileX(ABoxLatLng.fRightBottom.fLng,z).fTile
			Y1=LatToTileY(ABoxLatLng.fLeftTop.flat,z).fTile
			Y2=LatToTileY(ABoxLatLng.fRightBottom.flat,z).fTile
			r=r+fMapTileManager.DeleteTilesFromDB(X1,X2,Y1,Y2,z)
		Next
	Catch
		Log(LastException.Message)
	End Try
	Return r
End Sub

'empty db
public Sub emptyDB As Long
	Return fMapTileManager.emptyDB
End Sub
#end region