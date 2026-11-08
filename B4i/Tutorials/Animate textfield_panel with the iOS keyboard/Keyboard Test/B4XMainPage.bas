B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private xpnl_AddNewGroup As B4XView
	Private m_KeyboardHeight As Float = 0
	#If B4I
	Private xpnl_SafeArea As B4XView
	#End If
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	#if B4i
	Dim no As NativeObject = B4XPages.GetNativeParent(Me) 'or Page1 in non-B4XPages project.
	no.RunMethod("addWillHide", Null)
	xpnl_SafeArea = xui.CreatePanel("")
	xpnl_SafeArea.Color = xui.Color_White
	Root.AddView(xpnl_SafeArea,0,0,0,0)
#End If
	
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	xpnl_SafeArea.SetLayoutAnimated(0,0,Height - B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom,Width,B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom)
	xpnl_AddNewGroup.SetLayoutAnimated(0,0,Height - m_KeyboardHeight - xpnl_AddNewGroup.Height - IIf(m_KeyboardHeight=0,B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom,0),Width,xpnl_AddNewGroup.Height)
End Sub

Private Sub B4XPage_KeyboardStateChanged (Height As Float)
	m_KeyboardHeight = Height
	Dim ow As NativeObject
	Dim duration As Int = ow.Initialize("B4IObjectWrapper").RunMethod("getMap:", Array(B4XPages.GetNativeParent(Me))) _
        .RunMethod("objectForKey:", Array("animation_duration")).AsNumber * 1000
	Log("duration in ms: " &  duration)
	Log("keyboard state changed: " & Height)
		
	Dim curveIndex As Int = ow.Initialize("B4IObjectWrapper").RunMethod("getMap:", Array(B4XPages.GetNativeParent(Me))) _
    .RunMethod("objectForKey:", Array("animation_curve")).AsNumber
	Log("curve: " & curveIndex)
		
	Dim Page As NativeObject = B4XPages.GetNativeParent(Me)
	If Height > 0 Then 'Keyboard is open
		xpnl_AddNewGroup.Top = Root.Height - xpnl_AddNewGroup.Height
		Page.RunMethod("animateView:toYPosition:duration:curve:", Array(xpnl_AddNewGroup, Root.Top + Root.Height - Height - xpnl_AddNewGroup.Height, duration, curveIndex))
	Else 'Keyboard is closed
		Page.RunMethod("animateView:toYPosition:duration:curve:", Array(xpnl_AddNewGroup,Root.Height - xpnl_AddNewGroup.Height - B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom, duration, curveIndex))
	End If
		
End Sub
