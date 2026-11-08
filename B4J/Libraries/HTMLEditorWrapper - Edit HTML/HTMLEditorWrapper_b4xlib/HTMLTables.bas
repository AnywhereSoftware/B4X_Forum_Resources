B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
'#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
'#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color
#Event: Generated(HTML as String)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private SelectSize1 As SelectSize
	Private pnHTMLTables As B4XView
	Private mCols, mRows As Int
	Private Dialog As B4XDialog


	Private pmBorderSpacingClick As PlusMinusClick
	Private pmBorderWidthClick As PlusMinusClick
	Private pmPaddingClick As PlusMinusClick
	Private pmTableHeightClick As PlusMinusClick
	Private pmTableWidthClick As PlusMinusClick
	
	Private pmBorderWidth As B4XPlusMinus
	Private pmBorderSpacing As B4XPlusMinus
	Private pmPadding As B4XPlusMinus
	Private pmTableHeight As B4XPlusMinus
	Private pmTableWidth As B4XPlusMinus

	Private cbBorderCollapse As B4XView
	Private cbCentreTable As B4XView
	Private cbNoStyle As B4XView
	Private cbPadding As B4XView
	Private cbTableHeight As B4XView
	Private cbTableWidth As B4XView
	
	Private cbClearData As B4XView
	Private cbDataBackground As B4XView
	Private cbDataFontClr As B4XView
	Private cbHdrBackground As B4XView
	Private cbHeaderFontColor As B4XView
	Private cbHeaderRow As B4XView
	Private cbNbsp As B4XView
	Private cbTextAlign As B4XView
	
	Private cbxBorderStyle As B4XComboBox
	Private cbxCSSuses As B4XComboBox
	Private cbxTableHeight As B4XComboBox
	Private cbxTableWidth As B4XComboBox
	Private cbxTextAlign As B4XComboBox
	
	Private lblBorderColor As B4XView
	Private lblCssIdprefix As B4XView
	Private lblDataBackground As B4XView
	Private lblDataFontClr As B4XView
	Private lblHdrBackground As B4XView
	Private lblHeaderFontColor As B4XView
	
	Private tfcssId As B4XView
	Private lblTableSize As B4XView
	
	Private ParseDataMap As Map
	Private ViewStateMap As Map
	
	Private TableStyleMap,HeaderStyleMap,CellStyleMap, SetStyleMap As Map
	Private AddlTableStyleMap,AddlHeaderStyleMap,AddlCellStyleMap As Map
	Private ParseErrorList As List
	Private HEPane4 As Pane
	Private HEPane3 As Pane
	Private HEPane2 As Pane
	
	Private mForm As Form
	Dim CP As SL_B4XColorTemplate
	
	Private ScrollPane1 As B4XView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback

	ParseDataMap.Initialize
	TableStyleMap.Initialize
	HeaderStyleMap.Initialize
	CellStyleMap.Initialize
	SetStyleMap.Initialize
	ViewStateMap.Initialize
	
	AddlTableStyleMap.Initialize
	AddlHeaderStyleMap.Initialize
	AddlCellStyleMap.Initialize
	ParseErrorList.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	mBase.LoadLayout("htmltableslayout")
'	mBase.Visible = False
	mBase.As(Node).StyleClasses.add("html-tables")
	
	For Each V As B4XView In mBase.Parent.GetAllViewsRecursive
		If V.Tag = "sphtmltables" Then
			ScrollPane1 = V
			Exit
		End If
	Next
	
	HTMLEW_Utils.RightToLeft(cbCentreTable)
	HTMLEW_Utils.RightToLeft(cbTextAlign)
	HTMLEW_Utils.RightToLeft(cbHeaderRow)
	HTMLEW_Utils.RightToLeft(cbPadding)
	HTMLEW_Utils.RightToLeft(cbTableWidth)
	HTMLEW_Utils.RightToLeft(cbTableHeight)
	HTMLEW_Utils.RightToLeft(cbNbsp)
	HTMLEW_Utils.RightToLeft(cbNoStyle)
	
	cbxBorderStyle.SetItems(Array As String("none","solid","dotted","dashed","double","groove","ridge","inset","outset"))
	cbxCSSuses.SetItems(Array("None","Tag","Class","Id"))
	cbxTableWidth.SetItems(Array As String("px","%"))
	cbxTableHeight.SetItems(Array As String("px","%"))
	cbxTextAlign.SetItems(Array As String("left","center","right"))
	
	cbxBorderStyle.SelectedIndex = 0
	cbxCSSuses.SelectedIndex = 0
	cbxCssUses_SelectedIndexChanged (0)
	cbxTableHeight.SelectedIndex = 0
	cbxTableWidth.SelectedIndex = 0
	cbxTextAlign.SelectedIndex = 0
	
	pmBorderWidthClick.Initialize(pmBorderWidth)
	pmPaddingClick.Initialize(pmPadding)
	pmTableWidthClick.Initialize(pmTableWidth)
	pmBorderSpacingClick.Initialize(pmBorderSpacing)
	pmTableHeightClick.Initialize(pmTableHeight)
	
	pmBorderWidth.SetNumericRange(0,5,1)
	pmPadding.SetNumericRange(0,30,1)
	pmTableWidth.SetNumericRange(0,1000,1)
	pmTableHeight.SetNumericRange(0,1000,1)
	pmBorderSpacing.SetNumericRange(0,100,1)
	
	pmTableWidth.Formatter.GetDefaultFormat.GroupingCharacter = ""
	pmTableHeight.Formatter.GetDefaultFormat.GroupingCharacter = ""
	
	lblBorderColor.Color = xui.Color_Black
	lblTableSize.Text = "New Table 0 X 0"
	mBase.As(Node).StyleClasses.Add("html-tables")
	
	mForm = Props.Get("Form")
	
	Dim Stage As JavaObject = mForm.As(JavaObject).GetField("stage")
	Dim HProp As JavaObject = Stage.RunMethod("heightProperty",Null)
	Dim WProp As JavaObject = Stage.RunMethod("widthProperty",Null)
	
	Dim O As Object = mForm.As(JavaObject).CreateEventFromUI("javafx.beans.value.ChangeListener","ParentResized",Null)
	HProp.RunMethod("addListener",Array(O))
	WProp.RunMethod("addListener",Array(O))
	
	Dialog.Initialize(mForm.RootPane)
	
	
	
End Sub

Private Sub ParentResized_Event (MethodName As String, Args() As Object)
	If Dialog.IsInitialized And Dialog.Visible Then
		Dialog.Resize(mForm.RootPane.Width,mForm.RootPane.Height)
	End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub Show
'	mBase.Visible = True
	ScrollPane1.Visible = True
	For Each V As B4XView In ScrollPane1.Parent.GetAllViewsRecursive
		If V.Tag = "pncodebg" Then
			For Each N As Node In V.GetAllViewsRecursive
				N.Enabled = False
				N.StyleClasses.Add("code-disabled")
			Next
			Exit
		End If
	Next

End Sub

Public Sub Hide
	ScrollPane1.Visible = False
	For Each V As B4XView In ScrollPane1.Parent.GetAllViewsRecursive
		If V.Tag = "pncodebg" Then
			For Each N As Node In V.GetAllViewsRecursive
				N.Enabled = True
				Dim Pos As Int = N.StyleClasses.IndexOf("code-disabled")
				If Pos > -1 Then N.StyleClasses.RemoveAt(Pos)
			Next
		Exit
		End If
	Next
	
End Sub

Public Sub ClearUI
	cbxBorderStyle.SelectedIndex = 0
	cbxCSSuses.SelectedIndex = 0
	cbxCssUses_SelectedIndexChanged (0)
	cbxTableHeight.SelectedIndex = 0
	cbxTableWidth.SelectedIndex = 0
	cbxTextAlign.SelectedIndex = 0
	
	cbBorderCollapse.Checked = True
	cbCentreTable.Checked = False
	cbClearData.Checked = False
	cbDataFontClr.Checked = False
	cbDataBackground.Checked = False
	cbHdrBackground.Checked = False
	cbHeaderFontColor.Checked = False
	cbHeaderRow.Checked = False
	cbHeaderRow_CheckedChange(False)
	
	cbPadding.Checked = False
	cbTableHeight.Checked = False
	cbTableWidth.Checked = False
	cbTextAlign.Checked = False
	cbNbsp.Checked = True
	
	pmBorderWidth.SelectedValue = 0
	pmPadding.SelectedValue = 0
	pmTableWidth.SelectedValue = 0
	pmTableHeight.SelectedValue = 0
	pmBorderSpacing.SelectedValue = 0
	
	lblBorderColor.Color = xui.Color_Black
	lblDataBackground.Color = xui.Color_Transparent
	lblDataFontClr.Color = xui.Color_Transparent
	lblHdrBackground.Color = xui.Color_Transparent
	lblHeaderFontColor.Color = xui.Color_Transparent
	
	SelectSize1.Rows = 0
	SelectSize1.Cols = 0
	lblTableSize.Text = "New Table 0 X 0"
	
	tfcssId.Text = ""
End Sub

public Sub getBase As B4XView
	Return mBase
End Sub

Private Sub SelectSize1_Selected(Cols As Int, Rows As Int)
	mCols = Cols
	mRows = Rows
	If lblTableSize.Text.StartsWith("New") Then
		lblTableSize.Text = "New Table"
	Else
		lblTableSize.Text = "Editing Table"
	End If
	lblTableSize.Text = lblTableSize.Text & " " & Cols & " X " & Rows
End Sub

Private Sub BuildHTML As String
	Dim Spaces As Int = 4
	Dim Indent As Int = 0
	
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append(MakeIndent(Indent))
	SB.Append("<table ")
	Select cbxCSSuses.SelectedItem
		Case "Class"
			SB.Append($"class="${tfcssId.Text}"$)
		Case "Id"
			SB.Append($"id="${tfcssId.Text}"$)
	End Select
	Select cbxCSSuses.SelectedItem
		Case "None"
			Select cbxBorderStyle.SelectedItem
				Case "none"
				Case Else
					If cbNoStyle.Checked = False Then ApplyStyle(SB,True,False)
			End Select
	End Select
	SB.Append(">")
	SB.Append(CRLF)
	
	If cbClearData.Checked Then ParseDataMap.Clear
	
	Dim ParseDataList As List
	ParseDataList.Initialize
	
	Dim i,j As Int
	
	For i = 0 To mRows - 1
		ParseDataList.Clear
		ParseDataList = ParseDataMap.GetDefault(i,ParseDataList)
		If i = 0 And cbHeaderRow.Checked Then
			Indent = Indent + Spaces
			SB.Append(MakeIndent(Indent))
			SB.Append("<thead>")
	
			Indent = Indent + Spaces
			SB.Append(CRLF)
			SB.Append(MakeIndent(Indent))
			SB.Append("<tr>")
			Indent = Indent + Spaces
			For j = 0 To mCols - 1
				SB.Append(CRLF)
				SB.Append(MakeIndent(Indent))
				SB.Append("<th")
				If cbxCSSuses.SelectedItem = "None" Then
					If cbNoStyle.Checked = False Then ApplyStyle(SB, False,True)
				End If
				SB.Append(">")
				If ParseDataList.Size > j Then
					SB.Append(ParseDataList.Get(j))
				Else
					If cbNbsp.Checked Then SB.Append("&nbsp;")
				End If
				SB.Append("</th>")
			Next
			SB.Append(CRLF)
			Indent = Indent - Spaces
			SB.Append(MakeIndent(Indent))
			SB.Append("</tr>")
			SB.Append(CRLF)
			Indent = Indent - Spaces
			SB.Append(MakeIndent(Indent))
			SB.Append("</thead>")
			SB.Append(CRLF)
			SB.Append(MakeIndent(Indent))
			SB.Append("<tbody>")
			Indent = Indent + Spaces
			Continue
		Else If i = 0 Then
			Indent = Indent + Spaces
			SB.Append(MakeIndent(Indent))
			SB.Append("<tbody>")
			Indent = Indent + Spaces
		End If
		SB.Append(CRLF)
		SB.Append(MakeIndent(Indent))
		SB.Append("<tr>")
		Indent = Indent + Spaces
		For j = 0 To mCols - 1
			SB.Append(CRLF)
			SB.Append(MakeIndent(Indent))
			SB.Append("<td")
			If cbxCSSuses.SelectedItem = "None" Then
				If cbNoStyle.Checked = False Then ApplyStyle(SB, False,False)
			End If
			SB.Append(">")
			If ParseDataList.Size > j Then
				SB.Append(ParseDataList.Get(j))
			Else
				If cbNbsp.Checked Then SB.Append("&nbsp;")
			End If
			SB.Append("</td>")
		Next
		SB.Append(CRLF)
		Indent = Indent - Spaces
		SB.Append(MakeIndent(Indent))
		SB.Append("</tr>")
		SB.Append(CRLF)
	Next
	
	Indent = Indent - Spaces
	SB.Append(MakeIndent(Indent))
	SB.Append("</tbody>")
	SB.Append(CRLF)
	
	Indent = Indent - Spaces
	SB.Append(MakeIndent(Indent))
	SB.Append("</table>")
	
	ParseDataMap.Clear
	Return SB.ToString
End Sub

Private Sub ApplyStyle(SB As StringBuilder, Table As Boolean, Header As Boolean)
	SB.Append($" style=""$)
	SB.Append($"border:${NumberFormat(pmBorderWidth.SelectedValue,1,0)}px ${cbxBorderStyle.SelectedItem} #${ColorToHex(lblBorderColor.Color).SubString(2)};"$)
	If cbxCSSuses.SelectedItem <> "None" Then SB.Append(CRLF)
	If cbTextAlign.Checked Then
		SB.Append($"text-align:${cbxTextAlign.SelectedItem};"$)
	End If
	If Table Then
		If cbBorderCollapse.Checked Then
			SB.Append($"border-collapse:collapse;"$)
		Else
			SB.Append($"border-spacing:${NumberFormat(pmBorderSpacing.SelectedValue,1,0)}px;"$)
		End If
		If cbTableWidth.Checked Then
			SB.Append($"width:${NumberFormat(pmTableWidth.SelectedValue,1,0)}${cbxTableWidth.SelectedItem};"$)
		End If
		If cbTableHeight.Checked Then
			SB.Append($"height:${NumberFormat(pmTableHeight.SelectedValue,1,0)}${cbxTableHeight.SelectedItem};"$)
		End If
		If cbCentreTable.Checked Then
			SB.Append("margin:auto;")
		End If
	End If
	If Header Then
		If cbHdrBackground.Checked Then
			SB.Append($"background-color:#${ColorToHex(lblHdrBackground.Color).SubString(2)};"$)
		End If
		If cbHeaderFontColor.Checked Then
			SB.Append($"color:#${ColorToHex(lblHeaderFontColor.Color).SubString(2)};"$)
		End If
	Else
		If cbDataBackground.Checked Then
			SB.Append($"background-color:#${ColorToHex(lblDataBackground.Color).SubString(2)};"$)
		End If
		If cbDataFontClr.Checked Then
			SB.Append($"color:#${ColorToHex(lblDataFontClr.Color).SubString(2)};"$)
		End If
	End If
	If cbPadding.Checked Then
		SB.Append($"padding:${NumberFormat(pmPadding.SelectedValue,1,0)}px;"$)
	End If
	SB.Append($"""$)
End Sub

Public Sub ColorToHex(clr As Int) As String
	Dim bc As ByteConverter
	Return bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr)))
End Sub


Private Sub MakeIndent(Indent As Int) As String
	Dim SB As StringBuilder
	SB.Initialize
	For i = 0 To Indent - 1
		SB.Append(" ")
	Next
	Return SB.ToString
End Sub


Private Sub cbNoStyle_CheckedChange(Checked As Boolean)
	
	Dim Panes() As Pane = Array As Pane(HEPane2,HEPane3,HEPane4)
	
	For Each P As Pane In Panes
		For i = 0 To P.NumberOfNodes - 1
			Dim V As B4XView = P.GetNode(i)
			If V = cbNoStyle Or V = cbNbsp Or V = cbClearData Then Continue
			If Checked Then
				ViewStateMap.Put(V,V.Enabled)
				V.Enabled = Not(Checked)
			Else
				If ViewStateMap.ContainsKey(V) Then	V.Enabled = ViewStateMap.Get(V)
			End If
			If Checked Then
				If V Is Label Or V Is CheckBox Then
					Dim VN As Node = V
					VN.SetAlphaAnimated(0,0.5)
				End If
			Else
				If V Is Label Or V Is CheckBox Then
					Dim VN As Node = V
					VN.SetAlphaAnimated(0,1)
				End If
			End If
		Next
	Next
'	pmBorderWidth.mBase.Enabled = Not(Checked)
'	pmBorderSpacing.mBase.Enabled = Not(Checked)
'	pmPadding.mBase.Enabled = Not(Checked)
'	pmTableHeight.mBase.Enabled = Not(Checked)
'	pmTableWidth.mBase.Enabled = Not(Checked)
	'
'	cbBorderCollapse.Enabled = Not(Checked)
'	cbCentreTable.Enabled = Not(Checked)
'	cbPadding.Enabled = Not(Checked)
'	cbTableHeight.Enabled = Not(Checked)
'	cbTableWidth.Enabled = Not(Checked)
'	
'	cbDataBackground.Enabled = Not(Checked)
'	cbDataFontClr.Enabled = Not(Checked)
'	cbHdrBackground.Enabled = Not(Checked)
'	cbHeaderFontColor.Enabled = Not(Checked)
'	cbHeaderRow.Enabled = Not(Checked)
'	cbNbsp.Enabled = Not(Checked)
'	cbTextAlign.Enabled = Not(Checked)
'	
'	cbxBorderStyle.mBase.Enabled = Not(Checked)
'	cbxCSSuses.mBase.Enabled = Not(Checked)
'	cbxTableHeight.mBase.Enabled = Not(Checked)
'	cbxTableWidth.mBase.Enabled = Not(Checked)
'	cbxTextAlign.mBase.Enabled = Not(Checked)
'	
'	lblBorderColor.Enabled = Not(Checked)
'	lblCssIdprefix.Enabled = Not(Checked)
'	lblDataBackground.Enabled = Not(Checked)
'	lblDataFontClr.Enabled = Not(Checked)
'	lblHdrBackground.Enabled = Not(Checked)
'	lblHeaderFontColor.Enabled = Not(Checked)
End Sub

Private Sub cbControl_CheckedChange(Checked As Boolean)
	Select Sender
		Case cbPadding
			pmPadding.mBase.Enabled = Checked
		Case cbTableWidth
			pmTableWidth.mBase.Enabled = Checked
			cbxTableWidth.mBase.Enabled = Checked
		Case cbTableHeight
			pmTableHeight.mBase.Enabled = Checked
			cbxTableHeight.mBase.Enabled = Checked
		Case cbHdrBackground
			lblHdrBackground.Enabled = Checked
		Case cbDataBackground
			lblDataBackground.Enabled = Checked
		Case cbHeaderFontColor
			lblHeaderFontColor.Enabled = Checked
		Case cbDataFontClr
			lblDataFontClr.Enabled = Checked
		Case cbBorderCollapse
			pmBorderSpacing.mBase.Enabled = Not(Checked)
		Case cbTextAlign
			cbxTextAlign.mBase.Enabled = Checked
	End Select
End Sub

Private Sub cbxCssUses_SelectedIndexChanged (Index As Int)
	
	Select cbxCSSuses.SelectedItem

		Case "None","Tag"
			lblCssIdprefix.Text = ""
			tfcssId.Text = ""
			tfcssId.Enabled = False
		Case "Class"
			lblCssIdprefix.Text = "."
			tfcssId.Enabled = True
		Case "Id"
			lblCssIdprefix.Text = "#"
			tfcssId.Enabled = True
	End Select
	
End Sub

Private Sub lblColor_MouseClicked (EventData As MouseEvent)
	Dim Lbl As B4XView = Sender
	
	CP.Initialize
	CP.SelectedColor = Bit.Or(Lbl.Color,0xFF000000)
	CP.NoAlpha = True
	Dialog.Title = "Choose a color"
	Wait For (Dialog.ShowTemplate(CP,"OK","","Cancel")) Complete (resp As Int)
	If resp = xui.DialogResponse_Cancel Then Return
	Lbl.Color = CP.SelectedColor

End Sub

Private Sub btnGenerate_Click
	If mRows = 0 Or mCols = 0 Then
		Dialog.Title = "Specify table Size"
		Wait For (Dialog.Show("Column and/or row size is 0","OK","","")) Complete (Resp As Int)
		Return
	End If
	
	Dim HTML As String = BuildHTML
	CallSub2(mCallBack,mEventName & "_Generated",HTML)
	'Do this after callback
	Hide
	ClearUI
'	Sleep(100)
	mCallBack.As(HTMLEditorWrapper).TextArea1.RequestFocus
End Sub

Private Sub btnCancel_Click
	Hide
	mCallBack.As(HTMLEditorWrapper).TextArea1.RequestFocus
End Sub

Public Sub ParseTable(Html As String) As ResumableSub
	
	ClearUI
	
'	Log("Parsing ... " & Html)
	
	'Dim KnownStylee As List = Array("border","border-collapse","border-spacing","text-align","width","height","margin","background-color","color","padding")
	
	ParseDataMap.Clear
	TableStyleMap.Clear
	HeaderStyleMap.Clear
	CellStyleMap.Clear
	SetStyleMap.Clear
	
	AddlTableStyleMap.Clear
	AddlHeaderStyleMap.Clear
	AddlCellStyleMap.Clear
	ParseErrorList.Clear
	

	
	mRows = 0
	mCols = 0
	
	
	
	Dim JS As JavaObject
	JS.InitializeStatic("org.jsoup.Jsoup")
	Dim Doc As JavaObject = JS.RunMethod("parse", Array(Html))
	
	'Currently unhandled tags
	Dim UnHandled As List = Doc.RunMethod("getElementsByTag",Array("caption")).As(List)
	If UnHandled.Size > 0 Then ParseErrorList.Add("caption")
	
	Dim UnHandled As List = Doc.RunMethod("getElementsByTag",Array("colgroup")).As(List)
	If UnHandled.Size > 0 Then ParseErrorList.Add("colgroup")
	
	Dim UnHandled As List = Doc.RunMethod("getElementsByTag",Array("col")).As(List)
	If UnHandled.Size > 0 Then ParseErrorList.Add("col")
	
	Dim UnHandled As List = Doc.RunMethod("getElementsByTag",Array("tfoot")).As(List)
	If UnHandled.Size > 0 Then ParseErrorList.Add("tfoot")
	
	
		
	Dim Table As JavaObject = Doc.RunMethod("getElementsByTag",Array("table")).As(List).Get(0)
	Dim PropStr As String = Table.RunMethod("attr",Array("style"))
	
	'Not yet used
	Dim ClassStr As String = Table.RunMethod("attr",Array("class"))
	If ClassStr <> "" Then TableStyleMap.Put("class",ClassStr)
	Dim IdStr As String = Table.RunMethod("attr",Array("id"))
	If IdStr <> "" Then TableStyleMap.Put("id",IdStr)
	
'	xxx
	
	If PropStr.Contains(";") Then
		Dim L As List = Regex.Split(";",PropStr)
		For Each S As String In L
			S = S.Trim
			Dim Pos As Int = S.IndexOf(":")
			AddToMap(TableStyleMap,S.SubString2(0,Pos),S.SubString(Pos + 1))
		Next
	End If
	If SetGui(TableStyleMap, False) = False Then
		Dialog.Title = "Error parsing table"
		Wait For(Dialog.Show("Could not recognise some of the styles. Aborting...","OK","","")) Complete (resp As Int)
		ClearUI
		Hide
		Return False
		
	End If
	
	Dim RowNo As Int = 0
	Dim Rows As List = Doc.RunMethod("getElementsByTag",Array("tr")).As(List)
	
	For Each Row As JavaObject In Rows
		Dim ParseDataList As List
		ParseDataList.Initialize
		
		Dim HeaderCells As List = Row.RunMethod("getElementsByTag",Array("th")).As(List)
		For Each HeaderCell As JavaObject In HeaderCells
			Dim PropStr As String = HeaderCell.RunMethod("attr",Array("style"))
			If PropStr.Contains(";") Then
				Dim L As List = Regex.Split(";",PropStr)
				For Each S As String In L
					S = S.Trim
					Dim Pos As Int = S.IndexOf(":")
					AddToMap(HeaderStyleMap,S.SubString2(0,Pos),S.SubString(Pos + 1))
				Next
			End If
			If HeaderCell.RunMethod("html",Null) = "&nbsp;" Then
				ParseDataList.Add("&nbsp;")
			Else
				ParseDataList.Add(HeaderCell.RunMethod("html",Null))
			End If
		Next
	
		If HeaderCells.Size > 0 Then
			ParseDataMap.Put(RowNo,ParseDataList)
			RowNo = RowNo + 1
			If SetGui(HeaderStyleMap, True) = False Then
				Dialog.Title = "Error parsing table"
				Wait For(Dialog.Show("Could not recognise some of the styles. Aborting...","OK","","")) Complete (resp As Int)
				ClearUI
				Hide
				Return False
			End If
'			Log("Data Update Row " & RowNo)
		End If
		
		
		Dim DataCells As List = Row.RunMethod("getElementsByTag",Array("td")).As(List)
		For Each Cell As JavaObject In DataCells
			Dim PropStr As String = Cell.RunMethod("attr",Array("style"))
			If PropStr.Contains(";") Then
				L = Regex.Split(";",PropStr)
				For Each S As String In L
					S = S.Trim
					Dim Pos As Int = S.IndexOf(":")
					AddToMap(CellStyleMap,S.SubString2(0,Pos),S.SubString(Pos + 1))
				Next
			End If
			If Cell.RunMethod("html",Null) = "&nbsp;" Then
				ParseDataList.Add("&nbsp;")
			Else
				ParseDataList.Add(Cell.RunMethod("html",Null))
			End If
		Next
		
		If DataCells.Size > 0 Then
			ParseDataMap.Put(RowNo,ParseDataList)
			RowNo = RowNo + 1
'			Log("Data Update Row " & RowNo)
		End If
	Next
	
'	Log("PDM " & ParseDataMap.Size)
'	
'		Dim l As List
'		
'	For Each K As Int In ParseDataMap.Keys
'		L.Initialize
'		L = ParseDataMap.GetDefault(K,L)
'		For Each S As String In L
'			Log(K & " : " & S)
'		Next
'	Next
	
	If SetGui(CellStyleMap, False) = False Then
		Dialog.Title = "Error parsing table"
		Wait For(Dialog.Show("Could not recognise some of the styles. Aborting...","OK","","")) Complete (resp As Int)
		ClearUI
		Hide
		Return False
	End If
	
	If CellStyleMap.Size = 0 And HeaderStyleMap.Size = 0 And TableStyleMap.Size = 0 Then cbNoStyle.Checked = True
	mRows = Rows.Size
	mCols = mCols + DataCells.Size
	
	If ParseErrorList.Size > 0 Then
		Dialog.Title = "Unrecognised or multiple Styles"
		Wait For(Dialog.Show("Table has unsupported or unrecognised styles or multiple different values. These will be lost","Edit","","Cancel")) Complete (resp As Int)
		If resp = xui.DialogResponse_Cancel Then
			ClearUI
			Hide
			Return False
		End If
	End If
	
	lblTableSize.Text = "Editing Table " & mCols & " X " & mRows
	Return True
End Sub

'Public Sub ParseTable(Html As String)
'	
'	ClearUI
'	ParseDataList.Clear
'	
'	Log("Parsing ... " & Html)
'	
'	'Dim KnownStylee As List = Array("border","border-collapse","border-spacing","text-align","width","height","margin","background-color","color","padding")
'	
'	TableStyleMap.Initialize
'	HeaderStyleMap.Initialize
'	CellStyleMap.Initialize
'	SetStyleMap.Initialize
'	
'	AddlTableStyleMap.Initialize
'	AddlHeaderStyleMap.Initialize
'	AddlCellStyleMap.Initialize
'	ParseErrorList.Initialize
'	
'	mRows = 0
'	mCols = 0
'	
'	
'	Dim JS As JavaObject
'	JS.InitializeStatic("org.jsoup.Jsoup")
'	Dim Doc As JavaObject = JS.RunMethod("parse", Array(Html))
'		
'	Dim Table As JavaObject = Doc.RunMethod("getElementsByTag",Array("table")).As(List).Get(0)
'	Dim PropStr As String = Table.RunMethod("attr",Array("style"))
'	
'	If PropStr.Contains(";") Then
'		Dim L As List = Regex.Split(";",PropStr)
'		For Each S As String In L
'			S = S.Trim
'			Dim Pos As Int = S.IndexOf(":")
'			AddToMap(TableStyleMap,S.SubString2(0,Pos),S.SubString(Pos + 1))
'		Next
'	End If
'	SetGui(TableStyleMap, False)
'	
'	Dim Headers As List = Doc.RunMethod("getElementsByTag",Array("th")).As(List)
'	For Each HeaderCell As JavaObject In Headers
'		Dim PropStr As String = HeaderCell.RunMethod("attr",Array("style"))
'		If PropStr.Contains(";") Then
'			Dim L As List = Regex.Split(";",PropStr)
'			For Each S As String In L
'				S = S.Trim
'				Dim Pos As Int = S.IndexOf(":")
'				AddToMap(HeaderStyleMap,S.SubString2(0,Pos),S.SubString(Pos + 1))
'			Next
'		End If
'		If HeaderCell.RunMethod("html",Null) = "&nbsp;" Then
'			ParseDataList.Add("&nbsp;")
'		Else
'			ParseDataList.Add(HeaderCell.RunMethod("text",Null))
'		End If
'	Next
'	
'	If Headers.Size > 0 Then SetGui(HeaderStyleMap, True)
'	
'	Dim Cells As List = Doc.RunMethod("getElementsByTag",Array("td")).As(List)
'	For Each Cell As JavaObject In Cells
'		Dim PropStr As String = Cell.RunMethod("attr",Array("style"))
'		If PropStr.Contains(";") Then
'			L = Regex.Split(";",PropStr)
'			For Each S As String In L
'				S = S.Trim
'				Dim Pos As Int = S.IndexOf(":")
'				AddToMap(CellStyleMap,S.SubString2(0,Pos),S.SubString(Pos + 1))
'			Next
'		End If
'		If Cell.RunMethod("html",Null) = "&nbsp;" Then
'			ParseDataList.Add("&nbsp;")
'		Else
'			ParseDataList.Add(Cell.RunMethod("text",Null))
'		End If
'	Next
'	mRows = Doc.RunMethod("getElementsByTag",Array("tr")).As(List).Size
'	mCols = mCols + (Cells.Size + Headers.Size) / mRows
'	
'	SetGui(CellStyleMap, False)
'	
'	lblTableSize.Text = mCols & " X " & mRows
'	
'End Sub

Private Sub AddToMap(M As Map,Key As String, Value As String)
	
	If M.ContainsKey(Key) Then
		If M.Get(Key) <> Value Then
			ParseErrorList.Add(Key)
			Return
		End If
		Return
	End If
	
	M.Put(Key,Value)
End Sub

Private Sub SetGui(PropsMap As Map, Header As Boolean) As Boolean
	
	If Header Then cbHeaderRow.Checked = True
	Try
		For Each S As String In PropsMap.Keys
			Select S
				Case "border"
'					Log("Border")
					Dim BorderStr As String = PropsMap.Get(S).As(String).Trim.ToLowerCase
					Do While BorderStr.Contains("  ")
						BorderStr = BorderStr.Replace("  "," ")
					Loop
					If BorderStr.Contains(", ") Then BorderStr = BorderStr.Replace(", ",",")
					If BorderStr.Contains(" ,") Then BorderStr = BorderStr.Replace(" ,",",")
				
					Dim Vals() As String = Regex.Split(" ",BorderStr)
					
					Dim IVal As String = Vals(0).Trim.Replace("px","").Replace("%","")
					If IsNumber(IVal) = False Then Return False
					pmBorderWidth.SelectedValue = IVal
					cbxBorderStyle.SelectedIndex = cbxBorderStyle.IndexOf(Vals(1).Trim)
				
					Dim Color As JavaObject
					Color.InitializeStatic("javafx.scene.paint.Color")
					lblBorderColor.Color = xui.PaintOrColorToColor(Color.RunMethod("web",Array(Vals(2))))
				Case "border-style"
'					Log("BS *"&PropsMap.Get(S) & "*")
					Dim BorderStr As String = PropsMap.Get(S).As(String).Trim.ToLowerCase
					Do While BorderStr.Contains("  ")
						BorderStr = BorderStr.Replace("  "," ")
					Loop
					If BorderStr.Contains(" ") Then
						'More than 1 value present, can't handle that
						ParseErrorList.Add(S)
					Else
						cbxBorderStyle.SelectedIndex = cbxBorderStyle.IndexOf(PropsMap.Get(S))
					End If
				Case "border-width"
					Dim IVal As String = PropsMap.Get(S).As(String).Trim.Replace("px","").Replace("%","")
					If IsNumber(IVal) = False Then Return False
					pmBorderWidth.SelectedValue = IVal
				Case "border-color"
					Dim Color As JavaObject
					Color.InitializeStatic("javafx.scene.paint.Color")
					Dim ColorStr As String = PropsMap.Get(S)
					Do While ColorStr.Contains("  ")
						ColorStr = ColorStr.Replace("  "," ")
					Loop
					If ColorStr.Contains(", ") Then ColorStr = ColorStr.Replace(", ",",")
					If ColorStr.Contains(" ,") Then ColorStr = ColorStr.Replace(" ,",",")
					lblBorderColor.Color = xui.PaintOrColorToColor(Color.RunMethod("web",Array(ColorStr)))
				
				Case "border-collapse"
					cbBorderCollapse.Checked = PropsMap.Get(S) = "collapse"
				
				Case "border-spacing"
					cbBorderCollapse.Checked = False
					Dim IVal As String = PropsMap.Get(S).As(String).Trim.Replace("px","").Replace("%","")
					If IsNumber(IVal) = False Then Return False
					pmBorderSpacing.SelectedValue = IVal
				Case "text-align"
					cbTextAlign.Checked = True
					cbxTextAlign.SelectedIndex = cbxTextAlign.IndexOf(PropsMap.Get(S))
				Case "width"
					cbTableWidth.Checked = True
					Dim Val As String = PropsMap.Get(S)
					If Val.EndsWith("px") Then
						cbxTableWidth.SelectedIndex = cbxTableWidth.IndexOf("px")
					Else
						cbxTableWidth.SelectedIndex = cbxTableWidth.IndexOf("%")
					End If
					Dim IVal As String = Val.Replace("px","").Replace("%","")
					If IsNumber(IVal) = False Then Return False
					pmTableWidth.SelectedValue = IVal
				Case "height"
					cbTableHeight.Checked = True
					Dim Val As String = PropsMap.Get(S)
					If Val.EndsWith("px") Then
						cbxTableHeight.SelectedIndex = cbxTableHeight.IndexOf("px")
					Else
						cbxTableHeight.SelectedIndex = cbxTableHeight.IndexOf("%")
					End If
					Dim IVal As String = Val.Replace("px","").Replace("%","")
					If IsNumber(IVal) = False Then Return False
					pmTableHeight.SelectedValue = IVal
				Case "margin"
					cbCentreTable.Checked = True
				Case "background-color"
					If Header Then
						cbHeaderRow.Checked = True
						cbHdrBackground.Checked = True
						lblHdrBackground.Color = HTMLEW_Utils.HexToInt("ff" & PropsMap.Get(S).As(String).SubString(1))
					Else
						cbDataBackground.Checked = True
						lblDataBackground.Color = HTMLEW_Utils.HexToInt("ff" & PropsMap.Get(S).As(String).SubString(1))
					End If
				
				Case "color"
					If Header Then
						cbHeaderFontColor.Checked = True
						lblHeaderFontColor.Color = HTMLEW_Utils.HexToInt("ff" & PropsMap.Get(S).As(String).SubString(1))
					Else
						cbDataFontClr.Checked = True
						lblDataFontClr.Color = HTMLEW_Utils.HexToInt("ff" & PropsMap.Get(S).As(String).SubString(1))
					End If
				Case "padding"
					cbPadding.Checked = True
					Dim IVal As String = PropsMap.Get(S).As(String).Replace("px","").Replace("%","")
					If IsNumber(IVal) = False Then Return False
					pmPadding.SelectedValue = IVal
				Case Else
					ParseErrorList.Add(S)
'					Log("Extra css " & S)
			End Select
		Next
	Catch
		Log(LastException)
		Return False
	End Try
	Return True
End Sub

Private Sub cbHeaderRow_CheckedChange(Checked As Boolean)
	cbHdrBackground.Enabled = Checked
	cbHeaderFontColor.Enabled = Checked
End Sub

'Private Sub ParsePropLine(CSSTag As String,Line As String) As List
'	
'	Dim L As List
'	L.Initialize
'	Select CSSTag
'		Case "table"
'			Dim Pos As Int = Line.ToLowerCase.IndexOf("style")
'			Pos = Line.IndexOf2($"""$,Pos)
'			Dim LastPos As Int = Line.LastIndexOf($"""$)
'			
'			Dim Props As List = Regex.Split(";",Line.SubString2(Pos,LastPos))
'			Dim PropMap As Map
'			PropMap.Initialize
'			For Each Prop As String In Props
'				Dim PParts As List = Regex.Split(Prop,":")
'				If PParts.Size = 2 Then
'					PropMap.Put(PParts.Get(0),PParts.Get(1))
'				End If
'			Next
'	End Select
'	
'	
'	
'	
'	Return L
'End Sub