B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.5
@EndOfDesignText@
'Code module

Sub Process_Globals
	
	Private buttonNext                                                          As Button
	Private Page6                                                               As Page
		
End Sub

Public Sub ShowPage
	
	If Page6.IsInitialized = False Then
		Page6.Initialize ("Page6")
		Page6.RootPanel.LoadLayout ("layout1")
		Page6.Title = "SMC Any orientation"
	End If
	
	If Main.applicationInstance.KeyController <> Main.sideMenuControllerInstance Then Main.applicationInstance.KeyController = Main.sideMenuControllerInstance
	Main.navigationControllerSMC.ShowPage (Page6)
	pageOrientations.setInterfaceOrientations (Page6, "")

End Sub

Private Sub Page6_Resize (Width As Int, Height As Int)

End Sub

Sub buttonNext_Click

	moduleSeven.ShowPage

End Sub
