B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.6
@EndOfDesignText@
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Type TMapTileXY(fX As Long,fY As Long)
	Type TMapLatLng(fLat As Double,fLng As Double)
	Type TMapGPS(fLatLng As TMapLatLng,fBearing As Int)
	Type TMap(fCenterLatLng As TMapLatLng,fZoomLevel As Int,fCompassDirection As Double,fShowMenu As Boolean,fShowGrid As Boolean,fShowCenter As Boolean,fShowLandmark As Boolean,fShowCenterLatLng As Boolean,fShowZoom As Boolean,fShowScale As Boolean,fOfflineMode As Boolean,fShowCompass As Boolean,fShowShapes As Boolean,fShapes As List,fShowGPS As Boolean,fFollowGPS as boolean,fGPS As TMapGPS)
	Type TMapBoxLatLng(fLeftTop As TMapLatLng,fRightBottom As TMapLatLng)
	Type TMapTileNumberOffset(fTile As Long,fOffset As Double)
	Type TMapPoint(fX As Double,fY As Double)
	'public constants
	Public const cTileSize As Double=256dip
	Public const cMinLat As Double=-85.0511
	Public const cMaxLat As Double=85.0511
	Public const cMinLng As Double=-180.0
	Public const cMaxLng As Double=180.0
	Public const cMinZoomLevel As Int=0
	Public const cMaxZoomLevel As Int=17
End Sub

'return true if a point is in a rect else false
Public Sub PointInRect(aPoint As TMapPoint,aRect As B4XRect) As Boolean
	Return aPoint.fX>=aRect.Left And aPoint.fX<=aRect.Right And aPoint.fY>=aRect.Top And aPoint.fY<=aRect.Bottom	
End Sub

'return true if point is in rect else false
public Sub distanceBetween2Points(aPoint1 As TMapPoint,aPoint2 As TMapPoint) As Double
	Return Sqrt(Power((aPoint1.fX-aPoint2.fX),2) + Power((aPoint1.fy-aPoint2.fy),2))
End Sub

'return a valid lat
public Sub validLat(aLat As Double) As Double
	Return Max(cMinLat,Min(aLat,cMaxLat))
End Sub

'return a valid lng
public Sub validLng(aLng As Double) As Double
	Return Max(cMinLng,Min(aLng,cMaxLng))
End Sub

'return a valid zoomLevel
public Sub validZoomLevel(aZoomLevel As Int) As Int
	Return Max(cMinZoomLevel,Min(aZoomLevel,cMaxZoomLevel))
End Sub

'return a valid compassDirection
public Sub validCompassDirection(aCompassDirection As Double) As Double
	#if b4i
		Dim d As Double=Bit.FMod(aCompassDirection, 360)
	#Else
		Dim d As Double=aCompassDirection Mod 360
	#End If
	If d<0 Then
		d=360+d
	End If
	Return Round(d)
End Sub

'return a TLatLng from lat/lng
public Sub initLatLng(aLat As Double,aLng As Double) As TMapLatLng
	Dim ll As TMapLatLng
	ll.Initialize
	ll.fLat=validLat(aLat)
	ll.fLng=validLng(aLng)
	Return ll
End Sub

'return a TBoxLatLng from Lat/Lng (left top) and Lat/Lng (Right Bottom)
Public Sub initBoxLatLng(aLat1 As Double,aLng1 As Double,aLat2 As Double,aLng2 As Double) As TMapBoxLatLng
	Dim b As TMapBoxLatLng
	b.Initialize
	b.fLeftTop=initLatLng(aLat1,aLng1)
	b.fRightBottom=initLatLng(aLat2,aLng2)
	Return b
End Sub

'return a TMapGPS from lat/lng and bearing
public Sub initGPS(aLatLng As TMapLatLng,aBearing As Int) As TMapGPS
	Dim g As TMapGPS
	g.Initialize
	g.fLatLng=aLatLng
	g.fBearing=aBearing
	Return g
End Sub

'return a tmap
public Sub initMap(aLatLng As TMapLatLng,aZoomLevel As Int,aCompassDirection As Double,aOfflineMode As Boolean,aShowMenu As Boolean,aShowGrid As Boolean,aShowCenter As Boolean,aShowLandmark As Boolean,aShowCenterLatLng As Boolean,aShowZoom As Boolean,aShowScale As Boolean,aShowCompass As Boolean,aShowShapes As Boolean,aShapes As List,aShowGPS As Boolean,aFollowGPS as boolean,aGPS As TMapGPS) As TMap
	Dim mi As TMap
	mi.fCenterLatLng=aLatLng
	mi.fCompassDirection=aCompassDirection
	mi.fOfflineMode=aOfflineMode
	mi.fShowCenter=aShowCenter
	mi.fShowCenterLatLng=aShowCenterLatLng
	mi.fShowCompass=aShowCompass
	mi.fShowGrid=aShowGrid
	mi.fShowLandmark=aShowLandmark
	mi.fShowShapes=aShowShapes
	mi.fShowMenu=aShowMenu
	mi.fShowScale=aShowScale
	mi.fShowZoom=aShowZoom
	mi.fZoomLevel=aZoomLevel
	mi.fShapes=aShapes
	mi.fShowGPS=aShowGPS
	mi.fFollowGPS=aFollowGPS
	mi.fGPS=aGPS
	Return mi
End Sub

'Return a TMapPoint from X And Y
public Sub initPoint(aX As Int,aY As Int) As TMapPoint
	Dim p As TMapPoint
	p.Initialize
	p.fX=aX
	p.fY=aY
	Return p
End Sub

'return a TTileXY from X and Y
public Sub initTileXY(aX As Long,aY As Long) As TMapTileXY
	Dim fTileXY As TMapTileXY
	fTileXY.Initialize
	fTileXY.fX=aX
	fTileXY.fY=aY
	Return fTileXY
End Sub

'return a clMapShapeCircle instance
public Sub instanceShapeCircle(acvMap As cvMap,aShape As TMapShapeCircle) As clMapShapeCircle
	Dim s As clMapShapeCircle
	s.Initialize(acvMap,aShape)
	Return s
End Sub

'return a clMapShapeLine instance
public Sub instanceShapeLine(acvMap As cvMap,aShape As TMapShapeLine) As clMapShapeLine
	Dim s As clMapShapeLine
	s.Initialize(acvMap,aShape)
	Return s
End Sub

'return a clMapShapePolygon instance
public Sub instanceShapePolygon(acvMap As cvMap,aShape As TMapShapePolygon) As clMapShapePolygon
	Dim s As clMapShapePolygon
	s.Initialize(acvMap,aShape)
	Return s
End Sub

'return a clMapShapeImage instance
public Sub instanceShapeImage(acvMap As cvMap,aShape As TMapShapeImage) As clMapShapeImage
	Dim s As clMapShapeImage
	s.Initialize(acvMap,aShape)
	Return s
End Sub

'return a TShapeCircle instance
public Sub initShapeCircle(aLatLng As TMapLatLng,aRadius As Double,aColor As Int,aFilled As Boolean,aStrokeWidth As Double,aData As Object) As TMapShapeCircle
	Dim s As TMapShapeCircle
	s.Initialize
	s.fLatLng=aLatLng
	s.fRadius=aRadius
	s.fColor=aColor
	s.fFilled=aFilled
	s.fStrokeWidth=aStrokeWidth
	s.fData=aData
	Return s
End Sub

'return a TShapeLine instance
public Sub initShapeLine(aLatLng1 As TMapLatLng,aLatLng2 As TMapLatLng,aColor As Int,aStrokeWidth As Double,aData As Object) As TMapShapeLine
	Dim s As TMapShapeLine
	s.Initialize
	s.fLatLng1=aLatLng1
	s.fLatLng2=aLatLng2
	s.fColor=aColor
	s.fStrokeWidth=aStrokeWidth
	s.fData=aData
	Return s
End Sub

'return a TShapePolygon instance
public Sub initShapePolygon(aLatLng As List,aColor As Int,aFilled As Boolean,aStrokeWidth As Double,aData As Object) As TMapShapePolygon
	Dim s As TMapShapePolygon
	s.Initialize
	s.fLatLng=aLatLng
	s.fColor=aColor
	s.fFilled=aFilled
	s.fStrokeWidth=aStrokeWidth
	s.fData=aData
	Return s
End Sub

'return a TShapeImage instance
public Sub initShapeImage(aLatLng As TMapLatLng,aBitmap As B4XBitmap,aRotation As Double,aData As Object) As TMapShapeImage
	Dim s As TMapShapeImage
	s.Initialize
	s.fLatLng=aLatLng
	s.fBitmap=aBitmap
	s.fRotation=aRotation
	s.fData=aData
	Return s
End Sub