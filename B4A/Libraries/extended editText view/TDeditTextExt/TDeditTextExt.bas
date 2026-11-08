B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.2
@EndOfDesignText@
' ################################################
' Custom extended editText view
' ------------------------------------------------
' Name:			TDeditTextExt
' Version:		1
' Libs:			AppCompat, IME, JavaObject, Reflcetion,
'				StringUtils, XUI
' Designerable: yes
' #################################################
' (C) TechDoc G. Becker
' #################################################

#region Properties
' editText standard properties
#DesignerProperty: Key: Color, DisplayName: Background color, FieldType: color, DefaultValue:0xFFFFFFFF, Description:
#DesignerProperty: Key: Width, DisplayName: Width, FieldType: Int, DefaultValue:100, Description: editText width
#DesignerProperty: Key: Height, DisplayName: Height, FieldType: Int, DefaultValue:100 , Description: editText height
#DesignerProperty: Key: Padding, DisplayName: Padding, FieldType:string, DefaultValue:, Description: Left,Top,Right,Bottom
#DesignerProperty: Key: Enabled, DisplayName: Enabled, FieldType: Boolean, DefaultValue: false, Description:
#DesignerProperty: Key: Tag, DisplayName: Tag, FieldType: string, DefaultValue:, Description:
#DesignerProperty: Key: Text, DisplayName: Text, FieldType: string, DefaultValue:, Description:
#DesignerProperty: Key: Typeface, DisplayName: Typeface, FieldType: string, List: DEFAULT|MONOSPACE|SERIF|SANS_SERIF, DefaultValue: DEFAULT, Description:
#DesignerProperty: Key: Style, DisplayName: Style, FieldType: string, List: BOLD|ITALIC|BOLD_ITALIC, DefaultValue:, Description:
#DesignerProperty: Key: HorizAlignment, DisplayName: Horiz. Alignment, FieldType: string, List: LEFT|RIGHT|CENTER, DefaultValue: LEFT, Description:
#DesignerProperty: Key: VertAlignment, DisplayName: Vert. Alignment, FieldType: string, List: TOP|Bottom|CENTER, DefaultValue: TOP, Description:
#DesignerProperty: Key: Size, DisplayName: Size, FieldType: int, DefaultValue: 14, Description:
#DesignerProperty: Key: TextColor, DisplayName: Text color, FieldType: color, DefaultValue:0xFF000000, Description:
#DesignerProperty: Key: SingleLine, DisplayName: Single line, FieldType: boolean, DefaultValue: true, Description:
#DesignerProperty: Key: Passwort, DisplayName: Passwort, FieldType: boolean, DefaultValue: false, Description:
#DesignerProperty: Key: InputType, DisplayName: Input Type, FieldType: string, List: NONE|NUMBERS|DECIMAL_NUMBERS|TEXT|PHONE , DefaultValue:TEXT, Description:
#DesignerProperty: Key: HintText, DisplayName:Hint Text, FieldType: string, DefaultValue:, Description:
#DesignerProperty: Key: HintTextColor, DisplayName:, FieldType: color, DefaultValue:0x00FFFFFF, Description:
#DesignerProperty: Key: WrapText, DisplayName: Wrap Text, FieldType: boolean, DefaultValue: true, Description:
#DesignerProperty: Key: ForceDone, DisplayName: Force Done, FieldType: boolean, DefaultValue: false, Description:
' editText additional functions
#DesignerProperty: Key: SpellCheck, DisplayName: Spell Check, FieldType: boolean, DefaultValue: false, Description:
#DesignerProperty: Key: Mask, DisplayName: Mask Format, FieldType: string, DefaultValue:, Description: A-Text, #-Digit
#DesignerProperty: Key: Length, DisplayName: Max Length, FieldType: int, DefaultValue: 1, Description: Max Input length
#end region
#DesignerProperty: Key: Tint, DisplayName: Tint, FieldType: Boolean, DefaultValue: false , Description: editText frame border
#DesignerProperty: Key: TintActive, DisplayName: Tint focused, FieldType: color, DefaultValue: 0xFFF40000 , Description: editText focused  frame color
#DesignerProperty: Key: TintBorderWidth, DisplayName: Tint width, FieldType: int, DefaultValue: 1, Description: editText frame width
#DesignerProperty: Key: TintNotActive, DisplayName: Tint  not focused, FieldType: color, DefaultValue: 0xFF1912E3 , Description: editText not focused color
#DesignerProperty: Key: Message, DisplayName: Error Text, FieldType: string, DefaultValue: Violation of Input Format, Description:
#DesignerProperty: Key: Title, DisplayName: Error Ttile, FieldType: string, DefaultValue: Input Error!, Description:
#end region

' #################################################

#region Events
' events:
#Event: TextChange(Old as string, New as string)
#Event: EnterPressed
#Event: FocusChanged(HasFocus as boolean)
#Event: InputError(Error as boolean)
#end region

' #################################################

#region Basic
' globals
' V1
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private ime As IME
	Private mprops As Map
	Public edt As EditText
	Private lbl1 As Label
	Private pnl As Panel
	Public scvH As HorizontalScrollView
End Sub

' intialize globals
' V1
Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	ime.Initialize("ime")
	mprops.initialize
	edt.Initialize("edt")
	lbl1.Initialize("lbl")
	pnl.Initialize("pnl")
	scvH.Initialize(100,"scvH")
End Sub

' create Base
' V1
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me
	' publish props 
	mprops=Props
	' set standard edt properties
	Public edtB4X As B4XView = edt
	edt.Width = mBase.Width
	edt.Height = mBase.Height
	edtB4X.Width = Props.Get("Width")
	edtB4X.Height= Props.Get("Height")
	Dim ty As Typeface = Typeface.DEFAULT
	Select Case mprops.get("Typeface")
		Case "DEFAULT"
			Select Case mprops.Get("Style")
				Case "NORMAL"
					ty = Typeface.CreateNew(Typeface.DEFAULT,Typeface.STYLE_NORMAL)
				Case "BOLD"
					ty = Typeface.CreateNew(Typeface.DEFAULT,Typeface.STYLE_BOLD)
				Case "ITALIC"
					ty = Typeface.CreateNew(Typeface.DEFAULT,Typeface.STYLE_ITALIC)
				Case "BOLD_ITALIC"
					ty = Typeface.CreateNew(Typeface.DEFAULT,Typeface.STYLE_BOLD_ITALIC)
			End Select
		Case "MONOSPACE"
			Select Case mprops.Get("Style")
				Case "NORMAL"
					ty = Typeface.CreateNew(Typeface.MONOSPACE,Typeface.STYLE_NORMAL)
				Case "BOLD"
					ty = Typeface.CreateNew(Typeface.MONOSPACE,Typeface.STYLE_BOLD)
				Case "ITALIC"
					ty = Typeface.CreateNew(Typeface.MONOSPACE,Typeface.STYLE_ITALIC)
				Case "BOLD_ITALIC"
					ty = Typeface.CreateNew(Typeface.MONOSPACE,Typeface.STYLE_BOLD_ITALIC)
			End Select
		Case "SERIF"
			Select Case mprops.Get("Style")
				Case "NORMAL"
					ty = Typeface.CreateNew(Typeface.SERIF,Typeface.STYLE_NORMAL)
				Case "BOLD"
					ty = Typeface.CreateNew(Typeface.SERIF,Typeface.STYLE_BOLD)
				Case "ITALIC"
					ty = Typeface.CreateNew(Typeface.SERIF,Typeface.STYLE_ITALIC)
				Case "BOLD_ITALIC"
					ty = Typeface.CreateNew(Typeface.SERIF,Typeface.STYLE_BOLD_ITALIC)
			End Select
		Case "SANS_SERIF"
			Select Case mprops.Get("Style")
				Case "NORMAL"
					ty = Typeface.CreateNew(Typeface.SANS_SERIF,Typeface.STYLE_NORMAL)
				Case "BOLD"
					ty = Typeface.CreateNew(Typeface.SANS_SERIF,Typeface.STYLE_BOLD)
				Case "ITALIC"
					ty = Typeface.CreateNew(Typeface.SANS_SERIF,Typeface.STYLE_ITALIC)
				Case "BOLD_ITALIC"
					ty = Typeface.CreateNew(Typeface.SANS_SERIF,Typeface.STYLE_BOLD_ITALIC)
			End Select
	End Select
	edtB4X.Font = xui.createfont(ty,mprops.Get("Size"))
	edtB4X.TextSize = mprops.Get("Size")
	edtB4X.SetTextAlignment(mprops.Get("VertAlignment"),mprops.Get("HorizAlignment"))
	edtB4X.TextColor=mprops.Get("TextColor")
	edt = edtB4X ' set b4x properties to edt
	Dim temp(3) As String
	temp(0) = mprops.Get("Padding")
	If temp(0).Length>0 Then
		temp = Regex.split("\,",temp(0))
		edt.Padding = Array As Int (temp(0),temp(1),temp(2),temp(3)) 
	End If
	edt.Color = mprops.Get("Color")
	edt.Enabled=mprops.Get("Enabled")
	edt.tag=mprops.Get("Tag")
	edt.Text=mprops.Get("Text")
	edt.PasswordMode = mprops.Get("Passwort")
	Select Case mprops.Get("InputType")
		Case "NONE"
			edt.InputType = edt.INPUT_TYPE_NONE
		Case "NUMBERS"
			edt.InputType = edt.INPUT_TYPE_NUMBERS
		Case "DECIMAL_NUMBERS"
			edt.InputType = edt.INPUT_TYPE_DECIMAL_NUMBERS
		Case "TEXT"
			edt.InputType = edt.INPUT_TYPE_TEXT
		Case "PHONE"
			edt.InputType = edt.INPUT_TYPE_PHONE
	End Select
	edt.Hint = mprops.Get("HintText")
	edt.HintColor = mprops.Get("HintTextColor")
	edt.Wrap = mprops.Get("WrapText")
	edt.ForceDoneButton = mprops.Get("ForceDone") 
	SpellCheck(edt,mprops.Get("SpellCheck"))
	' set scvH properties	
	scvH.Panel.Color=Colors.Transparent
	scvH.Width = mBase.Width
	scvH.panel.Width = mBase.width + 50dip
	scvH.Height =mBase.height
	scvH.panel.Height = mBase.height
	' add edt to scvH
	scvH.Panel.AddView(edt,0dip,0dip,scvH.panel.Width ,scvH.panel.height )
	If mprops.Get("SingleLine") Then
		edt.SingleLine=True
	Else
		edt.SingleLine=False
	End If
	Dim l As String = mprops.Get("Mask")
	If l.length > 0 Then mprops.Put("Lenght",l.length)
	' set pnl
	pnl.Width = mBase.Width+4: pnl.Height = mBase.height+4
	pnl.Color = Colors.Transparent
	pnl.Padding = Array As Int (2,2,2,2)
	' add scvh to pnl
	pnl.AddView(scvH,0,0,scvH.Width,scvH.Height)
	' add pnl to main Base
	mBase.AddView(pnl,0,0,scvH.width,scvH.height)
End Sub

' Base has resized
' V1
Private Sub Base_Resize (Width As Double, Height As Double)
End Sub
#end region

' #################################################

#region Events edt
' text value changed
' V1
private Sub edt_TextChanged(old As String, new As String)
	If edt.Text.Length > mprops.Get("Length") Then
		 edt.Text=old
	End If

	If xui.SubExists(mCallBack, mCallBack & "_TextChanged",0) Then
		CallSubDelayed3(mCallBack,mCallBack  & "_TextChanged",old, new)
	End If
End Sub

' view focus changed
' V1
private Sub edt_FocusChanged(HasFocus As Boolean)
	' show state border
	Dim edtB4X As B4XView = pnl
	If HasFocus And mprops.get("Tint") Then
		edtB4X.SetColorAndBorder(edtB4X.Color, _
			mprops.Get("TintBorderWidth"), mprops.Get("TintActive"),0)
	Else
		edtB4X.SetColorAndBorder(edtB4X.Color, _
			mprops.Get("TintBorderWidth"), mprops.Get("TintNotActive"),0)
	End If
	
	' set pnl border
	pnl=edtB4X
	
	' lost foucus hide keyboard
	If HasFocus = False Then 
		ime.HideKeyboard
	Else
		ime.ShowKeyboard(edt)
	End If
	
	' call parent event sub
	If xui.SubExists(mCallBack, mCallBack & "_FocusChanged",0) Then
		CallSubDelayed2(mCallBack,mCallBack  & "_FocusChanged",HasFocus)
	End If
End Sub

' Enter Pressed
' SingleLine > check Input (Mask)
' MultiLine > call parent event - no mask possible
' V1
private Sub edt_EnterPressed
	If mprops.Get("SingleLine") = True Then
		' check mask	
		If mprops.get("Mask") <> Null And edt.Text <> "" Then 
			checkMask(edt.Text)
		End If
	Else
		' call parent event sub
		If xui.SubExists(mCallBack, mCallBack & "_EnterPressed",0) Then
			CallSubDelayed(mCallBack,mCallBack  & "_EnterPressed")
		End If	
	End If
End Sub
#end region

' #################################################

#region Events Scrollbar
' raise vertical Scrollbar Change Event
' V1
private Sub scvV_ScrollChanged(Position As Int)
	' call parent event sub
	If xui.SubExists(mCallBack, mCallBack & "_ScrollChanged",0) Then
		CallSubDelayed2(mCallBack,mCallBack  & "_ScrollChanged",Position)
	End If
End Sub
#end region

#region Custom Properties
' show/hide Borderframe
' V1
public Sub setTint(DoTint As Boolean)
	mprops.Put("Tint",DoTint)
End Sub
' Mask format string
' A-Text #-Number, seperator comma, dot
public Sub setMask(MaskString As String)
	mprops.Put("Mask",MaskString)
End Sub
' Max Input length
public Sub setLength(LengthValue As Int)
	mprops.put("Length",LengthValue)
End Sub

public Sub setSpellChecking(Active As Boolean)
	SpellCheck(edt,Active)
	mprops.put("SpellCheck",Active)
End Sub
#end region

' #################################################

#region helpers
' Check given Mask
' V1
private Sub checkMask(edtTxt As String)
	Dim msk As String = mprops.Get("Mask")
	Dim T As String = edtTxt
	If msk.Length <> T.Length And mprops.Get("SingleLine")=True Then
			flashError
	else if msk.Length = 0 Or T.Length =0 Then
			flashError
	Else
		Dim M,S As String
		Dim error As Boolean = False
		Dim start, stop , StepVal As Int
		Log(edt.InputType)
		' NUMBER/DECIMAL = reverse
		If  edt.InputType = 524290 Or edt.InputType = 536578 Then
			start = msk.Length-1
			stop = 0
			StepVal = -1
		Else
			start = 0
			stop = msk.Length-1
			StepVal = 1
		End If
		' Iterate through mask
		For x = start To stop Step StepVal
			If error Then Exit ' on error leave loop
			' Get char or digit
			M = msk.SubString2(x,x+1)
			S = T.SubString2(x,x+1)
			Select Case edt.InputType
				Case 524290 ' NUMBER
					If m = "#" And IsNumber(S) Then
						error = False
					Else
						error = True
					End If
				Case 536578 ' DECIMAL
					If m = "#" Then
						error = Not(IsNumber(S))
					else If m = "." Or m = "," Then
						Log(S):Log(M)
						 If s <> m Then	error = True
					End If
				Case 524291 ' PHONE
					If m = "#" Then
						error = Not(IsNumber(S))
					else If m = "." Or m = "N" Or M="/" _
						Or m= ";" Or m= "-" Or m="+" Or m="," _
						Or m="(" Or m=")" Or m=" " Then
						If s <> m Then error = True
					End If
				Case Else ' Text/NONE
					' no check
			End Select
		Next
		If error Then
			flashError
		End If
	End If
	' call parent event sub
	If xui.SubExists(mCallBack, mCallBack & "_InputError",0) Then
		CallSubDelayed2(mCallBack,mCallBack  & "_InputError",error)
	End If
End Sub

' Turn SpellCheck On/Off
' V1
private Sub SpellCheck(et As EditText, Enable As Boolean)
	If Enable Then
		et.inputType=Bit.Or(et.InputType, 524288)
	Else
		et.InputType = Bit.And(et.InputType, Bit.Not(524288))
	End If
End Sub

' Flasch Backgroundcolor if error
' V1
private Sub flashError
	Dim toggle As Boolean = False
	For x = 0 To 5
		Sleep(250)
		If toggle = False Then
			edt.Color = 0xFFEF7575
			toggle=True
		Else
			edt.Color = mprops.Get("Color")
			toggle=False
		End If
	Next
	edt.Color = mprops.Get("Color")
	xui.MsgboxAsync(mprops.Get("Message") & CRLF & _
		"(" & mprops.get("Mask") & ")",mprops.Get("Title"))
End Sub
#end region
' #################################################
' (C) TechDoc G. Becker
' #################################################

