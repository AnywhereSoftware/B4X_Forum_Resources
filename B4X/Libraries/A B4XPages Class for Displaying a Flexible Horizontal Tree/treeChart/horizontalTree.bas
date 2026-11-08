B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private cv As B4XCanvas
	Private rows, cols As Int
	Private showGrid As Boolean
	Private rowheight, colWidth As Float
	Private styles As Map
	Private targetPanel As B4XView
	Private styles As Map
	Private spec As String
End Sub

Public Sub Initialize(targetPanel_ As B4XView, rows_ As Int, cols_ As Int, showGrid_ As Boolean, styles_ As Map, spec_ As String) As Object
	targetPanel = targetPanel_
	cv.Initialize(targetPanel)

	rows = rows_
	cols = cols_
	showGrid = showGrid_
	styles = LCase(styles_)
	spec = spec_
	Return Me
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.AddView(targetPanel, targetPanel.Left, targetPanel.top, targetPanel.width, targetPanel.Height)
	defineGrid
	Dim treeData As List = parseDefinition(spec)
	drawTree(treeData)
	drawAnnotations
End Sub

Private Sub drawAnnotations
	If styles.ContainsKey("title") Then
		Dim titleStyle As Map = LCase(styles.Get("title"))
		Dim text As String = titleStyle.GetDefault("text", "")
		Dim textColor As Int = titleStyle.GetDefault("textcolor", xui.Color_Black)
		Dim textSize As Int = titleStyle.GetDefault("textsize", 20)
		Dim textAlign As String = titleStyle.GetDefault("align", "center")
		Dim textBold As Boolean = titleStyle.GetDefault("bold", "false")
		If textBold Then
			Dim fnt As B4XFont = xui.CreateDefaultBoldFont(textSize)
		Else
			Dim fnt As B4XFont = xui.CreateDefaultFont(textSize)
		End If
		Select textAlign.ToLowerCase
			Case "left"
				cv.DrawText(text, .05 * targetPanel.Width, .07 * targetPanel.Height, fnt, textColor, "LEFT")
			Case "center"
				Dim w As Float = targetPanel.Width
				cv.DrawText(text, w /2, .07 * targetPanel.Height, fnt, textColor, "CENTER")
			Case "right"
				Dim w As Float = targetPanel.Width
				cv.DrawText(text, .95 * targetPanel.Width, .07 * targetPanel.Height, fnt, textColor, "RIGHT")
		End Select
	End If
	If styles.ContainsKey("notes") Then
		Dim notes As Map = LCase(styles.Get("notes"))
		Dim noteHeight As Int = notes.GetDefault("noteheight", 18)
		Dim noteList As List = notes.Get("lines")
		Dim top As Int = targetPanel.Height - noteList.Size * noteHeight
		For i = 0 To noteList.Size - 1
			Dim noteStyle As Map = noteList.Get(i)
			Dim text As String = noteStyle.GetDefault("text", "")
			Dim textColor As Int = noteStyle.GetDefault("textcolor", xui.Color_Black)
			Dim textSize As Int = noteStyle.GetDefault("textsize", 20)
			Dim textAlign As String = noteStyle.GetDefault("align", "center")
			Dim textBold As Boolean = noteStyle.GetDefault("bold", "false")
			If textBold Then
				Dim fnt As B4XFont = xui.CreateDefaultBoldFont(textSize)
			Else
				Dim fnt As B4XFont = xui.CreateDefaultFont(textSize)
			End If
			Select textAlign.ToLowerCase
				Case "left"
					cv.DrawText(text, .05 * targetPanel.Width, top, fnt, textColor, "LEFT")
				Case "center"
					Dim w As Float = targetPanel.Width
					cv.DrawText(text, w /2, top, fnt, textColor, "CENTER")
				Case "right"
					Dim w As Float = targetPanel.Width
					cv.DrawText(text, .95 * targetPanel.Width, top, fnt, textColor, "RIGHT")
			End Select
			top = top + noteHeight
		Next
	End If
End Sub

Private Sub drawTree(tree As List)
	Dim connectCount As Int
	For Each item As Map In tree
		Dim text As String = item.Get("text")
		Dim row As Int = item.Get("row")
		Dim col As Int = item.Get("col")
		Dim style As String = item.GetDefault("style", "Default")
		Dim styleMap As Map = LCase(styles.Get(style.ToLowerCase.trim))
		drawText(text, row, col, styleMap)
		If item.ContainsKey("children") Then
			Dim children As List = item.Get("children")
			If children.Size > 0 Then
				connectCount = connectCount + 1
				connect(connectCount, row, col, children.Get(0), True)
				connect(connectCount, row, col, children.Get(children.Size -1), False)
				drawTree(children)
			End If
		End If
	Next
End Sub

Private Sub connect(connectCount As Int, row As Int, col As Int, child As Map, onTop As Boolean)
	If styles.ContainsKey("connectors") Then
		Dim connectors As Map = LCase(styles.Get("connectors"))
		Dim clr As Int = connectors.GetDefault("color", xui.Color_RGB(160, 160, 160))
		Dim lWidth As Int = connectors.GetDefault("width", 2)
	Else
		Dim clr As Int = xui.Color_RGB(160, 160, 160)
		Dim lWidth As Int = 2
	End If
	Dim targetRow As Int = child.Get("row")
	Dim targetCol As Int = child.Get("col")
	Dim xmargin As Float = 30
	Dim ymargin As Float = 5
	Dim smallOffset As Float = 7
	Dim adjust As Float = 3 * smallOffset
	Dim innerBoxHeight As Float = rowheight - ymargin
	Dim x1 As Float = (col + 1) * colWidth - xmargin
	Dim y1 As Float = ymargin + row * rowheight + innerBoxHeight / 2
	Dim x2 As Float = targetCol * colWidth + adjust - smallOffset * (connectCount - 1)
	Dim x3 As Float = x2 + xmargin / 2 + smallOffset * (connectCount - 1)
	If onTop Then
		cv.DrawLine(x1, y1, x1 + 30 + adjust - smallOffset * (connectCount - 1), y1, clr, lWidth)
		Dim y2 As Float = ymargin + targetRow * rowheight - 2 * ymargin
		cv.DrawLine(x2, y1, x2, y2, clr, lWidth)
		cv.DrawLine(x2, y2, x3, y2, clr, lWidth)
	Else
		Dim y2 As Float = ymargin + (targetRow + 1) * rowheight + ymargin
		cv.DrawLine(x2, y1, x2, y2, clr, lWidth)
		cv.DrawLine(x2, y2, x3, y2, clr, lWidth)
	End If
End Sub

Private Sub drawText(text As String, row As Int, col As Int, styleMap As Map)
	Dim clr As Int = styleMap.GetDefault("color", xui.Color_Black)
	Dim backgroundColor As Int = styleMap.GetDefault("backgroundcolor", xui.Color_White)
	Dim borderColor As Int = styleMap.GetDefault("bordercolor", xui.Color_Black)
	Dim borderWidth As Int = styleMap.GetDefault("borderwidth", 1)
	Dim borderRadius As Int = styleMap.GetDefault("borderradius", 10)
	Dim fs As Int = styleMap.GetDefault("textsize", 18)
	Dim bold As Boolean = styleMap.GetDefault("bold", False)
	If bold Then
		Dim fnt As B4XFont = xui.CreateDefaultBoldFont(fs)
	Else
		Dim fnt As B4XFont = xui.CreateDefaultFont(fs)
	End If
	Dim metrics As B4XRect = cv.MeasureText(text, fnt)
	Dim xmargin As Float = 30
	Dim ymargin As Float = 5
	Dim x As Float = xmargin + col * colWidth
	Dim y As Float = ymargin + row * rowheight
	Dim innerBoxHeight As Float = rowheight - ymargin
	Dim cvRect As B4XRect
	cvRect.Initialize(x, y, x + colWidth - 2 * xmargin, y + innerBoxHeight)
	Dim xPath As B4XPath
	xPath.InitializeRoundedRect(cvRect, borderRadius)
	cv.DrawPath(xPath, backgroundColor, True, 1)
	cv.DrawPath(xPath, borderColor, False, borderWidth)
	cv.DrawText(text, x + 10, y + innerBoxHeight / 2 + metrics.Height / 2, fnt, clr, "LEFT")
End Sub

Private Sub parseDefinition(ss As String) As List
	Dim items As List = CreateList(Array(CreateMap("text": "root", "row": -1, "col": -1)))
	Dim stack As List = CreateList(Array())
	Dim prevJ As Int = -1
	Dim v() As String = Regex.Split(CRLF, ss)
	For Each s As String In v
		If s.Trim.Length = 0 Then Continue
		For j = 0 To s.Length - 1
			Dim c As String = s.charAt(j)
			If c <> TAB Then Exit
		Next
		Dim w() As String = Regex.Split("\|", s.trim)
		Dim text As String = w(0)
		Dim q() As String = Regex.Split("\,", w(1))
		Dim row As String = q(0)
		Dim col As String = j
		Dim item As Map = CreateMap("text": text, "row": row, "col": col)
		If q.Length > 1 Then item.Put("style", q(1).Trim)
		If j > prevJ Then
			stack.Add(items)
			Dim prevItem As Map = items.Get(items.Size - 1)
			items = CreateList(Array())
			items.Add(item)
			prevItem.Put("children", items)
		Else if j < prevJ Then
			For k = prevJ To j + 1 Step - 1
				items = stack.Get(stack.Size - 1)
				stack.RemoveAt(stack.Size - 1)
			Next
			items.Add(item)
		Else
			items.Add(item)
		End If
		prevJ = j
	Next
	Dim l1 As List = stack.Get(0)
	Return l1.Get(0).As(Map).Get("children")
End Sub

Public Sub getBitmap As B4XBitmap
	Return cv.CreateBitmap
End Sub

Private Sub defineGrid
	Dim w As Float = targetPanel.Width
	Dim h As Float = targetPanel.height - 30
	rowheight = h / rows
	colWidth = w / cols
	If showGrid Then
		Dim cvRect As B4XRect
		cvRect.Initialize(0, 0, w, h + 30)
		cv.drawRect(cvRect, xui.Color_Blue, False, 2)

		Dim yoffset As Float = rowheight
		For i = 1 To rows - 1
			cv.DrawLine(0, yoffset, w, yoffset, xui.Color_RGB(200, 200, 200), 1)
			yoffset = yoffset + rowheight
		Next

		Dim xoffset As Float = colWidth
		For i = 1 To cols - 1
			cv.DrawLine(xoffset, 0, xoffset, h, xui.Color_RGB(200, 200, 200), 1)
			xoffset = xoffset + colWidth
		Next
	End If
End Sub

Private Sub CreateList(items() As Object) As List
	Dim result As List
	result.Initialize
	result.AddAll(items)
	Return result
End Sub

Private Sub LCase(mp As Map) As Map
	Dim newM As Map
	newM.initialize
	For Each kw As String In mp.Keys
		newM.Put(kw.ToLowerCase.trim, mp.Get(kw))
	Next
	Return newM
End Sub
