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

'INSTRUCTIONS: 
'1. Click anywhere on outer panel to add a point - more than one point will result in a line with its length in units (center of line)
'2. The X and Y of the point will be shown in blue - X is units from left of the grid, and Y is units from bottom of grid)
'3. When two or more lines are visible the smallest angle between (in degrees) will be shown below the intersection
'4. Drag any point to see the changing numbers
'5. The "X" above the grid clears the trail and starts with an empty grid
'6. Mouse down and up without significant movement removes a point from the trail - confirmation asked - redo not implemented


Sub Class_Globals
	Type Point(X As Float, Y As Float)			'these two types make life simpler - see subs NewPoint and NewLine
	Type Line(A As Point, B As Point)
	
	Private Root As B4XView
	Private xui As XUI
	
	Private trail As List						'keeps track of acrive points - X above grid clears this
	
	Private outerPanel, innerPanel, touchPanel As B4XView  	'ignore outerpanel is slightly bigger than inner panel to ease point selction and other things
	Private outerRect, innerRect As B4XRect		'object to hold dimensions

	Private gridCV, markerCV As B4XCanvas		'two canvases: 1 to show the grid and on top one to show the points and lines

	Private minWH As Float
	Private gridNCells As Float = 50			'grid is 50 by 50
	Private gridUnitSize As Float				'meaning of a cell size - could be any real world unit
	Private gridMargin As Float					'the difference between outer and inner
	
	Private pointIndex As Int					'index of dragging starting point (index in trail)
	
	Private hasMoved As Boolean					'some switches for dragging
	Private busy As Boolean
	Private ignoreMouse As Boolean
	Private mouseIsDown as boolean
	
	Private whiteOutW, whiteOutH, whiteOutYoffset As Float		'to creat a small white rectangle to hold x, y, and angle
	
	Private fnt As B4XFont	
	Private txtHeight, txtWidth As Float
End Sub

Public Sub Initialize
	gridNCells = 50		'number of cells per row and per column
	gridUnitSize = 2   	'2 meters or any other unit - therefore the whole grid is 100 meters (gridNCells * gridUnitSize)
	fnt = xui.CreateDefaultBoldFont(12)
	trail.Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	minWH = Min(Root.Height, Root.Width)

	gridMargin = 2.5 * minWH / (4 + gridNCells)
	outerRect.Initialize(Root.Width / 2 - minWH /2, Root.Height / 2 - minWH / 2, Root.Width / 2 + minWH /2, Root.Height / 2 + minWH / 2)
	innerRect.Initialize(outerRect.Left + gridMargin, outerRect.Top + gridMargin, outerRect.Left + outerRect.Width - gridMargin, outerRect.Top + outerRect.Height - gridMargin)
	
	innerPanel = AddPanel("", innerRect.left, innerRect.top, innerRect.width, innerRect.Height, 1)
	outerPanel = AddPanel("", outerRect.left, outerRect.top, outerRect.width, outerRect.Height, 1)
	touchPanel = AddPanel("touchPanel", outerRect.left, outerRect.top, outerRect.width, outerRect.Height, 0)
	
	gridCV.Initialize(innerPanel)
	markerCV.Initialize(outerPanel)
	
	AddLabel("clear", outerRect.Right - 40dip, innerRect.Top - 25dip, 25dip, 25dip, Chr(0xE14C), xui.CreateMaterialIcons(20), xui.Color_Blue)
	AddLabel("", outerRect.left + outerRect.Width / 2 - 100dip, innerRect.Top - 25dip, 200dip, 25dip, $"1 Cell width = $1.2{gridUnitSize} units"$, xui.CreateDefaultBoldFont(18), xui.Color_Blue)
		
	Dim metric As B4XRect = gridCV.MeasureText("100.0", fnt)
	txtHeight = metric.height
	txtWidth = metric.width

	whiteOutW = 1.2 * txtWidth / 2
	whiteOutH = 6.2 * txtHeight
	whiteOutYoffset = 1.5 * txtHeight
	
	DisplayGrid
End Sub

Private Sub AddPanel(eventName As String, xoffset As Float, yoffset As Float, width As Float, height As Float, borderWidth As Int) As B4XView
	Dim pnl As B4XView = xui.CreatePanel(eventName)
	pnl.SetColorAndBorder(xui.Color_Transparent, borderWidth, xui.Color_Black, 0)
	Root.AddView(pnl, xoffset, yoffset, width, height)
	Return pnl
End Sub

Private Sub AddLabel(eventName As String, xoffset As Float, yoffset As Float, width As Float, height As Float, text As String, font As B4XFont, textClr As Int) As B4XView
	Dim lbl As Label
	lbl.Initialize(eventName)
	Dim lblx As B4XView = lbl
	lblx.Text = text
	lblx.Font = font
	lblx.Textcolor = textClr
	Root.AddView(lblx, xoffset, yoffset, width, height)
	Return lblx
End Sub

Private Sub DisplayGrid
	Dim innerW As Float = innerRect.width
	Dim hw As Float = innerW / gridNCells
	Dim leftP, topP As Float
	For i = 1 To gridNCells
		Dim clr As Int = xui.Color_RGB(200, 200, 200)
		If i Mod 10 = 1 Then clr = xui.Color_Black
		gridCV.drawLine(leftP, 0, leftP, innerW, clr, 1dip)
		leftP = leftP + hw
	Next
	For i = 1 To gridNCells
		Dim clr As Int = xui.Color_RGB(200, 200, 200)
		If i Mod 10 = 1 Then clr = xui.Color_Black
		gridCV.drawLine(0, topP, innerW, topP, clr, 1dip)
		topP = topP + hw
	Next
	gridCV.invalidate
End Sub

'platform differences w.r.t. to event handlers
#if B4j
Private Sub touchPanel_MousePressed(ev As MouseEvent)
	MouseDown(NewPoint(ev.X, ev.Y))
End Sub 
Private Sub touchPanel_MouseDragged(ev As MouseEvent)
	MouseMoved(NewPoint(ev.X, ev.Y))
End Sub 
Private Sub touchPanel_MouseReleased(ev As MouseEvent)
	MouseUp(NewPoint(ev.X, ev.Y))
End Sub
Private Sub clear_mouseClicked(ev As MouseEvent)
	clearClicked
End Sub
#else if B4A
Sub touchPanel_Touch (Action As Int, X As Float, Y As Float)
	Select Action
		Case touchPanel.TOUCH_ACTION_DOWN: MouseDown(NewPoint(X, Y))
		Case touchPanel.TOUCH_ACTION_MOVE: MouseMoved(NewPoint(X, Y))
		Case touchPanel.TOUCH_ACTION_UP: MouseUp(NewPoint(X, Y))
	End Select
End Sub
Private Sub clear_Click
	clearClicked
End Sub
#End If

Private Sub MouseDown(pt As Point)
	pointIndex = IsInTrail(pt)
	If pointIndex = - 1 Then ignoreMouse = True Else ignoreMouse = False
	hasMoved = False
	mouseIsDown = True
End Sub

Private Sub MouseMoved(pt As Point)
	If ignoreMouse Then Return		'mouse down was on a empty area - no dragging allowed
	If busy Then Return				'mouse dragged handler was busy - try later
	Dim thisPoint As Point = pt
	hasMoved = True
	busy = True
	trail.Set(pointIndex, thisPoint)
	refreshTrail					'every mouse move will result in redrawing the markerCV completey
	busy = False
End Sub

Private Sub MouseUp(pt As Point)
	If Not(hasMoved) Then
		'limit points to the grid
		Dim x As Float = Max(innerRect.Left - outerRect.left, Min(pt.X, innerRect.Right - outerRect.Left))
		Dim y As Float = Max(innerRect.Top - outerRect.Top, Min(pt.Y, innerRect.Bottom - outerRect.Top))
		Dim p As Point = NewPoint(x, y)
		Dim index As Int = IsInTrail(p)
		If index = - 1 Then
			trail.Add(p)
		Else
			Dim sf As Object = xui.Msgbox2Async("Remove Point?", "Warning", "Yes", "", "No", Null)
			Wait For (sf) Msgbox_Result (Result As Int)
			If Result = xui.DialogResponse_Positive Then trail.removeAt(index)
		End If
	End If
	mouseIsDown = False
	refreshTrail						'every mouse up will result in redrawing the markerCV completey
End Sub

Private Sub IsInTrail(p As Point) As Int
	Dim closestDist As Float = 1 / 0
	Dim closestIndex As Int = -1
	For i = 0 To trail.Size - 1
		Dim pt As Point = trail.Get(i)
		Dim d As Float = distance(p, pt)
		If  d < closestDist Then
			closestDist = d
			closestIndex = i
		End If
	Next
	If closestDist > 25dip Then closestIndex = -1
	Return closestIndex
End Sub

'clears and redraws trail on markerCV
Private Sub refreshTrail
	Dim r As B4XRect
	r.Initialize(0, 0, outerRect.Width, outerRect.Height)
	markerCV.ClearRect(r)
	
	'Two passes, so that on the second pass annotations are shown on white patches on top of lines and points
	Dim lastP As Point
	Dim lastLine As Line
	For i = 0 To trail.Size - 1
		Dim pt As Point = trail.Get(i)
		markerCV.drawCircle(pt.X, pt.Y, 3dip, xui.Color_Blue, True, 1dip)
		If i > 0 Then
			If i = 1 Then
				lastLine = NewLine(NewPoint(lastP.X + 50, lastP.Y), NewPoint(lastP.X, lastP.Y))
				markerCV.drawLine(lastLine.A.X, lastLine.A.Y, lastLine.B.X, lastLine.B.Y, xui.Color_Black, 3dip)
			End If

			markerCV.drawLine(lastP.X, lastP.Y, pt.X, pt.Y, xui.Color_Blue, 1dip)
		End If
		lastP = NewPoint(pt.X, pt.Y)
	Next
	
	For i = 0 To trail.Size - 1
		Dim pt As Point = trail.Get(i)

		Dim posRect As B4XRect
		posRect.Initialize(pt.X - whiteOutW, pt.Y + whiteOutYoffset, pt.X + whiteOutW, pt.Y + whiteOutH)
		markerCV.drawRect(posRect, xui.Color_White, True, 0)
		
		Dim xpos As String = NumberFormat2(gridUnitSize * gridNCells * (toInner(pt.X) / innerRect.width), 1, 1, 1, False)
		Dim ypos As String = NumberFormat2(gridUnitSize * gridNCells * ((innerRect.Height - toInner(pt.Y)) / innerRect.width), 1, 1, 1, False)
		markerCV.drawText(xpos, posRect.centerX, posRect.centerY + 2dip, fnt, xui.Color_Blue, "CENTER")
		markerCV.drawText(ypos, posRect.centerX, posRect.centerY + 15dip, fnt, xui.Color_Blue, "CENTER")

		If i > 0 Then		'lines can only be drawn starting at the second point (index 1)
			Dim midp As Point = NewPoint((lastP.X + pt.X) / 2, (lastP.Y + pt.Y) / 2)
			markerCV.drawCircle(midp.X, midp.Y, 14dip, xui.Color_White, True, 0)
			Dim d As String = NumberFormat2(gridUnitSize * gridNCells * (distance(lastP, pt) / innerRect.width), 1, 1, 1, False)
			markerCV.drawText(d, midp.X, midp.Y + 5dip, fnt, xui.Color_Gray, "CENTER")
			If i = 1 Then
				lastLine = NewLine(NewPoint(lastP.X + 50dip, lastP.Y), NewPoint(lastP.X, lastP.Y))
				markerCV.drawLine(lastLine.A.X, lastLine.A.Y, lastLine.B.X, lastLine.B.Y, xui.Color_Black, 3dip)
			End If
			Dim thisLine As Line = NewLine(NewPoint(lastP.X, lastP.Y), NewPoint(pt.X, pt.Y))
			Dim angle As Float = angleBetween(lastLine, thisLine)
			Dim angleStr As String = NumberFormat2(Abs(angle), 1, 1, 1, False)
			markerCV.drawText(angleStr, lastP.X, lastP.Y + whiteOutYoffset + 1.1 * txtHeight, xui.CreateDefaultBoldFont(12), xui.Color_RGB(220, 20, 16), "CENTER")
			lastLine = thisLine
		End If
		lastP = NewPoint(pt.X, pt.Y)
	Next
	If mouseIsDown And pointIndex > -1 Then
		Dim activePoint As Point = trail.Get(pointIndex)
		markerCV.DrawCircle(activePoint.X, activePoint.Y, 30dip, xui.color_Green, False, 1dip)
	End If
	markerCV.invalidate
End Sub

'to correct for smaller grid
Private Sub toInner(x As Float) As Float
	Return x - gridMargin
End Sub

Private Sub distance(pt0 As Point, pt1 As Point) As Float
	Dim difx As Float = pt0.X - pt1.X
	Dim dify As Float = pt0.Y - pt1.Y
	Dim d As Float = Sqrt((difx * difx) + (dify * dify))
	Return d
End Sub

Private Sub clearClicked
	trail.Clear
	refreshTrail
End Sub

'basic trigonometry
Private Sub angleBetween(line1 As Line, line2 As Line) As Float
	Dim a1 As Float = ATan2D(line1.A.Y - line1.B.Y, line1.B.X - line1.A.X)
	Dim a2 As Float = ATan2D(line2.A.Y - line2.B.Y, line2.B.X - line2.A.X)
	Dim difa1 As Float = Abs(a1 - a2)
	If difa1 > 180 Then difa1 = 360 - difa1
	difa1 = 180 - difa1
	Return difa1
End Sub

'helper subs
Public Sub NewPoint (X As Float, Y As Float) As Point
	Dim t1 As Point
	t1.Initialize
	t1.X = X
	t1.Y = Y
	Return t1
End Sub

Public Sub NewLine (A As Point, B As Point) As Line
	Dim t1 As Line
	t1.Initialize
	t1.A = A
	t1.B = B
	Return t1
End Sub