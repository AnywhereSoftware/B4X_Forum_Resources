B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8
@EndOfDesignText@
#Event: CompleteAndClosed(Result as int)
Sub Class_Globals
	Private xui As XUI
	Public mBase As B4XView
	Private xDialog As B4XDialog
	Private Label1 As B4XView
	Private Label2 As B4XView
	Private mVisible As Boolean
	Private mDuration As Int = 600
	Private mPause As Int = 500
	Private lblText As B4XView
	Private pnComplete As B4XView
	Private StartTime As Long
	Private lblTime As B4XView
	Private mCallback As Object
	Private mEventName As String
End Sub

Public Sub Initialize
	mBase = xui.CreatePanel("mBase")
	mBase.SetLayoutAnimated(0, 0, 0, 300dip, 150dip)
	mBase.LoadLayout("filedownloadindeterminate_template")
	DateTime.SetTimeZone(0)
End Sub

'Sub required for Template
Public Sub GetPanel (Dialog As B4XDialog) As B4XView
	Return mBase
End Sub

'Set the duration of the animation
Public Sub setDuration(Duration As Int)
	mDuration = Duration
End Sub

'Set the pause between animations
Public Sub setPause(Pause As Int)
	mPause = Pause
End Sub

'Set the label text, a filename for this template
Public Sub setText(Text As String)
	lblText.Text = Text
End Sub

'Return the text label
Public Sub TextLabel As B4XView
	Return lblText
End Sub

'Sub required for Template
Private Sub Show (Dialog As B4XDialog)
	xDialog = Dialog
	xDialog.PutAtTop = xui.IsB4A Or xui.IsB4i
	mBase.Color = Dialog.BackgroundColor
	pnComplete.Color = Dialog.BackgroundColor
	StartTime = DateTime.now
	mVisible = True
	pnComplete.Visible = False

	SetButtonsVisiblity(False)
	
	Dim Left As Double = Label1.Left
	Dim Top As Double = Label1.Top

	Do While mVisible And pnComplete.Visible = False
		Label1.SetRotationAnimated(mDuration,45)
		Label1.SetLayoutAnimated(mDuration,Label2.Left,Label2.Top,Label1.Width,Label1.Height)
		Sleep(mDuration)
		Label1.Visible = False
		Sleep(mPause)
		Label1.SetLayoutAnimated(0,Left,Top,Label1.Width,Label1.Height)
		Label1.SetRotationAnimated(0,0)
		Label1.Visible = True
		Sleep(mPause)
	Loop
	
End Sub

Private Sub SetButtonsVisiblity(Visible As Boolean)
	'Sleep to allow the dialog to finish creating itself.
	Sleep(0)
	
	For Each DR As Int In xDialog.ButtonsOrder
		Try
		Dim B As B4XView = xDialog.GetButton(DR)
		If B.IsInitialized Then B.Visible = Visible
		Catch
'			Log(LastException)
		End Try
	Next
End Sub

'To display complete Dialog, you need to provide a callback and 
'eventname so you can wait for the dialog to finally be closed by the user.
'<code>DT.Complete(Me,"DT")
'Wait For DT_CompleteAndClosed</code>
'If you don't want to display the Complete message, call Dialog.Close(0) when you are ready
Public Sub Complete(Callback As Object,EventName As String)
	mCallback = Callback
	mEventName = EventName
	lblTime.Text = "Time taken : " & DateTime.Time(DateTime.Now - StartTime)
	SetButtonsVisiblity(True)
	pnComplete.Visible = True
End Sub


'Sub required for Template
Private Sub DialogClosed(Result As Int) 'ignore
	mVisible = False
	If pnComplete.Visible  And SubExists(mCallback,mEventName & "_CompleteAndClosed") Then CallSubDelayed2(mCallback,mEventName & "_CompleteAndClosed",Result)
End Sub