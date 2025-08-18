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
	Private B4XSearchTemplate1 As gB4XSearchTemplate
	Private B4XDialog1 As B4XDialog
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XSearchTemplate1.Initialize
	Dim List1 As List
	List1.Initialize
	List1.AddAll(Array As String("Value1", "Value2", "Value3", "Value4", "Value5", "Value6", "Value7"))
	B4XSearchTemplate1.SetItems(List1)
	B4XDialog1.Initialize(Root)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	B4XDialog1.Title = "Tittle"
	B4XDialog1.TitleBarHeight = 80
	
	B4XSearchTemplate1.Resize(90%x, 80%y)
	Wait For (B4XDialog1.ShowTemplate(B4XSearchTemplate1, "", "", "Close")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		Log(B4XSearchTemplate1.SelectedItem)
	End If	
	
End Sub

Private Sub B4XPage_CloseRequest As ResumableSub
	If B4XDialog1.Visible = True Then 
		B4XDialog1.Close(xui.DialogResponse_Positive)
	End If
	Return True
End Sub