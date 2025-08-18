B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.9
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private ourScanDemo As ScanDemo
	Private ourLogin As frmLogin
	
	Private lblUser As Label
	Private btnScan As B4XView
	
	Private loginShownOnce As Boolean
End Sub

Public Sub Initialize
	ourLogin.Initialize
	ourScanDemo.Initialize
End Sub

public Sub Setup
	loginShownOnce = False
	btnScan.Enabled = False
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frmMenu")
	B4XPages.AddPageAndCreate("frmLogin", ourLogin)
	B4XPages.AddPageAndCreate("Demo Page", ourScanDemo)
End Sub

Private Sub B4XPage_Appear ' appears after login so loops if they don't login. need to find better way to show login when started
	If B4XPages.MainPage.IsLoggedin = False And loginShownOnce = False Then
		' test of passing parameter through a Map
		Dim ourMap As Map
		ourMap.Initialize
		ourMap.Put("Parm1", "1")
		ourMap.Put("Parm2", "2")
		ourMap.Put("Parm3", "3")
		ourLogin.Setup(Me, "LoginResult", ourMap)
		B4XPages.ShowPage("frmLogin")
	End If
End Sub

' Instead of OnActivityResult style with RequestID, have a Sub for each external Page called our use PageExit.
' Either way the signature is the same.
' And instead of GetStringExtra just return data to routine e.g. LoginResult using CallSubDelayed2 in called Page
public Sub LoginResult(theResult As String)
	loginShownOnce = True
	If theResult <> "" Then
		lblUser.Text = "User: " & theResult
		btnScan.Enabled = True
	Else
		lblUser.Text = "Not logged in"
		btnScan.Enabled = False
	End If
End Sub

' Generic callback
public Sub PageExit(theResult As String)
	
End Sub

Sub btnExit_Click
	B4XPages.MainPage.SetLogin(False)
	B4XPages.ClosePage(Me)
End Sub
Sub B4XPage_CloseRequest As ResumableSub
	B4XPages.MainPage.SetLogin(False)
	Return True
End Sub

Sub btnScan_Click
	ourScanDemo.Setup(Me, "PageExit")
	B4XPages.ShowPage("Demo Page")
End Sub

Sub btnLogin_Click
	Dim ourMap As Map
	ourMap.Initialize
	ourMap.Put("Parm1", "!")
	ourMap.Put("Parm2", "2")
	ourMap.Put("Parm3", "3")
	ourLogin.Setup(Me, "LoginResult", ourMap)
	B4XPages.ShowPage("frmLogin")
End Sub