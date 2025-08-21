B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.5
@EndOfDesignText@
'Code module

Sub Process_Globals
	
	Private buttonNext                                                          As Button
	Private Page5                                                               As Page
		
End Sub

Public Sub ShowPage
	
	If Page5.IsInitialized = False Then
		Page5.Initialize ("Page5")
		Page5.RootPanel.LoadLayout ("layout1")
		Page5.Title = "SMC Landscape"	
	End If
	
	If Main.applicationInstance.KeyController <> Main.sideMenuControllerInstance Then Main.applicationInstance.KeyController = Main.sideMenuControllerInstance
	Main.navigationControllerSMC.ShowPage (Page5)
	pageOrientations.setInterfaceOrientations (Page5, "LandscapeLeft, LandscapeRight")

End Sub

Private Sub Page5_Resize (Width As Int, Height As Int)

End Sub

Sub buttonNext_Click

	moduleSix.ShowPage

End Sub
