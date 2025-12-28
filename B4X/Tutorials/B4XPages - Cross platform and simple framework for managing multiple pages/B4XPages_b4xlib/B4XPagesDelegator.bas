B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
Sub Class_Globals
End Sub

Public Sub Initialize
	
End Sub

#if B4J
Public Sub MainForm_FocusChanged (HasFocus As Boolean)
	B4XPages.GetManager.MainForm_FocusChanged (HasFocus)
End Sub

Public Sub MainForm_Closed
	B4XPages.GetManager.MainForm_Closed
End Sub

Public Sub MainForm_CloseRequest (EventData As Event)
	B4XPages.GetManager.MainForm_CloseRequest (EventData)
End Sub

Public Sub MainForm_IconifiedChanged (Iconified As Boolean)
	B4XPages.GetManager.MainForm_IconifiedChanged(Iconified)
End Sub
#End If

#if B4A
Public Sub Activity_KeyPress (KeyCode As Int) As Boolean
	Return B4XPages.GetManager.Activity_KeyPress (KeyCode)
End Sub

Sub Activity_PermissionResult (Permission As String, Result As Boolean)
	B4XPages.GetManager.RaiseEvent(B4XPages.GetManager.GetTopPage, "B4XPage_PermissionResult", Array(Permission, Result))
End Sub

Public Sub Activity_ActionBarHomeClick
	B4XPages.GetManager.Activity_ActionBarHomeClick
End Sub

Public Sub Create_Menu (Menu As Object)
	B4XPages.GetManager.CreateMenu(Menu)
End Sub
#end if

Public Sub MainForm_Resize(Width As Double, Height As Double)
	B4XPages.GetManager.MainForm_Resize(Width, Height)
End Sub

Public Sub Activity_Resume
	B4XPages.GetManager.Activity_Resume
End Sub

Public Sub Activity_Pause
	B4XPages.GetManager.Activity_Pause
End Sub

