B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Dim backPg, frontPg, darkOverlay As AnimationPlus
	Private darkOverlayPnl As B4XView
	Private CurrentActivity As Activity

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub


Sub SlidePageIn(r1 As B4XView, r2 As B4XView, destPg As Object, pgID As String)
	
	CallSubDelayed(destPg, "show")

	CurrentActivity = B4XPages.GetNativeParent(B4XPages.MainPage)
	
	
	'Create a transparent dark overlay over previous page
	darkOverlayPnl = xui.CreatePanel("")
	darkOverlayPnl.SetLayoutAnimated(0, 0, 0, 100%x, 100%y)
	
	'Raise overlay elevation above the previous page
	Dim p As Panel = darkOverlayPnl
	p.Elevation = 1dip
	
	
	CurrentActivity.AddView(darkOverlayPnl, 0, 0, 100%x, 100%y)
	CurrentActivity.AddView(r2, 100%x, 0, r2.Width, r2.Height)
	
	Dim p2 As Panel = r2
	p2.Elevation = 20dip
	
	darkOverlayPnl.SetColorAnimated(200, darkOverlayPnl.Color, 0x64000000)
	r1.SetLayoutAnimated(600, -50%x, 0, r1.Width, r1.Height)

	r2.SetLayoutAnimated(100, 50%x, 0, r2.Width, r2.Height)
	Sleep(100)
	
	r2.SetLayoutAnimated(200, 0, 0, r2.Width, r2.Height)
	Sleep(200)
	
	
	
	darkOverlayPnl.RemoveViewFromParent
	B4XPages.ShowPage(pgID)

End Sub

Sub SlidePageIn2(r1 As B4XView, r2 As B4XView, destPg As Object, pgID As String)
	
	'Use the "show" sub to get parameters ready in the b4xpage befoe showing
	CallSubDelayed(destPg, "show")

	'Get current activity of the B4xPage
	CurrentActivity = B4XPages.GetNativeParent(B4XPages.MainPage)
	
	'Create a transparent dark overlay over previous page
	darkOverlayPnl = xui.CreatePanel("")
	darkOverlayPnl.Color = 0x90000000
	
	'Raise overlay elevation above the previous page
	Dim p As Panel = darkOverlayPnl
	p.Elevation = 1dip	
	
	'Add views to the activity
	CurrentActivity.AddView(darkOverlayPnl, 0, 0, 100%x, 100%y)
	CurrentActivity.AddView(r2, 100%x, 0, r2.Width, r2.Height)
	
	Dim p2 As Panel = r2
	p2.Elevation = 20dip
	
	darkOverlay.InitializeAlpha("darkOverlay", 0, 1)
	backPg.InitializeTranslate("backAnim", 0, 0, -20%x, 0)
	frontPg.InitializeTranslate("frontAnim", 100%x, 0, 0, 0)
	
	darkOverlay.Duration = 500
	backPg.Duration = 500
	frontPg.Duration = 600
	
	backPg.SetInterpolator(backPg.INTERPOLATOR_DECELERATE)
	frontPg.SetInterpolatorWithParam(frontPg.INTERPOLATOR_DECELERATE, 2)
	
	backPg.Start(r1)
	darkOverlay.Start(darkOverlayPnl)
	frontPg.Start(r2)

	B4XPages.ShowPage(pgID)
End Sub

Sub frontAnim_AnimationEnd
	'darkOverlayPnl.RemoveViewFromParent
End Sub

Sub darkOverlay_AnimationEnd
	darkOverlayPnl.RemoveViewFromParent
End Sub