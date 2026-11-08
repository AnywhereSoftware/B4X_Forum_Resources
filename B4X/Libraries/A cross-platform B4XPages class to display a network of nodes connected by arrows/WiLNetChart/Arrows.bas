B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Type point(X As Float, Y As Float)	'without this, the code would be repetitive, susceptible to error, and 3 times as long
	Private xui As XUI
	Private cv As B4XCanvas
End Sub

Public Sub Initialize(cv_ As B4XCanvas)
	cv = cv_
End Sub

Public Sub draw(X0 As Float, Y0 As Float, X1 As Float, Y1 As Float, specs As Map)
	draw2(X0, Y0, X1, Y1, 0, 100, specs)
End Sub

Public Sub draw2(X0 As Float, Y0 As Float, X1 As Float, Y1 As Float, fromPercent As Float, toPercent As Float, specs As Map)
	standardize(specs)							'protect code from inconsistent caseness
	Dim pt0 As point = newPoint(X0, Y0)
	Dim pt1 As point = newPoint(X1, Y1)
	Dim color As Int = specs.Get("color")
	Dim filled As Boolean = specs.Get("filled")
	Dim thickness As Float = specs.Get("thickness") * 1dip
	Dim color As Int = specs.Get("color")
	Dim tipW As Float = specs.Get("tipwidth") * 1dip
	Dim tipH As Float = specs.Get("tipheight") * 1dip
	Dim zeroPt, fromPt, toPt, savePt, rotatePt As point
	Dim angle As Float = ATan2D(pt1.y - pt0.y, pt1.x - pt0.x)
	zeroPt = PntsSubtract(pt1, pt0)
	fromPt = PntsAdd(pt0, PntMultBy(fromPercent / 100, zeroPt)) 		'starting point of line segment
	savePt = PntsAdd(pt0, PntMultBy(toPercent / 100, zeroPt))			'end point of line segment
	Dim stemLength As Float = distance(savePt, fromPt) - tipH			'stem is shorter because of arrow tip
	toPt = PntsAdd(fromPt, newPoint(stemLength * CosD(angle), stemLength * SinD(angle)))
	Dim sequence(7) As point											'the path will go through these points in sequence
	rotatePt = newPoint(thickness * CosD(angle + 90) / 2, thickness * SinD(angle + 90) / 2)		'perpendicular line
	sequence(0) = PntsAdd(fromPt, rotatePt)
	sequence(1) = PntsAdd(fromPt, PntMultBy(-1, rotatePt))
	sequence(2) = PntsAdd(toPt, PntMultBy(-1, rotatePt))
	sequence(6) = PntsAdd(toPt, rotatePt)
	rotatePt = newPoint(tipW * CosD(angle + 90) / 2, tipW * SinD(angle + 90) / 2)	'bigger	perpendicular line
	sequence(3) = PntsAdd(toPt, PntMultBy(-1, rotatePt))
	sequence(4) = savePt
	sequence(5) = PntsAdd(toPt, rotatePt)
	Dim path As B4XPath
	path.Initialize(sequence(0).x, sequence(0).y)
	For i = 1 To 6
		path.lineTo(sequence(i).x, sequence(i).y)
	Next
	path.lineTo(sequence(0).x, sequence(0).y)
	cv.drawPath(path, color, filled, 1)
	If specs.ContainsKey("caption") Then
		Dim s As String = specs.Get("caption")
		Dim fnt As B4XFont
		Dim fntCol As Int
		If specs.ContainsKey("font") Then fnt = specs.Get("font") Else fnt = xui.CreateDefaultFont(.9 * thickness)
		If specs.ContainsKey("fontcolor") Then fntCol = specs.Get("fontcolor") Else fntCol = xui.Color_Black
		Dim p As point = midPoint(fromPt, toPt)
		Dim txtangle As Float = angle
		If angle < -90 Or angle > 90 Then txtangle = angle - 180		'caption reads from left to right in this case
		cv.DrawTextRotated(s, p.X, p.Y + thickness / 3, fnt, fntCol, "CENTER", txtangle)
	End If
	Dim dcolor As Int = specs.GetDefault("dashcolor", 0)
	If dcolor<>0 Then
		drawDashes(sequence(1), sequence(2), dcolor)
		drawDashes(sequence(0), sequence(6), dcolor)
	End If
	cv.Invalidate
End Sub

Public Sub draw3(X0 As Float, Y0 As Float, radius As Float, angle As Float, specs As Map)
	radius = radius * 1dip
	Dim pt1 As point = PntsAdd(newPoint(X0, Y0), newPoint(radius * CosD(angle), radius * SinD(angle)))
	draw2(X0, Y0, pt1.X, pt1.Y, 0, 100, specs)
End Sub

Private Sub drawDashes(p0 As point, p1 As point, color As Int)
	Dim d As Float = 4dip / distance(p0, p1)
	Dim zeroPt As point = PntsSubtract(p1, p0)
	Dim multiplier As Float = .04
	For i = 2 To 24 Step 2
		Dim pA As point = PntsAdd(p0, PntMultBy(multiplier, zeroPt))
		Dim pB As point= PntsAdd(p0, PntMultBy(multiplier + d, zeroPt))
		cv.DrawLine(pA.X, pA.Y, pB.X, pB.Y, color, 3dip)
		multiplier = multiplier + .08
	Next
End Sub

Private Sub standardize(specs As Map)
	For Each kw As String In specs.keys
		specs.Put(kw.toLowerCase, specs.Get(kw))	'both original and lower case are indexed
	Next
End Sub

Public Sub newPoint (X As Float, y As Float) As point
	Dim t1 As point: t1.Initialize
	t1.X = X: t1.y = y
	Return t1
End Sub

Public Sub PntsSubtract(p1 As point, p0 As point) As point
	Return newPoint(p1.X - p0.X, p1.y - p0.y)
End Sub

Public Sub PntMultBy(factor As Float, p As point) As point
	Return newPoint(factor * p.X, factor * p.y)
End Sub

Public Sub PntsAdd(p1 As point, p0 As point) As point
	Return newPoint(p1.X + p0.X, p1.y + p0.y)
End Sub

Public Sub distance(p1 As point, p0 As point) As Float
	Dim dx As Float = p1.X - p0.X
	Dim dy As Float = p1.Y - p0.Y
	Return Sqrt(dx * dx + dy * dy)
End Sub

Public Sub midPoint(p0 As point, p1 As point) As point
	Return newPoint((p0.X + p1.X) / 2, (p0.Y + p1.Y) / 2)
End Sub