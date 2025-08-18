B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	
	Private fx As JFX
		
	Type Point(x As Float, y As Float)
	
	Type curve(point1 As Point, point2 As Point, point3 As Point)
	
	Private curveTop(18), curveRight(18), curveBottom(18), curveLeft(18) As curve
	
	Private PuzzleShapeCoordinates() As Float
	
	Private PieceWidth, PieceHeight, PieceLeft, PieceTop As Float
	
	Private YhighestPoint, XhighestPoint As Float = 0
		
	Type PieceShapeData(PiecePath As B4XPath, SafeZoneRect As B4XRect, FullRect As B4XRect)
	
	Private shapeData As PieceShapeData
	
	Private overlapWidth As Float
End Sub

'Call "CreatePieceShape" after initializing to draw jigsaw shape on piece(view)
Public Sub Initialize
	PuzzleShapeCoordinates = Array As Float(20, 20, 23, 19, 26, 19, 29, 19, 31, 19.5, 35, 20, 37, 20, 40, 20, 43, 19, 45, 18, 45, 16, 45, 14, 44, 11, 42, 7, 42.5, 5, 43, 2, 45, 1, 47, 0, 50, 0 _
	,52, 0, 54, 1, 56, 2, 56.5, 5, 57, 7, 55, 11, 54, 14, 54, 16, 54, 18, 56, 19, 59, 20, 62, 20, 64, 20, 68, 19.5, 71, 19, 74, 19, 77, 19, 80, 20)	
End Sub

'Insets can only be 0, 1 and 2
'0 = Outer inset
'1 = Flat inset
'2 = Inner inset
Sub CreatePieceShape(piece_top As Float, piece_left As Float, piece_width As Float, piece_height As Float, safe_Zone_Width As Float, topInset As Int, rightInset As Int, bottomInset As Int, leftInset As Int) As PieceShapeData	
	'Prepare canvas and coordinates
	shapeData.Initialize

	overlapWidth = safe_Zone_Width
	PieceWidth = piece_width
	PieceHeight = piece_height
	PieceLeft = piece_left
	PieceTop = piece_top
	
	CalculateCoordinatePositions(topInset, rightInset, bottomInset, leftInset)
	
	'Draw jigsaw shape based on piece size parameters	
	shapeData.PiecePath = DrawJigsawPiece
	
	'Draw safe zone border if allowed
	shapeData.SafeZoneRect = GetSafeZone
	
	'Draw full rect
	shapeData.FullRect = GetFullRect
	
	Return shapeData
End Sub

Private Sub FindHighestYpoint
	For i = 1 To PuzzleShapeCoordinates.Length - 1 Step 2
		Dim y As Float = PieceTop + ((PuzzleShapeCoordinates(i)/100) * PieceHeight)
		
		If y > YhighestPoint Then
			YhighestPoint = y
		End If

		If y > YhighestPoint Then
			YhighestPoint = y
		End If
		
		If y > YhighestPoint Then
			YhighestPoint = y
		End If
	Next
End Sub

Private Sub FindHighestXpoint
	For i = 0 To PuzzleShapeCoordinates.Length - 1 Step 2
		Dim x As Float = PieceTop + ((PuzzleShapeCoordinates(i)/100) * PieceHeight)
		
		If x > XhighestPoint Then
			XhighestPoint = x
		End If

		If x > XhighestPoint Then
			XhighestPoint = x
		End If
		
		If x > XhighestPoint Then
			XhighestPoint = x
		End If
	Next
End Sub

Private Sub CalculateCoordinatePositions(Top As Int, Right As Int, Bottom As Int, Left As Int)

	FindHighestYpoint : FindHighestXpoint	
	
	'////Draw TOP
	Dim i As Int = 0
	For Each c As curve In curveTop
		c.point1 = CalculatePositionTop(PuzzleShapeCoordinates(i * 4 + 0), PuzzleShapeCoordinates(i * 4 + 1), Top)
		c.point2 = CalculatePositionTop(PuzzleShapeCoordinates(i * 4 + 2), PuzzleShapeCoordinates(i * 4 + 3), Top)
		c.point3 = CalculatePositionTop(PuzzleShapeCoordinates(i * 4 + 4), PuzzleShapeCoordinates(i * 4 + 5), Top)
		i = i + 1
	Next
	
	'////Draw RIGHT
	Dim i As Int = 0
	For Each c As curve In curveRight
		c.point1 = CalculatePositionRight(PuzzleShapeCoordinates(i * 4 + 1), PuzzleShapeCoordinates(i * 4 + 0), Right)
		c.point2 = CalculatePositionRight(PuzzleShapeCoordinates(i * 4 + 3), PuzzleShapeCoordinates(i * 4 + 2), Right)
		c.point3 = CalculatePositionRight(PuzzleShapeCoordinates(i * 4 + 5), PuzzleShapeCoordinates(i * 4 + 4), Right)
		i = i + 1
	Next
	
	'////Draw BOTTOM
	Dim i As Int = curveBottom.Length - 1
	For Each c As curve In curveBottom
		c.point1 = CalculatePositionBottom(PuzzleShapeCoordinates(i * 4 + 4), PuzzleShapeCoordinates(i * 4 + 5), Bottom)
		c.point2 = CalculatePositionBottom(PuzzleShapeCoordinates(i * 4 + 2), PuzzleShapeCoordinates(i * 4 + 3), Bottom)
		c.point3 = CalculatePositionBottom(PuzzleShapeCoordinates(i * 4 + 0), PuzzleShapeCoordinates(i * 4 + 1), Bottom)
		i = i - 1
	Next
	
	'////Draw LEFT
	Dim i As Int = curveLeft.Length - 1
	For Each c As curve In curveLeft
		c.point1 = CalculatePositionLeft(PuzzleShapeCoordinates(i * 4 + 5), PuzzleShapeCoordinates(i * 4 + 4), Left)
		c.point2 = CalculatePositionLeft(PuzzleShapeCoordinates(i * 4 + 3), PuzzleShapeCoordinates(i * 4 + 2), Left)
		c.point3 = CalculatePositionLeft(PuzzleShapeCoordinates(i * 4 + 1), PuzzleShapeCoordinates(i * 4 + 0), Left)
		i = i - 1
	Next
End Sub

Private Sub CalculatePositionTop(xPercent As Float, yPercent As Float, yMultiplier As Float) As Point
	Private CalculatedPoint As Point
	CalculatedPoint.Initialize
	
	CalculatedPoint.x = PieceLeft + ((xPercent/100) * PieceWidth)
	CalculatedPoint.y = PieceTop + ((yPercent/100) * PieceHeight) + (YhighestPoint - (PieceTop + ((yPercent/100) * PieceHeight))) * yMultiplier
	
	Return CalculatedPoint
End Sub

Private Sub CalculatePositionBottom(xPercent As Float, yPercent As Float, yMultiplier As Float) As Point
	Private CalculatedPoint As Point
	CalculatedPoint.Initialize
	
	CalculatedPoint.x = PieceLeft + ((xPercent/100) * PieceWidth)
	CalculatedPoint.y = PieceHeight + PieceTop - ((yPercent/100) * PieceHeight) - (YhighestPoint - (PieceTop + ((yPercent/100) * PieceHeight))) * yMultiplier
	
	Return CalculatedPoint
End Sub

Private Sub CalculatePositionRight(xPercent As Float, yPercent As Float, xMultiplier As Float) As Point
	Private CalculatedPoint As Point
	CalculatedPoint.Initialize
	
	CalculatedPoint.x = PieceWidth + PieceLeft - ((xPercent/100) * PieceWidth) - (YhighestPoint - ((xPercent/100) * PieceWidth)) * xMultiplier
	CalculatedPoint.y = PieceTop + ((yPercent/100) * PieceHeight)
	
	Return CalculatedPoint
End Sub

Private Sub CalculatePositionLeft(xPercent As Float, yPercent As Float, xMultiplier As Float) As Point
	Private CalculatedPoint As Point
	CalculatedPoint.Initialize
	
	CalculatedPoint.x = PieceLeft + ((xPercent/100) * PieceWidth) + (YhighestPoint - ((xPercent/100) * PieceWidth)) * xMultiplier
	CalculatedPoint.y = PieceTop + ((yPercent/100) * PieceHeight)
	
	Return CalculatedPoint
End Sub

Private Sub DrawJigsawPiece As B4XPath
	'Initialize jigsaw path
	Dim path As B4XPath
	path.Initialize(curveTop(0).point1.x, curveTop(0).point1.y) 'Set starting point as first coordinate of first curve
				
	Dim t As Float
	
	For Each c As curve In curveTop
		For t = 0.01 To 1 Step 0.01
			Dim pFinal As Point = QuadraticBezierPoint(c.point1, c.point2, c.point3, t)
			path.LineTo(pFinal.x, pFinal.y)
		Next
	Next
	'--------------------------------------------
	For Each c As curve In curveRight
		For t = 0.01 To 1 Step 0.01
			Dim pFinal As Point = QuadraticBezierPoint(c.point1, c.point2, c.point3, t)
			path.LineTo(pFinal.x, pFinal.y)
		Next
	Next
	'--------------------------------------------
	For Each c As curve In curveBottom
		For t = 0.01 To 1 Step 0.01
			Dim pFinal As Point = QuadraticBezierPoint(c.point1, c.point2, c.point3, t)
			path.LineTo(pFinal.x, pFinal.y)
		Next
	Next
	'--------------------------------------------
	For Each c As curve In curveLeft
		For t = 0.01 To 1 Step 0.01
			Dim pFinal As Point = QuadraticBezierPoint(c.point1, c.point2, c.point3, t)
			path.LineTo(pFinal.x, pFinal.y)
		Next
	Next
	'--------------------------------------------
	
	Return path
End Sub

Private Sub GetSafeZone As B4XRect
	Dim r As B4XRect
	r.Initialize(0 + overlapWidth, 0 + overlapWidth, PieceWidth - overlapWidth, PieceHeight - overlapWidth)

	Return r
End Sub

Private Sub GetFullRect As B4XRect
	Dim r As B4XRect
	r.Initialize(0, 0, PieceWidth, PieceHeight)
	Return r
End Sub

Private Sub QuadraticBezierPoint(p0 As Point, p1 As Point, p2 As Point, t As Float) As Point
	Dim pFinal As Point
	pFinal.Initialize
	
	pFinal.x = Power(1 - t, 2) * p0.x + (1 - t) * 2 * t * p1.x + t * t * p2.x
	pFinal.y = Power(1 - t, 2) * p0.y + (1 - t) * 2 * t * p1.y + t * t * p2.y
	
	Return pFinal
End Sub