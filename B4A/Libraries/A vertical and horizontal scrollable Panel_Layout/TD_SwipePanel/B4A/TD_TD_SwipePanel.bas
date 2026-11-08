B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.5
@EndOfDesignText@
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Public HScrollview As HorizontalScrollView
	Public VScrollView As ScrollView
	
	Public MainPanel As B4XView
	Public InnerPanel As B4XView
	
	Private GD As GestureDetector
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	HScrollview.Initialize(1dip,"HScrollView")
	VScrollView.Initialize(1dip)
	
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
  	
	MainPanel = xui.CreatePanel("mainpanel")
	InnerPanel = xui.Createpanel("innerpanel")
	
	gd.

End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub