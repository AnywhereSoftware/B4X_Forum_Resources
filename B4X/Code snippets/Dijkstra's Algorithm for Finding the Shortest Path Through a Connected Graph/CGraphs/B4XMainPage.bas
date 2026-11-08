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
	Type CNode(ID As Int, location As Point, distanceFromSource As Float, previousID As Int, visited As Boolean, neighbours As List)
	Type CNeighbour(nd As CNode, weight As Int)
	Private Root As B4XView
	Private xui As XUI
	Private cv As B4XCanvas
	Private cvRect As B4XRect
	
	Private nodes As List
	Private edges As List

	Private px As Point
	Public sourceNode As CNode
	Public targetNode As CNode
	
	Dim UNKNOWN As Float = 1 / 0

'for designing graph
	Private addNodes As Boolean
	Private markSource As Boolean
	Private markTarget As Boolean
	Private edges As List
	Private inDesign As Boolean = True
End Sub

Public Sub Initialize
	nodes.Initialize
	edges.Initialize
	px.Initialize(0, 0)
	addNodes = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	cv.Initialize(Root)
	cvRect.Initialize(0, 0, Root.Width, Root.Height)
	
#if B4A
	inDesign = False
#End If
	
	If inDesign Then
		Dim fnt As B4XFont = xui.CreateDefaultBoldFont(16)
		Dim fnt2 As B4XFont = xui.CreateDefaultBoldFont(12)
		Dim instruction As String = "Step 1: Start by laying down nodes - click on screen to add a node"
		'Dim w As Float = cv.MeasureText(instruction, fnt).width
		cv.DrawText(instruction, Root.Width / 2, 25, fnt, xui.Color_Black, "CENTER")
		Dim touchPanel As B4XView = xui.CreatePanel("touch")
		Root.AddView(touchPanel, 0, 0, Root.Width, Root.Height)
		cv.DrawCircle(Root.Width - 30, 25, 25, xui.Color_Gray, True, 0)
		cv.DrawText("step 2", Root.Width - 30, 20, fnt2, xui.Color_White, "CENTER")
		cv.DrawText("edges", Root.Width - 30, 30, fnt2, xui.Color_White, "CENTER")

		cv.DrawCircle(Root.Width - 30, 95, 25, xui.Color_Red, True, 0)
		cv.DrawText("step 3", Root.Width - 30, 90, fnt2, xui.Color_White, "CENTER")
		cv.DrawText("source", Root.Width - 30, 100, fnt2, xui.Color_White, "CENTER")

		cv.DrawCircle(Root.Width - 30, 165, 25, xui.Color_Green, True, 0)
		cv.DrawText("step 4", Root.Width - 30, 160, fnt2, xui.Color_Black, "CENTER")
		cv.DrawText("target", Root.Width - 30, 170, fnt2, xui.Color_Black, "CENTER")

		cv.DrawCircle(Root.Width - 30, 435, 25, xui.Color_Black, False, 1)
		cv.DrawText("step 5", Root.Width - 30, 435, fnt2, xui.Color_Black, "CENTER")
		cv.DrawText("save", Root.Width - 30, 445, fnt2, xui.Color_Black, "CENTER")
	Else
		startSimulation
	End If
End Sub

Private Sub startSimulation
	getModel
	drawGraph
	Dim markTime As Long = DateTime.now
	For i = 1 To 1000		'repeat 1000 times to get time estimate in microseconds
		getModel	'reset model
		solveDijkstra   'modifies nodes: previousID, visited
	Next
	Log(DateTime.Now - markTime)  
	'Desktop: 30 microseconds for this connected graph 
	'Android: 184 microseconds for this connected graph (about 6x slower than desktop)
	'	- complexity of the graph affects these numbers drammatically
	
	drawSolution	'backtracks from target, using shortest previousID
End Sub

Private Sub solveDijkstra
	sourceNode.distanceFromSource = 0
	sourceNode.visited = True
	Dim notDone As List: notDone.Initialize
	For i = 0 To nodes.Size - 1
		notDone.Add(i)
	Next
	Do While notDone.Size > 0
		Dim minx As Int = minIndex(notDone)
		Dim currentNode As CNode = nodes.Get(notDone.Get(minx))
		Dim ID As Int = currentNode.ID
		For Each neighbour As CNeighbour In currentNode.neighbours
			Dim tempDistance As Int = currentNode.DistanceFromSource + neighbour.weight
			If neighbour.nd.visited = False And tempDistance < neighbour.nd.distanceFromSource Then
				neighbour.nd.distanceFromSource = tempDistance
				neighbour.nd.previousID = ID
			End If
		Next
		currentNode.visited = True
		notDone.RemoveAt(minx)
	Loop
End Sub

Private Sub minIndex(notDone As List) As Int
	Dim minDist As Int = UNKNOWN
	Dim minx As Int
	For i = 0 To notDone.Size - 1
		Dim nd As CNode = nodes.Get(notDone.Get(i))
		If nd.distanceFromSource < minDist Then
			minDist = nd.distanceFromSource
			minx = i
		End If
	Next
	Return minx
End Sub

Private Sub drawGraph
	cv.ClearRect(cvRect)
	For Each nd As CNode In nodes
		Dim p As Point = nd.location
		cv.DrawCircle(p.X, p.Y, 5, xui.Color_Black, False, 1)
		cv.DrawText(nd.ID, p.X, p.Y - 15, xui.CreateDefaultBoldFont(15), xui.Color_Black, "CENTER")
		For Each neighbour As CNeighbour In nd.neighbours
			Dim p1 As Point = neighbour.nd.location
			cv.DrawLine(p.X, p.Y, p1.X, p1.Y, xui.Color_Black, 1)
		Next
	Next
	Dim source As CNode = sourceNode
	Dim target As CNode = targetNode
	cv.DrawCircle(source.location.X, source.location.Y, 10, xui.Color_Red, True, 1)
	cv.DrawCircle(target.location.X, target.location.Y, 10, xui.Color_Green, True, 1)
End Sub

Private Sub drawSolution
	Dim nextNode As CNode = targetNode
	Do While nextNode.ID <> sourceNode.ID
		Dim prevIndex As Int = nextNode.previousID
		Dim prevNode As CNode = nodes.Get(prevIndex)
		cv.DrawLine(nextNode.location.X, nextNode.location.Y, prevNode.location.X, prevNode.location.Y, xui.Color_Red, 5)
		nextNode = prevNode
	Loop
End Sub

#if B4J
'Design graph
Private Sub touch_MouseClicked(Ev As MouseEvent)
	Dim p As Point = px.new(Ev.X, Ev.Y)
	Dim pair() As Int
	If p.distance(px.new(Root.Width - 30, 25)) < 25 Then
		addNodes = (addNodes = False)
	Else If p.distance(px.new(Root.Width - 30, 95)) < 25 Then
		markSource = True
	Else If p.distance(px.new(Root.Width - 30, 165)) < 25 Then
		markTarget = True
	Else If p.distance(px.new(Root.Width - 30, 335)) < 25 Then
		startSimulation
	Else If p.distance(px.new(Root.Width - 30, 435)) < 25 Then
		saveModel
	Else if markSource Then
		Dim mind As Float = 1 / 0
		For i = 0 To nodes.size - 1
			Dim q As Point = nodes.Get(i).As(CNode).location
			If p.distance(q) < mind Then
				mind = p.distance(q)
				sourceNode = nodes.Get(i)
			End If
		Next
		Dim pz As Point = sourceNode.location
		cv.DrawCircle(pz.X, pz.Y, 10, xui.Color_Red, True, 1)
		markSource = False
	Else if markTarget Then
		Dim mind As Float = 1 / 0
		For i = 0 To nodes.size - 1
			Dim q As Point = nodes.Get(i).As(CNode).location
			If p.distance(q) < mind Then
				mind = p.distance(q)
				targetNode = nodes.Get(i)
			End If
		Next
		Dim pz As Point = targetNode.location
		cv.DrawCircle(pz.X, pz.Y, 10, xui.Color_Green, True, 1)
		markTarget = False
	Else
		If addNodes Then
			cv.DrawCircle(p.X, p.Y, 5, xui.Color_Black, False, 1)
			nodes.Add(NewNode(nodes.Size, p))
		Else
			Dim minDist As Float = 1 / 0
			For i = 0 To nodes.Size - 2
				For j = i + 1 To nodes.Size - 1
					Dim node1 As CNode = nodes.Get(i)
					Dim node2 As CNode = nodes.Get(j)
					Dim mpnt As Point = node1.location.middle(node2.location)
					Dim d As Float = p.distance(mpnt)
					If d < minDist Then
						minDist = d
						pair = Array As Int(i, j)
					End If
				Next
			Next
			edges.Add(pair)
			Dim nd0 As CNode = nodes.Get(pair(0))
			nd0.neighbours.Add(Array As Int(pair(1), 1))
			Dim nd1 As CNode = nodes.Get(pair(1))
			nd0.neighbours.Add(Array As Int(pair(0), 1))
			Dim p0 As Point = nd0.location
			Dim p1 As Point = nd1.location
			cv.DrawLine(p0.X, p0.Y, p1.X, p1.Y, xui.Color_Black, 1)
		End If
	End If
End Sub

Private Sub saveModel
	Log("Copy the following right before the dashed line in 'Sub getModel'")
	Log("_______________________________________________________________")
	Log("	Dim s As String = _")
	Log("$" & QUOTE)

	For Each nd As CNode In nodes
		Dim p As Point = nd.location
		Log(p.X & TAB & p.Y)
	Next
	Log(TAB)
	For Each edge() As Int In edges
		Log(edge(0) & TAB & edge(1) &  TAB & 1)
	Next
	Log(TAB)
	Log(sourceNode.ID & TAB & targetNode.ID)
	Log(QUOTE & "$")
End Sub

#End If


Public Sub NewNode (ID As Int, location As Point) As CNode
	Dim t1 As CNode
	t1.Initialize
	t1.ID = ID
	t1.location = location
	t1.distanceFromSource = 1 / 0
	t1.visited = False
	Dim neighbours As List: neighbours.Initialize
	t1.Neighbours = neighbours
	Return t1
End Sub

Public Sub NewNeighbour (nd As CNode, weight As Int) As CNeighbour
	Dim t1 As CNeighbour
	t1.Initialize
	t1.nd = nd
	t1.weight = weight
	Return t1
End Sub

Private Sub getModel
	nodes.clear
	Dim s As String = _
$"
138	149
257	252
382	195
516	260
598	197
660	140
212	122
277	68
344	135
449	142
508	101
597	134
	
0	6	1
6	7	1
7	8	1
2	8	1
2	9	1
9	10	1
10	11	1
5	11	1
0	1	1
1	2	1
2	3	1
3	4	1
4	5	1
1	6	1
	
0	5
"$
'_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _")

	Dim v() As String = Regex.Split(CRLF, s)
	Dim grpNum As Int
	For Each t As String In v
		If t.Trim.Length = 0 Then
			grpNum = grpNum + 1
			Continue
		End If
		Dim w() As String = Regex.Split(TAB, t)
		Select grpNum
			Case 1 'nodes
				Dim nd As CNode = NewNode(nodes.Size, px.New(w(0), w(1)))
				nodes.Add(nd)
			Case 2 'edges
				Dim nd0 As CNode = nodes.Get(w(0))
				Dim nd1 As CNode = nodes.Get(w(1))
				nd0.neighbours.Add(NewNeighbour(nd1, w(2)))
				nd1.neighbours.Add(NewNeighbour(nd0, w(2)))
			Case 3 'home/target
				sourceNode = nodes.Get(w(0))
				targetNode = nodes.Get(w(1))
		End Select
	Next
	'sourceNode = nodes.Get(9) to try various source nodes
End Sub

