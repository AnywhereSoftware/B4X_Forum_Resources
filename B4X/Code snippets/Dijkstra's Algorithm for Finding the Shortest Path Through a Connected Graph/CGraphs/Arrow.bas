B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private p As Point
	Private xui As XUI
	Private cv As B4XCanvas
End Sub

Public Sub Initialize(cv_ As B4XCanvas)
	p.Initialize(0, 0)
	cv = cv_
End Sub

Public Sub draw(X0 As Float, Y0 As Float, X1 As Float, Y1 As Float, specs As Map)
	draw2(X0, Y0, X1, Y1, 0, 100, specs)
End Sub

Public Sub draw2(X0 As Float, Y0 As Float, X1 As Float, Y1 As Float, fromPercent As Float, toPercent As Float, specs As Map)
	standardize(specs)							'protect code from inconsistent caseness
	Dim pt0 As Point = p.new(X0, Y0)
	Dim pt1 As Point = p.new(X1, Y1)
	Dim color As Int = specs.Get("color")
	Dim filled As Boolean = specs.Get("filled")
	Dim thickness As Float = specs.Get("thickness") * 1dip
	Dim color As Int = specs.Get("color")
	Dim tipW As Float = specs.Get("tipwidth") * 1dip
	Dim tipH As Float = specs.Get("tipheight") * 1dip
	Dim zeroPt, fromPt, toPt, savePt, rotatePt As Point
	Dim angle As Float = ATan2D(pt1.y - pt0.y, pt1.x - pt0.x)
	zeroPt = pt1.Subtract(pt0)
	fromPt = pt0.Add(p.MultBy(fromPercent / 100, zeroPt)) 		'starting point of line segment
	savePt = pt0.Add(p.MultBy(toPercent / 100, zeroPt))			'end point of line segment
	Dim stemLength As Float = savePt.distance(fromPt) - tipH			'stem is shorter because of arrow tip
	toPt = fromPt.Add(p.new(stemLength * CosD(angle), stemLength * SinD(angle)))
	Dim sequence(7) As Point											'the path will go through these points in sequence
	rotatePt = p.new(thickness * CosD(angle + 90) / 2, thickness * SinD(angle + 90) / 2)		'perpendicular line
	sequence(0) = fromPt.Add(rotatePt)
	sequence(1) = fromPt.Add(p.MultBy(-1, rotatePt))
	sequence(2) = toPt.Add(p.MultBy(-1, rotatePt))
	sequence(6) = toPt.Add(rotatePt)
	rotatePt = p.new(tipW * CosD(angle + 90) / 2, tipW * SinD(angle + 90) / 2)	'bigger	perpendicular line
	sequence(3) = toPt.Add(p.MultBy(-1, rotatePt))
	sequence(4) = savePt
	sequence(5) = toPt.Add(rotatePt)
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
		Dim p As Point = fromPt.middle(toPt)
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
	Dim pt1 As Point = p.new(X0, Y0).Add(p.new(radius * CosD(angle), radius * SinD(angle)))
	draw2(X0, Y0, pt1.X, pt1.Y, 0, 100, specs)
End Sub

Public Sub draw4(X0 As Float, Y0 As Float, radius As Float, angle As Float, specs As Map) As Point
	radius = radius * 1dip
	Dim p0 As Point = p.new(X0, Y0)
	Dim pt1 As Point = p0.Add(p.new(radius * CosD(angle), radius * SinD(angle)))
	draw2(pt1.X, pt1.Y, X0, Y0,  0, 100, specs)
	Return pt1.middle(p0)
End Sub

Private Sub drawDashes(p0 As Point, p1 As Point, color As Int)
	Dim d As Float = 4dip / p0.distance(p1)
	Dim zeroPt As Point = p1.Subtract(p0)
	Dim multiplier As Float = .04
	For i = 2 To 24 Step 2
		Dim pA As Point = p0.Add(p.MultBy(multiplier, zeroPt))
		Dim pB As Point= p0.Add(p.MultBy(multiplier + d, zeroPt))
		cv.DrawLine(pA.X, pA.Y, pB.X, pB.Y, color, 3dip)
		multiplier = multiplier + .08
	Next
End Sub

Private Sub standardize(specs As Map)
	For Each kw As String In specs.keys
		specs.Put(kw.toLowerCase, specs.Get(kw))	'both original and lower case are indexed
	Next
End Sub
