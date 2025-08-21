B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.5
@EndOfDesignText@
'Code module
#IgnoreWarnings : 11

Sub Process_Globals
	
	Private buttonNext                                                          As Button
	Private labelTitle                                                          As Label
	Private Page7a                                                              As Page
	Private Page7b                                                              As Page
	Private Page7c                                                              As Page
	Private pageViewControllerInstance                                          As PageViewController
	Private viewScreen                                                          As View
	
End Sub

Public Sub ShowPage
	
	Dim nativeObjectPageViewController                                          As NativeObject
	Dim nativeObjectScreenView                                                  As NativeObject
	
	If Page7a.IsInitialized = False Then		
		Page7a.Initialize ("Page7a")
		Page7a.RootPanel.LoadLayout ("layout1")		
		Page7a.RootPanel.Color = Colors.Green
		Page7b.Initialize ("Page7b")
		Page7b.RootPanel.LoadLayout ("layout1")
		Page7b.RootPanel.Color = Colors.Magenta
		Page7c.Initialize ("Page7c")
		Page7c.RootPanel.LoadLayout ("layout1")
		Page7c.RootPanel.Color = Colors.Yellow		
	    pageViewControllerInstance.Initialize ("pageViewControllerInstance", Array (Page7a, Page7b, Page7c))		
	
		nativeObjectPageViewController = pageViewControllerInstance
		nativeObjectScreenView = nativeObjectPageViewController.GetField ("view")
		labelTitle.Initialize ("")
		labelTitle.Font = Font.CreateNewBold (20)
		nativeObjectScreenView.RunMethod ("addSubview:", Array (labelTitle))
		viewScreen = nativeObjectScreenView
	End If

	If Main.applicationInstance.KeyController <> pageViewControllerInstance Then Main.applicationInstance.KeyController = pageViewControllerInstance
	
	' Theoretically, it's possible to set orientation to separate pages, but this looks terrible. So, we set orientations for all pages.
	pageOrientations.setInterfaceOrientations (pageViewControllerInstance, "LandscapeLeft, LandscapeRight")
	
End Sub

Private Sub Page7a_Appear
	showTitle (1)
End Sub

Private Sub Page7b_Appear
	showTitle (2)
End Sub

Private Sub Page7c_Appear
	showTitle (3)
End Sub

Private Sub showTitle (intPage As Int)
	
	labelTitle.Text = "PVC   Page " & intPage & " / 3   Landscape"	
	labelTitle.SizeToFit
	labelTitle.SetLayoutAnimated (0, 1, (viewScreen.Width - labelTitle.Width) / 2, (viewScreen.Height - labelTitle.Height) / 2, labelTitle.Width, labelTitle.Height)

End Sub


Private Sub Page7a_Resize (Width As Int, Height As Int)

End Sub

Private Sub Page7b_Resize (Width As Int, Height As Int)
	
End Sub

Private Sub Page7c_Resize (Width As Int, Height As Int)

End Sub

Sub buttonNext_Click

	moduleOne.ShowPage

End Sub
