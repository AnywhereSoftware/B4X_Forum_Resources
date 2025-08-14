B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.1
@EndOfDesignText@
'DOHelp class: a simple help system based on local web pages
'Version 1.3

'- Show a help system using a webview dialog with HTML pages.
'- Zip them up (without their parent folder) and put the file in your Files folder in B4A.
'- In your app, create a DOHelp instance and call the Show method.
'- You can set the specific page to start on.
'- You can also set a light or dark theme if you wish (handled by your CSS).
'- The Show method shows a dialog with basic browser controls and your help page.
'- The user can click through your help as needed using standard HTML links.
'- Included in this demo are a few sample web pages (interlinked), basic CSS, and a JavaScript file that handles light/dark mode.

'Requires these libraries:
'- Archiver (to expand your zip file of HTML/CSS/JS files to a folder on the device)
'- WebViewExtras2 (to set needed properties of the webview)
'- XUI to get the proper URI for the web pages

'1.1 - added a home-page argument to Initialize
'1.2 - added code to handle mailto links
'1.3 - deleted unneeded file after unzipping

Sub Class_Globals
	Private const MARGIN As Int = 16dip

	Private mActivity As Activity
	Private mZipNameRoot, mHomeFilename As String
	Private helpWebView As WebView
	Private wve As WebViewExtras
	Private ws As WebSettings
	Private titlePanel, maskPanel, helpPanel As Panel
	Private xuiInstance As XUI
	Private homeButton, backButton, forwardButton As Button
	Private targetDir As String
End Sub

#Region Public Sub

'zipNameRoot = root of your zip file in your Files folder (e.g. "help" for help.zip).
'homeFilename = filename of your home page (e.g. "index.html")
Public Sub Initialize(activityArg As Activity, zipNameRoot As String, homeFileName As String)
	mActivity = activityArg
	mZipNameRoot = zipNameRoot
	mHomeFilename = homeFileName
	
	maskPanel.Initialize("maskPanel")
	maskPanel.Elevation = 24dip
	maskPanel.Visible = False
	mActivity.AddView(maskPanel, 0, 0, mActivity.Width, mActivity.Height)
	
	helpPanel.Initialize("")
	helpPanel.Elevation = 28dip
	maskPanel.AddView(helpPanel, MARGIN, MARGIN, mActivity.Width - MARGIN*2, mActivity.Height - MARGIN*2)
	helpPanel.LoadLayout("DOHelp")
	
	configureWebview
	
	targetDir = File.DirInternal & "/" & mZipNameRoot
	unzipWebPagesToDirInternal		
End Sub

'pageFilename = the HTML page to show (e.g. "index.html")
'islightTheme = light mode (e.g. white background, black text)
public Sub show(pageFilename As String, islightTheme As Boolean)
	updateColorsFromTheme(islightTheme)
	wve.ClearHistory
	wve.ClearCache(True)
	Dim urlAndParameter As String = xuiInstance.FileUri(targetDir, pageFilename) & "?light-theme=" & islightTheme
	helpWebView.LoadUrl(urlAndParameter)
	maskPanel.Visible = True
End Sub

public Sub isShowing As Boolean
	Return maskPanel.Visible
End Sub

public Sub close
	closeButton_Click
End Sub

#End Region


#Region Private Sub

private Sub configureWebview
	helpWebView.AllowFileAccess = True
	wve.Initialize(helpWebView)
	ws = wve.GetSettings
	ws.SetDOMStorageEnabled(True)
'	wve.SetVerticalScrollbarOverlay(True)
'	wve.SetScrollBarStyle(33554432)	'https://developer.android.com/reference/android/view/View#SCROLLBARS_INSIDE_OVERLAY
End Sub

'unzip from DirAssets (which is read-only) to DirInternal, to a folder named in the initialize call.
private Sub unzipWebPagesToDirInternal
	Dim zip As Archiver
	Dim zipFileName As String = mZipNameRoot & ".zip"
	deleteDirFileContents(File.DirInternal, mZipNameRoot)
	File.Copy(File.DirAssets, zipFileName, File.DirInternal, zipFileName)
	zip.UnZip(File.DirInternal, zipFileName, targetDir, "")
	File.Delete(File.DirInternal, zipFileName)
End Sub

'deletes all files in the given path.
'Note: does NOT handle sub-directories
private Sub deleteDirFileContents(pathArg As String, folderArg As String)
	If File.Exists(pathArg, folderArg) And File.IsDirectory(pathArg, folderArg) Then
		Dim fullPath As String = File.Combine(pathArg, folderArg)
		Dim tempList As List = File.ListFiles(fullPath)
'		Log("files to delete: " & tempList)
		For Each tempFile As String In tempList
			File.Delete(fullPath, tempFile)
		Next
	Else
		LogColor("deleteDirFileContents: folder not found", Colors.yellow)
	End If
End Sub

private Sub updateColorsFromTheme(islightTheme As Boolean)
	If islightTheme Then
		titlePanel.color = 0xFFAAAAAA
		helpPanel.Color = 0xFFAAAAAA
	Else
		titlePanel.color = 0xFF222222
		helpPanel.Color = 0xFF222222
	End If
End Sub

Private Sub homeButton_Click
	helpWebView.LoadUrl(xuiInstance.FileUri(targetDir, mHomeFilename))
End Sub

Private Sub backButton_Click
	helpWebView.back
End Sub

Private Sub forwardButton_Click
	helpWebView.Forward
End Sub

Private Sub closeButton_Click
	maskPanel.Visible = False
End Sub

Private Sub maskPanel_Click
	closeButton_Click
End Sub

Private Sub helpWebView_PageFinished(Url As String)
	backButton.Enabled = wve.CanGoback
	forwardButton.Enabled = wve.CanGoBackOrForward(1)
End Sub

'https://www.b4x.com/android/forum/threads/html-mailto-in-webview.92571/post-585617
Private Sub helpWebView_OverrideUrl(Url As String) As Boolean
	If Url.StartsWith("mailto:") Then
		Dim Intent1 As Intent
		Intent1.Initialize(Intent1.ACTION_VIEW, Url)
		StartActivity(Intent1)
		Return True
	End If
	Return False
End Sub

#End Region