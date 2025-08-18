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
	Type sortPair(stringValue As String, numberValue As Int)
	Private Root As B4XView	'ignore
	Private xui As XUI
	Public XL As XLUtils
	Public result As XLReaderResult
	Private dataRows(2) As Int
	Public tableName As String
	Public headerRow As Int
	Private sections As List
	
	Public numSections As Int
	Public currentTablePage As Int
	Public selection As B4XSet
	Public savedSelection As List
	Public toolKit As List
End Sub

Public Sub Initialize
	'B4XPages.GetManager.LogEvents = True
	B4XPages.GetManager.TransitionAnimationDuration = 0
	selection.Initialize
	savedSelection.Initialize
	initializeToolKit
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	XL.Initialize
	tableName = "Countries of the world"
	result = XL.Reader.ReadSheetByName(File.DirAssets, tableName & ".xlsx", "Sheet1") 'complete sheet
	headerRow = 4
	dataRows(0) = 6
	dataRows(1) = result.BottomRight.Row0Based
	
	'Excel columns in each section, * = left justified, otherwise right justified
	Dim definition As String = $"
		B* C* D
		B* E F G
		B* H I J
		B* K L M
		B* N O P
		B* Q R S
		B* T U
	"$
	sections = parseDef(definition)
	numSections = sections.size
	For i = 0 To numSections - 1
		Dim section() As String = sections.Get(i)
		Dim colNames(section.length) As String
		Dim k As Int = 0
		For k = 0 To section.Length - 1
			Dim address As XLAddress = XL.AddressOne(section(k).Replace("*",""), headerRow)
			colNames(k) = result.Get(address)
		Next
		Dim newSection As tableSection
		newSection.Initialize(i, dataRows, section, colNames)
		B4XPages.AddPageAndCreate("section" & i, newSection)
	Next
	
	Sleep(100)
	currentTablePage = 1
	B4XPages.ShowPage("section0")
End Sub

Private Sub parseDef(s As String) As List
	Dim sections As List
	sections.Initialize
	Dim v() As String = Regex.Split(CRLF, s)
	Dim lastS As Int
	For i = 0 To v.Length - 1
		Dim t As String = v(i).Trim
		If t.Length = 0 And sections.Size = 0 Then Continue
		sections.Add(Regex.Split(" ", t))
		If t.Length > 0 Then lastS = sections.size
	Next
	Do While lastS<sections.Size 
		sections.RemoveAt(sections.Size - 1)
	Loop
	Return sections
End Sub

Private Sub initializeToolKit
	toolKit.Initialize
	toolKit.AddAll(Array As String("Summarize Data", "Other Tool A", "Other Tool B", "Other Tool C"))
End Sub

Public Sub getItem(row As Int, col As String) As Object		'called from tableSection
	Dim address As XLAddress = XL.AddressOne(col, row)
	Return result.Get(address)
End Sub

Public Sub handle_toolKit(section As tableSection, tool As String)
	'You can use the results of XLReaderResult and selection.AsList and/or savedSelection addresses
	'Note that the B4Xpage that the user was looking at when selecting a tool is still on screen
	'Below is an example of handling "Summarize Data", the report has to be rendered in calling instance of tableSection
	
	Select tool
		Case "Summarize Data"			'of last selected column
			Dim selected As String
			For j = selection.Size - 1 To 0 Step -1
				selected = selection.Aslist.get(j)
				If selected.endsWith(",*") Or selected.startsWith("*,") Then Exit
			Next
			If selected.endsWith(",*") Then 
				Dim column As String = selected.SubString2(0, selected.Length - 2)
				If GetType(result.Get(XL.AddressOne(column, dataRows(0)))).Contains("Double") Then 
					numericSummary(section, column)
				Else
					textSummary(section, column)
				End If
			Else if selected.startsWith("*,") Then 
				Dim row As Int = selected.SubString(selected.IndexOf(",") + 1)
				rowSummary(section, row)
			End If
	End Select
End Sub

Private Sub numericSummary(section As tableSection, column As String)
		Dim firstValue As Object = result.Get(XL.AddressOne(column, dataRows(0)))
		Dim N, Sum, SumSq, MinValue, MaxValue As Double
		MinValue = firstValue
		MaxValue = firstValue
		Dim nDecimals As Int
		Dim validValues As List
		validValues.Initialize
		For i = dataRows(0) To dataRows(1)
			Dim address As XLAddress = XL.AddressOne(column, i)
			Dim value As Double = result.GetDefault(address, 0/0)	'the default 0/0 is NaN and has the property of failing value = value
			Dim valueStr As String = value
			Dim k As Int = valueStr.IndexOf(".")
			Dim nd As Int = valueStr.Length - k - 1
			If k > -1 And nd > nDecimals And valueStr.Contains("E") = False Then nDecimals = nd
			If value = value Then 
				validValues.Add(value)
				N = N + 1
				Sum = Sum + value
				SumSq = SumSq + value * value
				If value < MinValue Then MinValue = value
				If value > MaxValue Then MaxValue = value
			End If 
		Next
		Dim mean As Double = Sum / N
		Dim stdDev As Double = 0
		If N > 1 Then stdDev = Sqrt((SumSq - Sum * Sum / N) / (N - 1))
		If validValues.Size > 0 Then 
			Dim colName As String = result.Get(XL.AddressOne(column, headerRow))
			validValues.Sort(True)
			Dim nv As Float = validValues.Size / 100
			Dim thresholds() As Float = Array As Float(5, 10, 15, 20, 25, 50, 75, 80, 85, 90, 95)
			Dim sb As StringBuilder
			sb.Initialize
			For i = 0 To 10
				Dim percentile As Double = validValues.Get(nv * thresholds(i))
				sb.Append("[Span MinWidth=15%x Alignment=right]").Append(thresholds(i) & "%").Append("[/Span]")
				sb.Append("[Span MinWidth=20%x Alignment=right]").Append(NumberFormat2(percentile, 1, nDecimals, nDecimals, True)).Append("[/Span]")
				If i < 10 Then sb.Append(CRLF)
			Next
			Dim content As String = $"
				[TextSize=22][Alignment=Center]
				${colName}[/Alignment][/TextSize]
				[Alignment=Left][Indent=1]
				Number of Rows = $1.0{N}
				Mean = ${NumberFormat2(mean, 1, nDecimals, nDecimals, True)}
				Std. Dev. = ${NumberFormat2(stdDev, 1, nDecimals, nDecimals, True)}
				Minimum = ${NumberFormat2(MinValue, 1, nDecimals, nDecimals, True)}
				Maximum = ${NumberFormat2(MaxValue, 1, nDecimals, nDecimals, True)}
				
				[Indent=2]Percentiles[Indent=0]
				${sb.ToString}
			"$
			section.hideScroll
			section.exitBtn.visible = True
			section.reportPanel.Text = content.replace(TAB, "")
			section.reportPanel.mBase.Visible = True
		End If
End Sub

Private Sub textSummary(section As tableSection, column As String)
		Dim values As Map
		values.Initialize
		For i = dataRows(0) To dataRows(1)
			Dim address As XLAddress = XL.AddressOne(column, i)
			Dim value As String = result.GetDefault(address, "?")
			If value <> "?" Then 
				If values.ContainsKey(value) Then 
					Dim n As Int = values.Get(value)
					values.Put(value, n + 1)
				Else
					values.Put(value, 1)
				End If
			End If 
		Next
		Dim sortList As List
		sortList.Initialize
		Dim totalN As Int
		For Each kw As String In values.keys
			Dim sp As sortPair
			sp.Initialize
			sp.stringValue = kw
			n = values.Get(kw)
			sp.numberValue = n
			totalN = totalN + n
			sortList.add(sp)
		Next
		sortList.SortType("numberValue", False)
		If values.Size > 0 Then
			Dim unique As String
			Dim sp As sortPair = sortList.Get(0)
			If sp.numberValue = 1 Then unique = "unique "
			Dim sb As StringBuilder
			sb.Initialize
			For i = 0 To sortList.size - 1
				Dim sp As sortPair = sortList.Get(i)
				Dim perc As String = NumberFormat2(100 * sp.numberValue / totalN, 1, 0, 0, False)
				If unique = "" Then 
					sb.Append("[Span MinWidth=15%x Alignment=right]").Append(sp.numberValue).Append($" (${perc}%)"$).Append("[/Span]")
					sb.Append("[Span MinWidth=1%x Alignment=right]").Append("  ").Append("[/Span]")
				End If
				sb.Append("[Span MinWidth=20%x Alignment=left]").Append(sp.stringValue).Append("[/Span]")
				sb.Append(CRLF)
			Next
			Dim colName As String = result.Get(XL.AddressOne(column, headerRow))
			Dim content As String = $"
				[TextSize=22][Alignment=Center]
				${colName}[/Alignment][/TextSize] (${sortList.Size} ${unique }items)
				[Alignment=Left][Indent=1]
				${sb.toString}
			"$
			If sortList.Size > 20 Then section.showScroll Else section.hideScroll
			section.exitBtn.visible = True
			section.reportPanel.Text = content.replace(TAB, "")
			section.reportPanel.mBase.Visible = True
		End If
End Sub

Private Sub rowSummary(section As tableSection, row As Long)
	Dim v() As String = sections.Get(0)
	Dim startColumn As String = result.GetDefault(XL.AddressOne(v(0), row), "?")
	Dim startColumnName As String = result.Get(XL.AddressOne(v(0), headerRow))
	Dim sb As StringBuilder
	sb.Initialize
	Dim nLines As Int
	For Each s() As String In sections
		For j = 1 To s.Length - 1
			Dim value As Object = result.GetDefault(XL.AddressOne(s(j), row), "?")
			Dim valueStr As String = value
			If GetType(value).Contains("Double") Then 
				Dim nDecimals As Int = 0
				Dim k As Int = valueStr.IndexOf(".")
				Dim nd As Int = valueStr.Length - k - 1
				If k > -1 And nd > nDecimals And valueStr.Contains("E") = False Then nDecimals = nd
				valueStr = NumberFormat2(value, 1, nDecimals, nDecimals, True)
				If valueStr.endsWith(".0") Then valueStr = valueStr.SubString2(0, valueStr.Length - 2)
			End If
			Dim valueName As String = result.Get(XL.AddressOne(s(j), headerRow))
			sb.Append("[Span MinWidth=25%x Alignment=right]").Append(valueName).Append("[/Span]")
			sb.Append("[Span MinWidth=1%x Alignment=right]").Append("  ").Append("[/Span]")
			sb.Append("[Span MinWidth=20%x Alignment=left]").Append(valueStr).Append("[/Span]")
			sb.Append(CRLF)
			nLines = nLines + 1
		Next
	Next
	Dim content As String = $"
		[TextSize=22][Alignment=Center]
		${startColumnName}: ${startColumn}[/Alignment][/TextSize]
		[Alignment=Left][Indent=1]
		${sb.toString}
	"$
	If nLines > 20 Then section.showScroll Else section.hideScroll
	section.exitBtn.visible = True
	section.reportPanel.Text = content.replace(TAB, "")
	section.reportPanel.mBase.Visible = True
End Sub
