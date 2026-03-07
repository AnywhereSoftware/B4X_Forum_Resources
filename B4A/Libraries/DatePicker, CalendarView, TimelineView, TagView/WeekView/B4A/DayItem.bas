B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#Event: Click (NewDate As Long)
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As Panel
	Private xui As XUI 'ignore
	Public Tag As Object
	Private lblDayNumber As Label
	Private lblDayName As Label
	Private mFullDate As Long
End Sub

Public Sub Initialize (Callback As Object, EventName As String, width As Int)
	mEventName = EventName
	mCallBack = Callback
	
	mBase.Initialize("mBase")
	'parentView.AddView(mBase, 0dip, 0dip, parentView.Width, parentView.Height)
	
	lblDayNumber.Initialize("")
	mBase.AddView(lblDayNumber, (width - 30dip) / 2 ,0,30dip, 30dip)
	lblDayNumber.Text = "15"
	lblDayNumber.TextSize = 12
	lblDayNumber.As(B4XView).SetColorAndBorder(Colors.White, 1dip, Colors.DarkGray, 15dip)
	lblDayNumber.Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
	
	lblDayName.Initialize("")
	mBase.AddView(lblDayName, 0,30dip,width, 20dip)
	lblDayName.Text = "Sun"
	lblDayName.TextSize = 10	
	lblDayName.Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
  	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor"))
End Sub

Public Sub setDayNumber(value As String)
	lblDayNumber.Text = value
End Sub

Public Sub setDayName(value As String)
	lblDayName.Text = value
End Sub

Public Sub setFulDate(value As Long)
	mFullDate = value
End Sub

Public Sub getFulDate() As Long
	Return mFullDate
End Sub

Public Sub Active()
	lblDayNumber.Color = Colors.DarkGray
	lblDayNumber.TextColor = Colors.White
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Public Sub GetView() As Panel
	Return mBase
End Sub

Sub mBase_Click
	CallSub2(mCallBack, mEventName & "_Click", mFullDate)	
End Sub