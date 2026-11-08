B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.86
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private lblHello As B4XView
	Private ImageView1 As B4XView
	Private Page3 As B4XPage3
	Public SoftOrientationPage2 As SoftOrientationB4XPage
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("Page2")
	Page3 = B4XPages.GetPage("Page 3")
	
	SoftOrientationPage2.Initialize(Me,"SoftOrientationPage2","page 2","Page2",B4XPages.MainPage.SoftOrientationMain.SCREEN_ORIENTATION_PORTRAIT,Root)
	B4XPages.MainPage.SoftOrientationMain.AddB4XPage2(SoftOrientationPage2)
End Sub

Private Sub B4XPage_Appear
	lblHello.Text = $"Hello ${B4XPages.MainPage.txtUser.Text}!"$
	UpdateImage
	
	B4XPages.MainPage.SoftOrientationMain.ApplyB4XPageDefaultOrientation(B4XPages.GetPageId(Me))
	'Or
	'B4XPages.MainPage.SoftOrientationMain.ApplyB4XPageDefaultOrientation2(SoftOrientationPage2)
End Sub

'This event will be activated when the orientation change procedure is completed.
Sub SoftOrientationPage2_ActivityConfigurationChanged (NewConfiguration As AndroidContentResConfiguration)
	If NewConfiguration.Orientation=NewConfiguration.Constants.ORIENTATION_PORTRAIT Then
		Log("SoftOrientationPage2 orientation PORTRAIT")
	Else If NewConfiguration.Orientation=NewConfiguration.Constants.ORIENTATION_LANDSCAPE Then
		Log("SoftOrientationPage2 orientation LANDSCAPE")
	End If
End Sub

Sub btnDraw_Click
	B4XPages.ShowPage("Page 3")
End Sub

Sub UpdateImage
	If Page3.Panel1.IsInitialized Then
		ImageView1.SetBitmap(Page3.cvs.CreateBitmap)
	End If
End Sub

Sub btnSignOut_Click
	Page3.ClearImage
	UpdateImage
	B4XPages.ShowPageAndRemovePreviousPages("MainPage")	
End Sub
