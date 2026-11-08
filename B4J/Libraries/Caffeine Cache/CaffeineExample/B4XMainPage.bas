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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=CaffeineExample.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Public Cache As Caffeine
	Private TextField1 As B4XView
	Private Label1 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Dim settings As CaffeineSettings
	settings.Initialize
	settings.MaximumSize = 10000
	settings.ExpireAfterWriteMs = DateTime.TicksPerMinute * 2 'value is valid for two minutes after it was written
	settings.RecordStats = True
	Cache.Initialize(Me, "Caffeine", settings)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

Private Sub Caffeine_Load (Key As Object) As Object
	'get the data. Maybe from a database. 
	Log("Loading value for key: " & Key)
	Dim n As Int = Key
	Return n * 2
End Sub


Private Sub Button1_Click
	If IsNumber(TextField1.Text) Then
		Dim n As Int = TextField1.Text
		Label1.Text = "Result = " & Cache.Get(n)
		Log(Cache.Stats) 'don't do in real app
		Log("cache size: " & Cache.EstimatedSize)
	End If
End Sub