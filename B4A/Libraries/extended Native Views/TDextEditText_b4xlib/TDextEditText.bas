B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.5
@EndOfDesignText@
' ##########################################
' extended nativ EditText
' ------------------------------------------
' Name:		TDextEditText
' Version:	1
' libs:		Audio,IME
' Designer: Yes
' ------------------------------------------
' (C) TechDoc G. Becker
' ##########################################

#region Properties/Event
' native Properties
#DesignerProperty: key: backgroundColor, DisplayName: Background Color,FieldType:Color, Defaultvalue:0xFFFFFFFF
#DesignerProperty: Key: typeface, Displayname: Typeface, FieldType:String, List:DEFAULT|FontAwesome|Material Icons|SANS_SERIF|SERIF|MONOSPACE, DefaultValue:DEFAULT
#DesignerProperty: Key: style, DisplayName: Style,FieldType: String,List: NORMAL|BOLD|ITALIC|BOLD_ITALIC,DefaultValue:NORMAL ,Description:
#DesignerProperty: Key: horiz, DisplayName: Horiz. Altignment,FieldType:String,List:LEFT|CENTER|RIGHT,DefaultValue:LEFT ,Description:
#DesignerProperty: Key: vert, DisplayName: Vertic. Alignment,FieldType:String,List:TOP|CENTER|BOTTOM ,DefaultValue:TOP ,Description:
#DesignerProperty: Key: textsize,DisplayName: Textsize,FieldType:Int ,DefaultValue:12 ,Description:
#DesignerProperty: Key: textcolor,DisplayName: Textcolor ,FieldType:Color ,DefaultValue: 0xFF000000,Description:
#DesignerProperty: Key: single,DisplayName: Single Line  ,FieldType: Boolean,DefaultValue:false ,Description:
#DesignerProperty: Key: password,DisplayName: Password  ,FieldType: Boolean ,DefaultValue:false ,Description:
#DesignerProperty: Key: input,DisplayName: Inputtype  ,FieldType:String ,List:NONE|NUMBERS|DECIMAL_NUMBERS|TEXT|PHONE,DefaultValue:Text ,Description:
#DesignerProperty: Key: hinttext,DisplayName: Hint Text ,FieldType:String ,DefaultValue: ,Description:
#DesignerProperty: Key: hintcolor,DisplayName: Hint color  ,FieldType:Color ,DefaultValue:0xFF808080  ,Description:
#DesignerProperty: key: wrap, DisplayName: Wrap text,FieldType: Boolean, DefaultValue:false
#DesignerProperty: key: force, DisplayName: Force Done,FieldType:Boolean,DefaultValue:false
#DesignerProperty: key: texttext, DisplayName: Text, FieldType:String, DefaultValue:

' custom Properties
#DesignerProperty: key: id, DisplayName: View ID, FieldType:String, DefaultValue:
#DesignerProperty: Key: spell, DisplayName: Spell check, FieldType: Boolean, DefaultValue: True, Description: Spell checking on/off
#DesignerProperty: Key: columnName, DisplayName: Column Name,FieldType: String,DefaultValue:, Description: Name of the database datacolumn
#designerProperty: Key: columnType, DisplayName: Column Typ, FieldType: String, List: Date|DateTime|Double|Int|Long|String|Time, DefaultValue: String, Description: Datatype of the Datbase Column
#DesignerProperty: key: inputlengthMax, DisplayName: Input max. length, FieldType:Int, MinValue:0, DefaultValue:0, Description: Min=0
#DesignerProperty: key: inputlengthMin, DisplayName: Input min. length, FieldType:Int, MinValue:0, DefaultValue:0, Description: Min=0
#DesignerProperty: key: inputChar, DisplayName:Input chars,FieldType:String,DefaultValue:, Description:Type in all input chars allowed
#DesignerProperty: key: textErrColor, DisplayName: Text Error Color,FieldType:Color, Defaultvalue:0xFFFF0000
#DesignerProperty: key: backgroundErrColor, DisplayName: Background Error Color,FieldType:Color, Defaultvalue:0xFFFFFFFF
#DesignerProperty: key: backgroundFocusColor, DisplayName: Background Focus Color,FieldType:Color, Defaultvalue:0xFFFFFFF
#DesignerProperty: key: errorbeep, DisplayName: Error Beep,FieldType:Boolean,DefaultValue:false
#DesignerProperty: key: borderfocused, DisplayName: Border Focus,FieldType:Boolean,DefaultValue:false, Description: Show Border if foused
#DesignerProperty: key: bordercolor, DisplayName: Bordercolor, Fieldtype: Color, DefaultValue:0x00FFFFFF
#DesignerProperty: key: borderwidth, DisplayName: Border Width, Fieldtype:int, MinValue:0, Defaultvalue:0
#DesignerProperty: key: borderradius, DisplayName: Border Radius, FieldType: int, MinValue:0,DefaultValue:0

' native event
#Event: TextChanged(Old as string, New as String)

' custom event
#Event: FocusChanged(HasFocus as boolean,Error as Int)
#Event: EnterPressed(Error as Int)
#end region

' ##########################################

#region globals
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignorea
	Public Tag As Object
	Private edt As EditText
	Private mprops As Map
	Private ime As IME
	Private beep As Beeper
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	edt.Initialize("edt")
	mprops.initialize
	ime.initialize("ime")
	beep.initialize(250,300)
End Sub
#end region

' ##########################################

#region basic
'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me
	
	' make props public
	mprops = Props
  	
	' setup EditTextView edt
	edt.Width=mBase.Width
	edt.Height=mBase.height
	edt.Top=0
	edt.Left=0
		
	' set spellcheck on/off
	If Props.Get("spell") Then
		edt.inputType=Bit.Or(edt.InputType, 524288)
	Else
		edt.InputType = Bit.And(edt.InputType, Bit.Not(524288))
	End If
	
	' set input char
	Dim ic As String = Props.Get("inputChar")
	If  ic.length > 0 Then
		ime.SetCustomFilter(edt,edt.InputType,Props.Get("inputChar"))
	End If
	
	'set standard properties
	Select Props.Get("typeface")
		Case "DEFAULT"
			edt.Typeface = Typeface.DEFAULT
		Case "FontAwesome"
			edt.Typeface = Typeface.FONTAWESOME
		Case "Material Icons"
			edt.Typeface = Typeface.MATERIALICONS
		Case "SANS_SERIF"
			edt.Typeface = Typeface.SANS_SERIF
		Case "SERIF"
			edt.Typeface = Typeface.SERIF
		Case "MONOSPACE"
			edt.Typeface =Typeface.MONOSPACE
	End Select
	Select Props.Get("style")
		Case "NORMAL"
			edt.Typeface =  Typeface.CreateNew(edt.Typeface, Typeface.STYLE_NORMAL)
		Case "BOLD"
			edt.Typeface =  Typeface.CreateNew(edt.Typeface, Typeface.STYLE_BOLD)
		Case "ITALIC"
			edt.Typeface =  Typeface.CreateNew(edt.Typeface, Typeface.STYLE_ITALIC)
		Case "BOLD_ITALIC"
			edt.Typeface =  Typeface.CreateNew(edt.Typeface, Typeface.STYLE_BOLD_ITALIC)
	End Select
	Dim B4xTemp As B4XView = edt
	B4xTemp.SetTextAlignment(Props.Get("vert"),Props.Get("horiz"))
	B4xTemp.SetColorAndBorder(mprops.Get("backgroundColor"),mprops.Get("borderwidth"), _
		mprops.Get("bordercolor"),mprops.Get("borderradius"))
	edt = B4xTemp
	edt.TextSize = Props.Get("textsize")
	edt.TextColor = Props.Get("textcolor")
	edt.SingleLine = Props.get("single")
	edt.PasswordMode = Props.Get("password")
	Select Props.Get("input")
		Case "NONE"
			edt.InputType=edt.INPUT_TYPE_NONE
		Case "NUMBERS"
			edt.InputType=edt.INPUT_TYPE_NUMBERS
		Case "DECIMAL_NUMBERS"
			edt.InputType=edt.INPUT_TYPE_DECIMAL_NUMBERS
		Case "Text"
			edt.InputType=edt.INPUT_TYPE_TEXT
		Case "PHONE"
			edt.InputType=edt.INPUT_TYPE_PHONE
	End Select
	edt.Hint = Props.Get("hinttext")
	edt.HintColor = Props.Get("hintcolor")
	edt.Wrap = Props.Get("wrap")
	edt.ForceDoneButton = Props.Get("force")
	edt.Text = Props.Get("texttext")	
	' add view
	mBase.AddView(edt,0,0,edt.Width,edt.Height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	edt.Width=mBase.Width
	edt.Height=mBase.height
	edt.Top=0
	edt.Left=0
End Sub
#end region

' ##########################################

#region set/get
'##### set Spellcheck on/off
public Sub setSpellcheck(Check As Boolean)
	If Check Then
		edt.inputType=Bit.Or(edt.InputType, 524288)
	Else
		edt.InputType = Bit.And(edt.InputType, Bit.Not(524288))
	End If
	mprops.Put("spell",Check)
End Sub

'##### set input char allowed
public Sub setInputChars(Chars As String)
	Dim ic As String = Chars
	If ic.Length > 0 Then
		ime.SetCustomFilter(edt,edt.InputType,Chars)
	End If
	mprops.put("inputChar",Chars)
End Sub

'##### set text
public Sub setText(text As String)
	edt.Text=text
	mprops.Put("texttext",text)
End Sub

'##### set textsize
public Sub setTextSize(size As Int)
	edt.TextSize=size
	mprops.put("textsize",size)
End Sub

'##### set textcolor
Public Sub setTextColor(color As Int)
	edt.TextColor = color
	mprops.Put("textcolor",color)
End Sub

'#### set beep
public Sub setBeep(doIt As Boolean)
	mprops.Put("errorbeep",doIt)
End Sub

'#### set border color
public Sub setBorderColor(color As Int)
	Dim B4x As B4XView = edt
	B4x.SetColorAndBorder(mprops.Get("backgroundColor"),mprops.Get("borderwidth"), _
		color,mprops.Get("borderradius"))
	edt = B4x
	mprops.Put("bordercolor",color)
End Sub

'#### raise Error
Public Sub setError
	
End Sub
'#### set Fous to view
public Sub GetFocus
	edt.RequestFocus
End Sub

'##### bring view to front
public Sub BringToFront
	mBase.BringToFront
End Sub

'#### get ViewID
public Sub getViewID As String
	Return mprops.Get("id")
End Sub

'#### get Column Name
Public Sub getColumnName As String
	Return mprops.Get("columnName")
End Sub

'#### get Column Type
public Sub getColumnType As String
	Return mprops.Get("columnType")
End Sub

'#### get Text
public Sub getText As String
	Return edt.text
End Sub

'#### get internal EditText
public Sub getEditTextView As EditText
	Return edt
End Sub
#end region

' ##########################################

#region events
private Sub edt_TextChanged(Old As String, New As String)
	' set the background color
	Dim err As Boolean = False
	edt.TextColor=mprops.Get("textcolor")
	If edt.Text.Length > mprops.Get("inputlengthMax") Then
		edt.Text = Old
		err=True
	End If
	If edt.Text.Length < mprops.Get("inputlengthMin") Then
		edt.Text = Old
		err=True
	End If
	If err Then
		edt.SelectionStart = edt.Text.Length
	End If
	' produce a beep sginal
	If mprops.Get("errorbeep") And err = True Then beep.Beep
	
	If SubExists(mCallBack, mEventName & "_TextChanged") Then
		CallSub3(mCallBack,mEventName & "_TextChanged",Old,New)
	End If
End Sub

private Sub edt_FocusCHanged(HasFocus As Boolean)
	Dim B4Xtemp As B4XView = edt
	If HasFocus Then
		edt.Color = mprops.Get("backgroundFocusColor")
	If mprops.Get("borderfocused") Then _
		B4Xtemp.SetColorAndBorder(mprops.Get("backgroundColor"), _
			2dip,mprops.get("bordercolor"),mprops.Get("broderradius"))
		edt=B4Xtemp
	Else
		edt.Color = mprops.Get("backgroundColor")
		If mprops.Get("borderfocused") Then _
			B4Xtemp.SetColorAndBorder(mprops.Get("backgroundColor"), _
			mprops.Get("borderwidth"),mprops.get("bordercolor"),mprops.Get("broderradius"))
	End If
	
	If SubExists(mCallBack, mEventName & "_FocusChanged") Then
		CallSub3(mCallBack,mEventName & "_FocusChanged", HasFocus,CheckDateTime)
	End If
End Sub

private Sub edt_EnterPressed
	If SubExists(mCallBack, mEventName & "_EnterPressed") Then
		CallSub2(mCallBack,mEventName & "_EnterPressed",CheckDateTime)
	End If
End Sub
#end region

' ##########################################

#region helpers
'###### check Date and Time input
'checked
private Sub CheckDateTime As Int
	If edt.Text.Length > 0 Then
		Dim l As Long
		Select mprops.Get("columnType")
			Case "Date"
				Try
					l = DateTime.DateParse(edt.Text)
					edt.TextColor = mprops.Get("textcolor")
					edt.Color = mprops.Get("backgroundColor")
					Return 0
				Catch
					edt.TextColor = mprops.Get("textErrColor")
					edt.Color = mprops.Get("backgroundErrColor")
					If mprops.Get("errorbeep") Then beep.Beep
					Return -1
				End Try
			Case "Time"
				Try
					l = DateTime.TimeParse(edt.Text)
					edt.TextColor = mprops.Get("textcolor")
					edt.Color = mprops.Get("backgroundColor")
					Return 0
				Catch
					edt.TextColor = mprops.Get("textErrColor")
					edt.Color = mprops.Get("backgroundErrColor")
					If mprops.Get("errorbeep") Then beep.Beep
					Return -2
				End Try
			Case "DateTime"
				Dim d() As String = Regex.Split("\ ",edt.text)
				If d.Length = 2 Then
					Try
						l = DateTime.DateParse(d(0))
						edt.TextColor = mprops.Get("textcolor")
						edt.Color = mprops.Get("backgroundColor")
						Try
							l = DateTime.TimeParse(edt.Text)
							edt.TextColor = mprops.Get("textcolor")
							edt.Color = mprops.Get("backgroundColor")
						Catch
							edt.TextColor = mprops.Get("textErrColor")
							edt.Color = mprops.Get("backgroundErrColor")
							If mprops.Get("errorbeep") Then beep.Beep
							Return -2
						End Try
						Return 0
					Catch
						edt.TextColor = mprops.Get("textErrColor")
						edt.Color = mprops.Get("backgroundErrColor")
						If mprops.Get("errorbeep") Then beep.Beep
						Return -1
					End Try
				Else
					If mprops.Get("errorbeep") Then beep.Beep
					Return -3
				End If
		End Select
	Else
		Return 0
	End If
End Sub
#end region
