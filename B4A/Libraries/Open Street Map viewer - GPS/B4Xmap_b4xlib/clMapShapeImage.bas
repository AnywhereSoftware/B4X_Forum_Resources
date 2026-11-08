B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.6
@EndOfDesignText@
Sub Class_Globals
	Type TMapShapeImage(fLatLng As TMapLatLng,fBitmap As B4XBitmap,fRotation As Double,fData As Object)
	Private fcvMap As cvMap
	Private fShape As TMapShapeImage
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(aCVMap As cvMap,aShape As TMapShapeImage)
	fcvMap=aCVMap
	fShape=aShape
End Sub

'draw the shape
public Sub draw
	Dim pt As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng)
	Dim r As B4XRect
	r.Initialize(pt.fX-fShape.fBitmap.Width/2,pt.fY-fShape.fBitmap.Height,pt.fX-fShape.fBitmap.Width/2+fShape.fBitmap.Width,pt.fY)
	fcvMap.ShapeCanvas.DrawBitmapRotated(fShape.fBitmap,r,fShape.fRotation)
End Sub

'return true if point is in shape
public Sub PointInShape(aPoint As TMapPoint) As Boolean
	Dim pt As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng)
	Dim r As B4XRect
	r.Initialize(pt.fX-fShape.fBitmap.Width/2,pt.fY-fShape.fBitmap.Height,pt.fX-fShape.fBitmap.Width/2+fShape.fBitmap.Width,pt.fY)
	Return coMapUtilities.PointInREct(aPoint,r)
End Sub

'get shape
public Sub get_Shape As TMapShapeImage
	Return fShape
End Sub

'set shape
Public Sub set_Shape(aShape As TMapShapeImage)
	fShape=aShape
End Sub

'return shape type
public Sub getShape_Type As String
	Return "image"
End Sub

'return shape data
public Sub getShape_Data As object
	Return fShape.fData
End Sub
