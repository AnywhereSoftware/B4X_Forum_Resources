B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Type NetPart(isNode As Boolean, Index As Int, Pos As B4XRect, Content As String, specMap As Map, xoffset As Float, yoffset As Float)
	Public mil As Float
	Public fsFactor As Float
	Private callback As Object
	
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
	Private startPoint As point
	Private dragging As Boolean
	Private partInDrag As String
	Private busy As Boolean
End Sub

'Initalizes the net chart, callback is used in touch event
Public Sub Initialize(callback_ As Object) As Object
	callback = callback_
	register.Initialize
	byIndex.Initialize
	nodeRefs.Initialize
	layoutArrows.Initialize
	xui.RegisterDesignerClass(Me)
	DD.Initialize
	xui.RegisterDesignerClass(DD)
	fnt = xui.CreateDefaultBoldFont(10)		'size here is replaced by .textsize method
	'any parameter below can be overrriden before rendering the chart, also see custom specs in the demo
	nodeSpec = CreateMap("Color": xui.Color_White, "Border": xui.Color_Blue, "BorderWidth": 2, "TextColor": xui.Color_Black, "CornerRadius": 5, "Font": fnt)
	arrowSpec = CreateMap("Color": xui.Color_Blue, "Filled": True, "Thickness": 2, "TipWidth": 10, "TipHeight": 13)
	Return Me
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
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
			Dim name As String = fromNode & "_" & toNode
			Dim sp As NetPart = NewNetPart(False, byIndex.Size, makeRect(0, 0, 0, 0), content, arrowSpec)
			byIndex.Add(name)
			register.Put(name, sp)
		Next
	Next
End Sub

'specification string ^ delimiter; ~ indicates "same as last"; * indicates "last plus spacing"; units are in mils = .001 * root.width
'Example: 	VP-Finance^*,~,200,80^Michael Rocher
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
					Dim name As String = w(0) & "_" & toNode
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
Public Sub fromConnections(connections As String, contentMap As Map, nCols As Float, nrows As Float)
	Dim connectors As List: connectors.Initialize
	Dim v() As String = Regex.Split(CRLF, connections)
	For Each s As String In v
		If s.Trim.Length > 0 Then connectors.Add(s.trim)
	Next
	
	Dim pairs As List: pairs.Initialize
	Dim nodesx As List: nodesx.Initialize
	Dim siblings As List: siblings.Initialize
	Dim indices As List: indices.Initialize
	
	For Each c As String In connectors
		Dim w() As String = Regex.Split("\=", c)
		Dim v() As String = Regex.Split("\,", w(1))
		Dim parent As String = w(0)
		Dim k1 As Int = nodesx.IndexOf(parent)
		If k1 = - 1 Then
			k1 = nodesx.Size
			nodesx.Add(parent)
			siblings.Add(0)
			indices.Add(0)
		End If
		For j = 0 To v.Length - 1
			Dim child As String = v(j)
			Dim k2 As Int = nodesx.IndexOf(child)
			If k2 = - 1 Then
				k2 = nodesx.Size
				nodesx.Add(child)
				siblings.Add(v.length)
				indices.Add(j)
			End If
			pairs.Add(Array As Int(k1, k2))
		Next
	Next
	Dim parents(nodesx.Size) As List
	For i = 0 To nodesx.Size - 1
		parents(i).Initialize
		parents(i).Add(nodesx.Get(i))
	Next
	For Each pr() As Int In pairs
		Dim plist As List = parents(pr(0))
		parents(pr(1)).AddAll(plist)
	Next
	
	Dim wx As Float = NodeLayer.Width / nCols
	Dim hx As Float = NodeLayer.Height / nrows
	Dim matrix(nCols, nrows) As B4XRect
	For i = 0 To nCols - 1
		For j = 0 To nrows - 1
			Dim r As B4XRect: r.Initialize(i * wx , j * hx, (i + 1) * wx, (j + 1) * hx)
			matrix(i, j) = r
		Next
	Next
	Dim parentCN As Map: parentCN.Initialize
	parentCN.Put(nodesx.get(0), nCols / 2)
	Dim columnNum As Int
	For i = 0 To nodesx.Size - 1
		Dim row As Int = (parents(i).Size - 1)
		If i > 0 Then
			If parents(i).Size = 1 Then
				Continue	'invalid situation
			Else
				Dim immediateParent As String = parents(i).Get(1)
			End If
			Dim pCN As Int = parentCN.Get(immediateParent)
			columnNum = pCN + indices.Get(i) - Floor(siblings.Get(i) / 2)
			If (pCN = 0) And (siblings.Get(i).As(Int) > 1) Then columnNum = columnNum + 1
			parentCN.Put(nodesx.Get(i), columnNum)
		Else
			columnNum = nCols / 2
		End If
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
			Dim name As String = w(0) & "_" & toNode
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
	Dim w() As String = Regex.Split("\_", name)
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
		'this section adjust the specified fontsize in the rich text string
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
		Dim lblx As B4XView = lbl
		lblx.Font = spec.GetDefault("Font", fnt)
		lblx.TextSize = fsFactor * 16
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
	If draggable = False Then Touched(ev.X, ev.Y)
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

Private Sub Touched(x As Float, y As Float)
	Dim index As Int = 16777216 + BC.GetColor(x, y)
	If index < 0 Or index > register.Size - 1 Then Return
	Dim partName As String = byIndex.Get(index)
	CallSubDelayed3(callback, "netChartClicked", partName, Array(X, Y))
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
		CallSubDelayed3(callback, "netNodeMoved", partInDrag, Array(X, Y))
	End If
End Sub

