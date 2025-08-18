B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private ASViewPagerNative1 As ASViewPagerNative
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	B4XPages.SetTitle(Me,"ASViewPagerNative Example")
	
	#If B4i
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	Dim lst As List
	lst.Initialize
	
	For i = 0 To 10 -1
		
		#If B4A
		Dim xpnl As B4XView = xui.CreatePanel("")
		xpnl.Color = Rnd(xui.Color_Black,xui.Color_White)
		xpnl.SetLayoutAnimated(0,0,0,Root.Width,Root.Height)
		'xpnl.LoadLayout("test")
		lst.Add(xpnl)
		#Else If B4I
		Dim page As Page
		page.Initialize("page")
		page.RootPanel.Color = Rnd(xui.Color_Black,xui.Color_White)
		page.RootPanel.As(B4XView).SetLayoutAnimated(0,0,0,Width,Height)
		'page.RootPanel.LoadLayout("test")
		lst.Add(page)
		#End If
		
	Next
	
	ASViewPagerNative1.AddPages(lst,"")
	
End Sub

Private Sub ASViewPagerNative1_PageChanged(Index As Int)
	Log("PageChanged: " & Index)
End Sub
