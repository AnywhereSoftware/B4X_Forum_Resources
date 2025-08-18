B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8
@EndOfDesignText@

'********************************************************************************************************
' xComboBox v1.00
' Created by Alberto Iglesias (alberto@visualnet.inf.br)
'********************************************************************************************************

#Event: Selected (Selection As String,Canceled as Boolean)
#DesignerProperty: Key: CloseImage, DisplayName: Close Image, FieldType: String, DefaultValue: 

'****** COMBOBOX COLORS AND LAYOUT ******
#DesignerProperty: Key: Editable, DisplayName: Editable, FieldType: Boolean, DefaultValue: true

#DesignerProperty: Key: ComboForeColor, DisplayName: Combo ForeColor, FieldType: Color, DefaultValue: #FF000000
#DesignerProperty: Key: ComboBackColor, DisplayName: Combo BackColor, FieldType: Color, DefaultValue: #FFFFFFFF
#DesignerProperty: Key: BorderCornerRadius, DisplayName: Border Corner Radius, FieldType: Int, DefaultValue: 10
#DesignerProperty: Key: CharAwesome, DisplayName: Character from FontAwesome, FieldType: Int, DefaultValue: 61555

'****** ITEM LIST COLORS AND SIZES ******
#DesignerProperty: Key: PanelWidth, DisplayName: Panel Width, FieldType: Int, DefaultValue: 320
#DesignerProperty: Key: PanelHeight, DisplayName: Panel Height, FieldType: Int, DefaultValue: 300
#DesignerProperty: Key: PanelMargin, DisplayName: Panel Margin, FieldType: Int, DefaultValue: 5
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: #FFFFFFFF
#DesignerProperty: Key: ItemRowHeight, DisplayName: Item Row Height, FieldType: Int, DefaultValue: 25

'*** MAIN LINE ***
#DesignerProperty: Key: ItemColor, DisplayName: Item Color, FieldType: Color, DefaultValue: #FF000000
#DesignerProperty: Key: ItemTextSize, DisplayName: Item TextSize, FieldType: Int, DefaultValue: 13

'*** SECOND LINE ***
#DesignerProperty: Key: SecondColor, DisplayName: Second Color, FieldType: Color, DefaultValue: #FFA9A9A9
#DesignerProperty: Key: SecondTextSize, DisplayName: Second TextSize, FieldType: Int, DefaultValue: 11

'****** IMAGE SIZE AND LAYOUT ******
#DesignerProperty: Key: ImageHeight, DisplayName: Image Height, FieldType: Int, DefaultValue: 25, MinRange: 5, MaxRange: 200
#DesignerProperty: Key: ImageWidth, DisplayName: Image Width, FieldType: Int, DefaultValue: 25, MinRange: 5, MaxRange: 200
#DesignerProperty: Key: ImageTop, DisplayName: Image Top, FieldType: Int, DefaultValue: 10
#DesignerProperty: Key: ImageLeft, DisplayName: Image Left, FieldType: Int, DefaultValue: 10

'#DesignerProperty: Key: SelectedColor, DisplayName: Selected Color, FieldType: Color, DefaultValue: 0xFF0BA29B
'#DesignerProperty: Key: HighlightedColor, DisplayName: Highlighted Color, FieldType: Color, DefaultValue: 0xFFABFFFB

Sub Class_Globals
	Private xui As XUI
	Private EventName As String
	Private CallBack As Object
	
	Private boxW, boxH As Float
	Private vCorrection As Float

	Private comboField As B4XView
	Private btnOpen As B4XView
	Private pnlDialog As B4XView
	Private MainPanel As B4XView
	Private mBase As B4XView
	Private visible As Boolean
	
	Private lstRows As List
	Private lstImages As List
	Private lstSecondLine As List
	
	Private gEditable As Boolean
End Sub

Public Sub Initialize (vCallback As Object, vEventName As String)
	EventName = vEventName
	CallBack = vCallback
	lstRows.Initialize
	lstSecondLine.Initialize
	lstImages.Initialize
End Sub

Public Sub Add(pItem As String, pSecondLine As String, pImage As String)
	lstRows.Add(pItem)
	If pImage.Trim <> "" Then  lstImages.Add(pImage)
	lstSecondLine.Add(pSecondLine)
End Sub

private Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)   'ignore
	mBase = Base
	Dim mlbl As B4XView = Lbl
	
#if B4A
	MainPanel = Props.Get("activity")
	Dim df As EditText
	df.Initialize("comboField")
	
	df.SingleLine = True
	Dim b As Button
	b.Initialize("btnOpen")
	b.Typeface = Typeface.FONTAWESOME
#end if
	
#if B4i
	MainPanel = Props.Get("page")
	Dim df As TextField
	df.Initialize("comboField")
	Dim b As Button
	b.Initialize("btnOpen", b.STYLE_SYSTEM)
	b.CustomLabel.Font = Font.CreateFontAwesome(25)
	'b.CustomLabel.TextColor = Colors.Red
	b.TintColor = xui.PaintOrColorToColor(Props.Get("ComboForeColor"))
#end if

	gEditable = Props.Get("Editable")
	df.Enabled = gEditable

	btnOpen = b
	comboField = df
	comboField.Font = mlbl.Font
	comboField.Color = xui.Color_White
	comboField.TextColor = mlbl.TextColor
	
	comboField.Enabled = gEditable
	
	comboField.Color = xui.PaintOrColorToColor(Props.Get("ComboBackColor"))
	comboField.TextColor= xui.PaintOrColorToColor(Props.Get("ComboForeColor"))
	btnOpen.TextColor = comboField.TextColor
	btnOpen.Color = comboField.Color
	
	Dim iChar As Int = Props.Get("CharAwesome")
	btnOpen.Text = Chr(iChar)
	'btnOpen.Text = Chr(0xF073)

	mBase.AddView(comboField, 0,0,0,0)
	mBase.AddView(btnOpen, 0,0,0,0)
	'It is not possible to load a layout file directly from DesignerCreateView.
	Sleep(0)
	
   '===================================================================
	Dim iPanelWidth As Int = 0
	Dim iPanelHeight As Int = 0
	
	If Props.Get("PanelWidth") <> Null Then iPanelWidth = DipToCurrent(Props.Get("PanelWidth"))
	If Props.Get("PanelHeight") <> Null Then iPanelHeight = DipToCurrent(Props.Get("PanelHeight"))
		
   
	pnlDialog = xui.CreatePanel("")
	MainPanel.AddView(pnlDialog, 0, 0, iPanelWidth,iPanelHeight)
	'pnlDialog.LoadLayout("ComboBox")
	pnlDialog.Visible = False

	
	'*********** TRANSFORM INT TO DIP ********************************************
'	Dim iBorderCornerRadius As Int = Props.Get("BorderCornerRadius")
'	LogColor("iBorderCornerRadius1=" & iBorderCornerRadius,Colors.Blue)
'	iBorderCornerRadius = iBorderCornerRadius / GetDeviceLayoutValues.Scale
'	LogColor("iBorderCornerRadius2=" & iBorderCornerRadius,Colors.Blue)
'	LogColor("iBorderCornerRadius3=" & DipToCurrent(Props.Get("BorderCornerRadius")),Colors.Blue)
'	LogColor("10dip DtC=" & DipToCurrent(10),Colors.Blue)
'	LogColor("10dip=" & 10dip,Colors.Blue)
	Dim iBorderCornerRadius As Int = DipToCurrent(Props.Get("BorderCornerRadius"))
	'******************************************************************************
	


	'iBorderCornerRadius As Int = Props.Get("BorderCornerRadius")
	 'iBorderCornerRadius = iBorderCornerRadius / GetDeviceLayoutValues.Scale
	
'#If B4A
	'BorderCornerRadius = Props.Get("BorderCornerRadius")
	'rderCornerRadius = BorderCornerRadius / GetDeviceLayoutValues.Scale
'#End If
	
	pnlDialog.SetColorAndBorder(xui.PaintOrColorToColor(Props.Get("BackgroundColor")), 1dip, xui.Color_Black, iBorderCornerRadius)
	pnlDialog.Tag = Me
	'===================================================================
	
	Dim iItemRowHeight As Int = DipToCurrent(Props.Get("ItemRowHeight"))
	
	'===== LIST VIEW  =========================================================
	#If B4A
		Dim objListview As ListView
		objListview.Initialize("objListview")
	#End If

	#If B4i
		Dim objListview As TableView
		objListview.Initialize("objListview",False)
		objListview.RowHeight = iItemRowHeight
	#End If
	
	'***************************************************************************
	objListview.Clear
	'***************************************************************************
	
	If lstImages.Size > 0 Then
		For a = 0 To lstImages.Size -1
			Dim strImage As String = lstImages.Get(a)
			
			Dim bmpIcon As Bitmap = LoadBitmap(File.DirAssets,strImage)
			
			#If B4i
			    'Dim tc As TableCell = objListview.AddTwoLines(lstRows.Get(a),lstSecondLine.Get(a))
		    	Dim tc As TableCell = objListview.AddTwoLines("","")
		
				Dim ColoredLine As AttributedString
			    ColoredLine.Initialize(lstRows.Get(a), Font.CreateNew(Props.Get("ItemTextSize")),  xui.PaintOrColorToColor(Props.Get("ItemColor")))
			    tc.Text = ColoredLine

				Dim ColoredSecondLine As AttributedString
		    	ColoredSecondLine.Initialize(lstSecondLine.Get(a), Font.CreateNew(Props.Get("SecondTextSize")),  xui.PaintOrColorToColor(Props.Get("SecondColor")))
			    tc.DetailText = ColoredSecondLine
				
			    tc.Bitmap = bmpIcon
			#End If
			
			
			#If B4A
				objListview.TwoLinesAndBitmap.ItemHeight = iItemRowHeight

				objListview.TwoLinesAndBitmap.Label.TextColor = xui.PaintOrColorToColor(Props.Get("ItemColor"))
				objListview.TwoLinesAndBitmap.Label.TextSize = Props.Get("ItemTextSize")
				
				objListview.TwoLinesAndBitmap.SecondLabel.TextColor = xui.PaintOrColorToColor(Props.Get("SecondColor"))
				objListview.TwoLinesAndBitmap.SecondLabel.TextSize = Props.Get("SecondTextSize")
							
				objListview.TwoLinesAndBitmap.ImageView.Gravity = Gravity.FILL
				
				objListview.TwoLinesAndBitmap.ImageView.Height = DipToCurrent(Props.Get("ImageHeight"))
				objListview.TwoLinesAndBitmap.ImageView.Width = DipToCurrent(Props.Get("ImageWidth"))
				objListview.TwoLinesAndBitmap.ImageView.Top = DipToCurrent(Props.Get("ImageTop"))
				objListview.TwoLinesAndBitmap.ImageView.Left = DipToCurrent(Props.Get("ImageLeft"))

				objListview.AddTwoLinesAndBitmap2(lstRows.Get(a),lstSecondLine.Get(a),bmpIcon,lstRows.Get(a))
			#End If

		Next
	Else
		
		For a = 0 To lstRows.Size -1
			Dim strItem As String = lstRows.Get(a)
			
			#If B4i
			    Dim tc As TableCell = objListview.AddSingleLine(strItem)
				
				Dim ColoredTitle As AttributedString
		     	ColoredTitle.Initialize(strItem, Font.CreateNew(Props.Get("ItemTextSize")),  xui.PaintOrColorToColor(Props.Get("ItemColor")))
		    	tc.Text = ColoredTitle	
			#End If
			
			#If B4A
				objListview.SingleLineLayout.Label.TextColor = xui.PaintOrColorToColor(Props.Get("ItemColor"))
				objListview.SingleLineLayout.Label.TextSize = Props.Get("ItemTextSize")
				objListview.SingleLineLayout.ItemHeight = iItemRowHeight
				objListview.AddSingleLine(strItem)			
			#End If
			
		Next

	End If 
	
	#if B4i
	    objListview.ReloadAll
	#End If
   '***************************************************************************
	
   '============================================================================
	Dim iPanelMargin As Int = DipToCurrent(Props.Get("PanelMargin"))
	pnlDialog.AddView(objListview,iPanelMargin,iPanelMargin,pnlDialog.Width-(iPanelMargin*2),pnlDialog.Height-(iPanelMargin*2))
   '============================================================================
	
	Dim strCloseImage As String = Props.Get("CloseImage")
	'===== CLOSE BUTTON =========================================================
	Dim objButtonClose As ImageView
	objButtonClose.Initialize("objButtonClose")
    If File.Exists(File.DirAssets,strCloseImage) Then 
	   objButtonClose.Bitmap = LoadBitmap(File.DirAssets,strCloseImage)
	   #If B4A
	       objButtonClose.Gravity = Gravity.FILL
	   #End If
	End If 
	pnlDialog.AddView(objButtonClose,pnlDialog.Width-30dip,5dip,25dip,25dip)
	objButtonClose.BringToFront
	'============================================================================
	
#if B4A
	Dim p As Panel = pnlDialog
	p.Elevation = 4dip
#End If

	' selectedColor = xui.PaintOrColorToColor(Props.Get("SelectedColor"))
	' tempSelectedColor = xui.PaintOrColorToColor(Props.Get("HighlightedColor"))

'	boxW = cvs.TargetRect.Width / 7
'	boxH = cvs.TargetRect.Height / 6
'	vCorrection = 5dip
'	If xui.IsB4i Then vCorrection = 9dip

	Base_Resize(mBase.Width, mBase.Height)
End Sub


#if B4A
Private Sub objListview_ItemClick (Position As Int, Value As Object)
	Dim strRet As String = Value
	comboField.Text = strRet
	comboField.Enabled = gEditable
	
	Hide
	CallSub3(CallBack, EventName & "_Selected", strRet,False)
End Sub
#End If

#if B4i
Sub objListview_SelectedChanged (SectionIndex As Int, Cell As TableCell)
	
	Dim strRet As String = Cell.Text.ToString
	comboField.Text = strRet
	comboField.Enabled = gEditable	
	Hide
	CallSub3(CallBack, EventName & "_Selected", strRet,False)
	
End Sub
#End If

Private Sub Base_Resize (Width As Double, Height As Double)
	comboField.SetLayoutAnimated(0, 0, 0, Width - Height, Height)
	btnOpen.SetLayoutAnimated(0, Max(0, Width - Height), 0, Height, Height)
End Sub

Private Sub BtnOpen_Click
	Show
End Sub


Private Sub Show
	If visible Then Return
	' CloseAllDialogs
	visible = True
	
'	Dim objButtonClose As Button
'	objButtonClose.Initialize("objButtonClose")
'	objButtonClose.Text = "Close"
'	objButtonClose.TextColor = Colors.Black
'	objButtonClose.Color = Colors.White
'	pnlDialog.AddView(objButtonClose,0,0,100dip,50dip)
'	
'	Dim objListview As ListView
'	objListview.Initialize("objListview")
'	objListview.Clear
'	For a = 1 To 20
'	    objListview.AddSingleLine(a & " - aaaaaaaaaaa")
'	Next
'	
'	pnlDialog.AddView(objListview,0,0,pnlDialog.Width,pnlDialog.Height)

	
	pnlDialog.SetLayoutAnimated(0, MainPanel.Width / 2 - pnlDialog.Width / 2, MainPanel.Height / 2 - pnlDialog.Height / 2, pnlDialog.Width, pnlDialog.Height)
	pnlDialog.BringToFront
	pnlDialog.SetVisibleAnimated(200, True)
	
End Sub

Public Sub Hide
	If visible = False Then Return
	pnlDialog.SetVisibleAnimated(200, False)
	'comboField.Enabled = True
	visible = False
End Sub




Public Sub ShowCombo(bShow As Boolean)
	
	If bShow Then 
		mBase.Visible = True
	Else
		Hide
		mBase.Visible = False
	End If
	
End Sub




Public Sub getIsVisible As Boolean
	Return visible
End Sub

Public Sub getText As String
	Return comboField.Text
End Sub

'Returns true if there was a visible dialog
'Public Sub CloseAllDialogs As Boolean
'	Dim res As Boolean = False
'	For i = 0 To MainPanel.NumberOfViews - 1
'		Dim x As B4XView = MainPanel.GetView(i)
'		If x.Tag Is ComboBox Then
'		   Dim adp As ComboBox = x.Tag
'		   adp.Hide
'		   res = True
'		End If
'	Next
'	Return res
'End Sub

Private Sub objButtonClose_Click	
		CallSub3(CallBack, EventName & "_Selected", "",True)
		Hide
End Sub
