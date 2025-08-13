B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Biometric As BiometricManager
	Private Label1 As B4XView
	Private btnAuth As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	Biometric.Initialize(Me, "Authenticate")
	Dim res As String = Biometric.CanAuthenticate
	If res = "SUCCESS" Then
		btnAuth.Enabled = True
	Else
		btnAuth.Enabled = False
		Label1.Text = "Can't authenticate: " & res
	End If
End Sub

Sub btnAuth_Click
	Biometric.Show("Please authenticate")
	Wait For Authenticate_Complete (Success As Boolean, ErrorMessage As String)
	Label1.text = $"Success: ${Success}
ErrorMessage: ${ErrorMessage}"$
	
End Sub
