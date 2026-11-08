B4A=true
Group=B4XPAGES
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=\%PROJECT_NAME%.zip

'B4A ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4A\%PROJECT_NAME%.b4a
'B4i ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4i\%PROJECT_NAME%.b4i
'B4J ide://run?file=%WINDIR%\System32\cmd.exe&Args=/c&Args=start&Args=..\..\B4J\%PROJECT_NAME%.b4j

'Opens the project folder.
'Project folder: ide://run?file=%WINDIR%\SysWOW64\explorer.exe&Args=%PROJECT%

#Region VERSIONS 
'	1.0.0.	01/12/2025
#End Region

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Logs As B4XView
End Sub

Public Sub Initialize
	B4XPages.GetManager.TransitionAnimationDuration = 0
'	B4XPages.GetManager.LogEvents = True
End Sub

#Region B4XPage EVENTS 

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("mainpage")
	B4XPages.SetTitle(Me, "Home")
End Sub

Private Sub B4XPage_Appear
	
End Sub

Private Sub B4XPage_Disappear
	
End Sub

Private Sub B4XPage_Background
	
End Sub

Private Sub B4XPage_Foreground
	
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	Dim sf As Object = xui.Msgbox2Async("Do you really want to close?", "", "Yes", "", "No", Null)
	Wait For (sf) Msgbox_Result (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Return True
	End If
	Return False
End Sub

Private Sub B4XPage_IconifiedChanged (Iconified As Boolean)
	
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	
End Sub

#End Region

#Region VIEWS' EVENTS 

Private Sub Button1_Click
	DoIt
End Sub

#End Region

#Region PUBLIC METHODS 
#End Region

#Region PRIVATE METHODS 

Private Sub DoIt
	Dim lstItems As List
	lstItems.Initialize
	lstItems.AddAll(Array ("A", "B", "C", "D"))
	
'	lmB4XPermutations.Callback = Me
'	lmB4XPermutations.EventName = "per"
	Wait For (lmB4XPermutations.Generate(lstItems)) Complete(lstPermutations As List)
	For Each lst As List In lstPermutations
		Log(lst)
		Logs.Text = Logs.Text & lst & CRLF 'ignore
	Next
	
	Log(" ")
	Log(lstPermutations.Size & " lists.")
	Logs.Text = Logs.Text & CRLF & lstPermutations.Size & " lists."
End Sub

#End Region

'Public Sub per_PermStep
'	Log("Step")
'End Sub