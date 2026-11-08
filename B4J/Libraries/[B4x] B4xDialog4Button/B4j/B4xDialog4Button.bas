B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
Sub Class_Globals
	Private XUI As XUI
	Private mDialog As B4XDialog
	Public Const DialogResponse_NewButton As Int = -4
	Public Const DialogResponse_Cancel As Int = XUI.DialogResponse_Cancel
	Public Const DialogResponse_Positive As Int = XUI.DialogResponse_Positive
	Public Const DialogResponse_Negative As Int = XUI.DialogResponse_Negative
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Dialog As B4XDialog)
	mDialog = Dialog
End Sub

Public Sub Show(Text As Object,NewButton As String,Positive As String, Negative As String,Cancel As String) As ResumableSub
	
	Dim p As B4XView
	p = XUI.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 380dip, 100dip)
	Dim lbl As Label
	lbl.Initialize("")
	#if B4J
	lbl.WrapText = True
	#else if B4A
	lbl.SingleLine = False
	#else if B4i
	lbl.Multiline = True
	#end if
	Dim xlbl As B4XView = lbl
	p.AddView(xlbl, 5dip, 0, p.Width - 10dip, p.Height)
	xlbl.TextColor = mDialog.BodyTextColor
	xlbl.Font = mDialog.TitleBarFont
	XUIViewsUtils.SetTextOrCSBuilderToLabel(xlbl, Text)
	xlbl.SetTextAlignment("CENTER", "LEFT")
	
	
	mDialog.ShowCustom(p,"","","")
	
	Dim P As B4XView = XUI.CreatePanel("")
	Dim Base As B4XView = mDialog.Base
	Base.AddView(P,0,Base.Height - mDialog.ButtonsHeight - 4dip,Base.Width,mDialog.ButtonsHeight + 4dip)
	
	Dim btnNames As List = Array As String(NewButton,Positive,Negative,Cancel)
	
	Dim i As Int
	For i = 0 To btnNames.Size - 1
		#If B4j
		Dim Btn As Button
		#else
		Dim Btn As Label
		#end if
		Btn.Initialize("Xbtn")
		Dim XB4x As B4XView = Btn
		XB4x.Color = mDialog.ButtonsColor
		XB4x.TextColor = mDialog.ButtonsTextColor
		
		If i = 0 Then XB4x.Tag = -4 Else XB4x.Tag = -i
		XB4x.Text = btnNames.Get(i)
		XB4x.Font = mDialog.ButtonsFont
		Base.AddView(XB4x, _
		Base.Width - 4dip - btnNames.Size * 80dip + i * 80dip, _			'Left
		Base.Height - mDialog.ButtonsHeight - 4dip, _						'Top
		80Dip, _															'Width
		mDialog.ButtonsHeight)												'height
		If -i = XUI.DialogResponse_Cancel Then Btn.RequestFocus
	Next
	
	Wait For Xbtn_Click
	mDialog.Close(0)
	Dim RBtn As B4XView = Sender
	Dim Resp As Int = RBtn.Tag
	Return Resp
End Sub

Public Sub ShowCustom(P As B4XView,NewButton As String,Positive As String, Negative As String,Cancel As String) As ResumableSub
	
	mDialog.ShowCustom(p,"","","")
	
	Dim P As B4XView = XUI.CreatePanel("")
	Dim Base As B4XView = mDialog.Base
	Base.AddView(P,0,Base.Height - mDialog.ButtonsHeight - 4dip,Base.Width,mDialog.ButtonsHeight + 4dip)
	
	Dim btnNames As List = Array As String(NewButton,Positive,Negative,Cancel)
	
	Dim i As Int
	For i = 0 To btnNames.Size - 1
		#If B4j
		Dim Btn As Button
		#else
		Dim Btn As Label
		#end if
		Btn.Initialize("Xbtn")
		Dim XB4x As B4XView = Btn
		XB4x.Color = mDialog.ButtonsColor
		XB4x.TextColor = mDialog.ButtonsTextColor
		
		If i = 0 Then XB4x.Tag = -4 Else XB4x.Tag = -i
		XB4x.Text = btnNames.Get(i)
		XB4x.Font = mDialog.ButtonsFont
		Base.AddView(XB4x, _
		Base.Width - 4dip - btnNames.Size * 80dip + i * 80dip, _			'Left
		Base.Height - mDialog.ButtonsHeight - 4dip, _						'Top
		80Dip, _															'Width
		mDialog.ButtonsHeight)												'height
		If -i = XUI.DialogResponse_Cancel Then Btn.RequestFocus
	Next
	
	Wait For Xbtn_Click
	mDialog.Close(0)
	Dim RBtn As B4XView = Sender
	Dim Resp As Int = RBtn.Tag
	Return Resp
End Sub

Public Sub ShowTemplate (DialogTemplate As Object,NewButton As String, Yes As Object, No As Object, Cancel As Object) As ResumableSub
	Dim content As B4XView = CallSub2(DialogTemplate, "GetPanel", mDialog)
	content.Width = content.Width + 50dip
	CallSub2(DialogTemplate, "Show", mDialog)
	
	Dim RS As ResumableSub = ShowCustom(content , NewButton, Yes, No, Cancel)
	
	
	Dim P As B4XView = XUI.CreatePanel("")
	Dim Base As B4XView = mDialog.Base
	Base.AddView(P,0,Base.Height - mDialog.ButtonsHeight - 4dip,Base.Width,mDialog.ButtonsHeight + 4dip)
	
	Dim btnNames As List = Array As String(NewButton,Yes,No,Cancel)
	
	Dim i As Int
	For i = 0 To btnNames.Size - 1
		#If B4j
		Dim Btn As Button
		#else
		Dim Btn As Label
		#end if
		Btn.Initialize("Xbtn")
		Dim XB4x As B4XView = Btn
		XB4x.Color = mDialog.ButtonsColor
		XB4x.TextColor = mDialog.ButtonsTextColor
		
		If i = 0 Then XB4x.Tag = -4 Else XB4x.Tag = -i
		XB4x.Text = btnNames.Get(i)
		XB4x.Font = mDialog.ButtonsFont
		Base.AddView(XB4x, _
		Base.Width - 4dip - btnNames.Size * 80dip + i * 80dip, _			'Left
		Base.Height - mDialog.ButtonsHeight - 4dip, _						'Top
		80Dip, _															'Width
		mDialog.ButtonsHeight)												'height
		If -i = XUI.DialogResponse_Cancel Then Btn.RequestFocus
	Next
	
	Wait For (RS)  Complete (Result As Int)
	
	CallSub2(DialogTemplate, "DialogClosed", Result)
	Return Result
End Sub