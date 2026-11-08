B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
#Event: Click (Tag as String)
#DesignerProperty: Key: BooleanExample, DisplayName: Show Seconds, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: TextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Text color

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As Panel
	Private xui As XUI 'ignore
	Public Tag As Object
	Private bg As Int = Colors.White
	Private boderWidth As Int = 1dip
	Private boderColor As Int = Colors.ARGB(255,0,221,255)
	Private lblContent As Label
	Private fontsize As Int = 12
	Private mSelected As Boolean = False
	Private mIndex As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String, width As Int, height As Int, Text As String)
	mEventName = EventName
	mCallBack = Callback
	mBase.Initialize("mBase")
	
	lblContent.Initialize("lblContent")
	mBase.AddView(lblContent,0,0, width, height)
	lblContent.Text = Text
	lblContent.TextSize = fontsize
	lblContent.Gravity = Gravity.CENTER_HORIZONTAL + Gravity.CENTER_VERTICAL
	
	Resize(Text)
	
	isSelected(False)
End Sub

Public Sub Resize(Text As String)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(lblContent)
	Dim fnt As B4XFont = xui.CreateFont(Typeface.DEFAULT, fontsize)
	Dim r As B4XRect = cvs1.MeasureText(Text, fnt)
	lblContent.Width = r.Width + 10dip
	mBase.Width = r.Width + 20dip
End Sub

Public Sub setBoderColor(color As Int)
	boderColor = color
End Sub

Public Sub setBoderWidth(value As Int)
	boderWidth = value
End Sub

Public Sub setColor(value As Int)
	bg = value
	lblContent.Color = value
End Sub

Public Sub setTag(value As Int)	
	mIndex = value
End Sub

Public Sub getTag()	As Int
	Return mIndex
End Sub

Public Sub setText(value As String)
	lblContent.Text = value
	Resize(value)
End Sub

Public Sub getText()
	Return lblContent.Text
End Sub

public Sub getWidth() As Int
	Return lblContent.Width
End Sub

public Sub isSelected(value As Boolean)	
	If value = True Then
		lblContent.As(B4XView).SetColorAndBorder(boderColor, boderWidth, bg, 4dip)
		lblContent.TextColor = Colors.White
		mSelected = True
	Else 
		lblContent.As(B4XView).SetColorAndBorder(bg, boderWidth, boderColor, 4dip)
		lblContent.TextColor = boderColor
		mSelected = False
	End If
	
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
  	Dim clr As Int = xui.PaintOrColorToColor(Props.Get("TextColor")) 'Example of getting a color value from Props
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

Sub lblContent_Click()
	If mSelected = False Then
		mSelected = True
		isSelected(True)		
	Else
		mSelected = False
		isSelected(False)				
	End If	
	CallSub2(mCallBack, mEventName & "_Click", mIndex)
End Sub

Public Sub getSelected() As Boolean
	Return mSelected
End Sub

Public Sub GetView() As Panel
	Return mBase
End Sub