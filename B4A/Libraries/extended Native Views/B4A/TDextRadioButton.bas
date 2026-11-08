B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.5
@EndOfDesignText@
' ##########################################
' extended nativ RadioButton
' ------------------------------------------
' Name:		TDextRadioButton
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
#DesignerProperty: key: texttext, DisplayName: Text, FieldType:String, DefaultValue:

' custom Properties
#DesignerProperty: key: id, DisplayName: View ID, FieldType:String, DefaultValue:
#DesignerProperty: Key: columnName, DisplayName: Column Name,FieldType: String,DefaultValue:, Description: Name of the database datacolumn
#designerProperty: Key: columnType, DisplayName: Column Typ, FieldType: String, List: Int|Long|String, DefaultValue: Int, Description: Datatype of the Datbase Column
#DesignerProperty: key: value, DisplayName: Integer Value, FieldType:Int, DefaultValue:0, Description: =0 false, 1 = true

' custom event
#Event: CheckedChanged(Checked as Boolean, Value as int)
#end region

' ##########################################

#region globals
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private radio As RadioButton
	Private mprops As Map
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	radio.Initialize("radio")
	mprops.Initialize
End Sub
#end region

' ##########################################

#region basic
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
  	
	mprops = Props
	
	radio.Width = mBase.Width
	radio.Height=mBase.height
	
	'set standard properties
	Select Props.Get("typeface")
		Case "DEFAULT"
			radio.Typeface = Typeface.DEFAULT
		Case "FontAwesome"
			radio.Typeface = Typeface.FONTAWESOME
		Case "Material Icons"
			radio.Typeface = Typeface.MATERIALICONS
		Case "SANS_SERIF"
			radio.Typeface = Typeface.SANS_SERIF
		Case "SERIF"
			radio.Typeface = Typeface.SERIF
		Case "MONOSPACE"
			radio.Typeface =Typeface.MONOSPACE
	End Select
	Select Props.Get("style")
		Case "NORMAL"
			radio.Typeface =  Typeface.CreateNew(radio.Typeface, Typeface.STYLE_NORMAL)
		Case "BOLD"
			radio.Typeface =  Typeface.CreateNew(radio.Typeface, Typeface.STYLE_BOLD)
		Case "ITALIC"
			radio.Typeface =  Typeface.CreateNew(radio.Typeface, Typeface.STYLE_ITALIC)
		Case "BOLD_ITALIC"
			radio.Typeface =  Typeface.CreateNew(radio.Typeface, Typeface.STYLE_BOLD_ITALIC)
	End Select
	Dim B4xTemp As B4XView = radio
	B4xTemp.SetTextAlignment(Props.Get("vert"),Props.Get("horiz"))
	radio = B4xTemp
	radio.TextSize = Props.Get("textsize")
	radio.TextColor = Props.Get("textcolor")
	radio.Text = Props.Get("texttext")
	
	' add view
	mBase.AddView(radio,0,0,radio.Width,radio.Height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  	radio.Width = mBase.Width
	radio.Height=mBase.height
End Sub
#end region

' ##########################################

#region events
Private Sub radio_CheckedChanged(Checked As Boolean)
	If Checked Then
		mprops.Put("value", 1)
	Else
		mprops.Put("value", 0)
	End If
	
	If SubExists(mCallBack, mEventName & "_CheckedChanged") Then
		CallSub3(mCallBack,mEventName & "_CheckedChanged",Checked,mprops.Get("value"))
	End If
End Sub
#end region

' ##########################################

#region set/get
'#### get internal RadioButton
public Sub getRadioButton As RadioButton
	Return radio
End Sub

'##### get/set current Value
'##### checked=1, not checked=0
public Sub getValue As Int
	If radio.Checked Then
		Return 1
	Else
		Return 0
	End If
End Sub

'##### get/set current Value
'##### checked=1, not checked=0
public Sub setValue(Value As Int)
	If Value=1 Then
		radio.checked=True
	Else
		radio.Checked=False
	End If
End Sub

'##### set text
'checked
public Sub setText(text As String)
	radio.Text=text
	mprops.Put("texttext",text)
End Sub

'##### set textsize
'checked
public Sub setTextSize(size As Int)
	radio.TextSize=size
	mprops.put("textsize",size)
End Sub

'##### set textcolor
'checked
Public Sub setTextColor(color As Int)
	radio.TextColor = color
	mprops.Put("textcolor",color)
End Sub

'##### set Checked or not
'checked
public Sub setChecked(Checked As Boolean)
	radio.Checked = Checked
End Sub
#end region