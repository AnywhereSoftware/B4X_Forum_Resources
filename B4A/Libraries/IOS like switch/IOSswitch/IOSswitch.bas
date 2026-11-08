B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
#Event: click (State as boolean, ID as String)
#DesignerProperty: Key: ID, DisplayName: ID, FieldType: Int, DefaultValue: 0
#DesignerProperty: Key: ImageON, DisplayName: Image Filename State ON, FieldType: String, DefaultValue: SwitchONWhite.png
#DesignerProperty: Key: ImageOFF, DisplayName: Image Filename State OFF, FieldType: String, DefaultValue: SwitchOFFWhite.png
#DesignerProperty: Key: ImageDisabled, DisplayName: Image Filename State Disabled, FieldType: String, DefaultValue: SwitchDisabled.png
#DesignerProperty: Key: textOFF, DisplayName: Text OFF, FieldType: String, DefaultValue: OFF
#DesignerProperty: Key: textON, DisplayName: Text ON, FieldType: String, DefaultValue: ON
#DesignerProperty: Key: textsize, DisplayName: Text size, FieldType: Int, DefaultValue: 14
#DesignerProperty: Key: textcolorOFF, DisplayName: Text color OFF, FieldType: Color, DefaultValue: 0xFF0000FF
#DesignerProperty: Key: textcolorON, DisplayName: Text color ON, FieldType: Color, DefaultValue: 0xFF0000FF

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Public Switch As Label
	Private stateON As Boolean = False
	Private iprops As Map
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	iprops.initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me
	
	iprops=Props
	
		Switch.Initialize("Switch")
		Switch.Height=mBase.Height
		Switch.Width=mBase.Width
		Switch.Color=Colors.Transparent
		Switch.TextColor= Props.Get("textcolor")
		Switch.TextSize = Props.Get("textsize")
		Switch.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.right)
		If Switch.Enabled Then
			Switch.SetBackgroundImage(LoadBitmap(File.DirAssets,Props.Get("ImageOFF")))
			Switch.Text = "· " & Props.Get("textOFF") & " · "
			Switch.TextColor= Props.Get("textcolorOFF")
		Else
			Switch.SetBackgroundImage(LoadBitmap(File.DirAssets,Props.Get("ImageDisabled")))
		End If
		
		mBase.AddView(Switch,0,0,mBase.Width,mBase.Height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)

End Sub

Public Sub enabled (isEnabled As Boolean)
	Switch.Enabled = isEnabled
	If Switch.Enabled Then
		Switch.SetBackgroundImage(LoadBitmap(File.DirAssets,iprops.Get("ImageOFF")))
		Switch.Text = "· " & iprops.Get("textOFF") & " · "
		Switch.TextColor= iprops.Get("textcolorOFF")
	Else
		Switch.Text = ""
		Switch.SetBackgroundImage(LoadBitmap(File.DirAssets,iprops.Get("ImageDisabled")))
	End If
End Sub

Sub Switch_click
	If stateON = False Then
  		stateON = True
		Switch.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.left)
		Switch.Text = "· " & iprops.Get("textON") & " · "
		Switch.TextColor= iprops.Get("textcolorON")
		Switch.SetBackgroundImage(LoadBitmap(File.DirAssets,iprops.Get("ImageON")))
	Else
		stateON = False
		Switch.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.right)
		Switch.Text = "· " & iprops.Get("textOFF") & " · "
		Switch.TextColor= iprops.Get("textcolorON")
		Switch.SetBackgroundImage(LoadBitmap(File.DirAssets,iprops.Get("ImageOFF")))
	End If
	If SubExists(mCallBack,"IOSswitch_click") Then
		CallSub3(mCallBack,"IOSswitch_click",stateON,iprops.Get("ID"))
	End If
End Sub
