B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.5
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private wvDnlHtml As WebView
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("download_html")
	download_html_file
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub download_html_file
	Private cURL, cFile, cText, cTxt As String

'	wvDnlHtml.LoadHtml("<html><body bgcolor=#FAFAD2><br><br><center><h2>Downloading HTML ..</h2></center></body></html>")
'	cURL = "https://www.dropbox.com/s/31w3ksayw80n6b8/b4xgoodies.html?dl=1"
'	cFile = "b4xgoodies.html"
'	Log("dn start " & cFile)
'	ProgressDialogShow("Downloading..")
'	File.Delete(Starter.SourceFolder, cFile)
'	Wait For ( Starter.Helper.DownloadAndSave(cURL, Starter.SourceFolder, cFile) ) Complete (Success As Boolean)
'	ProgressDialogHide()
'	Log("dn end " & cFile)
'	If Success Then
'		If File.Exists(Starter.SourceFolder, cFile) Then
'			UpdateVersionFile
'
'			cText = File.ReadString(Starter.SourceFolder, cFile)
'			cText = cText.Replace("<table border=1>", "<table border=1 bgcolor=F0FFFF>")
'			cTxt = File.ReadString(Starter.SourceFolder, "version.txt")
'			cText = "<b>Last Updated: " & cTxt & "</b><br>" & cText
'			wvDnlHtml.LoadHtml(cText)
'		Else
'			MsgboxAsync("No internet connection" & CRLF & "or error downloading " & cFile, "Download HTML")
'		End If
'	Else
'		MsgboxAsync("No Internet Connection" & CRLF & "or error downloading " & cFile, "Download HTML")
'	End If

	cURL = Main.cUrl
	cFile = "b4xgoodies.html"
	progress_download.OutFolder = Starter.SourceFolder
	progress_download.OutFile = cFile
	LogColor(cURL, Colors.Red)
	StartActivity(progress_download)
	LogColor("11", Colors.Red)
	Sleep(100)
	LogColor("22", Colors.Red)
	Do While progress_download.inProgress == True
		Sleep(10)
	Loop
	LogColor("33", Colors.Red)
	LogColor(progress_download.success, Colors.Red)
	If progress_download.success Then
		If File.Exists(Starter.SourceFolder, cFile) Then
			LogColor("44", Colors.Red)
			UpdateVersionFile

			' ref. https://www.b4x.com/android/forum/threads/hide-webview-zoom-controls-but-still-have-zoom.99655/#post-627423
			Dim r As Reflector
			r.Target = wvDnlHtml
			r.Target = r.RunMethod("getSettings")
			r.RunMethod2("setBuiltInZoomControls", True, "java.lang.boolean")
			r.RunMethod2("setDisplayZoomControls", False, "java.lang.boolean")
			
			cText = File.ReadString(Starter.SourceFolder, cFile)
			cText = cText.Replace("<table border=1>", "<table border=1 bgcolor=F0FFFF>")
			cTxt = File.ReadString(Starter.SourceFolder, "version.txt")
			cText = "<b>Last Updated: " & cTxt & "</b><br>" & cText
			wvDnlHtml.LoadHtml(cText)
		Else
			MsgboxAsync("No internet connection" & CRLF & "or error downloading " & cFile, "Check Version")
			Activity.Finish
		End If
	Else
		MsgboxAsync("No Internet Connection" & CRLF & "or error downloading " & cFile, "Check Version")
		Activity.Finish
	End If
	
End Sub

Sub UpdateVersionFile
	Private cFile As String
	cFile = "version.txt"

	If File.Exists(Starter.SourceFolder, cFile) Then
		File.Copy(Starter.SourceFolder, cFile, Starter.SourceFolder, "last_version.txt")
	End If
	
End Sub
