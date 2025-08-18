B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module: cl_appupdate
'Version: 2.00
'Author: UDG
'Last Modified: 18.10.2018
'Location: Di Gioia Consulting - Lugano (CH)
Private Sub Class_Globals
	'Status Codes
	Public ERR_NOPKG = -1	As Int				'missing package name
	Public ERR_NOTXT = -2 As Int				'missing webserver's info text file full path
	Public ERR_NOAPK = -3 As Int				'missing webserver's new apk file full path
	Public ERR_TXTROW = -4 As Int				'wrong row format in text file
	Public ERR_HTML = -5 As Int					'website returned an HTML error page instead of the info text file
	Public ERR_NOSPACE = -6 As Int				'no enough space on the device to load the apk
	Public ERR_NOPERM = -7 As Int				'no permissions to install new apk
	Public ERR_DOWNLOAD = -8 As Int				'failed to download apk from webserver
	Public ERR_HTTP = -100 As Int				'HttpUtils error
	Public OK_INIT = 0 As Int
	Public OK_CURVER = 1 As Int					'curver has valid value
	Public OK_WEBVER = 2 As Int
	Public NO_NEWERAPK = 3 As Int				'apk version on webserver is the same as current one
	Public OK_NEWERAPK = 4 As Int				'current apk has a newer version ready to download on the webserver
	Public OK_DOWNLOAD = 5 As Int				'newer apk correctly downloaded from webserver
	Public OK_INSTALL = 6 As Int				'user asked to install newer apk
	
	'Private variables
	Private Callback As Object
	Private Event As String
	Private sPackageName As String      		'ex: com.test.myapp
	Private sNewVerTxt As String        		'ex: http://umbetest.web44.net/p_apk/myapp.txt
	Private sNewVerApk  As String       		'ex: http://umbetest.web44.net/p_apk/myapp.apk
	Private sStatusCode As Int          		'negatives denote errors; 0 = lib initialized; positives show current status
	Private sUserName As String         		'user name for password protected folders on the server
	Private sUPassword As String        		'password related to username above
	Private curver, webver As String    		'curver = current version number; webver=version number read from the webserver
	Private webclog As String					'webclog = optional changelog data from webserver
	Private webfsize As String					'webfsize = optional apk file size from webserver
	Private sVerbose As Boolean					'TRUE = a lot of logs
	Private pnlSplash As Panel					'panel used to superimpose a splashscreen image
	Private SplashShowing As Boolean			'True = splashscreen showing
	Private phone As Phone
	Private rp As RuntimePermissions
	Private SharedFolder As String				'Foder where to store temporary apk file downloaded from a webserver
	Private UseFileProvider As Boolean			'TRUE = SDK >=24, make use of FileProvider; FALSE = use GetSafeDirDefaultExternal
	Private LogColor1 As Int = 0xFFFF8C00		'first color for log messages
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallbackModule As Object, EventName As String)
	Callback = CallbackModule
	Event = EventName
	sPackageName = ""
	sNewVerTxt = ""
	sNewVerApk = ""
	sUserName = ""
	sUPassword = ""
	sStatusCode = OK_INIT
	curver = ""
	webver = ""
	sVerbose = False
	SplashShowing = False
	Dim p As Phone
	If p.SdkVersion >= 24 Or File.ExternalWritable = False Then
		UseFileProvider = True
		SharedFolder = File.Combine(File.DirInternal, "shared")
		File.MakeDir("", SharedFolder)
	Else
		UseFileProvider = False
		SharedFolder = rp.GetSafeDirDefaultExternal("shared")
	End If
End Sub

'Sets package name for this app. It should equal the value in menu "Project.Build configurations.Package"
'Example: com.test.myapp
Public Sub setPackageName(PN As String)
	sPackageName = PN
End Sub

'Gets back the package name set for this app. Used internally.
Public Sub getPackageName As String
	Return sPackageName
End Sub

'Complete path to the info text file having a first line of text formatted as
'ver=x.yz where x.yz corresponds to the newest app's version available on the webserver
'Optionally that first line of text could be followed by ChangeLog and FileSize sections
Public Sub setNewVerTxt(NVT As String)
	sNewVerTxt = NVT
End Sub

'Complete path to the new apk for your app, available for download from the webserver
Public Sub setNewVerApk(NVA As String)
	sNewVerApk = NVA
End Sub

'Sets Username and Password to use when downloading from a protected website folder
Public Sub setCredentials(UserN As String, UserP As String)
	sUserName = UserN
	sUPassword = UserP
End Sub

'Sets verbose mode on/off
Public Sub setVerbose(Verbose As Boolean)
	sVerbose = Verbose
	newinst2.svcVerbose = Verbose
End Sub

'Returns current internal status. Negatives denote ERRORS/WARNINGS.
Public Sub getStatus As Int
	Return sStatusCode
End Sub

'Returns current version number value (as a string)  
'Valid only after calling ReadCurVN
Public Sub getCurVN As String
	Return curver
End Sub

'Returns the version number value (as a string) as read from the info text file on the webserver. 
'Valid only after successfully calling ReadWebVN
Public Sub getWebVN As String
	Return webver
End Sub

'Returns optional change log data (as a string) as read from the info text file on the webserver  
'Valid only after successfully calling ReadWebVN
Public Sub getWebChangeLog As String
	Return webclog
End Sub

'Returns optional apk's file size (as a string) as read from the info text file on the webserver  
'Valid only after successfully calling ReadWebVN
Public Sub getWebFileSize As String
	Return webfsize
End Sub

'Returns device's available space. Use to test whether there's enough room to load apk from webserver
Public Sub GetAvailableSpace As Long
	Return GetFreeSpace
End Sub

'Reads current version number from running copy of apk (see Attribute #VersionName).
'Valid if StatusCode = OK_CURVER
Public Sub ReadCurVN
	LogColor("---- AppUpdating.ReadCurVN", LogColor1)
	IsValidCV											'we don't care about its result since we go to sub Finito anyway
	Finito
End Sub

'Reads version number as published in the text info file on the webserver
'Valid if StatusCode = OK_WEBVER
Public Sub ReadWebVN
	LogColor("---- AppUpdating.ReadWebVN", LogColor1)
	Wait For(IsvalidWV) Complete (OkWebVer As Boolean)
	Finito
End Sub

'Downloads newer apk from webserver
Public Sub DownloadApk
	LogColor("---- AppUpdating.DownloadApk", LogColor1)
	'check whether NewVerApk was declared
	If sNewVerApk = "" Then
		sStatusCode = ERR_NOAPK
		If sVerbose Then Log($"${TAB}missing apk file full path indication"$)
		Finito
		Return
	End If
	'download new apk file from webserver and save it locally as temp file tmp.apk
	Dim j As HttpJob
	j.Initialize("", Me)
	j.Username = sUserName
	j.Password = sUPassword
	j.Download(sNewVerApk)							'ex: j.Download("http://umbetest.web44.net/p_apk/myapp.apk")
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		'save to temporary file "tmp.apk" in SharedFolder
		Dim out As OutputStream
		out = File.OpenOutput(SharedFolder,"tmp.apk",False)
		File.Copy2(J.GetInputStream, out)
		out.Close
		sStatusCode = OK_DOWNLOAD
		If sVerbose Then Log($"${TAB}new apk version downloaded and ready to install"$)
	Else
		Log($"${TAB}Error: ${J.ErrorMessage}"$)
		sStatusCode = ERR_HTTP
		If sVerbose Then Log($"${TAB}error in httputils2"$)
		ToastMessageShow("Error: " & J.ErrorMessage, True)
	End If
	j.Release
	Finito
End Sub

'Installs an already downloaded apk. Pstatus = result from a call to CheckInstallationRequirements in calling activity
Public Sub InstallApk(pstatus As Boolean)
	LogColor("---- AppUpdating.InstallApk", LogColor1)
	If pstatus Then
		SendInstallIntent
		sStatusCode = OK_INSTALL
		If sVerbose Then Log(TAB & "user asked to install new apk")
	Else
		sStatusCode = ERR_NOPERM
		If sVerbose Then Log(TAB & "no permissions from user to install new apk")
	End If
	Finito
End Sub

'Check website for a newer apk version and (if any exists) try to download it, then ask user to install it.
'Note: we don't know if the user will then accept to install it..
Public Sub UpdateApk(pstatus As Boolean)
	LogColor("---- AppUpdating.UpdateApk", LogColor1)
	If Not(pstatus) Then
		sStatusCode = ERR_NOPERM
		If sVerbose Then Log(TAB & "no permissions from user to install new apk")
	Else
		Wait For(IsvalidWV) Complete (OkWebVer As Boolean)
		If (IsValidCV And OkWebVer) Then							'here we check if both curver and webver are valid
			If curver < webver Then
				'check local devices' available disk space
				If IsNumber(webfsize) Then
					Dim fsize As Long = webfsize
					If fsize*2 > GetFreeSpace Then
						sStatusCode = ERR_NOSPACE
						If sVerbose Then Log($"${TAB}no enough available space to download apk"$)
					End If
				End If
				If sStatusCode >= 0 Then
					sStatusCode = OK_NEWERAPK			'info file tells us there is a newer apk								
					If sVerbose Then Log($"${TAB}Newer version available. Now I try its downloading"$)
					If sNewVerApk = "" Then
						sStatusCode = ERR_NOAPK
						If sVerbose Then Log($"${TAB}missing apk file full path indication"$)
					End If
				End If
			Else
				sStatusCode = NO_NEWERAPK
				If sVerbose Then Log($"${TAB}No newer version available on webserver."$)
			End If
		End If
	End If
	TryApkUpdate						'if available and permitted, download apk from webserver and ask user to install it
End Sub

'Download newer apk from wenserver and ask user to install it
Private Sub TryApkUpdate
	LogColor($"${TAB}-- TryApkUpdate"$, LogColor1)
	'check whether NewVerApk was declared
	If ((sStatusCode >= 0) And (sStatusCode <> NO_NEWERAPK)) Then
		'download new apk file from webserver and save it locally as temp file tmp.apk
		Dim j As HttpJob
		j.Initialize("", Me)
		j.Username = sUserName
		j.Password = sUPassword
		j.Download(sNewVerApk)								'ex: jobapk.Download("http://umbetest.web44.net/p_apk/myapp.apk")
		Wait For (j) JobDone(j As HttpJob)
		If j.Success Then
			Try
				'save to temporary file tmp.apk in SharedFolder
				Dim out As OutputStream
				out = File.OpenOutput(SharedFolder,"tmp.apk",False)
				File.Copy2(j.GetInputStream, out)
				out.Close
				sStatusCode = OK_DOWNLOAD
				If sVerbose Then Log($"${TAB}new apk version downloaded and ready to install"$)
			Catch
				sStatusCode = ERR_DOWNLOAD
				If sVerbose Then Log($"${TAB}failed download of new apk version"$)
				ToastMessageShow(LastException, True)
			End Try
		Else
			Log($"${TAB}Error: ${J.ErrorMessage}"$)
			sStatusCode = ERR_HTTP
			If sVerbose Then Log($"${TAB}error in httputils2"$)
			ToastMessageShow($"Error: ${J.ErrorMessage}"$, True)
		End If
		j.Release
		If sStatusCode == OK_DOWNLOAD Then
			SendInstallIntent
			sStatusCode = OK_INSTALL
			If sVerbose Then Log($"${TAB}user asked to install new apk"$)
		End If
	End If
	Finito
End Sub

'Action requested is over; it calls the Callback function, if any exists
Private Sub Finito
	If SubExists(Callback,Event&"_UpdateComplete") Then
		CallSub(Callback,Event&"_UpdateComplete")
	End If
End Sub

'Check whether PackageName was declared in order to set curver. Returns True for a valid curver, False otherwise
Private Sub IsValidCV As Boolean
	If sPackageName = "" Then
		curver = ""
		sStatusCode = ERR_NOPKG
		If sVerbose Then Log($"${TAB}missing package name for current version check"$)
	Else
		Dim pm As PackageManager
		curver = pm.GetVersionName(sPackageName)
		sStatusCode = OK_CURVER 									'got current version from Project Attributes
		If sVerbose Then Log($"${TAB}Current Version: ${curver}"$)
	End If
	Return (sStatusCode == OK_CURVER)
End Sub

'Check whether NewVerTxt file was declared in order to set webver. Returns True for a valid webver, False otherwise
Private Sub IsvalidWV As ResumableSub
	If sNewVerTxt = "" Then
		webver = ""
		sStatusCode = ERR_NOTXT
		If sVerbose Then Log($"${TAB}missing info file full path indication"$)
	Else
		'download info file from webserver
		Dim j As HttpJob
		j.Initialize("", Me)
		j.Username = sUserName
		j.Password = sUPassword
		j.Download(sNewVerTxt)								'ex: jobapk.Download("http://umbetest.web44.net/p_apk/myapp.apk")
		Wait For (j) JobDone(j As HttpJob)
		If j.Success Then
			If sVerbose Then Log($"Webserver's info file content: ${CRLF}${J.GetString}"$)
			If Not(J.GetString.Contains("<!DOCTYPE html>")) Then
				webver = ExtractVN(J.GetString)
				webclog = ExtractCL(J.GetString)					'optional changelog data
				webfsize = ExtractSZ(J.GetString)					'optional apk's file size
				If webver = "" Then
					sStatusCode = ERR_TXTROW
					If sVerbose Then Log($"${TAB}wrong row format in info file "$)
				Else
					sStatusCode = OK_WEBVER							'read apk's version number as published on webserver
					If sVerbose Then Log($"${TAB}Web version number: ${webver}"$)
				End If
			Else
				sStatusCode = ERR_HTML								'website returned an HTML error page
				If sVerbose Then Log($"${TAB}ERROR: website returned an HTML error page"$)
			End If
		Else
			Log($"${TAB}Error: ${J.ErrorMessage}"$)
			sStatusCode = ERR_HTTP
			If sVerbose Then Log($"${TAB}error in httputils2"$)
			ToastMessageShow("Error: " & J.ErrorMessage, True)
		End If
		j.Release
	End If
	Return (sStatusCode == OK_WEBVER)
End Sub

'Extract version number from the first row in sNewVerTxt info text file
'expected row format: ver=x.yz where "ver" could be any term and x.yz is the version number
'Attn: no spaces allowed between equal sign and version number
'Optionally that first line of text could be followed by ChangeLog and FileSize sections
Private Sub ExtractVN(TxtRow As String) As String
	Dim i As Int
	i = TxtRow.IndexOf("=")
	If i <> -1 Then
		Dim j1 As Int = TxtRow.IndexOf("<ChangeLog>")	'looks for optional ChangeLog
		Dim j2 As Int = TxtRow.IndexOf("<FileSize>")	'looks for optional Size
		Dim j As Int = Min(j1, j2)
		If j = -1 Then j = Max(j1,j2)
		Dim s As String
		If j <> - 1 Then s=TxtRow.SubString2(i+1,j) Else s=TxtRow.SubString(i+1)
		s=s.Replace(CRLF,"")
		s=s.Replace(Chr(13),"")
		Return s
	Else
		Return ""
	End If
End Sub

'Extract change log data from the sNewverTxt info text file
'Log data must be placed between <ChangeLog> and </ChangeLog> markers
'NEW: takes into account optional FileSize section
Private Sub ExtractCL(TxtRow As String) As String
	Dim i As Int
	i = TxtRow.IndexOf("<ChangeLog>")
	If i <> -1 Then
		Dim j1 As Int = TxtRow.IndexOf("</ChangeLog>")		'looks for ChangeLog closing marker
		If j1 = -1 Then
			Dim j2 As Int = TxtRow.IndexOf("<FileSize>")	'looks for optional FileSize
			j1 = j2
			If j1 < i Then j1 = -1
		End If
		If j1 <> -1 Then Return TxtRow.SubString2(i+11,j1) Else Return TxtRow.SubString(i+11)
	Else
		Return ""
	End If
End Sub

'Extract file size data from the sNewverTxt info text file
'File size data must be placed between <FileSize> and </FileSize> markers
Private Sub ExtractSZ(TxtRow As String) As String
	Dim i As Int
	i = TxtRow.IndexOf("<FileSize>")
	If i <> -1 Then
		Dim j1 As Int = TxtRow.IndexOf("</FileSize>")		'looks for FileSize closing marker
		If j1 = -1 Then
			Dim j2 As Int = TxtRow.IndexOf("<ChangeLog>")	'looks for optional ChangeLog
			j1 = j2
			If j1 < i Then j1 = -1
		End If
		Dim s As String
		If j1 <> -1 Then s = TxtRow.SubString2(i+10,j1) Else s = TxtRow.SubString(i+10)
		s = s.Replace(CRLF,"")
		s=s.Replace(Chr(13),"")
		Return s
	Else
		Return ""
	End If
End Sub

'Return unallocated bytes in Starter.SharedFolder
' Log($"$1.3{GetFreeSpace / 1024 / 1024 / 1024} GB"$)   
Private Sub GetFreeSpace As Long
	Dim jo As JavaObject
	jo.InitializeNewInstance("java.io.File", Array(SharedFolder))
	Return jo.RunMethod("getFreeSpace", Null)
End Sub

#Region version-safe-apk-installation
'https://www.b4x.com/android/forum/threads/version-safe-apk-installation.87667/

'Starting from Android 8 (API 26) each app needs to explicitly request a special permission to install other apps.
Public Sub CanRequestPackageInstalls As Boolean
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim PackageManager As JavaObject = ctxt.RunMethod("getPackageManager", Null)
	Return PackageManager.RunMethod("canRequestPackageInstalls", Null)
End Sub

'Check if installation of non-market apps is allowed
'Private Sub CheckNonMarketAppsEnabled As Boolean
'	If GetSDKVersion >= 26 Then Return True
'	If GetSDKVersion < 17 Or GetSDKVersion >= 21 Then
'		Return GetNMAppInst = "1"
'	Else
'		Dim context As JavaObject
'		context.InitializeContext
'		Dim resolver As JavaObject = context.RunMethod("getContentResolver", Null)
'		Dim global As JavaObject
'		global.InitializeStatic("android.provider.Settings.Global")
'		Return global.RunMethod("getString", Array(resolver, "install_non_market_apps")) = "1"
'	End If
'End Sub

'Check if installation of non-market apps is allowed
Public Sub CheckNonMarketAppsEnabled As Boolean
	If phone.SdkVersion >= 26 Then Return True
	If phone.SdkVersion < 17 Or phone.SdkVersion >= 21 Then
		Return phone.GetSettings("install_non_market_apps") = "1"
	Else
		Dim context As JavaObject
		context.InitializeContext
		Dim resolver As JavaObject = context.RunMethod("getContentResolver", Null)
		Dim global As JavaObject
		global.InitializeStatic("android.provider.Settings.Global")
		Return global.RunMethod("getString", Array(resolver, "install_non_market_apps")) = "1"
	End If
End Sub

'Start the installation intent
'A non-dangerous permission is required: AddPermission(android.permission.REQUEST_INSTALL_PACKAGES)
Private Sub SendInstallIntent
	Dim ApkName As String = "tmp.apk"
	Dim i As Intent
	If phone.SdkVersion >= 24 Then													'Nougat 7.0
		i.Initialize("android.intent.action.INSTALL_PACKAGE", GetFileUri(ApkName))
		i.Flags = Bit.Or(i.Flags, 1) 'FLAG_GRANT_READ_URI_PERMISSION
	Else
		i.Initialize(i.ACTION_VIEW, "file://" & File.Combine(SharedFolder, ApkName))
		i.SetType("application/vnd.android.package-archive")
	End If
	StartActivity(i)
End Sub
#End Region

#Region FileProvider
'Returns the file uri.
Private Sub GetFileUri (FileName As String) As Object
	If UseFileProvider = False Then
		Dim uri As JavaObject
		Return uri.InitializeStatic("android.net.Uri").RunMethod("parse", Array("file://" & File.Combine(SharedFolder, FileName)))
	Else
		Dim f As JavaObject
		f.InitializeNewInstance("java.io.File", Array(SharedFolder, FileName))
		Dim fp As JavaObject
		Dim context As JavaObject
		context.InitializeContext
		fp.InitializeStatic("android.support.v4.content.FileProvider")
		Return fp.RunMethod("getUriForFile", Array(context, Application.PackageName & ".provider", f))
	End If
End Sub

'Replaces the intent Data field with the file uri.
'Resets the type field. Make sure to call Intent.SetType after calling this method
Private Sub SetFileUriAsIntentData (Intent As Intent, FileName As String)
	Dim jo As JavaObject = Intent
	jo.RunMethod("setData", Array(GetFileUri(FileName)))
	Intent.Flags = Bit.Or(Intent.Flags, 1) 'FLAG_GRANT_READ_URI_PERMISSION
End Sub
#End Region

#Region Splashscreen
'Optional sub - superimposes a simple splash screen on the calling Activity. 
'To remove the splash screen, call StopSplashScreen from Activity (generally in the callback function. See "Initialize")
'CallingAct - Activity object whose layout will be superimposed with BM in a panel
'BM - Bitmap object to be shown while apk checking is in progress
Public Sub SetAndStartSplashScreen(CallingAct As Activity, BM As Bitmap)
	If BM.IsInitialized Then
		pnlSplash.Initialize("pnl1")
		pnlSplash.Tag = "splash"
		Dim BitImage As BitmapDrawable
		BitImage.Initialize(BM)
		BitImage.Gravity = Gravity.FILL
		CallingAct.AddView(pnlSplash, 0, 0, CallingAct.Width, CallingAct.Height)
		pnlSplash.Background = BitImage
		pnlSplash.BringToFront
		SplashShowing = True
	End If
End Sub

'Stops and removes the superimposed splash screen if it's showing
Public Sub StopSplashScreen
	If SplashShowing Then
		SplashShowing = False
		pnlSplash.RemoveView
	End If
End Sub
#End Region

'1) Holding the current version number in simple text file on your web server
'2) Download this file with HttpUtils.Download
'3) Read contents with HttpUtils.GetString
'4) Check against installed version
'5) If installed < current Then
'6) Download new 'apk' file with HttpUtils.Download
'7) Install
