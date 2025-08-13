B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private txtUrl As EditText
	Private rp As RuntimePermissions
	Private Settings As WebSettings
	Private CookieM As CookieManager
	Private WebViewClient As UltimateWebViewClient
	Private WebChromeClient As UltimateWebChromeClient
	Private DownloadListener As UltimateDownloadListener
	Private fp As FileProvider
	Public WebView1 As WebView ' Object added through Designer
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	fp.Initialize
	
		
	WebViewClient.Initialize2("WebView1",WebView1)
	'-------Or else-----
	'WebViewClient.Initialize("WebView1").ImplementInWebView(WebView1)
	
	WebChromeClient.Initialize2("WebView1",WebView1).AllowFullScreenVideo(True,False) 'AllowFullScreenVideo only if you need, it is not necessary to set.
	'-------Or else-----
	'WebChromeClient.Initialize("WebView1").AllowFullScreenVideo(True,False).ImplementInWebView(WebView1)
	
	DownloadListener.Initialize2("WebView1",WebView1)
	'-------Or else-----
	'DownloadListener.Initialize("WebView1").ImplementInWebView(WebView1)
	
	Settings.Initialize(WebView1)
	CookieM.Initialize(WebView1)
	
	Settings.AllowContentAccess=True
	Settings.AllowFileAccess=True
	Settings.AllowFileAccessFromFileURLs=True
	Settings.AllowUniversalAccessFromFileURLs=True
	Settings.BuiltInZoomControls=False
	Settings.JavaScriptEnabled=True
	Settings.DomStorageEnabled=True
	Settings.JavaScriptCanOpenWindowsAutomatically=True
	Settings.MediaPlaybackRequiresUserGesture=False
	Settings.SaveFormData=True
	Settings.GeolocationEnabled=True
	Settings.SupportMultipleWindows=True
	CookieM.AcceptCookies=True
	CookieM.AcceptFileSchemeCookies=True
	CookieM.AcceptThirdPartyCookies=True

End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub btnGo_Click
	WebView1.LoadUrl(txtUrl.Text)
End Sub

Private Sub WebView1_PermissionsRequest (RequestedRuntimePermissions As List, Request As PermissionRequest) 'Works from API level 21 and above.
	For Each permission As String In RequestedRuntimePermissions
		Log(permission)
		rp.CheckAndRequest(permission)
		Wait For B4XPage_PermissionResult (permission As String, Result As Boolean)
		If Result=False Then
			Request.Deny
			Return
		End If
	Next
	Request.Grant(Request.Resources)
End Sub

Private Sub WebView1_GeolocationPermissionRequest (Origin As String, Callback As GeolocationPermissionCallback) 'Works from API level 5 and above.
	Msgbox2Async("This web page requests geolocation permission.", "Geolocation permission required","Allow All Time", "Allow Once", "Deny",Null,False)
	Wait For Msgbox_Result(mResult As Int)
	If mResult=DialogResponse.CANCEL Or mResult=DialogResponse.POSITIVE Then
		Dim RequestedRuntimePermissions As List
		RequestedRuntimePermissions.Initialize
		RequestedRuntimePermissions.Add(rp.PERMISSION_ACCESS_FINE_LOCATION)
		RequestedRuntimePermissions.Add(rp.PERMISSION_ACCESS_COARSE_LOCATION)
		For Each permission As String In RequestedRuntimePermissions
			rp.CheckAndRequest(permission)
			Wait For B4XPage_PermissionResult (permission As String, Result As Boolean)
			If Result=False Then
				Callback.Invoke(Origin,False,False)
				Return
			End If
		Next
		If mResult=DialogResponse.POSITIVE Then
			Callback.Invoke(Origin,True,True)
		Else
			Callback.Invoke(Origin,True,False)
		End If
	Else
		Callback.Invoke(Origin,False,False)
	End If
End Sub

Private Sub WebView1_OverrideUrl (Request As WebResourceRequest) As Boolean 'Works from API level 1 and above.
	'Log("OverrideUrl = " & Request.Url)
	If Request.HasExternalAppIntent Then
		StartActivity(Request.ExternalAppIntent)
		Return True
	End If
	Return False
End Sub


Private Sub WebView1_FileDownloadInitialized (Properties As DownloadProperties) 'Works from API level 1 and above.
	Log("FileDownloadInitialized")
	DownloadListener.StartFileDownload(Properties,"","hello",True,True)
End Sub

Private Sub WebView1_FileDownloadStarted (Properties As DownloadProperties) 'Works from API level 9 and above.
	Log("FileDownloadStarted, ID=" & Properties.DownloadID)
End Sub

Private Sub WebView1_FileDownloadCompleted (Success As Boolean, Properties As DownloadProperties) 'Works from API level 9 and above.
	Log("FileDownloadCompleted, ID=" & Properties.DownloadID)
End Sub

Private Sub WebView1_PageFinished (Url As String) 'Works from API level 1 and above.
	'Log("PageFinished = " & Url)
	txtUrl.Text=Url
End Sub

Private Sub WebView1_CreateWindow (OverridenRequest As WebResourceRequest, ChildWebView As WebView, IsDialog As Boolean, IsUserGesture As Boolean) As Boolean 'Works from API level 1 and above. Return True if you want to consume ChildWebView, False to destroy. SupportMultipleWindows option must be enabled. You can add the newly created WebViewObject to Layout manualy, or use UltimateWebView's AddChildWindow method.
	Log("WebkitWebView1_CreateWindow")
	If IsUserGesture=False Then Return False 'Try to prevent an unwanted comercial popup's.
	
	'Add ChildWebView to layout manualy. You must set object size and position. Also, future control of the object is completely manual.
	
	Return True
End Sub

Private Sub WebView1_ShowFileChooser (FilePathCallback As ValueCallbackUri, Params As FileChooserParams) 'Works from API level 21 and above. FilePathCallback.OnReceiveValue must be executed with value from file chooser, or null to abort.
	WebChromeClient.ShowDefaultAppChooser(FilePathCallback,Params,False,fp.SharedFolder)
	
	'------------------StartActivityForResult library required to execute code below ("https://www.b4x.com/android/forum/threads/startactivityforresult-lib.157837/")-------------------
	'Dim ActForRes As StartActivityForResult
	'ActForRes.Initialize("ION")
	'ActForRes.Start2(Params.Intent,1,Array(FilePathCallback))
End Sub

'------------------StartActivityForResult library required to execute below event-------------------
'Private Sub ION_OnActivityResult (RequestCode As Int, ResultCode As Int, Data As Intent, ExtraParams() As Object)
'	Log("ION_OnActivityResult_RequestCode = " & RequestCode)
'	Dim ret As Object=FileChooserParams.ParseResult(ResultCode,Data)
'	ExtraParams(0).As(ValueCallbackUri).OnReceiveValue(ret)
'End Sub

Private Sub WebView1_ShouldInterceptRequest (Request As WebResourceRequest) As WebResourceResponse 'Works from API level 11 and above. From Api level 11 to 20, passed WebResourceRequest contains only Url.
	'Log("ShouldInterceptRequestUrl = " & Request.Url)
	Return Null
End Sub



Private Sub WebView1_ReceivedClientCertRequest (Request As ClientCertRequest) 'Works from API level 21 and above.
	Log("-------ReceivedClientCertRequest---------")
	Request.Ignore
End Sub

Private Sub WebView1_ConsoleMessage (Message As ConsoleMessage) As Boolean 'Works from API level 8 and above.
	'Log(Message.Message)
	Return False
End Sub

