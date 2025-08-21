B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.5
@EndOfDesignText@
Sub Class_Globals
	Private mCallbackModule As Object
	Private lblSeconds As Label
	Private lblText As EditText
	Private ProgressBar1 As ProgressBar
	Private dialog As CustomLayoutDialog
	Private mOKButtonText As String = "OK"
	Private Const DialogW As Float = 95%x
	Private Const DialogH As Float = 95%y
	Private Const Padding As Float = 10dip
	Private Const HeightRatio As Float = 0.8
	Private su As StringUtils
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallbackModule As Object, OKButtonText As String)
	mCallbackModule = CallbackModule
	mOKButtonText = OKButtonText
	
	ProgressBar1.Initialize("")
	lblSeconds.Initialize("")
	lblText.Initialize("")
	
	ProgressBar1.Width = 80dip
	ProgressBar1.Height = ProgressBar1.Width
	ProgressBar1.Indeterminate = True
	
	lblSeconds.TextSize = 20
	lblSeconds.TextColor = Colors.Red
	lblSeconds.Gravity = Gravity.CENTER
	lblSeconds.Width = ProgressBar1.Width/2
	lblSeconds.Height = lblSeconds.Width
	
	lblText.TextSize = 18
	lblText.InputType = lblText.INPUT_TYPE_NONE
	lblText.Gravity = Bit.Or(Gravity.LEFT, Gravity.TOP)
	lblText.SingleLine = False
	lblText.Width = DialogW - (6 * Padding)
	lblText.Height = DialogH * HeightRatio
End Sub

Public Sub MsgboxTimed(Message As String, Title As String, SecondsTimeOut As Int)
	lblText.Text = Message
	Calculate_Height(lblText)
	Dim sf As Object = dialog.ShowAsync(Title, mOKButtonText, "", "", Null, False)
	Dim MaxH As Float = Min(DialogH, lblText.Height / HeightRatio * 2.5)
	dialog.SetSize(DialogW, MaxH)
	Wait For (sf) Dialog_Ready (DialogPanel As Panel)
	
	Dialog_Layout(DialogPanel)
	
	Dim disable() As Boolean = Array As Boolean(False)
	AutoClose(dialog, SecondsTimeOut, lblSeconds, disable)
	Wait For (sf) Dialog_Result (Result As Int)
	DialogPanel.RemoveView
	disable(0) = True 'disable the AutoClose timer
End Sub

Public Sub MsgboxTimed2(Message As String, Title As String, Positive As String, Cancel As String, Negative As String, Icon As Bitmap, Cancellable As Boolean, SecondsTimeOut As Int) 
	lblText.Text = Message
	Calculate_Height(lblText)
	Dim sf As Object = dialog.ShowAsync(Title, Positive, Cancel, Negative, Null, Cancellable)
	Dim MaxH As Float = Min(DialogH, lblText.Height / HeightRatio * 2.5)
	dialog.SetSize(DialogW, MaxH)
	Wait For (sf) Dialog_Ready (DialogPanel As Panel)
	
	Dialog_Layout(DialogPanel)

	Dim disable() As Boolean = Array As Boolean(False)
	AutoClose(dialog, SecondsTimeOut, lblSeconds, disable)
	Wait For (sf) Dialog_Result (Result As Int)
	
	disable(0) = True 'disable the AutoClose timer
	DialogPanel.RemoveView
	CallSub2(mCallbackModule, "Msgbox_Result", Result)
End Sub

Public Sub Close
	dialog.CloseDialog(DialogResponse.CANCEL)
End Sub

Private Sub Dialog_Layout(container As Panel)
	ProgressBar1.RemoveView
	lblSeconds.RemoveView
	lblText.RemoveView
	
	container.AddView(ProgressBar1, 0, container.Height - ProgressBar1.Height, ProgressBar1.Width, ProgressBar1.Height)
	container.AddView(lblSeconds, (ProgressBar1.Left - lblSeconds.Width/2 + ProgressBar1.Width/2), (ProgressBar1.Top - lblSeconds.Height/2 + ProgressBar1.Height/2), lblSeconds.Width, lblSeconds.Height)

	lblText.Height = container.Height * HeightRatio
	container.AddView(lblText, Padding, Padding, lblText.Width, lblText.Height)
End Sub

Private Sub AutoClose (TimedDialog As CustomLayoutDialog, SecondsTimeOut As Int, UpdateLabel As Label, Disable() As Boolean)
	UpdateLabel.Text = SecondsTimeOut
	Do While UpdateLabel.Text > 0
		Sleep(1000)
		'the timer was disabled
		If Disable(0) = True Then Return
		UpdateLabel.Text = NumberFormat(UpdateLabel.Text - 1, 0, 0)
	Loop
	TimedDialog.CloseDialog(DialogResponse.CANCEL)
End Sub

Private Sub Calculate_Height(label As Label)
	label.Height = su.MeasureMultilineTextHeight(label, label.Text) + 10dip
	If label.Height < 15%y Then
		label.Height = 15%y
	End If
End Sub