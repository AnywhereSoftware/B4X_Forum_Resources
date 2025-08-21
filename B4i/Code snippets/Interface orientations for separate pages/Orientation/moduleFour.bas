B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.5
@EndOfDesignText@
'Code module

Sub Process_Globals
	
	Private buttonNext                                                          As Button
	Private Page4                                                               As Page
		
End Sub

Public Sub ShowPage
	
	If Page4.IsInitialized = False Then
		Page4.Initialize ("Page4")
		Page4.RootPanel.LoadLayout ("layout1")
		Page4.Title = "SMC Portrait"			
	End If
	
	If Main.applicationInstance.KeyController <> Main.sideMenuControllerInstance Then Main.applicationInstance.KeyController = Main.sideMenuControllerInstance	
	Main.navigationControllerSMC.ShowPage (Page4)	
	pageOrientations.setInterfaceOrientations (Page4, "Portrait, PortraitPortraitUpsideDown")
	
End Sub

Private Sub Page4_Resize (Width As Int, Height As Int)

End Sub

Sub buttonNext_Click

	moduleFive.ShowPage

End Sub
