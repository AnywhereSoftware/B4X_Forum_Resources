B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.86
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Public cvs As B4XCanvas
	Public Panel1 As B4XView
	Public SoftOrientationPage3 As SoftOrientationB4XPage
End Sub

'You can add more parameters here.
Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("Page3")
	cvs.Initialize(Panel1)
	B4XPages.SetTitle(Me, "Draw Something")
	#if B4A
	B4XPages.AddMenuItem(Me, "Random Background")
	#End If
	
	SoftOrientationPage3.Initialize(Me,"SoftOrientationPage3",B4XPages.GetPageId(Me),"Page3",B4XPages.MainPage.SoftOrientationMain.SCREEN_ORIENTATION_SENSOR,Root)
	B4XPages.MainPage.SoftOrientationMain.AddB4XPage2(SoftOrientationPage3)
End Sub


Sub B4XPage_Appear
	B4XPages.MainPage.SoftOrientationMain.ApplyB4XPageDefaultOrientation(B4XPages.GetPageId(Me))
	'Or
	'B4XPages.MainPage.SoftOrientationMain.ApplyB4XPageDefaultOrientation2(SoftOrientationPage3)
End Sub

'This event will be activated when the orientation change procedure is completed.
Sub SoftOrientationPage3_ActivityConfigurationChanged (NewConfiguration As AndroidContentResConfiguration)
	cvs.Resize(Root.Width,Root.Height)
	If NewConfiguration.Orientation=NewConfiguration.Constants.ORIENTATION_PORTRAIT Then
		Log("SoftOrientationPage3 orientation PORTRAIT")
	Else If NewConfiguration.Orientation=NewConfiguration.Constants.ORIENTATION_LANDSCAPE Then
		Log("SoftOrientationPage3 orientation LANDSCAPE")
	End If
End Sub

Sub Panel1_Touch (Action As Int, X As Float, Y As Float)
	If Action <> Panel1.TOUCH_ACTION_MOVE_NOTOUCH Then
		cvs.DrawCircle(X, Y, 10dip, Rnd(xui.Color_Black, xui.Color_White), True, 0)
		cvs.Invalidate
	End If
End Sub

Private Sub btnClear_Click
	ClearImage
End Sub

Public Sub ClearImage
	If Panel1.IsInitialized Then
		cvs.ClearRect(cvs.TargetRect)
		cvs.Invalidate
	End If
End Sub

Sub btnSet_Click
	B4XPages.ClosePage(Me)
End Sub

Sub B4XPage_Resize (Width As Int, Height As Int)
	ClearImage
	cvs.Resize(Width, Height)
End Sub

Sub B4XPage_MenuClick (Tag As String)
	If Tag = "Random Background" Then
		cvs.DrawRect(cvs.TargetRect, Rnd(xui.Color_Black, xui.Color_White), True, 0)
		cvs.Invalidate
	End If
End Sub

#if B4J
'Delegate the native menu action to B4XPage_MenuClick.
Sub MenuBar1_Action
	Dim mi As MenuItem = Sender
	Dim t As String
	If mi.Tag = Null Then t = mi.Text.Replace("_", "") Else t = mi.Tag
	B4XPage_MenuClick(t)
End Sub
#End If