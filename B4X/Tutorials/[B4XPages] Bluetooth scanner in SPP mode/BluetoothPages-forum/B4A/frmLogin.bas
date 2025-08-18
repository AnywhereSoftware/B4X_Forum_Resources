B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.9
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	Private ourCaller As  Object
	Private callersRoutine As String
	
	Private txtUsername As EditText
	Private lblStatus As B4XView
	Private lblConnected As B4XView
	Private list As List
	Private txtPassword As EditText
End Sub

Public Sub Initialize
End Sub

public Sub Setup(theCaller As  Object, paCallersRoutine As String, paParms As Map)
	Dim anParm As String
	Dim anParm2 As String
	anParm = GetFromMap("Parm1", paParms)
	anParm2 = GetFromMap("Parmx", paParms) ' isn't in paParms
	ourCaller = theCaller
	callersRoutine = paCallersRoutine
	list.Initialize
	list.AddAll(Array("Code 39", "Code 128"))
	B4XPages.MainPage.Scanset(Me, "NewMessage", list)
	lblStatus.Text = ""
	lblConnected.Text = ""
	txtUsername.Text = "dave" ' for testing so don't have to enter it
	txtPassword.Text = "abc"
End Sub

public Sub GetFromMap (paKey As  String, paMap As Map) As String
	Dim value As Object
	Dim valueStr As String
	value = paMap.Get(paKey)
	If value = Null Then
		valueStr = ""
	Else
		valueStr = value
	End If
	Return valueStr
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frmLogin")
End Sub

Private Sub B4XPage_Appear
End Sub

Sub B4XPage_CloseRequest As ResumableSub
	exitLogin ("")
	Return True
End Sub

Sub btnExit_Click
	exitLogin ("")
	B4XPages.ClosePage(Me)
End Sub

Sub exitLogin (paUserName As String)
	B4XPages.MainPage.Scanset(Null, "",  Array As String ("")) ' scanner off
	CallSubDelayed2(ourCaller, callersRoutine, paUserName)
End Sub

Sub txtUsername_EnterPressed
	txtPassword.RequestFocus
	lblStatus.Text = "Enter Password"
End Sub

Sub btnLogin_Click
	Dim leaving As Boolean
	If txtUsername.Text = "" Then
		B4XPages.MainPage.SetLogin(False)
		leaving = True
	Else
	If txtUsername.Text.ToLowerCase = "dave" Or txtUsername.Text.ToLowerCase = "abc-1234" Then ' not case sensitive
			' not verifying password for testing
			B4XPages.MainPage.SetLogin(True)
			leaving = True
		Else
			lblStatus.Text = "Incorrect Username or Password"
			B4XPages.MainPage.PlaySound("bad")
			txtUsername.Text = ""
			txtPassword.Text = ""
			txtUsername.RequestFocus
		End If
	End If
	If leaving Then
		exitLogin (txtUsername.Text)
		B4XPages.ClosePage(Me)
	End If
End Sub

'  Called by B4XMainPage
Public Sub NewMessage (msg As String)
	txtUsername.Text = msg
	txtUsername_EnterPressed
End Sub

'  Called by B4XMainPage
public Sub ScanError (errorMsg As String)
	lblStatus.Text = ""
	lblConnected.Text = errorMsg
End Sub

Sub txtPassword_EnterPressed
	lblStatus.Text = "Click Login"
End Sub