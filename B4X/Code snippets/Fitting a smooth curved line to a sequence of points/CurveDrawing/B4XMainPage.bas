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
	Type Point(x As Float, y As Float)
	Private Root As B4XView
	Private xui As XUI

	Private original As B4XBitmap
	Private stage As B4XRect
	Private drawLayer As B4XView
	Private CVRect As B4XRect
	
	Private CV As B4XCanvas
	Private	recording As List
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	CV.Initialize(Root)
	CVRect.Initialize(0, 0, Root.Width, Root.height)
	Dim w As Float = Min(Root.Width, Root.Height)
	stage.Initialize(.15 * Root.Width, - 150, 1.3 * w, w - 150)
	original = xui.LoadBitmap(File.DirAssets, "mouse.jpg")
	CV.DrawBitmap(original, stage)
	drawLayer = xui.CreatePanel("drawing")
	Root.AddView(drawLayer, 0, 0, Root.Width, Root.Height)
	recording.Initialize
	SampledPoints		'for the demo this was done by hand using the drawLayer and saved - I wanted to do it just once
	Log(recording.size)	'64 points were sampled on the original when it was 150 pixels lower - I shifted it up to show both figures
	For Each p As Point In recording
		CV.DrawCircle(p.X, p.Y - 150, 5, xui.Color_Blue, False, 1)
	Next
	displaySmoothData(recording, 4, 4, 150)
End Sub

Private Sub drawing_MouseClicked(Ev As MouseEvent)
	If Ev.X > Root.Width - 50 And Ev.Y > Root.Height - 50 Then 
		CV.ClearRect(CVRect)
		For Each p As Point In recording
			CV.DrawCircle(p.X, p.Y, 5, xui.Color_Blue, True, 0)
			Log(Floor(p.x) & TAB & Floor(p.y))
		Next
		displaySmoothData(recording, 4, 4, 0)
		Return
	End If
	CV.DrawCircle(Ev.X, Ev.Y, 5, xui.Color_Blue, True, 0)
	recording.Add(newPoint(Ev.X, Ev.Y))
End Sub

Private Sub displaySmoothData(points As List, smoothness As Int, roundness As Int, yoffset As Float)
	Dim thisData As List = copyPointList(points)
	For Each p As Point In thisData
		p.x = p.x
		p.y = p.y + yoffset
	Next
	Dim smoothPath As List = smooth(thisData, smoothness, roundness)
	Dim lastPoint As Point = smoothPath.Get(0)
	For i = 1 To smoothPath.Size - 1
		Dim p As Point = smoothPath.Get(i)
		CV.DrawLine(lastPoint.x, lastPoint.y, p.x, p.y, xui.color_Blue, 3)
		lastPoint = p
	Next
	Dim text As String = "Smoothness = " & smoothness & "  Roundness = " & roundness & "  #Points = " & smoothPath.Size
	CV.drawText(text, 200, yoffset + 170, xui.CreateDefaultFont(15), xui.color_Black, "LEFT")
End Sub

Public Sub smooth(OrigPoints As List, smoothness As Int, roundness As Int) As List
	Dim Points As List = copyPointList(OrigPoints)
	If Points.Size < 3 Then Return Points
	Dim roundnessFactor As Float = .3 * roundness / 5
	Dim closed As Boolean = False
	Dim firstPoint As Point = Points.Get(0)
	If distance(firstPoint, Points.Get(Points.Size-1)) < .01 Then closed = True
	Dim p0, p1, p2 As Point
	p0 = Points.Get(Points.Size-1)
	If p0.x < 0 Then Points.RemoveAt(Points.Size-1)
	For m = 0 To (smoothness - 1)
		Dim p As Point = Points.Get(0)
		If closed Then Points.add(PntsCopy(p))
		p0 = Points.Get(0)
		p1 = Points.Get(1)
		Dim k As Int = 2
		Do While k < Points.Size
			p2 = Points.Get(k)
			Points.Set(k-1, partPoint(p0, p1, 1 - roundnessFactor))
			Points.insertAt(k, partPoint(p1, p2, roundnessFactor))
			p0 = PntsCopy(p1)
			p1 = PntsCopy(p2)
			k = k + 2
		Loop
		If closed Then
			Points.RemoveAt(0)
			Dim p As Point = Points.Get(0)
			Points.Set(Points.Size - 1, PntsCopy(p))
		End If
	Next
	Return Points
End Sub

Private Sub copyPointList(a As List) As List
	Dim result As List: result.Initialize
	For Each p As Point In a
		result.Add(newPoint(p.x, p.y))
	Next
	Return result
End Sub

Private Sub partPoint(p1 As Point, p2 As Point, fraction As Float) As Point
	Return newPoint(p1.x + fraction * (p2.x - p1.x), p1.y + fraction * (p2.y - p1.y))
End Sub

Public Sub newPoint (X As Float, y As Float) As Point
	Dim t1 As Point: t1.Initialize
	t1.X = X: t1.y = y
	Return t1
End Sub

Public Sub PntsCopy(p1 As Point) As Point
	Return newPoint(p1.X, p1.y)
End Sub

Public Sub PntsSubtract(p1 As Point, p0 As Point) As Point
	Return newPoint(p1.X - p0.X, p1.y - p0.y)
End Sub

Public Sub PntMultBy(factor As Float, p As Point) As Point
	Return newPoint(factor * p.X, factor * p.y)
End Sub

Public Sub PntsAdd(p1 As Point, p0 As Point) As Point
	Return newPoint(p1.X + p0.X, p1.y + p0.y)
End Sub

Public Sub distance(p1 As Point, p0 As Point) As Float
	Dim dx As Float = p1.X - p0.X
	Dim dy As Float = p1.Y - p0.Y
	Return Sqrt(dx * dx + dy * dy)
End Sub

Public Sub midPoint(p0 As Point, p1 As Point) As Point
	Return newPoint((p0.X + p1.X) / 2, (p0.Y + p1.Y) / 2)
End Sub

Private Sub SampledPoints
	Dim points As String = $"
	527	388
	536	370
	544	346
	541	314
	530	287
	506	260
	470	242
	424	234
	388	242
	370	250
	353	260
	322	285
	341	262
	353	237
	351	212
	343	195
	331	182
	311	175
	287	173
	269	180
	250	198
	239	219
	237	247
	243	263
	250	275
	272	287
	245	282
	225	285
	212	293
	192	304
	179	317
	173	333
	168	343
	159	353
	149	362
	139	366
	124	370
	127	383
	131	393
	143	402
	158	407
	173	409
	196	411
	325	410
	506	411
	520	398
	536	380
	559	365
	589	360
	618	362
	639	370
	658	376
	680	381
	705	384
	738	378
	765	365
	777	341
	770	309
	748	288
	724	283
	713	291
	717	300
	723	307
	733	313
	"$
	Dim v() As String = Regex.Split(CRLF, points)
	For Each s As String In v
		s = s.Trim
		If s.Length > 0 Then
			Dim w() As String = Regex.Split(TAB, s)
			recording.Add(newPoint(w(0), w(1)))
		End If
	Next
End Sub
