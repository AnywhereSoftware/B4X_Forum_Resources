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
	Private AHViewPager1 As AHViewPager
	Private WobbleMenu1 As WobbleMenu
	
	Private pagecont As AHPageContainer
End Sub

Public Sub Initialize
	pagecont.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	WobbleMenu1.SetTabTextIcon(1,"Page 1", Chr(0xE3D0), Typeface.MATERIALICONS)
	WobbleMenu1.SetTabTextIcon(2,"Page 2", Chr(0xE3D1), Typeface.MATERIALICONS)
	WobbleMenu1.SetTabTextIcon(3,"Page 3", Chr(0xE3D2), Typeface.MATERIALICONS)
	WobbleMenu1.SetTabTextIcon(4,"Page 4", Chr(0xE3D4), Typeface.MATERIALICONS)
	WobbleMenu1.SetTabTextIcon(5,"Page 5", Chr(0xE3D5), Typeface.MATERIALICONS)
	
	For i=0 To 4
		Dim p As Panel = xui.CreatePanel("")
		p.SetLayout(0,0,AHViewPager1.Width,AHViewPager1.Height)
		
		'load any layout 
		'p.LoadLayout("")
		
		'or add views from code
		p.Color = Colors.LightGray
		Dim l As Label
		l.Initialize("")
		l.Text = "Page "&(i+1)
		l.Gravity = Gravity.CENTER
		l.TextColor = Colors.Black
		l.TextSize = 40
		p.AddView(l,0,0,AHViewPager1.Width,AHViewPager1.Height)
		
		pagecont.AddPage(p,"")
	Next
	
	AHViewPager1.PageContainer = pagecont
	AHViewPager1.CurrentPage = 2
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub WobbleMenu1_Tab1Click
	AHViewPager1.GotoPage(0,True)
End Sub

Sub WobbleMenu1_Tab2Click
	AHViewPager1.GotoPage(1,True)
End Sub

Sub WobbleMenu1_Tab3Click
	AHViewPager1.GotoPage(2,True)
End Sub

Sub WobbleMenu1_Tab4Click
	AHViewPager1.GotoPage(3,True)
End Sub

Sub WobbleMenu1_Tab5Click
	AHViewPager1.GotoPage(4,True)
End Sub
