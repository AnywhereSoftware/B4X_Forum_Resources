B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
'FlipSwitch 1.01
'by Sagenut


#Event: ValueChanged (Value as Int)
#DesignerProperty: Key: Value, DisplayName: Initial Value, FieldType: String, DefaultValue: 0, List: 0|1, Description: Set the initial Value of the switch (0=OFF 1=ON)
#DesignerProperty: Key: Duration, DisplayName: Flip Duration, FieldType: Int, DefaultValue: 150, Description: Set the duration of the flipping movement to change Value in milliseconds
#DesignerProperty: Key: ONText, DisplayName: ON Text, FieldType: String, DefaultValue: ON, Description: The text to be displayed on the ON (Green) side (Value = 1)
#DesignerProperty: Key: ONTextSize, DisplayName: ON Text Size, FieldType: Int, DefaultValue: 14, Description: Set the text size for the ON (Green) text (Value = 1)
#DesignerProperty: Key: ONTextColor, DisplayName: ON Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Color of the text when flipped ON (Value = 1)
#DesignerProperty: Key: OFFText, DisplayName: OFF Text, FieldType: String, DefaultValue: OFF, Description: The text to be displayed on the OFF (Red) side (Value = 0)
#DesignerProperty: Key: OFFTextSize, DisplayName: OFF Text Size, FieldType: Int, DefaultValue: 14, Description: Set the text size for the OFF (Red) text (Value = 0)
#DesignerProperty: Key: OFFTextColor, DisplayName: OFF Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Color of the text when flipped OFF (Value = 0)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private ivGreen As B4XView
	Private ivRed As B4XView
	Private Dimension As Int
	Public Duration As Int
	Private IsMoving As Boolean = False
	Private lblGreen As B4XView
	Private lblRed As B4XView
	Private ivBody As B4XView
	Private mValue As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me
	mValue = Props.Get("Value")
	Duration = Props.Get("Duration") / 2
	Sleep(0)
	If mBase.Width > 140dip Then mBase.Width = 140dip
	mBase.Height = mBase.Width / 2
	mBase.LoadLayout("FlipSwitchLayout")
	Dimension = mBase.Width / 2 + 1dip
	If mValue = 1 Then
		ivRed.SetLayoutAnimated(0, ivRed.Left + Dimension, ivRed.Top, 1dip, ivRed.Height)
		ivGreen.Visible = True
	Else
		ivGreen.SetLayoutAnimated(0, ivGreen.Left, ivGreen.Top, 1dip, ivGreen.Height)
		ivRed.Visible = True
	End If
	Duration = Props.Get("Duration") / 2
	lblGreen.Text = Props.Get("ONText")
	lblGreen.TextSize = Props.Get("ONTextSize")
	lblGreen.TextColor = xui.PaintOrColorToColor(Props.Get("ONTextColor"))
	lblRed.Text = Props.Get("OFFText")
	lblRed.TextSize = Props.Get("OFFTextSize")
	lblRed.TextColor = xui.PaintOrColorToColor(Props.Get("OFFTextColor"))
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	Sleep(0)
	Dimension = mBase.Width / 2 + 1dip
	mBase.Height = mBase.Width / 2
	ivBody.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height)
	lblGreen.SetLayoutAnimated(0, 0, 0, mBase.Width / 2, mBase.Height)
	lblRed.SetLayoutAnimated(0, mBase.Width / 2, 0, mBase.Width / 2, mBase.Height)
	If ivGreen.Visible Then
		ivGreen.SetLayoutAnimated(0, mBase.Width / 2 - 1dip, 0, Dimension, mBase.Height)
		ivRed.SetLayoutAnimated(0, Dimension, 0, 1dip, mBase.Height)
	Else
		ivGreen.SetLayoutAnimated(0, mBase.Width / 2 - 1dip, 0, 1dip, mBase.Height)
		ivRed.SetLayoutAnimated(0, 0, 0, Dimension, mBase.Height)
	End If
End Sub
		
#if B4J
	Private Sub ivSwitch_MouseClicked (EventData As MouseEvent)
		Flip
	End Sub
#else
	Private Sub ivSwitch_Click
		Flip
	End Sub
#End If

#Region Properties
'Get or Set the FlipSwitch Value
Public Sub getValue As Int
	Return mValue
End Sub

Public Sub setValue (newvalue As Int)
	If newvalue = mValue Then Return
	Flip
End Sub

'Get or Set the Left position of the FlipSwitch
Public Sub getLeft As Int
	Return mBase.Left
End Sub

Public Sub setLeft (newvalue As Int)
	If newvalue = mBase.Left Then Return
	mBase.Left = newvalue
End Sub

'Get or Set the Top position of the FlipSwitch
Public Sub getTop As Int
	Return mBase.Top
End Sub

Public Sub setTop (newvalue As Int)
	If newvalue = mBase.Top Then Return
	mBase.Top = newvalue
End Sub

'Get or Set the Right position of the FlipSwitch
Public Sub getRight As Int
	Return mBase.Left + mBase.Width
End Sub

Public Sub setRight (newvalue As Int)
	If newvalue = mBase.Left + mBase.Width Then Return
	mBase.Left = newvalue - mBase.Width
End Sub

'Get or Set the Bottom position of the FlipSwitch
Public Sub getBottom As Int
	Return mBase.Top + mBase.Height
End Sub

Public Sub setBottom (newvalue As Int)
	If newvalue = mBase.Top + mBase.Height Then Return
	mBase.Top = newvalue - mBase.Height
End Sub

'Get or Set the Width of the FlipSwitch
Public Sub getWidth As Int
	Return mBase.Width
End Sub

Public Sub setWidth (newvalue As Int)
	If newvalue = mBase.Width Then Return
	If newvalue > 140dip Then newvalue = 140dip
	mBase.Width = newvalue
	#if B4A
		LayoutResize
	#End If
End Sub

'Get or Set the Height of the FlipSwitch
Public Sub getHeight As Int
	Return mBase.Height
End Sub

Public Sub setHeight (newvalue As Int)
	If newvalue = mBase.Height Then Return
	If newvalue > 70dip Then newvalue = 70dip
	mBase.Width = newvalue * 2
	#if B4A
		LayoutResize
	#End If
End Sub

'Get or Set the ON Text of the FlipSwitch
Public Sub getONText As String
	Return lblGreen.Text
End Sub

Public Sub setONText (newvalue As String)
	If newvalue = lblGreen.Text Then Return
	lblGreen.Text = newvalue
End Sub

'Get or Set the ON Text Size of the FlipSwitch
Public Sub getONTextSize As Int
	Return lblGreen.TextSize
End Sub

Public Sub setONTextSize (newvalue As Int)
	If newvalue = lblGreen.TextSize Then Return
	lblGreen.TextSize = newvalue
End Sub

'Get or Set the ON Text Color of the FlipSwitch
Public Sub getONTextColor As Int
	Return lblGreen.TextColor
End Sub

Public Sub setONTextColor (newvalue As Int)
	If newvalue = lblGreen.TextColor Then Return
	lblGreen.TextColor = newvalue
End Sub

'Get or Set the OFF Text of the FlipSwitch
Public Sub getOFFText As String
	Return lblRed.Text
End Sub

Public Sub setOFFText (newvalue As String)
	If newvalue = lblRed.Text Then Return
	lblRed.Text = newvalue
End Sub

'Get or Set the OFF Text Size of the FlipSwitch
Public Sub getOFFTextSize As Int
	Return lblRed.TextSize
End Sub

Public Sub setOFFTextSize (newvalue As Int)
	If newvalue = lblRed.TextSize Then Return
	lblRed.TextSize = newvalue
End Sub

'Get or Set the OFF Text Color of the FlipSwitch
Public Sub getOFFTextColor As Int
	Return lblRed.TextColor
End Sub

Public Sub setOFFTextColor (newvalue As Int)
	If newvalue = lblRed.TextColor Then Return
	lblRed.TextColor = newvalue
End Sub
#End Region

Private Sub Flip
	If IsMoving Then Return
	IsMoving = True
	If ivGreen.Visible Then
		ivGreen.SetLayoutAnimated(Duration, ivGreen.Left, ivGreen.Top, 1dip, ivGreen.Height)
		Sleep(Duration)
		ivGreen.Visible = Not(ivGreen.Visible)
		ivRed.Visible = Not(ivRed.Visible)
		ivRed.SetLayoutAnimated(Duration, ivRed.Left - Dimension, ivRed.Top, Dimension, ivRed.Height)
		Sleep(Duration)
		IsMoving = False
		mValue = 0
		If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 1) Then
			CallSubDelayed2(mCallBack, mEventName & "_ValueChanged", mValue)
		End If
	Else
		ivRed.SetLayoutAnimated(Duration, ivRed.Left + Dimension, ivRed.Top, 1dip, ivRed.Height)
		Sleep(Duration)
		ivGreen.Visible = Not(ivGreen.Visible)
		ivRed.Visible = Not(ivRed.Visible)
		ivGreen.SetLayoutAnimated(Duration, ivGreen.Left, ivGreen.Top, Dimension, ivGreen.Height)
		Sleep(Duration)
		IsMoving = False
		mValue = 1
		If xui.SubExists(mCallBack, mEventName & "_ValueChanged", 1) Then
			CallSubDelayed2(mCallBack, mEventName & "_ValueChanged", mValue)
		End If
	End If
End Sub

Private Sub LayoutResize
	Dimension = mBase.Width / 2 + 1dip
	mBase.Height = mBase.Width / 2
	ivBody.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height)
	lblGreen.SetLayoutAnimated(0, 0, 0, mBase.Width / 2, mBase.Height)
	lblRed.SetLayoutAnimated(0, mBase.Width / 2, 0, mBase.Width / 2, mBase.Height)
	If ivGreen.Visible Then
		ivGreen.SetLayoutAnimated(0, mBase.Width / 2 - 1dip, 0, Dimension, mBase.Height)
		ivRed.SetLayoutAnimated(0, Dimension, 0, 1dip, mBase.Height)
	Else
		ivGreen.SetLayoutAnimated(0, mBase.Width / 2 - 1dip, 0, 1dip, mBase.Height)
		ivRed.SetLayoutAnimated(0, 0, 0, Dimension, mBase.Height)
	End If
End Sub