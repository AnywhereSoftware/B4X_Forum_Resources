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
	Public page_2 As page2
	Public Root As B4XView
	Private xui As XUI
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.GetManager.TransitionAnimationDuration = 0
	B4XPages.AddPageAndCreate("page2",page_2.Initialize)
End Sub
 
Private Sub btn_Click
	Dim btn As Button = Sender
	Select btn.Tag.As(Int)
		Case 0 'RadiusIn
			page_2.loadpageinadvance
			B4x_Transition.PrepareTransition_RadiusIn(xui, Root.Width, Root.Height, Root, page_2.Root)
			B4XPages.ShowPageAndRemovePreviousPages("page2")
		Case 1 'RadiusOut
			page_2.loadpageinadvance
			B4x_Transition.PrepareTransition_RadiusOut(xui, Root.Width, Root.Height, Root, page_2.Root)
			B4XPages.ShowPageAndRemovePreviousPages("page2")
		Case 2 'OpenDoor
			page_2.loadpageinadvance
			B4x_Transition.PrepareTransition_OpenDoor(xui, Root.Width, Root.Height, Root, page_2.Root)
			B4XPages.ShowPageAndRemovePreviousPages("page2")
		Case 3 'CloseDoor
			page_2.loadpageinadvance
			B4x_Transition.PrepareTransition_CloseDoor(xui, Root.Width, Root.Height, Root, page_2.Root)
			B4XPages.ShowPageAndRemovePreviousPages("page2")
		Case 4 'FadeOut
			page_2.loadpageinadvance
			B4x_Transition.PrepareTransition_FadeOut(xui, Root.Width, Root.Height, Root, page_2.Root)
			B4XPages.ShowPageAndRemovePreviousPages("page2")
		Case 5 'SpiralOut
			page_2.loadpageinadvance
			B4x_Transition.PrepareTransition_SpiralOut(xui, Root.Width, Root.Height, Root, page_2.Root)
			B4XPages.ShowPageAndRemovePreviousPages("page2")
		Case 6 'BurnOut
			page_2.loadpageinadvance
			B4x_Transition.PrepareTransition_BurnOut(xui, Root.Width, Root.Height, Root, page_2.Root)
			B4XPages.ShowPageAndRemovePreviousPages("page2")
		Case 7 'Up
			page_2.loadpageinadvance
			B4x_Transition.PrepareTransition_SlideOut(xui, Root.Width, Root.Height, Root, page_2.Root,"TOP")
			B4XPages.ShowPageAndRemovePreviousPages("page2")
		Case 8 'Right
			page_2.loadpageinadvance
			B4x_Transition.PrepareTransition_SlideOut(xui, Root.Width, Root.Height, Root, page_2.Root,"RIGHT")
			B4XPages.ShowPageAndRemovePreviousPages("page2")
		Case 9 'Down
			page_2.loadpageinadvance
			B4x_Transition.PrepareTransition_SlideOut(xui, Root.Width, Root.Height, Root, page_2.Root,"BOTTOM")
			B4XPages.ShowPageAndRemovePreviousPages("page2")
		Case 10 'Left
			page_2.loadpageinadvance
			B4x_Transition.PrepareTransition_SlideOut(xui, Root.Width, Root.Height, Root, page_2.Root,"LEFT")
			B4XPages.ShowPageAndRemovePreviousPages("page2")
	End Select
End Sub