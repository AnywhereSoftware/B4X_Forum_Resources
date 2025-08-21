B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.5
@EndOfDesignText@
'Code module

Sub Process_Globals

	Private buttonNext                                                          As Button
	Private Page2                                                               As Page

End Sub

Public Sub ShowPage
	
	If Page2.IsInitialized = False Then
		Page2.Initialize ("Page2")
		Page2.RootPanel.LoadLayout ("layout1")
		Page2.Title = "NC Landscape"		
	End If
	
	If Main.applicationInstance.KeyController <> Main.navigationControllerMain Then Main.applicationInstance.KeyController = Main.navigationControllerMain	
	Main.navigationControllerMain.ShowPage (Page2)	
	pageOrientations.setInterfaceOrientations (Page2, "LandscapeLeft, LandscapeRight")
	
End Sub

Private Sub Page2_Resize (Width As Int, Height As Int)
			
End Sub

Sub buttonNext_Click

	moduleThree.ShowPage

End Sub
