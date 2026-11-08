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
	Private cbPadding As B4XView
	Private cbTableHeight As B4XView
	Private cbTableWidth As B4XView
	
	Private cbDataBackground As B4XView
	Private cbDataFontClr As B4XView
	Private cbHdrBackground As B4XView
	Private cbHeaderFontColor As B4XView
	Private cbHeaderRow As B4XView
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
	Private Popup As JavaObject

	Private mForm As Form
	Private mOwnerNode As Node
	Dim CP As SL_B4XColorTemplate
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	Popup.InitializeNewInstance("javafx.stage.Popup",Null)
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	mBase.RemoveViewFromParent
	Popup.RunMethodJO("getContent",Null).RunMethod("add",Array(mBase))
	Popup.RunMethod("setAutoHide",Array(True))	

	mBase.LoadLayout("htmltableminilayout")

	mBase.As(Node).StyleClasses.add("html-tables")
	
	
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

Public Sub Show(OwnerNode As Node)
	mOwnerNode = OwnerNode
'	Dim Pos() As Double = HTMLEW_Utils.GetScreenPosition(OwnerNode)
	Dim stage As JavaObject = mForm.As(JavaObject).GetField("stage")
	Popup.RunMethod("show",Array(stage))
	Dim P2d As JavaObject = OwnerNode.As(JavaObject).RunMethod("localToScene",Array(0.0,0.0))
	Popup.RunMethod("setX",Array(stage.RunMethod("getX",Null) + P2d.RunMethod("getX",Null)-50))
	Popup.RunMethod("setY",Array(stage.RunMethod("getY",Null) + P2d.RunMethod("getY",Null) + 65))
'	,stage.RunMethod("getY",Null) + P2d.RunMethod("getY",Null) + 40)
'	, P2d.RunMethod("getX",Null), stage.RunMethod("getY",Null) + P2d.RunMethod("getY",Null)))
	'mForm.As(JavaObject).GetField("stage")
End Sub

Public Sub Hide
	Popup.RunMethod("hide",Null)
End Sub

Private Sub ClearUI
	cbxBorderStyle.SelectedIndex = 1
	cbxCSSuses.SelectedIndex = 0
	cbxCssUses_SelectedIndexChanged (0)
	cbxTableHeight.SelectedIndex = 0
	cbxTableWidth.SelectedIndex = 0
	cbxTextAlign.SelectedIndex = 0
	
	cbBorderCollapse.Checked = True
	cbCentreTable.Checked = False
	cbDataFontClr.Checked = False
	cbDataBackground.Checked = False
	cbHdrBackground.Checked = False
	cbHeaderFontColor.Checked = False
	cbHeaderRow.Checked = False
	cbPadding.Checked = False
	cbTableHeight.Checked = False
	cbTableWidth.Checked = False
	cbTextAlign.Checked = False
	
	pmBorderWidth.SelectedValue = 1
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
	lblTableSize.Text = ""
		
	tfcssId.Text = ""
End Sub

public Sub getBase As B4XView
	Return mBase
End Sub

Private Sub SelectSize1_Selected(Cols As Int, Rows As Int)
'	Log($"Cols ${Cols} X Rows ${Rows}"$)
	mCols = Cols
	mRows = Rows
	lblTableSize.Text = Cols & " X " & Rows
End Sub

Private Sub BuildHTML As String
	Dim Spaces As Int = 4
	Dim Indent As Int = 0
	
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append(MakeIndent(Indent))
	SB.Append($"<table style="border:1px solid #${ColorToHex(lblBorderColor.Color).SubString(2)};"$)
	If cbBorderCollapse.Checked Then SB.Append("border-collapse:collapse;")
	If cbCentreTable.Checked Then SB.Append("margin:auto;")
	If pmTableWidth.SelectedValue > 0 Then SB.Append($"width:${NumberFormat(pmTableWidth.SelectedValue,1,0)}px;"$)
	SB.Append($"">"$)
	SB.Append(CRLF)
	Indent = Indent + Spaces
	SB.Append(MakeIndent(Indent))
	SB.Append("<tbody>")
	Indent = Indent + Spaces
	For i = 0 To mRows - 1
		SB.Append(CRLF)
		SB.Append(MakeIndent(Indent))
		SB.Append("<tr>")
		Indent = Indent + Spaces
		For j = 0 To mCols - 1
			SB.Append(CRLF)
			SB.Append(MakeIndent(Indent))
			SB.Append($"<td style="border:1px solid #${ColorToHex(lblBorderColor.Color).SubString(2)};">&nbsp;</td>"$)
'			SB.Append($"<td style="border:1px solid #${ColorToHex(lblBorderColor.Color).SubString(2)};">C${j}:R${i}</td>"$)
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
	
	Return SB.ToString
End Sub

'Private Sub ApplyStyle(SB As StringBuilder, Table As Boolean, Header As Boolean)
'	SB.Append($" style = ""$)
'	SB.Append($"border:${NumberFormat(pmBorderWidth.SelectedValue,1,0)}px ${cbxBorderStyle.SelectedItem} #${ColorToHex(lblBorderColor.Color).SubString(2)};"$)
'	If cbxCSSuses.SelectedItem <> "None" Then SB.Append(CRLF)
'	If cbTextAlign.Checked Then
'		SB.Append($"text-align:${cbxTextAlign.SelectedItem};"$)
'	End If
'	If Table Then
'		If cbBorderCollapse.Checked Then
'			SB.Append($"border-collapse:collapse;"$)
'		Else
'			SB.Append($"border-spacing:${NumberFormat(pmBorderSpacing.SelectedValue,1,0)}px;"$)
'		End If
'		If cbTableWidth.Checked Then
'			SB.Append($"width:${NumberFormat(pmTableWidth.SelectedValue,1,0)}${cbxTableWidth.SelectedItem};"$)
'		End If
'		If cbTableHeight.Checked Then
'			SB.Append($"height:${NumberFormat(pmTableHeight.SelectedValue,1,0)}${cbxTableHeight.SelectedItem};"$)
'		End If
'		If cbCentreTable.Checked Then
'			SB.Append("margin:auto;")
'		End If
'	End If
'	If Header Then
'		If cbHeaderFontColor.Checked Then
'			SB.Append($"color:#${ColorToHex(lblHeaderFontColor.Color).SubString(2)};"$)
'		End If
'		If cbHdrBackground.Checked Then
'			SB.Append($"background-color:#${ColorToHex(lblHdrBackground.Color).SubString(2)};"$)
'		End If
'	Else
'		If cbDataBackground.Checked Then
'			SB.Append($"background-color:#${ColorToHex(lblDataBackground.Color).SubString(2)};"$)
'		End If
'		If cbDataFontClr.Checked Then
'			SB.Append($"color:#${ColorToHex(lblDataFontClr.Color).SubString(2)};"$)
'		End If
'	End If
'	If cbPadding.Checked Then
'		SB.Append($"padding:${NumberFormat(pmPadding.SelectedValue,1,0)}px;"$)
'	End If
'	SB.Append($"""$)
'End Sub

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
'	Dim Lbl As B4XView = Sender
'	Dim CP As B4XColorTemplate
'	CP.Initialize
'	CP.SelectedColor = Bit.Or(Lbl.Color,0xFF000000)
'	
'	Wait For (Dialog.ShowTemplate(CP,"OK","","Cancel")) Complete (Resp As Int)
'	If Resp = xui.DialogResponse_Cancel Then Return
'	Lbl.Color = CP.SelectedColor
'	Show(mOwnerNode)
	
	Dim Lbl As B4XView = Sender

	CP.Initialize
	CP.SelectedColor = Bit.Or(Lbl.Color,0xFF000000)
	Dialog.Title = "Choose a color"
	CP.NoAlpha = True
	Wait For (Dialog.ShowTemplate(CP,"OK","","Cancel")) Complete (Resp As Int)
	If Resp = xui.DialogResponse_Cancel Then Return
	Lbl.Color = CP.SelectedColor
	Show(mOwnerNode)
End Sub

Private Sub btnGenerate_Click
	If mRows = 0 Or mCols = 0 Then
		Dialog.Title = "Specify table Size"
		Wait For (Dialog.Show("Column and/or row size is 0","OK","","")) Complete (Resp As Int)
		Show(mOwnerNode)
		Return
	End If
	Hide
	Dim HTML As String = BuildHTML
'	Log(HTML)
	Dim fx As JFX
	fx.Clipboard.SetString(HTML)
	CallSub2(mCallBack,mEventName & "_Generated",HTML)
	ClearUI
End Sub
