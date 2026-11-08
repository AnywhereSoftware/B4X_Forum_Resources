B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
	Private CallBack As Object
	Private mActivity As Activity
	Public ResultOK As Boolean
	Public ResultData As String
	Public WebView1 As WebView
	Public wve As WebViewExtras
	Private WebViewOK As Boolean
	Private Done As Boolean
	Private ime1 As IME
	Dim url As String = "https://www.domain.com/urlphoneauth"
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(vActivity As Activity, vCallback As Object)
	CallBack = vCallback
	mActivity = vActivity
	WebViewOK = False
	Done = False
	WebView1.Initialize("WebView1")
	WebView1.Visible = False
	mActivity.AddView(WebView1,0,0,100%x,100%y)
	ime1.Initialize("")
	wve.Initialize(WebView1)

	ResultOK = False
	ResultData = ""

	Private rid As String = DateTime.Now
	WebView1.ZoomEnabled = False
	
	Dim urlphoneauth As String
	'urlphoneauth = url & "?rid=" & rid
	
	' debug mode -> 
	urlphoneauth = url & "?debug=1&rid=" & rid
	
	WebView1.LoadUrl(urlphoneauth)
	WebView1.Visible = True
	StartTimeout(20000)
End Sub
Private Sub StartTimeout(ms As Long)
	Sleep(ms)
	If Done Then Return
	If WebViewOK = False Then
		Done = True
		CallSubDelayed(CallBack, "firebaseauthphoneweb_fail")
	End If
End Sub
Sub WebView1_PageFinished (urltxt As String)
	WebViewOK = True
	Sleep(500)
	'Do While WebView1.Zoom(False) = True
	'Loop
	If WebView1.IsInitialized Then
		ime1.ShowKeyboard(WebView1)
	End If
End Sub
Sub showkeyboard
	Try
		WebView1.RequestFocus
		Sleep(50)
		ime1.ShowKeyboard(WebView1)
	Catch
		Log(LastException)
	End Try
End Sub
Sub WebView1_OverrideUrl (urlstring As String) As Boolean
	If urlstring.StartsWith("foneauth://showkeyboard") Then
		Dim field As String = GetQueryParam(urlstring, "field") ' phone / code
		showkeyboard
		' FORZAR FOCO AL INPUT DENTRO DEL WEBVIEW
		Try
			Dim js As String = ""
			If field = "code" Then
				js = "try{var e=document.getElementById('code'); if(e){e.focus(); e.click();}}catch(ex){}"
			Else
				js = "try{var e=document.getElementById('phone'); if(e){e.focus(); e.click();}}catch(ex){}"
			End If
			' Si tu WebView soporta RunJavaScript:
			wve.ExecuteJavascript(js)
		Catch
			Log(LastException)
		End Try

		Return True
	End If
	
	If urlstring.StartsWith("foneauth://result") Then
		Done = True
		
		Dim success As String = GetQueryParam(urlstring, "success")
		Dim dataEnc As String = GetQueryParam(urlstring, "data")

		ResultOK = (success = "1")
		ResultData = ""

		Dim phone As String = ""

		If dataEnc <> "" Then
			Dim su As StringUtils
			Dim dataJson As String = su.DecodeUrl(dataEnc, "UTF-8")
			ResultData = dataJson

			Try
				Dim jp As JSONParser
				jp.Initialize(dataJson)
				Dim m As Map = jp.NextObject

				phone = m.GetDefault("phone","")
				Log("UID=" & m.GetDefault("uid",""))
				Log("PHONE=" & phone)
			Catch
				Log("JSON parse error: " & dataJson)
			End Try
		End If

		CallSubDelayed2(CallBack, "firebaseauthphoneweb_result", phone)
		Return True
	End If

	Return False
End Sub
Sub GetQueryParam(u As String, key As String) As String
	Try
		Dim i As Int = u.IndexOf("?")
		If i = -1 Then Return ""
		Dim qs As String = u.SubString(i + 1)
		Dim parts() As String = Regex.Split("&", qs)
		For Each p As String In parts
			Dim kv() As String = Regex.Split("=", p)
			If kv.Length >= 2 Then
				If kv(0) = key Then Return kv(1)
			End If
		Next
	Catch
		Log(LastException)
	End Try
	Return ""
End Sub

Public Sub CloseAndRemove
	Done = True
	If WebView1.IsInitialized Then
		Try
			WebView1.Visible = False
			WebView1.StopLoading
			WebView1.LoadUrl("about:blank")
			WebView1.RemoveView
		Catch
			Log(LastException)
		End Try
	End If
End Sub