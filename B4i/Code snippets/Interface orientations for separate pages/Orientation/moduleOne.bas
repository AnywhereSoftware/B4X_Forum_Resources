B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.5
@EndOfDesignText@
'Code module

Sub Process_Globals

	Private buttonNext                                                          As Button
	Private Page1                                                               As Page

End Sub

Public Sub ShowPage
	
	If Page1.IsInitialized = False Then
		Page1.Initialize ("Page1")		
		Page1.RootPanel.LoadLayout ("layout1")
		Page1.Title = "NC Portrait"
	End If
	
	' Typically not needed, but a sample uses some keyControllers and we want to be sure
	If Main.applicationInstance.KeyController <> Main.navigationControllerMain Then Main.applicationInstance.KeyController = Main.navigationControllerMain
	
	Main.navigationControllerMain.ShowPage (Page1)
		
	'******************************************************************************************************
	'   Set interface orientations directly after ShowPage.                                         
	'   Valid names (case sensitive):  Portrait, LandscapeLeft, LandscapeRight, PortraitUpsideDown.
	'   If an orientation is not allowed in	#iPhoneOrientations / #iPadOrientations, it will be ignored.
	'   For a example, if a program uses standard settings, PortraitUpsideDown will work on iPad only.
	'******************************************************************************************************
	
	pageOrientations.setInterfaceOrientations (Page1, "Portrait, PortraitUpsideDown")
	
	' To disable animation during rotation, set pageOrientations.isRotateAnimationEnabled to False
	
End Sub

Private Sub Page1_Resize (Width As Int, Height As Int)

	' You can use pageOrientations.getCurrentInterfaceOrientation to ignore 'invalid' orientations.

End Sub

Sub buttonNext_Click

	moduleTwo.ShowPage

End Sub
