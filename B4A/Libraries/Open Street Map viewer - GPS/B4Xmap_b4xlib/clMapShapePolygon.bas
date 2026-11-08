B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.6
@EndOfDesignText@
Sub Class_Globals
	Type TMapShapePolygon(fLatLng As List,fColor As Int,fFilled As Boolean,fStrokeWidth As Double,fData As Object)
	Private fcvMap As cvMap
	Private fShape As TMapShapePolygon
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(aCVMap As cvMap,aShape As TMapShapePolygon)
	fcvMap=aCVMap
	fShape=aShape
End Sub

'draw the shape
public Sub draw
	Dim p As B4XPath
	Dim pt As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng.Get(0))
	p.Initialize(pt.fx,pt.fy)
	For i=1 To fShape.fLatLng.Size-1
		Dim pt As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng.Get(i))
		p.LineTo(pt.fx,pt.fy)
	Next
	Dim pt As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng.Get(0))
	p.LineTo(pt.fx,pt.fy)
	fcvMap.ShapeCanvas.DrawPath(p,fShape.fColor,fShape.fFilled,fShape.fStrokeWidth)
End Sub

'return true if point is in shape
public Sub PointInShape(aPoint As TMapPoint) As Boolean
	'https://wrf.ecse.rpi.edu/Research/Short_Notes/pnpoly.html
	Dim r As B4XRect=BoundingBox(fShape)
	If (aPoint.fX<r.left) Or (aPoint.fX>r.Right) Or (aPoint.fY<r.Top) Or (aPoint.fY>r.Bottom) Then
		Return False
	End If

	Dim inside As Boolean=False
	Dim i As Int
	Dim j As Int = fShape.fLatLng.size- 1
	For i=0 To fShape.fLatLng.Size-1
		Dim pti As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng.Get(i))
		Dim ptj As TMapPoint=fcvMap.LatLngToPoint(fShape.fLatLng.Get(j))
		If ((pti.fy > aPoint.fY) <> (ptj.fy > aPoint.fY)) And (aPoint.fX<(ptj.fX-pti.fX)*(aPoint.fY-pti.fY)/(ptj.fy-pti.fY)+pti.fX) Then
			inside=Not(inside)
		End If
		j=i
	Next
	Return inside
End Sub

'get shape
public Sub get_Shape As TMapShapePolygon
	Return fShape
End Sub

'set shape
Public Sub set_Shape(aShape As TMapShapePolygon)
	fShape=aShape
End Sub

'return shape type
public Sub getShape_Type As String
	Return "polygon"
End Sub

'return shape data
public Sub getShape_Data As Object
	Return fShape.fData
End Sub

public Sub BoundingBox(ashape As TMapShapePolygon) As B4XRect
	Dim r As B4XRect
	Dim p1 As TMapPoint=fcvMap.LatLngToPoint(coMapUtilities.initLatLng(coMapUtilities.cMinLat,coMapUtilities.cMinLng))
	Dim p2 As TMapPoint=fcvMap.LatLngToPoint(coMapUtilities.initLatLng(coMapUtilities.cMaxLat,coMapUtilities.cMaxLng))
	r.Initialize(p2.fX,p2.fy,p1.fX,p1.fy)
	For Each ll As TMapLatLng In ashape.fLatLng
		Dim pt As TMapPoint=fcvMap.LatLngToPoint(ll)
		If pt.fX<r.Left Then
			r.Left=pt.fx
		End If
		If pt.fy<r.top Then
			r.top=pt.fy
		End If
		If pt.fX>r.Right Then
			r.Right=pt.fx
		End If
		If pt.fy>r.Bottom Then
			r.Bottom=pt.fy
		End If
	Next
	Return r
End Sub

