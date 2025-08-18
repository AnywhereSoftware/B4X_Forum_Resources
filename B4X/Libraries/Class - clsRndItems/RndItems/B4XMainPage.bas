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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=RndItems.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Private mRndItems As clsRndItems
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	mRndItems.Initialize(Me, "RndItems", 10)
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	LogColor("Numbers...", xui.Color_Blue)
	For i = 0 To mRndItems.Items.Size - 1
		Log(mRndItems.PopRndItem)
	Next
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	LogColor("Letters...", xui.Color_Blue)
	mRndItems.Items = Array As String("a","b","c","d","e","f")
	For i = 0 To mRndItems.Items.Size - 1
		Log(mRndItems.PopRndItem)
	Next
End Sub

