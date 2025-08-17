B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'To keep things simple, this XY plot has fixed choices of dimensions, text size, and alignment
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private cv As B4XCanvas
	Private cvRect As B4XRect
	Private bounds() As Float
	
	'Colors are set to defaults in Initialize
	Public canvasColor, frameColor, pointColor, titleColor, subtitleColor, XAxisColor, YAxisColor, lineColor As Int
End Sub

'Initializes the instance of this B4XPages Class - no arguments needed. Colors are Public and can be changed
Public Sub Initialize As Object
	canvasColor = xui.Color_RGB(220, 220, 255)
	frameColor = xui.Color_Black
	pointColor = xui.Color_Black
	titleColor = xui.Color_Black
	subtitleColor = xui.Color_Black
	XAxisColor = xui.Color_Black
	YAxisColor = xui.Color_Black
	lineColor = xui.Color_Blue
	Return Me
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Dim pnl As B4XView = xui.CreatePanel("")
	Root.AddView(pnl, Root.Width / 2 - Root.Height / 2, 0, Root.Height,  Root.Height)
	cv.Initialize(pnl)
	cvRect.Initialize(0, 0, Root.Height, Root.Height)
	B4XPages.SetTitle(Me, "Simple Plot")
End Sub

'Draws the square frame, axis and a tranformed version of data points scaled to fit the frame 
Public Sub drawXY (xData As String, yData As String)
	cv.ClearRect(cvRect)
	Dim r As B4XRect
	r.initialize(50, 50, cvRect.Right - 50, cvRect.Bottom - 50)
	cv.DrawRect(r, canvasColor, True, 0)
	cv.DrawRect(r, frameColor, False, 1)
	Dim v0() As String = Regex.Split("\,", xData)
	Dim v1() As String = Regex.Split("\,", yData)
	Dim x(v0.Length) As Float
	Dim y(v1.Length) As Float
	Dim minx, maxx, miny, maxy As Float
	maxx = - 1 /0: minx =  1 /0: maxy = - 1 /0: miny =  1 /0
	For i = 0 To v0.Length - 1
		x(i) = v0(i)
		y(i) = v1(i)
		If x(i) > maxx Then maxx = x(i)
		If x(i) < minx Then minx = x(i)
		If y(i) > maxy Then maxy = y(i)
		If y(i) < miny Then miny = y(i)
	Next
	For i = 0 To v0.Length - 1
		x(i) = 60 + ((x(i) - minx) / (maxx - minx)) * (cvRect.Width - 120)
		y(i) = (cvRect.bottom - 60) - ((y(i) - miny) / (maxy - miny)) * (cvRect.height - 120)
	Next
	For i = 0 To v0.Length - 1
		cv.DrawCircle(x(i), y(i), 4, pointColor, True, 0)
	Next
	Dim fnt As B4XFont = xui.CreateDefaultBoldFont(15)
	Dim h As Float = cv.MeasureText("X", fnt).Height
	cv.DrawText(miny, 45, (cvRect.bottom - 60) + h /2, fnt, frameColor, "RIGHT")
	cv.DrawText(maxy, 45, 60 + h /2, fnt, frameColor, "RIGHT")
	cv.DrawLine(47, (cvRect.bottom - 60), 53, (cvRect.bottom - 60), frameColor, 2)
	cv.DrawLine(47, 60, 53, 60, frameColor, 2)

	cv.DrawText(minx, 60, (cvRect.bottom - 50) + 2 * h, fnt, frameColor, "CENTER")
	cv.DrawText(maxx, cvRect.right - 60, (cvRect.bottom - 50) + 2 * h, fnt, frameColor, "CENTER")
	cv.DrawLine(60, (cvRect.bottom - 50) - 3, 60, (cvRect.bottom - 50) + 3, frameColor, 2)
	cv.DrawLine(cvRect.right - 60, (cvRect.bottom - 50) - 3, cvRect.right - 60, (cvRect.bottom - 50) + 3, frameColor, 2)
	bounds = Array As Float(minx, maxx, miny, maxy)
End Sub

'Draws the regression line based on intercept and slope
Public Sub drawRegression(intercept As Float, slope As Float)
	Dim minx, maxx, miny, maxy As Float
	minx = bounds(0): maxx = bounds(1): miny = bounds(2): maxy = bounds(3)
	Dim yAtminx As Float = intercept + slope * minx
	Dim yAtmaxx As Float = intercept + slope * maxx
	Dim xAtminy As Float = (miny - intercept) / slope
	Dim xAtmaxy As Float = (maxy - intercept) / slope
	Dim p(2, 2) As Float
	If yAtminx >= miny And yAtminx <= maxy Then
		p(0, 0) = minx: p(0, 1) = yAtminx
	Else
		p(0, 0) = maxx: p(0, 1) = yAtmaxx
	End If
	If xAtminy >= minx And xAtminy <= maxx Then
		p(1, 0) = xAtminy: p(1, 1) = miny
	Else
		p(1, 0) = xAtmaxy: p(1, 1) = maxy
	End If
	For i = 0 To 1
		p(i, 0) = 60 + ((p(i, 0) - minx) / (maxx - minx)) * (cvRect.Width - 120)
		p(i, 1) = (cvRect.bottom - 60) - ((p(i, 1) - miny) / (maxy - miny)) * (cvRect.height - 120)
	Next
	cv.DrawLine(p(0, 0), p(0, 1), p(1, 0), p(1, 1), lineColor, 2)
End Sub

'Adds a title - to keep things simple, this plot has fixed choices for text size
Public Sub addTitle(s As String)
	cv.DrawText(s, cvRect.CenterX, 25, xui.CreateDefaultBoldFont(18), titleColor, "CENTER")
End Sub

'Adds a subtitle - to keep things simple, this plot has fixed choices for text size
Public Sub addSubTitle(s As String)
	cv.DrawText(s, cvRect.CenterX, 42, xui.CreateDefaultFont(14), subtitleColor, "CENTER")
End Sub

'Adds a Y label - to keep things simple, this plot has fixed choices for text size and alignment
Public Sub addYLabel(s As String)
	cv.DrawTextRotated(s, 38, cvRect.CenterY, xui.CreateDefaultBoldFont(15), YAxisColor, "CENTER", -90)
End Sub

'Adds a X label - to keep things simple, this plot has fixed choices for text size and alignment
Public Sub addXLabel(s As String)
	cv.DrawText(s, cvRect.CenterX, cvRect.Bottom - 23, xui.CreateDefaultBoldFont(15), XAxisColor, "CENTER")
End Sub