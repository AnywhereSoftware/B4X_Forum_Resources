B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Type myPoint (x As Float, y As Float)
	Type bezierSpec (p0 As myPoint, p1 As myPoint, p2 As myPoint, p3 As myPoint)
	Private fx As JFX
	Private Root As B4XView
	Private xui As XUI
	Private cv As B4XCanvas
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Dim w As Float = 300dip
	Dim h As Float = 400dip
	Dim basePanel As B4XView = xui.CreatePanel("")
	basePanel.SetColorAndBorder(xui.Color_Transparent, 1dip, xui.Color_Black, 10dip)
	Root.AddView(basePanel, Root.Width / 2 - w /2, Root.Height / 2 - h / 2, w, h)
	cv.Initialize(basePanel)
	
	Dim aw As Float = .5
	Dim ah As Float = -.7
	Dim p0 As myPoint = setP(0, 0)
	Dim p1 As myPoint = setP(aw * w, .05 * h)
	Dim p2 As myPoint = setP(ah * w, .95 * h)
	Dim p3 As myPoint = setP(w, h)
	Dim bz As bezierSpec = setSpec(p0, p1, p2, p3)
	
	Dim points As List = BuildBezierCurve(bz)
	TextOnCurve("The Time Has Come, the Walrus Said; to Speak of Many Things",	xui.CreateDefaultFont(16), 23dip, points)
	cv.Invalidate
	
'EXPLANATION
	'Bezier curves have two end points and two intermediate control points
	'To show control points of bezier curve make sure width and height >= 1000 (in example, p2 is not in the panel)
	'Also see how easy it would be to animate the curve and text by varying the control points in small increments
	'and redrawing the text
	Dim cv2 As B4XCanvas
	cv2.Initialize(Root)
	
	cv2.DrawCircle(basePanel.Left + p0.x, basePanel.top + p0.y, 5dip, xui.Color_Red, True, 0)
	cv2.DrawCircle(basePanel.Left + p1.x, basePanel.top + p1.y, 5dip, xui.Color_Red, True, 0)
	cv2.DrawCircle(basePanel.Left + p2.x, basePanel.top + p2.y, 5dip, xui.Color_Red, True, 0)
	cv2.DrawCircle(basePanel.Left + p3.x, basePanel.top + p3.y, 5dip, xui.Color_Red, True, 0)

	cv2.DrawText("p0", basePanel.Left + p0.x + 5dip, basePanel.top + p0.y, xui.CreateDefaultFont(15), xui.Color_Black, "LEFT")
	cv2.DrawText("p1", basePanel.Left + p1.x + 5dip, basePanel.top + p1.y, xui.CreateDefaultFont(15), xui.Color_Black, "LEFT")
	cv2.DrawText("p2", basePanel.Left + p2.x + 5dip, basePanel.top + p2.y, xui.CreateDefaultFont(15), xui.Color_Black, "LEFT")
	cv2.DrawText("p3", basePanel.Left + p3.x + 5dip, basePanel.top + p3.y, xui.CreateDefaultFont(15), xui.Color_Black, "LEFT")

	cv2.Invalidate
End Sub

Private Sub TextOnCurve(text As String, font As B4XFont, leadDistance As Float, Points As List)
	'Find the distance along the curve - to center the text and compute the lead distance for first character
	'Dim textWidth As Float = cv.MeasureText(text, font).width + (text.Length - 1) * 5dip  ' increased spacing
	Dim lastPoint As myPoint = copyP(Points.Get(0))
	Dim totalDistance As Float
	For j = 1 To Points.Size - 1
		Dim thisPoint As myPoint = Points.Get(j)
		Dim distance As Float = Sqrt((thisPoint.x - lastPoint.x) * (thisPoint.x - lastPoint.x) + (thisPoint.y - lastPoint.y) * (thisPoint.y - lastPoint.y))
		totalDistance = totalDistance + distance
		lastPoint = copyP(thisPoint)
	Next
	
	'Loop through the points, keep track of the curve distance, when it exceeds the lead plus drawn text, draw another character
	Dim accumDistance As Float
	Dim cursor As Int = 0
	lastPoint = copyP(Points.Get(0))
	For j = 1 To Points.Size - 1
		Dim thisPoint As myPoint = Points.Get(j)
		Dim distance As Float = Sqrt((thisPoint.x - lastPoint.x) * (thisPoint.x - lastPoint.x) + (thisPoint.y - lastPoint.y) * (thisPoint.y - lastPoint.y))
		If leadDistance < accumDistance And leadDistance < totalDistance And cursor < text.length Then
			Dim dif As Float = (distance - (accumDistance - leadDistance)) / distance
			Dim leadPoint As myPoint = setP(lastPoint.x + dif * (thisPoint.x - lastPoint.x), lastPoint.y + dif * (thisPoint.y - lastPoint.y))
			Dim angle As Float = ATan2D(leadPoint.y - lastPoint.y, leadPoint.x - lastPoint.x)
			If angle < 0 Then angle = 180 + angle
			cv.DrawTextRotated(text.charAt(cursor), leadPoint.x, leadPoint.y, font, xui.Color_Blue, "LEFT", angle)
			Dim charWidth As Float = 3dip + cv.MeasureText(text.charAt(cursor), font).width
			leadDistance = leadDistance + charWidth
			cursor = cursor + 1
		End If
		accumDistance = accumDistance + distance
		lastPoint = copyP(thisPoint)
	Next
End Sub

Private Sub BuildBezierCurve(bz As bezierSpec) As List
	Dim dt As Float
	Dim endP As myPoint
	Private pointList As List
	pointList.Initialize
	pointList.Add(setP(bz.p0.x, bz.p0.y))
	For dt = .01 To 1 Step .01				'creates 100 points along the curve (not equal distance apart)
		endP = bezierNextPoint(bz, dt)
		pointList.Add(setP(endP.x, endP.y))
	Next
	Return pointList
End Sub

Sub setP(x As Float, y As Float) As myPoint
	Dim p As myPoint: p.x = x: p.y = y
	Return p
End Sub

Sub copyP(orig As myPoint) As myPoint
	Dim p As myPoint: p.x = orig.x: p.y = orig.y
	Return p
End Sub

Sub setSpec(p0 As myPoint, p1 As myPoint, p2 As myPoint, p3 As myPoint) As bezierSpec
	Dim b As bezierSpec: b.p0 = copyP(p0): b.p1 = copyP(p1): b.p2 = copyP(p2): b.p3 = copyP(p3)
	Return b
End Sub

Sub bezierNextPoint(bz As bezierSpec, dt As Float) As myPoint
	Dim p0 As myPoint = bz.p0
	Dim p1 As myPoint = bz.p1
	Dim p2 As myPoint = bz.p2
	Dim p3 As myPoint = bz.p3
	Dim a, b, c, r As myPoint
	c = setP(3 * (p1.x - p0.x), 3 * (p1.y - p0.y))
	b = setP(3 * (p2.x - p1.x) - c.x, 3 * (p2.y - p1.y) - c.y)
	a = setP(p3.x - p0.x - c.x - b.x, p3.y - p0.y - c.y - b.y)
	r.x = (a.x * Power(dt, 3)) + (b.x * Power(dt, 2)) + (c.x * dt) + p0.x
	r.y = (a.y * Power(dt, 3)) + (b.y * Power(dt, 2)) + (c.y * dt) + p0.y
	Return r
End Sub