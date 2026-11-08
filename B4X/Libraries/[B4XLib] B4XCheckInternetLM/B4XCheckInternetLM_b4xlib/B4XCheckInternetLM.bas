B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11
@EndOfDesignText@
'B4XCheckInternetLM
' V. 1.1.0
' LucaMs

Sub Class_Globals
	Private xui As XUI
	
	Private mParentView As B4XView
	
	Public Dlg As B4XDialog
	Public DlgTitle As String
	Public DlgMsg As String
	Public DlgYesText As String
	Public DlgCancelText As String
	
	Public URL As String = "https://www.google.com/"
End Sub

Public Sub Initialize(ParentView As B4XView)
	mParentView = ParentView
	
	DlgTitle = "Internet connection"
	DlgMsg = "Please, enable an Internet connection"
	DlgYesText = "Done"
	DlgCancelText = "Cancel"
End Sub

Public Sub setParentView(Parent As B4XView)
	mParentView = Parent
End Sub

Public Sub Check(DialogToo As Boolean) As ResumableSub
	Dim CheckResult As Boolean

	Wait For (DownloadPage) Complete (Success As Boolean)
	CheckResult = Success
	
	If DialogToo Then
		
		Dlg.Initialize(mParentView)
		Dlg.Title = DlgTitle
		
		Do Until CheckResult

			Wait For (DownloadPage) Complete (Success As Boolean)
			CheckResult = Success
			If Not(CheckResult) Then
				Wait For (Dlg.Show(DlgMsg, DlgYesText, "", DlgCancelText)) Complete(Result As Int)
				If Result = xui.DialogResponse_Cancel Then
					Exit
				End If
			End If
			
		Loop

	End If
	
	Return CheckResult
End Sub

Private Sub DownloadPage() As ResumableSub
	Dim result As Boolean = False
	Dim Job As HttpJob
	Job.Initialize("Job", Me)
	Job.Download(URL)
	Wait For(Job) JobDone(Job As HttpJob)
	result = Job.Success
	Job.Release
	Return result
End Sub
