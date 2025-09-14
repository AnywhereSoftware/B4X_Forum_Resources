B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.6
@EndOfDesignText@
Sub Class_Globals
	Type TMapShapeCircle(fLatLng As TMapLatLng,fRadius As Double,fColor As Int,fFilled As Boolean,fStrokeWidth As Double,fData As Object)
	Private fcvMap As cvMap
	Private fShape As TMapShapeCircle
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(aCVMap As cvMap,aShape As TMapShapeCircle)
	fcvMap=aCVMap
	fShape=aShape	
End Sub

'draw the shape
public Sub draw
	Dim p As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng)
	fcvMap.shapeCanvas.DrawCircle(p.fX,p.fY,fShape.fRadius,fShape.fColor,fShape.fFilled,fShape.fStrokeWidth)
End Sub

'return true if point is in shape
public Sub PointInShape(aPoint As TMapPoint) As Boolean
	Dim c As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng)
	Return coMapUtilities.distanceBetween2Points(c,aPoint)<=fShape.fRadius
End Sub

'get shape
public Sub get_Shape As TMapShapeCircle
	Return fShape
End Sub

'set shape
Public Sub set_Shape(aShape As TMapShapeCircle)
	fShape=aShape
End Sub

'return shape type
public Sub getShape_Type As String
	Return "circle"
End Sub

'return shape data
public Sub getShape_Data As object
	Return fShape.fData
End Sub
