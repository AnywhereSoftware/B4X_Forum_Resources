B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@

'Class module
' iOS style MsgBox
Sub Class_Globals
	Private xui As XUI
	Private mParent As B4XView
	Private Overlay As B4XView
	Private Popup As B4XView
	Private mCallBack As Object
	Private mEventName As String
End Sub

Public Sub Initialize(Parent As B4XView, CallBack As Object, EventName As String)
	mParent = Parent
	mCallBack = CallBack
	mEventName = EventName
End Sub

Public Sub Show(Title As String, Message As String, Buttons() As String)
	' background shadow
	Overlay = xui.CreatePanel("")
	Overlay.Color = xui.Color_ARGB(120, 0, 0, 0)
	mParent.AddView(Overlay, 0, 0, mParent.Width, mParent.Height)

	' Main Popup
	Popup = xui.CreatePanel("")
	Popup.Color = Colors.White
	Popup.SetColorAndBorder(Colors.White, 0, 0, 20dip)   ' angoli arrotondati
	Dim dlgWidth As Float
	If mParent.Width>mParent.Height Then
		dlgWidth = Min(mParent.Width * 0.4, 400dip)
	Else
		dlgWidth = Min(mParent.Width * 0.8, 400dip)
	End If
	mParent.AddView(Popup, 0, 0, dlgWidth, 1dip)
	Dim TopPos As Float = 20dip

	' Title
	If Title <> "" Then
		Dim lblTitle As Label
		lblTitle.Initialize("")
		lblTitle.Text = Title
		lblTitle.TextColor = Colors.Black
		lblTitle.TextSize = 20
		lblTitle.Typeface = Typeface.DEFAULT_BOLD
		lblTitle.Gravity = Gravity.CENTER_HORIZONTAL
		Popup.AddView(lblTitle, 0, TopPos, Popup.Width, 30dip)
		TopPos = TopPos + 40dip
	End If

	' Message
	Dim lbl As Label
	lbl.Initialize("")
	lbl.Text = Message
	lbl.TextColor = Colors.black
	lbl.TextSize = 17
	lbl.Gravity = Gravity.CENTER_HORIZONTAL
	lbl.SingleLine = False
	Popup.AddView(lbl, 20dip, TopPos, Popup.Width - 40dip, 2dip)

	Dim su As StringUtils
	Dim h As Float = su.MeasureMultilineTextHeight(lbl, Message)
	lbl.Height = h
	TopPos = TopPos + h + 20dip

	' Buttons
	For Each btnText As String In Buttons
		' iOS style divider line
		Dim sep As Panel
		sep.Initialize("")
		sep.Color = 0xFFDDDDDD
		Popup.AddView(sep, 0, TopPos, Popup.Width, 1dip)
		TopPos = TopPos + 1dip
		' iOS style clickable label
		Dim lblBtn As Label
		lblBtn.Initialize("dgbx")
		lblBtn.Text = btnText
		lblBtn.TextSize = 18
		lblBtn.TextColor = Colors.Blue
		lblBtn.Gravity = Gravity.CENTER
		lblBtn.Tag = btnText
		lblBtn.Color = Colors.White
		Popup.AddView(lblBtn, 0, TopPos, Popup.Width, 50dip)
		TopPos = TopPos + 50dip
	Next

	' Popup dimension
	Popup.Height = TopPos + 20dip
	Popup.Left = (mParent.Width - Popup.Width) / 2
	Popup.Top = (mParent.Height - Popup.Height) / 2

	Popup.Visible = True
	Overlay.Visible = True
End Sub

' Buttons click event
Private Sub dgbx_Click
	Dim b As B4XView = Sender
	Dim txt As String = b.Tag
	Close
    CallSubDelayed2(mCallBack, mEventName & "_Result", txt)
End Sub

public Sub Close
	If Popup.IsInitialized Then Popup.RemoveViewFromParent
	If Overlay.IsInitialized Then Overlay.RemoveViewFromParent
End Sub

Public Sub GetPopup As B4XView
	Return Popup
End Sub
