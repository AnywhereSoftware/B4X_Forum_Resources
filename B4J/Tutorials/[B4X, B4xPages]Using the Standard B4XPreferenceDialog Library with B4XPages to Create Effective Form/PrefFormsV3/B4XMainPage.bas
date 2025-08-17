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
	Private Root As B4XView	'ignore
	Private xui As XUI
	Private Example As ExampleForm
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	'In Class_Globals: Private Example As ExampleForm
	Root = Root1
	Example.Initialize(Me)
	B4XPages.AddPageAndCreate("example", Example)
	Sleep(0)
	B4XPages.ShowPage("example")
End Sub

#Region Form Results
Public Sub Example_Closed(NumRetries As Int, items As List)
	Log(NumRetries & TAB & items.Size & TAB & Example.MaxRetries)
	If NumRetries = Example.MaxRetries Then
		Log("Error: the user has exceeded the maximum tries and the form was closed")
		Return
	End If
	For i = 0 To items.Size - 1
		Dim pi As B4XPrefItem = items.Get(i)
		Dim itemName As String = pi.Key
		If pi.ItemType = Example.prefdialog.TYPE_SEPARATOR Then Continue
		Dim answer As Object = Example.data.Get(itemName)
		Select pi.ItemType
			Case Example.prefdialog.TYPE_DATE
				Log(itemName & TAB & DateTime.Date(answer))
			Case Else
				Log(itemName & TAB & answer)
		End Select
	Next
End Sub
#End Region
