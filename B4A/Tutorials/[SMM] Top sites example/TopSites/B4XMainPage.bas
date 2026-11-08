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
	Private CustomListView1 As CustomListView
	Private Sites As List
	Private smm As SimpleMediaManager
	Private pnlWebView As B4XView
End Sub


Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Dim su As StringUtils
	Sites.Initialize
	For Each row() As String In su.LoadCSV(File.DirAssets, "topsites.txt", ",")
		Sites.Add(row(1))
	Next
	smm.Initialize
	smm.AddLocalMedia(smm.KEY_DEFAULT_LOADING, File.ReadBytes(File.DirAssets, "loading.gif"), "image/gif")
	For Each s As String In Sites
		Dim base As B4XView = xui.CreatePanel("")
		base.SetLayoutAnimated(0, 0, 0, Root.Width, 300dip)
		base.Color = xui.Color_White
		CustomListView1.Add(base, s)
	Next
End Sub

Private Sub CustomListView1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	For i = 0 To CustomListView1.Size - 1
		Dim IsVisible As Boolean = i >= FirstIndex - 2 And i <= LastIndex + 2
		Dim base As B4XView = CustomListView1.GetPanel(i)
		If IsVisible Then
			If base.NumberOfViews = 0 Then
				base.LoadLayout("Item")
				Dim site As String = CustomListView1.GetValue(i)
				smm.SetMedia(base.GetView(0), $"https://www.${site}/favicon.ico"$)
				smm.SetMedia(base.GetView(2), $"https://${site}"$)
				base.GetView(1).Text = site
			End If
		Else
			If base.NumberOfViews > 0 Then
				smm.ClearMedia(base.GetView(2)) 'immediately stop WebView.
			End If
			base.RemoveAllViews
		End If
	Next
End Sub