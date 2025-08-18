B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'Ctrl + click to export as zip: ide://run?=&File=%B4X%\Zipper.jar&Args=Project.zip
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore

	Private btnLogin As Button
	Public PageData As B4XPageData   'Page to show the xCustomListview with the data (Página para añadir el xCLV con los datos)
	Public etPass As B4XView
	Public etUser As B4XView
	Public KVS As KeyValueStore
	Public jRDC As jRDC2
	Public Const PlusChar As String = Chr(0xF067) '+ char for the title bar add menú. (signo + para el menú añadir en la barra de títulos)
	Public Toast As BCToast
End Sub

'You can add more parameters here.
Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
	jRDC.Initialize
	xui.SetDataFolder("jRDC2")
	KVS.Initialize(xui.DefaultFolder,"kvs") 'We use KVS to save the logged user (Usaremos KVS para guardar el usuario que inicia sesión)

	If KVS.ContainsKey("user") Then  'If we've logged before, go directly to PageData (Si hemos iniciado sesión con anterioridad, vamos directamente a la página de datos)
		PageData.Initialize
		B4XPages.AddPage("Page Data", PageData)
		B4XPages.ShowPageAndRemovePreviousPages("Page Data")
		'To avoid loading B4XMainpage if you've logged (check https://www.b4x.com/android/forum/threads/b4xpages-how-to-quickly-load-a-b4xpage-without-showing-mainpage.127180/#post-796199)
		'Para evitar cargar B4XMaipage si hemos iniciado sesión con anterioridad (check https://www.b4x.com/android/forum/threads/b4xpages-how-to-quickly-load-a-b4xpage-without-showing-mainpage.127180/#post-796199)
	End If
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'If we are not logged, load the login layout and initialize PageData
	'Si no hemos iniciado sesión, cargamos el layout de login, e inicializamos PageData
	Root.LoadLayout("Login")
	If Not(PageData.isInitialized) Then
		PageData.Initialize
		B4XPages.AddPage("Page Data", PageData)
	End If
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

#if B4J
Private Sub btnLogin_MouseClicked (EventData As MouseEvent)
#else
Private Sub btnLogin_Click
#end if
	'B4XPages.MainPage.Toast.Show("Checking user and password...")
	Dim Parametros() As String = Array As String(etUser.Text.Trim, etPass.Text.Trim)
	Wait For(jRDC.GetRecord("Login", Parametros)) Complete (Answer As Map)
	If Answer.Get("Success") Then
		Dim l As List
		Dim rs As DBResult
		rs = Answer.Get("Data")
		l = rs.Rows
		If l.Size > 0 Then 'We get a result
			Dim UserData As List
			For Each row() As Object In l
				UserData = row
			Next
			'Save the user name and id to build the sql queries
			'Guardamos el nombre de usuario y el id para construir las sentencias sql
			KVS.Put("user", etUser.Text.Trim)
			KVS.Put("id_user", UserData.Get(0))
			B4XPages.ShowPageAndRemovePreviousPages("Page Data")
		Else
			xui.MsgboxAsync("Wrong sername or password", "Error")
		End If
	Else
		xui.MsgboxAsync("Problem connecting: " & Answer.Get("Error"), "Error")
	End If
End Sub

Sub etPass_TextChanged (Old As String, New As String)
	btnLogin.Enabled = New.Length > 0
End Sub

Sub txtUser_EnterPressed
	'If btnLogin.Enabled Then btnLogin_Click
End Sub

Sub B4XPage_Appear

End Sub


