B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
#Event: selected (index as int, value As string)
#Event: changed (index as int, value As string)
#Event: opened ()

#if B4j
#DesignerProperty: Key: ExpandHeight, DisplayName: Expanded Height, FieldType: Int, DefaultValue: 120, MinRange: 10, MaxRange: 1000
#else
#DesignerProperty: Key: ExpandHeight, DisplayName: Expanded Height, FieldType: Int, DefaultValue: 120, MinRange: 10, MaxRange: 1000
#End If

#if B4j

#DesignerProperty: Key: FontSize, DisplayName: Font Size, FieldType: Int, DefaultValue: 14, MinRange: 2, MaxRange: 100
#DesignerProperty: Key: FontType, DisplayName: Font Type, FieldType: String, DefaultValue: DEFAULT, List: DEFAULT|Arial|Arial Black|Arial Narrow|Arial Rounded MT Bold|Arial Unicode MS|Brush Script MT|Comic Sans MS|Courier New|Georgia|Impact|Lucida Bright|Lucida Sans|Lucida Sans Typewriter|Microsoft Sans Serif|Monospaced|Papyrus|SanSerif|Serif|Symbol|System|Tacoma|Times New Roman|Trebuchet MS|Verdana
#else if b4a
#DesignerProperty: Key: FontSize, DisplayName: Font Size, FieldType: Int, DefaultValue: 16, MinRange: 2, MaxRange: 100
#DesignerProperty: Key: FontType, DisplayName: Font Type, FieldType: String, DefaultValue: DEFAULT, List: DEFAULT|DEFAULT_BOLD|MONOSPACE|SANS_SERIF|SERIF
#else if b4i
#DesignerProperty: Key: FontType, DisplayName: Font Type, FieldType: String, DefaultValue: DEFAULT, List: DEFAULT|DEFAULT_BOLD|ArialMT|Arial-BoldMT|Arial-ItalicMT|Arial-BoldItalicMT|Courier|Courier-Bold|Georgia|Georgia-Bold|Georgia-BoldItalic|Georgia-Italic|Helvetica|Helvetica-Bold|HelveticaNeue|HelveticaNeue-Bold|helvetica-BoldItalic|Helvetica-Italic|TimesNewRomanPSMT|TimesNewRomanPS-BoldMT
#DesignerProperty: Key: FontSize, DisplayName: Font Size, FieldType: Int, DefaultValue: 16, MinRange: 2, MaxRange: 100
#End If

#DesignerProperty: Key: ButtonTopColor, DisplayName: Button Top Color, FieldType: Color, DefaultValue: #FFF1F1F1
#DesignerProperty: Key: ButtonBottomColor, DisplayName: Button Bottom Color, FieldType: Color, DefaultValue: #FFCECECE

#if B4j
#DesignerProperty: Key: ButtonTopHoverColor, DisplayName: Button Top Hover, FieldType: Color, DefaultValue: #FFF1F1F1
#DesignerProperty: Key: ButtonBottomHoverColor, DisplayName: Button Bottom Hover, FieldType: Color, DefaultValue: #FFE3E3E3
#End If

#DesignerProperty: Key: CLVBackground, DisplayName: CLV Background Color, FieldType: Color, DefaultValue: #FFFFFFFF

#if B4j
#DesignerProperty: Key: CLVHover, DisplayName: CLV Hover Color, FieldType: Color, DefaultValue: #FF0096C9
#End If

#DesignerProperty: Key: Color1, DisplayName: Text Color colorkey=0, FieldType: Color, DefaultValue: #FF000000
#DesignerProperty: Key: Color2, DisplayName: Text Color colorkey=1, FieldType: Color, DefaultValue: #FFFF0000
#DesignerProperty: Key: Color3, DisplayName: Text Color colorkey=2, FieldType: Color, DefaultValue: #FF0000FF
#DesignerProperty: Key: Color4, DisplayName: Text Color colorkey=3, FieldType: Color, DefaultValue: #FF458B00
#DesignerProperty: Key: Color5, DisplayName: Text Color colorkey=4, FieldType: Color, DefaultValue: #FF4928A9
#DesignerProperty: Key: Color6, DisplayName: Text Color colorkey=5, FieldType: Color, DefaultValue: #FFFF5700

'#DesignerProperty: Key: DisableType, DisplayName: Disable Type, Fieldtype: Int, DefaultValue: 0, MinRange: 0, MaxRange: 1
#DesignerProperty: Key: DisableType, DisplayName: Disable Type, FieldType: String, DefaultValue: String, List: String|Background
#DesignerProperty: Key: DisableColor, DisplayName: Disable Color, FieldType: Color, DefaultValue: #FFD3D3D3

'#DesignerProperty: Key: EnabledValue, DisplayName: Enabled, FieldType: Boolean, DefaultValue: True

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	'Private MainPanel As B4XView
	Private LabelDown As B4XView
	Private CLVCB As CustomListView
	Public cardselected As Int = 0
	'Private LabelCBSelected As B4XView
	Private compactht As Float
	Private fs As String
	Private Visible1 As Boolean
	
	Private BBLabelSuit As B4XView
	'Private BBLabelCBSelected As BBLabel
	Type CardviewL(LabelSuit As B4XView, PaneCard As B4XView, colorkey As Int, Text As String, Enabled As Boolean)
	Private DisableStringBackground As Int
	Private expandedheightvalue As Float
	Public scale As Float
	Private AutoClosevalue As Boolean
	Private fonttype As String
	Private EnabledValue As Boolean

#If b4j
	Private pnbb As B4XView
	Private fx As JFX
	Private btntop As Paint
	Private btnbot As Paint
	Private btntophover As Paint
	Private btnbothover As Paint

	Private CLVhov As Int
	Private CLVback As Int
	Private colors1 As Int
	Private colors2 As Int
	Private colors3 As Int
	Private colors4 As Int
	Private colors5 As Int
	Private colors6 As Int
	Private pan As B4XView
	Private LabelDisplay As B4XView
	Private disablecolor As Int
#else if B4a
	'Private pan As B4XView
	Private LabelDisplay As B4XView
	Private LabelDisplayBorder As B4XView
	Private pnbb As B4XView
#else if b4i
	Private pan As B4XView
	Private pnbb As B4XView
	Private labelDisplay As Panel
	Private rtedge As Int
	Private tfont As Font
#End If

#if B4a or B4i
	Private btntop As Int
	Private btnbot As Int
	Private CLVback As Int
	Private colors1 As Int
	Private colors2 As Int
	Private colors3 As Int
	Private colors4 As Int
	Private colors5 As Int
	Private colors6 As Int
	Private disablecolor As Int
	Private fontscale As Float
	Private LblDummyFontSize As Label
	
#End If
	

End Sub

Public Sub Initialize (CallBack As Object, EventName As String)
	mEventName = EventName
	mCallBack = CallBack
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	'mBase.SetColorAndBorder(xui.Color_Gray, 2dip, xui.Color_Black, 0)
	Visible1 = True
	Dim dtemp As String = Props.Get("DisableType")
	If dtemp = "String" Then
		DisableStringBackground = 0
	Else
		DisableStringBackground = 1
	End If
	disablecolor = xui.PaintOrColorToColor(Props.Get("DisableColor"))
	AutoClosevalue = True
	
#if B4J
	CSSUtils.SetBorder(mBase, 0, fx.Colors.Black, 2)
	'Dim form As Form = Props.Get("Form")
	'MainPanel = form.RootPane
	btntophover = Props.Get("ButtonTopHoverColor")
	btnbothover = Props.Get("ButtonBottomHoverColor")
	'CLVhov = Props.Get("CLVHover")
	CLVhov = xui.PaintOrColorToColor(Props.Get("CLVHover"))
	fs = Props.Get("FontSize")
	fonttype = Props.Get("FontType")

	compactht = mBase.height
	btntop = Props.Get("ButtonTopColor")
	btnbot = Props.Get("ButtonBottomColor")
	scale = 1
#else if B4A

	'MainPanel = Props.Get("activity")
	
	'scaling is based on compactht and font scaling
	'scale factor of 3 corresponds to the 120 dip height of the CBP
	scale = 3 * (mBase.Height / 120)
	
	compactht = mBase.height
	btntop = Props.Get("ButtonTopColor")
	btnbot = Props.Get("ButtonBottomColor")
#else if B4i
	'MainPanel = Props.Get("page")
	mBase.SetColorAndBorder(xui.Color_Transparent, 0, xui.Color_White, 2)
	
	rtedge = 30
	compactht = mBase.height
	btntop = Props.Get("ButtonTopColor")
	btnbot = Props.Get("ButtonBottomColor")
	scale = 1
		
#end if
	expandedheightvalue = Props.Get("ExpandHeight")
	expandedheightvalue = expandedheightvalue * scale 
	If expandedheightvalue < compactht Then
		expandedheightvalue = compactht
	End If
	
	CLVback = xui.PaintOrColorToColor(Props.Get("CLVBackground"))
	colors1 = xui.PaintOrColorToColor(Props.Get("Color1"))
	colors2 = xui.PaintOrColorToColor(Props.Get("Color2"))
	colors3 = xui.PaintOrColorToColor(Props.Get("Color3"))
	colors4 = xui.PaintOrColorToColor(Props.Get("Color4"))
	colors5 = xui.PaintOrColorToColor(Props.Get("Color5"))
	colors6 = xui.PaintOrColorToColor(Props.Get("Color6"))
	
	'EnabledValue = Props.Get("EnabledValue")
	EnabledValue = True

	'label with background (spans full width)
#if B4j
	Dim ld As Label
	ld.Initialize("LabelCBSelected")
	If EnabledValue = True Then
		CSSUtils.SetStyleProperty(ld,"-fx-background-color","linear-gradient(" & CSSUtils.ColorToHex(btntop) & "," & CSSUtils.ColorToHex(btnbot) & ")")
	Else
		CSSUtils.SetStyleProperty(ld,"-fx-background-color","linear-gradient(#FFF1F1F1, #FFCECECE)")
	End If
	CSSUtils.SetBorder(ld,1,fx.Colors.RGB(180,180,180), 2)
	LabelDisplay = ld
	mBase.AddView(LabelDisplay, 0, 0, mBase.Width, compactht)
#else if B4a
	Dim ld As Label
	ld.Initialize("LabelCBSelected")
	If EnabledValue = True Then
		ld.Background = SetGradientColor(btntop, btnbot)
	Else
		ld.Color = xui.Color_RGB(206,206,206)
	End If
	LabelDisplay = ld
	mBase.AddView(LabelDisplay, 0, 0, mBase.Width, compactht)
	
	'add additional label with border
	Dim ld As Label
	ld.Initialize("LabelCBSelected")
	Dim cd As ColorDrawable
	cd.Initialize2(Colors.Transparent, 2dip, 1dip, Colors.RGB(150,150,150))
	ld.Background = cd
	LabelDisplayBorder = ld
	mBase.AddView(LabelDisplayBorder, 0, 0, mBase.Width, compactht)
#else if B4i	
	Dim ld1 As Panel
	ld1.Initialize("LabelCBSelected")
	labelDisplay = ld1
	mBase.AddView(labelDisplay, 0, 0, mBase.Width, compactht)
	If EnabledValue = True Then
		Dim clr() As Int = Array  As Int(btntop, btnbot)
	Else
		Dim clr() As Int = Array  As Int(xui.Color_RGB(241,241,241), xui.Color_RGB(206,206,206))
	End If
	SetGradientBackground(labelDisplay, clr, "TOP_BOTTOM")
	labelDisplay.SetBorder(1, Colors.RGB(150,150,150), 2)
#End If
	
	'Label with down icon (transparent background)
	Dim ld As Label
	ld.Initialize("LabelCBSelected")
	LabelDown = ld
	LabelDown.SetColorAndBorder(xui.Color_Transparent, 0dip, xui.color_black, 2dip)
	LabelDown.Font = xui.CreateFontAwesome(14+2)
	LabelDown.SetTextAlignment("CENTER", "RIGHT")
	LabelDown.Text = Chr(0xF107) & "   "  'down arrow
	mBase.AddView(LabelDown, 0, 0, mBase.width, compactht)

	#if b4a
		Sleep(0)
	#End If
	Dim BBLabelCBSelected As Label
	BBLabelCBSelected.Initialize("LabelCBSelected")
	pnbb = BBLabelCBSelected
	pnbb.SetTextAlignment("CENTER", "CENTER")
	pnbb.Color = xui.Color_Transparent
	mBase.addview(pnbb, 0, 0, mBase.Width-30dip, compactht)

	'customlistview
#if B4j
	Dim pn As B4XView = xui.CreatePanel("")
	pn.LoadLayout("jComboBoxPlus2L")
	pan = pn
	mBase.AddView(pan, 0, compactht, mBase.Width, expandedheightvalue-compactht)
	pan.Visible = False
#else if B4a
	mBase.LoadLayout("aComboBoxPlus2L")
	CLVCB.Base_Resize(mBase.Width, expandedheightvalue-compactht)
	CLVCB.GetBase.SetLayoutAnimated(0, 0, compactht, mBase.Width, expandedheightvalue-compactht)
	CLVCB.GetBase.Visible = False
	fontscale = LblDummyFontSize.TextSize / 14
	
	'use a dummy label to get fontscaling and then use it
	fonttype = Props.Get("FontType")
	fs = Props.Get("FontSize")
	fs = fs * fontscale
	
	LabelDown.TextSize = fs + 2
	
#else if B4i
	Dim pn As B4XView = xui.CreatePanel("")
	pn.LoadLayout("iComboBoxPlus2L")
	pan = pn
	mBase.AddView(pan, 0, compactht, mBase.Width, expandedheightvalue-compactht)
	'CLVCB.GetBase.Visible = False
	pan.Visible = False
	fontscale = LblDummyFontSize.Font.size / 14
	
	'use a dummy label to get fontscaling and then use it
	fonttype = Props.Get("FontType")
	fs = Props.Get("FontSize")
	fs = fs * fontscale
	
	LabelDown.Font = xui.CreateFontAwesome(fs+2)
	pnbb.Font = xui.CreateDefaultFont(fs)
	
	Select Case fonttype
		Case "DEFAULT"
			tfont = Font.DEFAULT
		Case "DEFAULT_BOLD"
			tfont = Font.DEFAULT_BOLD
		Case Else
			Try
				tfont = Font.CreateNew2(fonttype, fs)
			Catch
				tfont = Font.DEFAULT
			End Try
	End Select
	
#End If

	If mBase.Visible = True Then
		Visible1 = True
	Else
		Visible1 = False
	End If
	
End Sub


Private Sub Base_Resize (Width As Double, Height As Double)
#if b4j	
	LabelDisplay.SetLayoutAnimated(0, 0, 0, Width, compactht)
	LabelDown.SetLayoutAnimated(0, 0, 0, Width, compactht)
	pnbb.SetLayoutAnimated(0, 0, 0, Width-30dip, compactht)
	pan.SetLayoutAnimated(0, 0, compactht, Width, Height-compactht)
#Else if b4a
	LabelDisplay.SetLayoutAnimated(0, 0, 0, Width, compactht)
	LabelDisplayBorder.SetLayoutAnimated(0, 0, 0, Width, compactht)
	LabelDown.SetLayoutAnimated(0, 0, 0, Width, compactht)
	'BBLabelCBSelected.mBase.SetLayoutAnimated(0, 0, 0, Width-30dip, compactht)
	pnbb.SetLayoutAnimated(0, 0, 0, Width-30dip, compactht)
	CLVCB.GetBase.SetLayoutAnimated(0, 0, compactht, Width, Height-compactht)
#Else if b4i
	labelDisplay.SetLayoutAnimated(0, 0, 0, 0, Width, compactht)
	LabelDown.SetLayoutAnimated(0, 0, 0, Width-10dip, compactht)
	pnbb.SetLayoutAnimated(0, 0, 0, Width-rtedge, compactht)
	'Log($"tag= ${Tag} w= ${Width} , h= ${Height}"$)
	pan.SetLayoutAnimated(0, 0, compactht, Width, Height-compactht)
#End If

End Sub

#if B4i
Sub SetGradientBackground(pnl As B4XView, Clrs() As Int, Orientation As String)
	Dim bc As BitmapCreator
	bc.Initialize(pnl.Width / xui.Scale, pnl.Height / xui.Scale)
	bc.FillGradient(Clrs, bc.TargetRect, Orientation)
	Dim iv As ImageView
	iv.Initialize("")
	Dim xiv As B4XView = iv
	pnl.AddView(xiv, 0, 0, pnl.Width, pnl.Height)
	xiv.SendToBack
	bc.SetBitmapToImageView(bc.Bitmap, xiv)
End Sub
#End If

#if b4a
Sub SetGradientColor(c1 As Int, c2 As Int) As GradientDrawable
	Dim GD As GradientDrawable
	Dim Cls(2) As Int
	Cls(0) = c1
	Cls(1) = c2
	GD.Initialize("TOP_BOTTOM", Cls)
	GD.CornerRadius = 2
	Return GD
End Sub
#End If

Public Sub setVisible (setv As Boolean)
	If setv = True Then
		If Visible1 Then Return
		Visible1 = True
		LabelDisplay.Visible = True
		LabelDown.Visible = True
		mBase.Visible = True
		#if B4a
			LabelDisplayBorder.Visible = True
		#End If
		pnbb.Visible = True
	Else
		If Visible1 = False Then Return
		Visible1 = False
		LabelDisplay.Visible = False
		LabelDown.Visible = False
		mBase.Visible = False
		#if B4a
			LabelDisplayBorder.Visible = False
		#Else
			pan.Visible = False
		#End If
		pnbb.Visible = False
		mBase.Height = compactht
	End If
End Sub

Public Sub getVisible As Boolean
	Return Visible1
End Sub

Public Sub setEnabled (sete As Boolean)
	If sete = True Then
		#if b4j
			CSSUtils.SetStyleProperty(LabelDisplay,"-fx-background-color","linear-gradient(" & CSSUtils.ColorToHex(btntop) & "," & CSSUtils.ColorToHex(btnbot) & ")")
		#else if b4a
			'LabelDisplay.Color = SetGradientColor(btntop, btnbot)
		#Else
			Dim clr() As Int = Array  As Int(btntop, btnbot)
			SetGradientBackground(labelDisplay, clr, "TOP_BOTTOM")
		#End If
		EnabledValue = True
	Else
		#if b4j
			CSSUtils.SetStyleProperty(LabelDisplay,"-fx-background-color","linear-gradient(#F1F1F1, #CECECE)")
		#Else if b4a
			LabelDisplay.Color = xui.Color_RGB(206,206,206)
		#else	
			Dim clr() As Int = Array  As Int(xui.Color_RGB(241,241,241), xui.Color_RGB(206,206,206))
			SetGradientBackground(labelDisplay, clr, "TOP_BOTTOM")
		#End If
		EnabledValue = False
	End If
End Sub

Public Sub getEnabled As Boolean
	Return EnabledValue
End Sub

Public Sub SetSelectedIndex (Index As Int)
	If Index < CLVCB.size Then
		If cardselected <> Index Then
			Dim cp As CardviewL = CLVCB.GetValue(Index)
			Dim temp1 As String = $"${cp.text}"$
			Try
				If xui.SubExists(mCallBack, mEventName & "_changed", 0) Then
					CallSub3(mCallBack, mEventName & "_changed", Index, temp1)
				End If
			Catch
				'Log(LastException)
				Log("")
			End Try
		End If
		cardselected = Index
#if b4j		
		If pan.IsInitialized = True Then
			refreshbutton(cardselected)
		End If
#else
		If CLVCB.getbase.IsInitialized = True Then
			refreshbutton(cardselected)
		End If
#End If
	End If
End Sub

Public Sub SetEnable (Index As Int, enab As Boolean)
	Dim cp As CardviewL = CLVCB.GetValue(Index)
	cp.enabled = enab
#if b4j
	cp.LabelSuit.Width = mBase.width-20dip  'set this after you set the text.
	cp.LabelSuit.Height = compactht
#End If
	If DisableStringBackground = 1 Then
		If enab = True Then
			cp.labelsuit.Color = CLVback
		Else
			cp.labelsuit.Color = disablecolor
		End If
	Else
		cp.LabelSuit.Color = CLVback
		bbtextwriter1(cp.text, cp.colorkey, cp.LabelSuit, cp.enabled)
	End If
End Sub

Public Sub GetEnable(index As Int) As Boolean
	Dim cp As CardviewL = CLVCB.GetValue(index)
	Return cp.enabled
End Sub

Public Sub SetEntry(txt As String)
	bbtextwriter1(txt, 0, pnbb, True)
End Sub

Public Sub setAutoClose (temp As Boolean)
	AutoClosevalue = temp
End Sub

Public Sub getAutoClose() As Boolean
	Return AutoClosevalue	
End Sub

Public Sub GetVersion As String
	'added a close routine for version 14
	'added keep open option for version 15
	'speed up for version 16
	'fixed callback so that it does not error if there is no sub version 18
	'fixed fontsize on B4a
	'fixed call back in version 20
	Return "Version 20.0"
End Sub

Public Sub setFontsize(setfs As Float)
	fs = setfs
	#if B4a
		LabelDown.Font = xui.CreateFontAwesome(fs+2)
	#else if B4i
		LabelDown.Font = xui.CreateFontAwesome(fs+2)
	#else if b4j
		LabelDown.Font = fx.CreateFontAwesome(fs)
	#End If
	changefontsize(pnbb)
	For x = 0 To CLVCB.Size - 1
		Dim cp As CardviewL = CLVCB.GetValue(x)
		cp.LabelSuit.SetLayoutAnimated(0,0dip,0dip,mBase.width-20dip,compactht)
		changefontsize(cp.LabelSuit)
	Next
End Sub

Public Sub getFontSize As Float
	Return fs
End Sub

Private Sub changefontsize(lbl As B4XView)
	#if B4j
		lbl.Font = xui.CreateFont(fx.CreateFont(fonttype,fs,False,False), fs)
	#Else if B4a
		Select Case fonttype
			Case "DEFAULT"
				lbl.Font = xui.CreateFont(Typeface.DEFAULT,fs)
			Case "DEFAULT_BOLD"
				lbl.Font = xui.CreateFont(Typeface.DEFAULT_BOLD,fs)
			Case "MONOSPACE"
				lbl.Font = xui.CreateFont(Typeface.MONOSPACE,fs)
			Case "SANS_SERIF"
				lbl.Font = xui.CreateFont(Typeface.SANS_SERIF,fs)
			Case "SERIF"
				lbl.Font = xui.CreateFont(Typeface.SERIF,fs)
		End Select
	#Else if B4i
		lbl.Font = xui.CreateFont2(tfont,fs)
	#End If
End Sub

Public Sub GetItems As List
	Dim AllItems As List
	AllItems.Initialize
	For i = 0 To CLVCB.Size - 1
		Dim cp As CardviewL = CLVCB.GetValue(i)
		AllItems.Add(cp.Text)
	Next
	Return AllItems
End Sub

Public Sub GetSelectedValue As String
	Dim cp As CardviewL = CLVCB.GetValue(cardselected)
	Dim temp1 As String = $"${cp.text}"$
	Return temp1
End Sub

Public Sub GetSelectedIndex As Int
	Dim temp1 As Int = cardselected
	Return temp1
End Sub

Public Sub GetValue(Index As Int) As String
	Dim cp As CardviewL = CLVCB.GetValue(Index)
	Return cp.Text
End Sub

public Sub GetItemColorkey (index As Int) As Int
	Dim cp As CardviewL = CLVCB.GetValue(index)
	Return cp.colorkey
End Sub

Public Sub SetItemColor (Index As Int, colorkey As Int)
	Dim cp As CardviewL = CLVCB.GetValue(Index)
	cp.colorkey = colorkey
#if B4j
	cp.labelsuit.Height = compactht
#End If
	bbtextwriter1(cp.text, cp.colorkey, cp.LabelSuit, cp.enabled)
End Sub

Public Sub GetIndex(Value As String) As Int
	For i = 0 To CLVCB.Size - 1
		Dim cp As CardviewL = CLVCB.GetValue(i)
		If cp.Text = Value Then
			Return i
		End If
	Next
	Return -1
End Sub

Public Sub setExpandedHeight (Height As Float)
	expandedheightvalue = Height
	#If B4A
		CLVCB.Base_Resize(mBase.Width, expandedheightvalue-compactht)
		CLVCB.GetBase.SetLayoutAnimated(0, 0, compactht, mBase.Width, expandedheightvalue-compactht)
	#End If
End Sub

Public Sub getExpandedHeight As Float
	Return expandedheightvalue
End Sub

Private Sub refreshbutton(cs As Int)
	Dim cp As CardviewL = CLVCB.GetValue(cs)
	bbtextwriter1(cp.text, cp.colorkey, pnbb, cp.enabled)
End Sub

Public Sub AddItems(cd As String, colorkey As Int, enabled As Boolean)
	Dim ItemWidth As Double =  mBase.width   'same as the CLV width
	Dim itemheight As Double = compactht
	Dim ContactItem As B4XView = xui.CreatePanel("")
	ContactItem.SetLayoutAnimated(0, 0, 0, ItemWidth, itemheight)

	Dim lbltemp As Label
	lbltemp.initialize("BBLabelSuit")
	Dim BBLabelSuit As B4XView = lbltemp
	BBLabelSuit.SetLayoutAnimated(0,0dip,0dip,ItemWidth,compactht)
	ContactItem.AddView(BBLabelSuit, 0, 0, ItemWidth, itemheight)
	
	Dim cview As CardviewL
	cview.Initialize
	cview.colorkey = colorkey
	cview.Text = cd
	cview.LabelSuit = BBLabelSuit
	cview.enabled = enabled
	CLVCB.Add(ContactItem, cview)
	cview.LabelSuit.SetLayoutAnimated(0,0dip,0dip,ItemWidth-20dip,compactht)
	cview.LabelSuit.SetTextAlignment("CENTER", "CENTER")

	If DisableStringBackground = 1 Then
		If enabled = True Then
			cview.LabelSuit.Color = CLVback
		Else
			cview.LabelSuit.Color = disablecolor
		End If
	Else
		cview.LabelSuit.Color = CLVback
	End If
	bbtextwriter1(cd, colorkey, BBLabelSuit, enabled)
End Sub

Public Sub AddItemAt(Position As Int, cd As String, colorkey As Int, enabled As Boolean)
	If Position <= CLVCB.Size - 1 Then
		Dim ItemWidth As Double =  mBase.width   'same as the CLV width
		Dim itemheight As Double = compactht
		Dim ContactItem As B4XView = xui.CreatePanel("")
		ContactItem.SetLayoutAnimated(0, 0, 0, ItemWidth, itemheight)

		Dim lbltemp As Label
		lbltemp.initialize("BBLabelSuit")
		Dim BBLabelSuit As B4XView = lbltemp
		BBLabelSuit.SetLayoutAnimated(0,0dip,0dip,ItemWidth,compactht)
		ContactItem.AddView(BBLabelSuit, 0, 0, ItemWidth, itemheight)

		Dim cview As CardviewL
		cview.Initialize
		cview.colorkey = colorkey
		cview.Text = cd
		cview.LabelSuit = BBLabelSuit
		cview.enabled = enabled
		CLVCB.InsertAt(Position, ContactItem, cview)
		cview.LabelSuit.SetLayoutAnimated(0, 0dip, 0dip, ItemWidth-20dip, compactht)
		cview.LabelSuit.SetTextAlignment("CENTER", "CENTER")

		If DisableStringBackground = 1 Then
			If enabled = True Then
				cview.LabelSuit.Color = CLVback
			Else
				cview.LabelSuit.Color = disablecolor
			End If
		Else
			cview.LabelSuit.Color = CLVback
		End If
		bbtextwriter1(cd, colorkey, BBLabelSuit, enabled)
	End If
End Sub

Public Sub RemoveItemAt(Position As Int)
	If Position <= CLVCB.Size -1 Then
		CLVCB.RemoveAt(Position)
	End If
End Sub

Public Sub Clear
	CLVCB.clear
	'bbtextwriter("", -1, BBLabelCBSelected, True)
	bbtextwriter1("", -1, pnbb, True)
End Sub

Public Sub Close
	#if b4j or b4i
		pan.Visible = False
		mBase.Height = compactht
	#else if B4a
		CLVCB.GetBase.Visible = False
		mBase.Height = compactht
	#End If
End Sub

#if b4j
	Private Sub LabelCBSelected_MouseClicked (EventData As MouseEvent)
		If EnabledValue = True Then
			If pan.Visible = True Then
				pan.Visible = False
				mBase.Height = compactht
			Else
				pan.Visible = True
				mBase.Height = expandedheightvalue
				CreateOpenedEvent
			End If
		End If
	End Sub
#else
	Private Sub LabelCBSelected_Click
		If EnabledValue = True Then
			#if B4a
				If CLVCB.GetBase.Visible = True Then
					CLVCB.GetBase.Visible = False
					mBase.Height = compactht
				Else
					CLVCB.GetBase.Visible = True
					mBase.Height = expandedheightvalue
					CreateOpenedEvent
				End If
			#Else b4i
				If pan.Visible = True Then
					pan.Visible = False
					mBase.Height = compactht
				Else
					pan.Visible = True
					mBase.Height = expandedheightvalue
					CreateOpenedEvent
				End If
			#End If
		End If	
	End Sub
#End If

Private Sub CreateOpenedEvent
	Try
	If xui.SubExists(mCallBack, mEventName & "_opened", 0) Then
		CallSub(mCallBack, mEventName & "_opened")
	End If
	Catch
		'Log(LastException)
		Log("")
	End Try
End Sub

Private Sub CLVCB_ItemClick (Index As Int, Value As Object)
	Dim cp As CardviewL = Value
	If cp.enabled = True Then
		Dim temp1 As String = $"${cp.text}"$
		cardselected = Index
		refreshbutton(cardselected)
		Try
			If xui.SubExists(mCallBack, mEventName & "_selected", 0) Then
				CallSub3(mCallBack, mEventName & "_selected", Index, temp1)
			End If
		Catch
			'Log(LastException)
			Log("")
		End Try
		If cardselected <> Index Then
			Dim temp1 As String = $"${cp.text}"$
			Try
				If xui.SubExists(mCallBack, mEventName & "_changed", 0) Then
					CallSub3(mCallBack, mEventName & "_changed", Index, temp1)
				End If	
			Catch
				'Log(LastException)
				Log("")
			End Try
		End If
		If AutoClosevalue = True Then
					#if b4j
				pan.Visible = False
				mBase.Height = compactht
			#else if B4a
				CLVCB.GetBase.Visible = False
				mBase.Height = compactht
			#else if b4i
				pan.visible = False	
				mBase.Height = compactht
			#End If
		End If	
	End If
End Sub

#if B4j
Private Sub LabelCBSelected_MouseEntered (EventData As MouseEvent)
	If EnabledValue = True Then
		CSSUtils.SetStyleProperty(LabelDisplay,"-fx-background-color","linear-gradient(" & CSSUtils.ColorToHex(btntophover) & "," & CSSUtils.ColorToHex(btnbothover) & ")")
	End If
End Sub

Private Sub LabelCBSelected_MouseExited (EventData As MouseEvent)
	If EnabledValue = True Then
		CSSUtils.SetStyleProperty(LabelDisplay,"-fx-background-color","linear-gradient(" & CSSUtils.ColorToHex(btntop) & "," & CSSUtils.ColorToHex(btnbot) & ")")
	End If
End Sub

Private Sub BBLabelSuit_MouseEntered (EventData As MouseEvent)
	Dim indexp As Int = CLVCB.GetItemFromView(Sender)
	If indexp >= 0 And indexp < CLVCB.Size Then
		Dim cp As CardviewL = CLVCB.GetValue(indexp)
'		cp.labelsuit.width = mBase.width-20dip
'		cp.labelsuit.Height = compactht
		cp.LabelSuit.Color = CLVhov
	End If
End Sub

Private Sub BBLabelSuit_MouseExited (EventData As MouseEvent)
	Dim indexp As Int = CLVCB.GetItemFromView(Sender)
	If indexp >= 0 And indexp < CLVCB.Size Then
		Dim cp As CardviewL = CLVCB.GetValue(indexp)
'		cp.labelsuit.width = mBase.width-20dip  'set this after you set the text.
'		cp.labelsuit.Height = compactht
		If DisableStringBackground = 1 Then
			If cp.enabled = True Then
				cp.LabelSuit.Color = CLVback
			Else
				cp.LabelSuit.Color = disablecolor
			End If
		Else
			cp.LabelSuit.Color = CLVback
		End If
	End If
End Sub

#End If

Private Sub bbtextwriter1(cd As String, colorkey As Int, bb As B4XView, enabled As Boolean)
	Select colorkey
		Case -1
			Dim ccode As String = "FFFFFFFF"  'white
		Case 0
			Dim ccode As String = "FF" & ColorToHex(xui.PaintOrColorToColor(colors1)).SubString(2)
		Case 1
			Dim ccode As String = "FF" & ColorToHex(xui.PaintOrColorToColor(colors2)).SubString(2)
		Case 2
			Dim ccode As String = "FF" & ColorToHex(xui.PaintOrColorToColor(colors3)).SubString(2)
		Case 3
			Dim ccode As String = "FF" & ColorToHex(xui.PaintOrColorToColor(colors4)).SubString(2)
		Case 4
			Dim ccode As String = "FF" & ColorToHex(xui.PaintOrColorToColor(colors5)).SubString(2)
		Case 5
			Dim ccode As String = "FF" & ColorToHex(xui.PaintOrColorToColor(colors6)).SubString(2)
		Case Else
			Dim ccode As String = "FF000000"  'black
	End Select
	If enabled = False And DisableStringBackground = 0 Then
		Dim ccode As String = "FFC0C0C0"  'grey
	End If
	bb.Text = cd
	
	changefontsize(bb)
	
	Dim colorint As Int = StringToInt(ccode)
	bb.textcolor = colorint
End Sub

Private Sub ColorToHex(clr As Int) As String
	Dim bc As ByteConverter
	Return bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr)))
End Sub

Sub StringToInt(Str As String) As Int
	Dim converter As ByteConverter
	Dim ii() As Int = converter.IntsFromBytes(converter.HexToBytes(Str))
	Return ii(0)
End Sub