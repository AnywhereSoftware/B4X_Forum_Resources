B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.5
@EndOfDesignText@
'Code module

Sub Process_Globals

	Private buttonNext                                                          As Button
	Private Page3                                                               As Page

End Sub

Public Sub ShowPage
	
	If Page3.IsInitialized = False Then
		Page3.Initialize ("Page3")
		Page3.RootPanel.LoadLayout ("layout1")
		Page3.Title = "NC Any orientation"	
	End If
	
	If Main.applicationInstance.KeyController <> Main.navigationControllerMain Then Main.applicationInstance.KeyController = Main.navigationControllerMain	
	Main.navigationControllerMain.ShowPage (Page3)
	pageOrientations.setInterfaceOrientations (Page3, "")
		
End Sub

Private Sub Page3_Resize (Width As Int, Height As Int)

End Sub

Sub buttonNext_Click

	moduleFour.ShowPage

End Sub
