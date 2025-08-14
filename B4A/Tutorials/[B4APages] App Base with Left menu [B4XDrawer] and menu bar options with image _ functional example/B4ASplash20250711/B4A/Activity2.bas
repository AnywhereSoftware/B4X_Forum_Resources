B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=10
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	Public ActionBarHomeClicked As Boolean
	Public CorrectHeight As Int
	Public HeightChangedFired As Boolean
End Sub

Sub Globals

End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Log("Activity 1")
	Dim ime As IME
	ime.Initialize("ime")
	ime.AddHeightChangedEvent
	Dim pm As B4XPagesManager
	pm.Initialize(Activity)

	CorrectHeight = 100%y
	Wait For ime_HeightChanged (NewHeight As Int, OldHeight As Int)
	CorrectHeight = NewHeight
	HeightChangedFired = True
	'Log("Activity 2")
End Sub

Sub ime_HeightChanged (NewHeight As Int, OldHeight As Int)
	
End Sub

'Template version: B4A-1.01
#Region Delegates

Sub Activity_ActionBarHomeClick
	ActionBarHomeClicked = True
	B4XPages.Delegate.Activity_ActionBarHomeClick
	ActionBarHomeClicked = False
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean
	Return B4XPages.Delegate.Activity_KeyPress(KeyCode)
End Sub

Sub Activity_Resume
	B4XPages.Delegate.Activity_Resume
End Sub

Sub Activity_Pause (UserClosed As Boolean)
	B4XPages.Delegate.Activity_Pause
End Sub

Sub Activity_PermissionResult (Permission As String, Result As Boolean)
	B4XPages.Delegate.Activity_PermissionResult(Permission, Result)
End Sub

Sub Create_Menu (Menu As Object)
	B4XPages.Delegate.Create_Menu(Menu)
End Sub

#if Java
public boolean _onCreateOptionsMenu(android.view.Menu menu) {
	 processBA.raiseEvent(null, "create_menu", menu);
	 return true;
	
}
#End If
#End Region

