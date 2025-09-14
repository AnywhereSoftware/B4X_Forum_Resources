B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#Event: Event(EventName as String)
Sub Class_Globals
	Public Const EVENT_START As String = "Start"
	Public Const EVENT_FAIL As String = "Fail"
	Public Const EVENT_COMPLETE As String = "Complete"
	Private fx As JFX
	Private CForm As Form
	Private CmdTwain_CV1 As CmdTwain_CV
	Private mVisible As Boolean
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	CForm.Initialize("CForm",600,250)
	CForm.Resizable = False
	
	CForm.RootPane.LoadLayout("cmdtwain_layout")
	CForm.Title = "CmdTwain Gui"
	
End Sub

Private Sub CForm_CloseRequest (EventData As Event)
	SaveOptions
	mVisible = False
End Sub

Public Sub AddEventListener(Callback As Object,EventName As String)
	CmdTwain_CV1.AddEventListener(Callback,EventName)
End Sub

Public Sub GetCmdTwain As CmdTwain
	Return CmdTwain_CV1.GetCmdTwain
End Sub

Public Sub ResetOptions
	CmdTwain_CV1.ResetOptions
End Sub

Public Sub Show
	CmdTwain_CV1.SetFormMetrics(CForm,"")
	CForm.Show
	mVisible = True
End Sub

Public Sub Hide
	SaveOptions
	CForm.Close
	mVisible = False
End Sub

Public Sub Visible As Boolean
	Return mVisible
End Sub

Private Sub SaveOptions
	CmdTwain_CV1.SaveFormMetrics(CForm,"")
	CmdTwain_CV1.SaveOptions
End Sub

