B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
' By William Lancee - https://www.b4x.com/android/forum/threads/b4x-a-cross-platform-b4xpages-class-to-display-a-network-of-nodes-connected-by-arrows.143069/
' Modified by WM (see 'WM' comments in the code) to have the chart in a Pane; for B4J only, may/will produce compiler and/or run time errors for B4A/B4I
Sub Class_Globals
	Public Root As B4XView 'ignore ' WM: changed from Private to Public
	Private xui As XUI 'ignore
	Type NetPart(isNode As Boolean, Index As Int, Pos As B4XRect, Content As String, specMap As Map, xoffset As Float, yoffset As Float)
	Public mil As Float
	Public fsFactor As Float
	Public useFsFactorForLabels As Boolean = True ' Added by WM
	Private callback As Object
	Private event As String ' WM : added this
	
	Private NodeLayer, ConnectionLayer, TouchLayer As B4XView
	Private RootRect As B4XRect
	Private CV As B4XCanvas
	Private BC As BitmapCreator
	Private DD As DDD
	Private textengine1 As BCTextEngine
	Private BBCodeView1 As BBCodeView
	Public fnt As B4XFont
	
	Public register, nodeSpec, arrowSpec As Map
	Private byIndex As List
	Public nodeRefs As Map
	
	Private layoutArrows As List
	Private lastXOffset, lastYOffset, lastLeft, lastTop As Float
	Public draggable As Boolean
	Public enableDragAndSelect As Boolean = False ' WM : added this
	Public wrapText As Boolean = False ' WM : added this
	Private startPoint As point
	Private dragging As Boolean
	Private partInDrag As String
	Private busy As Boolean

	Private Const SEPARATOR As String = Chr(255) ' WM : using this as separator instead of underscore: if a partname contains an underscore, the latter caused exceptions
End Sub

'Initalizes the net chart, callback is used in touch event
Public Sub Initialize(callback_ As Object, rootPane As B4XView, event_ As String, nodeFontSize As Float, nodeFontBold As Boolean) As Object ' WM : added the rootPane, event_, nodeFontSize, and nodeFontBold parms
	callback = callback_
	event = event_
	register.Initialize
	byIndex.Initialize
	nodeRefs.Initialize
	layoutArrows.Initialize
	xui.RegisterDesignerClass(Me)
	DD.Initialize
	xui.RegisterDesignerClass(DD)
	'fnt = xui.CreateDefaultBoldFont(10)		'size here is replaced by .textsize method ' WM : replaced this line by the next one:
	fnt = IIf(nodeFontBold, xui.CreateDefaultBoldFont(nodeFontSize), xui.CreateDefaultFont(nodeFontSize))
	'any parameter below can be overrriden before rendering the chart, also see custom specs in the demo
	nodeSpec = CreateMap("Color": xui.Color_White, "Border": xui.Color_Blue, "BorderWidth": 2, "TextColor": xui.Color_Black, "CornerRadius": 5, "Font": fnt)
	arrowSpec = CreateMap("Color": xui.Color_Blue, "Filled": True, "Thickness": 2, "TipWidth": 10, "TipHeight": 13)

	' WM: start of original B4XPage_Created code
	Root = rootPane
	mil = Root.Width / 1000
	ConnectionLayer = xui.CreatePanel(""): Root.AddView(ConnectionLayer, 0, 0, Root.Width, Root.Height)
	CV.Initialize(ConnectionLayer)
	fsFactor = Max(.95, Min(1.25, Root.Width / (75 * CV.MeasureText("X", xui.CreateDefaultFont(20)).width)))
	NodeLayer = xui.CreatePanel(""): Root.AddView(NodeLayer, 0, 0, Root.Width, Root.Height)
	#if B4J
		TouchLayer = xui.CreatePanel("TouchLayer")
	#Else if B4A
		TouchLayer = xui.CreatePanel("")
		Dim r As Reflector
		r.Target = TouchLayer
		r.SetOnTouchListener("TouchLayer_Touch")
	#End If
	Root.AddView(TouchLayer, 0, 0, Root.Width, Root.Height)

	RootRect = makeRect(0, 0, Root.Width, Root.Height)
	BC.Initialize(Root.Width, Root.Height)
	textengine1.initialize(Root)
	' WM: end of original B4XPage_Created code

	Return Me

End Sub

'The Layout file created by the internal designer (in the IDE) has nodes as 'Labels". Connectors specified by designer extension script
Public Sub fromLayout(layoutFile As String)
	layoutArrows.Clear
	Dim allViews As B4XView = xui.CreatePanel("")
	allViews.SetLayoutAnimated(0, 0, 0, NodeLayer.Width, NodeLayer.Height)
	allViews.LoadLayout(layoutFile)
	Dim minX, maxX, minY, maxY As Float
	minX = Root.Width
	minY = Root.height
	For i = 0 To allViews.NumberOfViews - 1
		Dim bvx As B4XView = allViews.GetView(i)
		If bvx.Left < minX Then minX = bvx.left
		If bvx.Top < minY Then minY = bvx.Top
		If bvx.Left + bvx.Width > maxX Then maxX = bvx.Left + bvx.Width
		If bvx.Top + bvx.Height > maxY Then maxY = bvx.Top + bvx.Height
	Next
	Dim xPlus As Float = Root.Width / 2 - (maxX - minX) / 2 - minX
	Dim yPlus As Float = Root.Height / 2 - (maxY - minY) / 2 - minY
	For i = 0 To allViews.NumberOfViews - 1
		Dim bvx As B4XView = allViews.GetView(i)
		Dim data As DDDViewData = DD.GetViewData(bvx)
		Dim content As String = data.Name
		If bvx.Text <> "Text" Then content = bvx.Text
		Dim sp As NetPart = NewNetPart(True, byIndex.Size, makeRect(xPlus + bvx.Left, yPlus + bvx.Top, bvx.Width, bvx.Height), content, nodeSpec)
		byIndex.Add(data.Name)
		register.Put(data.Name, sp)
	Next
	For Each connections As List In layoutArrows
		Dim fromNode As String = connections.Get(0)
		For i = 1 To connections.Size - 1
			Dim toNode As String = connections.Get(i)
			Dim name As String = fromNode & SEPARATOR & toNode ' WM: changed "_" to SEPARATOR
			Dim sp As NetPart = NewNetPart(False, byIndex.Size, makeRect(0, 0, 0, 0), content, arrowSpec)
			byIndex.Add(name)
			register.Put(name, sp)
		Next
	Next
End Sub

'specification string: name/text^left,top,width,height^subtext where
'- ^ delimiter
'- ~ indicates "same as last"
'- * indicates "last plus spacing"
'- units are in mils = (.001 * root.width)
'- subtext starting with "RT\" is 'rich text', using BBCodeView syntax
'
'Example:
'Dim netString As String = $"
'	Root^Center,100,400,125^RT\[Alignment=Center][TextSize=22][Color=Red][b]The Company[/b][/Color][/TextSize][/Alignment]
'	CEO^75,*,220,90^Hans DeVoort
'	VP-Finance^Center,~,220,90^Michael Rocher
'	VP-HR^*,~,220,90^Emelia Hartman
'	Root=CEO,VP-Finance,VP-HR
'"$
Public Sub fromNetString(netString As String, HSpacing As Float, VSpacing As Int)
	lastXOffset = 0: lastYOffset = 0: lastLeft = 0: lastTop = 0
	Dim v() As String = Regex.Split(CRLF, netString)
	For Each s As String In v
		s = s.trim
		If s.Length > 0 Then
			If s.Contains("=") And s.Contains("^") = False Then
				Dim w() As String = Regex.Split("\=", s)
				Dim v() As String = Regex.Split("\,", w(1))
				For Each toNode As String In v
					Dim name As String = w(0) & SEPARATOR & toNode ' WM: changed "_" to SEPARATOR
					Dim sp As NetPart = NewNetPart(False, byIndex.Size, makeRect(0, 0, 0, 0), name, arrowSpec)
					byIndex.Add(name)
					register.Put(name, sp)
				Next
			Else
				registerNode(s, HSpacing, VSpacing)
			End If
		End If
	Next
End Sub

Private Sub registerNode(s As String, HSpacing As Float, VSpacing As Float)
	Dim v() As String = Regex.Split("\^", s)
	Dim name As String = v(0)
	Dim position() As String = Regex.Split("\,", v(1))
	Dim left, top, width, height As Float
	width = position(2) * mil
	height = position(3) * mil
	Select position(0)
		Case "~": left = lastLeft
		Case "*": left = lastXOffset
		Case "Center": left = NodeLayer.Width / 2 - width / 2
		Case Else: left = position(0) * mil
	End Select
	Select position(1)
		Case "~": top = lastTop
		Case "*": top = lastYOffset
		Case "Center": top = NodeLayer.Height / 2 - height / 2
		Case Else: top = position(1) * mil
	End Select
	Dim content As String = name
	If v.Length > 2 Then
		content = v(2)
		If name <> "Root" Then  content = name & CRLF & v(2)
	End If
	Dim sp As NetPart = NewNetPart(True, byIndex.Size, makeRect(left, top, width, height), content, nodeSpec)
	byIndex.Add(name)
	register.Put(name, sp)
	lastXOffset = left + width + HSpacing
	lastYOffset = top + height + VSpacing
	lastLeft = left
	lastTop = top
End Sub

'The position of nodes is automatically computed from the connections
'Example:	Root=CEO,VP-Finance,VP-HR
'			VP-HR=HR-Assistant,HR-Recruitment
'Added by WM:
'- use values less than 1 for nCols or nRows to calculate it/them dynamically
'- NOTE: node names are case-sensitive, so 'CEO' and 'ceo' are not the same!
Public Sub fromConnections(connections As String, contentMap As Map, nCols As Float, nRows As Float) ' WM : added fromConnections2

	fromConnections2(connections, contentMap, nCols, nRows, False)

End Sub

Public Sub fromConnections2(connections As String, contentMap As Map, nCols As Float, nRows As Float, doLog As Boolean) ' WM : renamed to fromConnections2 and added 'doLog' parm and the Log statements

	If doLog Then LogColor("::::::::::::::: Starting method wmWiLNetChartInPane.fromConnections2", xui.Color_Red)

	Dim maxCols As Int = nCols ' WM : added this
	Dim connectors As List: connectors.Initialize
	Dim v() As String = Regex.Split(CRLF, connections)
	For Each s As String In v
		If s.Trim.Length > 0 Then connectors.Add(s.trim)
	Next

	If nRows < 1 Then nRows = connectors.Size + 1 ' WM : added this to determine nRows dynamically
	If doLog Then Log("nRows=" & nRows)

	Dim pairs As List: pairs.Initialize
	Dim nodesx As List: nodesx.Initialize
	Dim siblings As List: siblings.Initialize
	Dim indices As List: indices.Initialize

	For Each c As String In connectors
		If doLog Then Log("Connector=" & c)
		Dim w() As String = Regex.Split("\=", c) ' For the first entry in the example data, this would be 0='Root' and 1='CEO,VP-Finance,VP-HR'
		If doLog Then Log("     w.Length=" & w.Length)
		Dim v() As String = Regex.Split("\,", w(1)) ' For the first entry in the example data, this would be 0='CEO', 1='VP-Finance', and 2='VP-HR'
		If doLog Then Log("     v.Length=" & v.Length)
		If v.Length > maxCols Then maxCols = v.Length ' WM : added this to determine nRows dynamically
		Dim parent As String = w(0) ' For the first entry in the example data, this would be 'Root'
		Dim k1 As Int = nodesx.IndexOf(parent)
		If doLog Then Log("     k1=" & k1)
		If k1 = - 1 Then ' Parent doesn't exist in nodesx yet; add it
			k1 = nodesx.Size
			nodesx.Add(parent)
			siblings.Add(0) ' The total number of siblings for this node, including this node itself
			indices.Add(0) ' The 'index' (zero-based) of this node in the collection of siblings from the same parent
		End If
		For j = 0 To v.Length - 1
			If doLog Then Log("         v(" & j & ")=" & v(j))
			Dim child As String = v(j)
			Dim k2 As Int = nodesx.IndexOf(child)
			If doLog Then Log("         k2=" & k2)
			If k2 = - 1 Then ' Child doesn't exist in nodesx yet; add it
				k2 = nodesx.Size
				nodesx.Add(child)
				siblings.Add(v.length) ' The total number of siblings for this child, including this child itself
				indices.Add(j) ' The 'index' (zero-based) of this child in the collection of siblings from the same parent
			End If
			pairs.Add(Array As Int(k1, k2)) ' k1=parent's index, k2=child's index (index in nodesx, indices, siblings)
		Next
	Next
	If nCols < 1 Then nCols = maxCols ' WM : added this to determine nCols dynamically
	If doLog Then Log("nCols=" & nCols)

	Dim parents(nodesx.Size) As List ' This is a list that contains lists
	For i = 0 To nodesx.Size - 1 ' To each list in 'parents', add the node's name as first entry
		parents(i).Initialize
		parents(i).Add(nodesx.Get(i))
	Next
	For Each pr() As Int In pairs
		Dim plist As List = parents(pr(0))
		parents(pr(1)).AddAll(plist)
	Next
	' Now, 'parents' contains lists like (each of these comment lines represents a list):
	' root
	' child, root
	' granddaughter, child, root
	' grandson, child, root

	If doLog Then
		Log("Parents:")
		For Each oneParentsList As List In parents
			Log("   oneParentsList=" & oneParentsList)
		Next
	End If

	Dim wx As Float = NodeLayer.Width / nCols
	Dim hx As Float = NodeLayer.Height / nRows
	Dim matrix(nCols, nRows) As B4XRect
	For i = 0 To nCols - 1
		For j = 0 To nRows - 1
			Dim r As B4XRect: r.Initialize(i * wx , j * hx, (i + 1) * wx, (j + 1) * hx)
			matrix(i, j) = r
		Next
	Next
	Dim parentCN As Map: parentCN.Initialize ' Parent Column Number
	parentCN.Put(nodesx.get(0), nCols / 2) ' Root node's column number; put it close to the centre

	If doLog Then
		Log("nodesx=" & nodesx)
		Log("indices=" & indices)
		Log("siblings=" & siblings)
	End If

	Dim columnNum As Int
	For i = 0 To nodesx.Size - 1
		If doLog Then Log("      " & i & ") " & nodesx.Get(i))
		If doLog Then Log("        parentCN=" & parentCN)
		Dim row As Int = (parents(i).Size - 1)
		If i > 0 Then
			If parents(i).Size = 1 Then
				Continue 'invalid situation
			Else
				Dim immediateParent As String = parents(i).Get(1)
				If doLog Then Log("        immediateParent=" & immediateParent)
			End If
			Dim pCN As Int = parentCN.Get(immediateParent) ' PCN = Parent Column Number
			If doLog Then
				Log("        pCN=" & pCN)
				Log("        indices=" & indices.Get(i))
				Log("        siblings=" & siblings.Get(i))
			End If
			columnNum = pCN + indices.Get(i) - Floor(siblings.Get(i) / 2)
			If (pCN = 0) And (siblings.Get(i).As(Int) > 1) Then columnNum = columnNum + 1 ' WM: explanation:
			' Without this addition, if the parent column number (PCN) is zero and there is more than one child,
			' - the first child's column number would be: 0 + 0 - (2 / 2) = -1 <<< Causes exception in the below line "Dim rx As B4XRect = matrix(columnNum, row)"
			' - the second child's column number would be: 0 + 1 - (2 / 2) = 0
			' WITH this addition, this becomes:
			' - the first child's column number is: 0 + 0 - (2 / 2) + 1 = 0
			' - the second child's column number is: 0 + 1 - (2 / 2) + 1 = 1
			If doLog Then Log("        columnNum A=" & columnNum)
			parentCN.Put(nodesx.Get(i), columnNum)
		Else
			columnNum = nCols / 2 ' This is for the root node
			If doLog Then Log("        columnNum B=" & columnNum)
		End If
		If doLog Then Log("        columnNum=" & columnNum & "; row=" & row)
		Dim rx As B4XRect = matrix(columnNum, row)
		Dim r As B4XRect: r.Initialize(rx.left + .15 * rx.width, rx.top + .25 * rx.height, rx.left + .85 * rx.width, rx.top + .75 * rx.height)
		Dim name As String = nodesx.Get(i)
		Dim content As String = contentMap.Get(name)
		If name <> "Root" Then content = name & CRLF & content
		Dim sp As NetPart = NewNetPart(True, byIndex.Size, makeRect(r.Left, r.Top, r.Width, r.Height), content, nodeSpec)
		byIndex.Add(name)
		register.Put(name, sp)
	Next
	For Each s As String In connectors
		Dim w() As String = Regex.Split("\=", s)
		Dim v() As String = Regex.Split("\,", w(1))
		For Each toNode As String In v
			Dim name As String = w(0) & SEPARATOR & toNode ' WM: changed "_" to SEPARATOR
			Dim sp As NetPart = NewNetPart(False, byIndex.Size, makeRect(0, 0, 0, 0), name, arrowSpec)
			byIndex.Add(name)
			register.Put(name, sp)
		Next
	Next
End Sub

Private Sub makeRect(left As Float, top As Float, width As Float, height As Float) As B4XRect
	Dim r As B4XRect
	r.Initialize(left, top, left + width, top + height)
	Return r
End Sub

'Called by the designer script
Public Sub ConnectNodes(DesignerArgs As DesignerArgs)
	Dim bvx As B4XView = DesignerArgs.GetViewFromArgs(0)
	Dim connections As List: connections.Initialize
	connections.Add(DD.GetViewData(bvx).Name)
	For i = 1 To DesignerArgs.Arguments.Size - 1
		bvx = DesignerArgs.GetViewFromArgs(i)
		connections.Add(DD.GetViewData(bvx).Name)
	Next
	layoutArrows.Add(connections)
End Sub

'Renders the chart based on the parts register
Public Sub renderNetChart
	For Each partName As String In register.Keys
		Dim part As NetPart = register.Get(partName)
		If part.isNode Then createNode(partName) Else createArrow(partName)
	Next
End Sub

Private Sub createNode(name As String)
	If register.ContainsKey(name) = False Then Return
	Dim part As NetPart = register.Get(name)
	BC.DrawRect(part.pos, -16777216 + part.Index, True, 0)
	Dim pnl As B4XView = xui.CreatePanel("")
	NodeLayer.AddView(pnl, part.pos.left, part.pos.top, part.pos.width, part.pos.height)
	addLabel(pnl, part.content, part.SpecMap)
	nodeRefs.Put(name, pnl)
End Sub

Private Sub createArrow(name As String)
	If register.ContainsKey(name) = False Then Return
	Dim part As NetPart = register.Get(name)
	Dim xoffset As Float = part.xoffset
	Dim yoffset As Float = part.yoffset
	Dim w() As String = Regex.Split(SEPARATOR, name) ' WM: changed "\_" to SEPARATOR
	Dim arrow As Arrows
	arrow.initialize(CV)
	Dim A As NetPart = register.Get(w(0))
	Dim B As NetPart = register.Get(w(1))
	Dim APos As B4XRect = A.pos
	Dim BPos As B4XRect = B.pos
	Dim x1, x2, y1, y2 As Float
	If Abs(APos.Top - BPos.Top) < .5 * (APos.Height + BPos.Height) Then
		If APos.Left + APos.Width < BPos.Left Then
			x1 = APos.Left + APos.Width - 3dip + xoffset
			y1 = APos.Top + APos.Height / 2 + yoffset
			x2 = BPos.Left - 5dip + xoffset
			y2 = BPos.Top + BPos.Height / 2 + yoffset
		Else
			x1 = APos.Left + xoffset + 3dip
			y1 = APos.Top + APos.Height / 2 + yoffset
			x2 = BPos.Left + BPos.Width + 5dip + xoffset
			y2 = BPos.Top + BPos.Height / 2 + yoffset
		End If
	Else
		If APos.Top < (BPos.Top + BPos.Height) Then
			x1 = APos.Left + APos.Width / 2 + xoffset
			y1 = APos.Top + APos.Height - 3dip + yoffset
			x2 = BPos.Left + BPos.Width / 2 + xoffset
			y2 = BPos.Top - 5dip + yoffset
		Else
			x1 = APos.Left + APos.Width / 2 + xoffset
			y1 = APos.Top + yoffset + 3dip
			x2 = BPos.Left + BPos.Width / 2 + xoffset
			y2 = BPos.Top + BPos.Height + 5dip + yoffset
		End If
	End If
	arrow.draw(x1, y1, x2, y2, part.specMap)
	BC.DrawLine(x1, y1, x2, y2, -16777216 + part.Index, 10dip)
End Sub

Private Sub addLabel(pnl As B4XView, text As String, spec As Map)
	Dim w As Float = spec.GetDefault("CornerRadius", 0) * 1dip
	Dim clr As Int = spec.GetDefault("Color", xui.Color_Transparent)
	If text.StartsWith("RT\") Then
		text = text.SubString(3)
		'this section adjusts the specified fontsize in the rich text string
		Dim sb As StringBuilder: sb.Initialize
		Dim v() As String = Regex.Split("\[Text", text)
		sb.Append(v(0))
		For i = 1 To v.Length - 1
			sb.Append("[Text")
			Dim k As Int = v(i).IndexOf("=")
			Dim prefix As String = v(i).SubString2(0, k + 1)
			Dim rest As String = v(i).SubString(k + 1)
			Dim number As Float = rest.SubString2(0, rest.IndexOf("]"))
			rest = rest.SubString(rest.IndexOf("]"))
			sb.Append(prefix).Append(NumberFormat2(number * fsFactor, 1, 0, 0, False)).Append(rest)
		Next
		text = sb.ToString		
		pnl.LoadLayout("BBCV")
		BBCodeView1.TextEngine = textengine1
#If B4J
		BBCodeView1.sv.As(ScrollPane).SetHScrollVisibility("NEVER")
#End If
		BBCodeView1.sv.color = clr
		BBCodeView1.sv.ScrollViewInnerPanel.Color = clr
		BBCodeView1.Text = text
		Sleep(15)
		Dim ContentHeight As Int = Min(BBCodeView1.Paragraph.Height / textengine1.mScale + BBCodeView1.Padding.Top + BBCodeView1.Padding.Bottom, BBCodeView1.mBase.Height)
		BBCodeView1.mBase.Height = ContentHeight + 12
		BBCodeView1.mBase.Top = pnl.Height / 2 - ContentHeight / 2
	Else
		Dim lbl As Label: lbl.Initialize("")
		lbl.WrapText = wrapText ' WM : added this
		Dim lblx As B4XView = lbl
		lblx.Font = spec.GetDefault("Font", fnt)
		If useFsFactorForLabels Then lblx.TextSize = fsFactor * 16 ' WM : added the If
		lblx.TextColor = spec.GetDefault("TextColor", xui.Color_Black)
		lblx.SetTextAlignment("CENTER", "CENTER")
		lblx.Text = " " & text
		lblx.Color = clr
		pnl.AddView(lblx, w, w, pnl.Width - 2*w, pnl.Height - 2*w)
	End If
	pnl.SetColorAndBorder(clr, spec.GetDefault("BorderWidth", 0) * 1dip, spec.GetDefault("Border", xui.Color_Black), spec.GetDefault("CornerRadius", 0) * 1dip)
End Sub

Private Sub RedrawConnectors
	CV.ClearRect(RootRect)
	For Each partName As String In register.Keys
		Dim part As NetPart = register.Get(partName)
		If part.isNode = False Then createArrow(partName)
	Next
End Sub

Private Sub RedrawNodes
	BC.DrawRect(RootRect, 0, True, 0)
	For Each partName As String In register.Keys
		Dim part As NetPart = register.Get(partName)
		If part.isNode Then
			BC.DrawRect(part.pos, -16777216 + part.Index, True, 0)
		End If
	Next
End Sub

'Sets the appearance of a connector based on a specification map
'Example: Dim customSpec As Map = CreateMap("Color": xui.Color_Red, "Filled": False, "Thickness": 5, "TipWidth": 10, "TipHeight": 13)
Public Sub ChangeConnector(name As String, spec As Map,  adjustx As Float, adjusty As Float)
	If register.ContainsKey(name) = False Then Return
	Dim part As NetPart = register.Get(name)
	part.specMap = spec
	part.xoffset = adjustx
	part.yoffset = adjusty
	RedrawConnectors
End Sub

'Sets the appearance of a node based on a specification map - keys here change existing values - rest remain unchanged
'Example: Dim customSpec As Map = CreateMap("Color": xui.Color_Blue, "TextColor": xui.Color_White)
Public Sub ChangeNode(name As String, content As Object, spec As Map)
	If register.ContainsKey(name) = False Then Return
	Dim part As NetPart = register.Get(name)
	Dim newMap As Map: newMap.Initialize
	For Each kw As String In part.specMap.Keys
		newMap.Put(kw, part.specMap.Get(kw))
	Next
	For Each kw As String In spec.Keys
		newMap.Put(kw, spec.Get(kw))
	Next
	part.specMap = newMap
	If content <> Null Then part.content = content
	Dim pnl As B4XView = nodeRefs.Get(name)
	pnl.RemoveAllViews
	addLabel(pnl, part.content, part.SpecMap)
End Sub

'Creates a custom "NetPart" type
Public Sub NewNetPart (isNode As Boolean, Index As Int, Pos As B4XRect, Content As String, specMap As Map) As NetPart
	Dim t1 As NetPart
	t1.Initialize
	t1.isNode = isNode
	t1.Index = Index
	t1.Pos = Pos
	t1.Content = Content
	t1.specMap = specMap
	Return t1
End Sub

#if B4J
Private Sub TouchLayer_MouseClicked(ev As MouseEvent)
	If ev.SecondaryButtonPressed Or enableDragAndSelect Or (draggable = False) Then Touched(ev.X, ev.Y, ev.SecondaryButtonPressed, ev) ' WM: added 'ev.SecondaryButtonPressed Or enableDragAndSelect Or' and the parms after 'ev.Y'
End Sub
Private Sub TouchLayer_MousePressed(ev As MouseEvent)
	If draggable Then Down(ev.X, ev.Y)
End Sub
Private Sub TouchLayer_MouseDragged(ev As MouseEvent)
	If draggable Then Moved(ev.X, ev.Y)
End Sub
Private Sub TouchLayer_MouseReleased(ev As MouseEvent)
	If draggable Then Up(ev.X, ev.Y)
End Sub
#Else If b4A
Private Sub TouchLayer_Touch (o As Object, ACTION As Int, x_ As Float, y_ As Float, motion As Object) As Boolean
	Select ACTION
		Case TouchLayer.TOUCH_ACTION_Down
			If draggable Then 
				Down(x_, y_)
			Else
				Touched(x_, y_)
			End If
		Case TouchLayer.TOUCH_ACTION_MOVE
			Moved(x_, y_)
		Case TouchLayer.TOUCH_ACTION_Up
			Up(x_, y_)
	End Select	
	Return True
End Sub
#End If

Private Sub Touched(x As Float, y As Float, rightClicked As Boolean, ev As MouseEvent) ' WM: added 'rightClicked' and 'ev'

	Dim index As Int = 16777216 + BC.GetColor(x, y)
	If index < 0 Or index > register.Size - 1 Then Return
	Dim partName As String = byIndex.Get(index)
	If rightClicked Then ' WM : added this test
		If SubExists(callback, event & "_RightClick") Then CallSubDelayed3(callback, event & "_RightClick", partName, ev) ' WM : added this
	Else
		If SubExists(callback, event & "_Click") Then CallSubDelayed3(callback, event & "_Click", partName, Array(X, Y)) ' WM : added the test, and used 'event' and '_Click'
	End If
End Sub

Private Sub Down(x As Float, y As Float)
	Dim index As Int = 16777216 + BC.GetColor(x, y)
	If index < 0 Or index > register.Size - 1 Then
		dragging = False
		Return
	End If
	Dim partName As String = byIndex.Get(index)
	Dim part As NetPart = register.Get(partName)
	If part.isNode = False Then
		dragging = False
		Return
	End If
	startPoint.X = x
	startPoint.Y = y
	dragging = True
	partInDrag = partName
End Sub

Private Sub Moved(x As Float, y As Float)
	If dragging And busy = False Then
		busy = True
		Dim panel As B4XView = nodeRefs.Get(partInDrag)
		Dim part As NetPart = register.Get(partInDrag)
		Dim Left As Float = panel.Left - (startPoint.X - x)
		Dim Top As Float = panel.Top - (startPoint.Y - y)
		panel.Left = Left
		panel.Top = Top
		Dim r As B4XRect
		r.Initialize(Left, Top, Left + panel.Width, Top + panel.Height)
		part.Pos = r
		startPoint.X = x
		startPoint.Y = y
		RedrawConnectors
		RedrawNodes
		busy = False
	End If
End Sub

Private Sub Up(x As Float, y As Float)
	If dragging Then 
		dragging = False
		If SubExists(callback, event & "_NodeMoved") Then CallSubDelayed3(callback, event & "_NodeMoved", partInDrag, Array(X, Y)) ' WM: added test, and used 'event'
	End If
End Sub

' WM : added this to change the overall font before rendering
Public Sub SetOverallFont(newFont As Font)

	fnt = newFont
	nodeSpec.Put("Font", fnt)

End Sub

' WM : added this:
'==============================
' Unused here - example code to show and handle a ContextMenu in the calling code if a WiLNetChart part is right-clicked
'==============================
'Private Sub wmWiLNetChartSQLSB_RightClick(partName As String, ev As MouseEvent)
'	Dim ContextMenu1 As ContextMenu ' WM : added this
'	ContextMenu1.Initialize("ContextMenu1")
'	For Each item As String In Array As String("Do this", "Do that", "Do something else")
'		ContextMenu1_AddItem(ContextMenu1, item)
'	Next
'	Dim joCM As JavaObject = ContextMenu1
'	Private ScreenX As Double = ev.As(JavaObject).RunMethod("getScreenX", Null)
'	Private ScreenY As Double = ev.As(JavaObject).RunMethod("getScreenY", Null)
'	joCM.RunMethod("show", Array(SOME_NODE_HERE, ScreenX, ScreenY))
'End Sub
'Private Sub ContextMenu1_AddItem(ContextMenu1 As ContextMenu, txt As String)
'	' Code based on https://www.b4x.com/android/forum/threads/get-contextmenus-working-on-nodes-controls-which-do-not-support-it.102721
'	Private TheMenuItem As MenuItem
'	TheMenuItem.Initialize(txt, "ContextMenu1")
'	ContextMenu1.MenuItems.Add(TheMenuItem)
'End Sub
'Private Sub ContextMenu1_Action
'	Dim menuItem1 As MenuItem = Sender
'	fx.Msgbox(frm, menuItem1.Text, "Right clicked")
'End Sub