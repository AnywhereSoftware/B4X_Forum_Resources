B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.6
@EndOfDesignText@
Sub Class_Globals
	Type TMapShapeLine(fLatLng1 As TMapLatLng,fLatLng2 As TMapLatLng,fColor As Int,fStrokeWidth As Double,fData As Object)
	Private fcvMap As cvMap
	Private fShape As TMapShapeLine
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(aCVMap As cvMap,aShape As TMapShapeLine)
	fcvMap=aCVMap
	fShape=aShape
End Sub

'draw the shape
public Sub draw
	Dim p1 As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng1)
	Dim p2 As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng2)
	fcvMap.ShapeCanvas.DrawLine(p1.fX,p1.fY,p2.fx,p2.fy,fShape.fColor,fShape.fStrokeWidth)
End Sub

'return true if point is in shape
public Sub PointInShape(aPoint As TMapPoint) As Boolean
	Dim p1 As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng1)
	Dim p2 As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng2)
	Dim dS As Double=coMapUtilities.distanceBetween2Points(p1,aPoint)
	Dim dE As Double=coMapUtilities.distanceBetween2Points(p2,aPoint)
	Dim d As Double=coMapUtilities.distanceBetween2Points(p1,p2)
	Return Round2(dS+dE,0)=Round2(d,0)
End Sub

'get shape
public Sub get_Shape As TMapShapeLine
	Return fShape
End Sub

'set shape
Public Sub set_Shape(aShape As TMapShapeLine)
	fShape=aShape
End Sub

'return shape type
public Sub getShape_Type As String
	Return "line"
End Sub

'return shape data
public Sub getShape_Data As object
	Return fShape.fData
End Sub
