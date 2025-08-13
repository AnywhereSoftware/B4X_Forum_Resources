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
	Private JNSlider1 As JNSlider
	Private JNSlider2 As JNSlider
	Private JNSlider3 As JNSlider
	Private JNSlider4 As JNSlider
	Private Button1 As B4XView
	Private Button2 As B4XView
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	'Set up gradient colors for each slider. 
	'JNSlider1 will use defaults
	
	Dim clrMap2 As Map
	clrMap2.Initialize
	clrMap2.Put(0, xui.Color_Blue)		'0 to 100 set to Blue i.e. no gradient
	clrMap2.Put(100, xui.Color_Blue)
	JNSlider2.SetColorMap (clrMap2)

	Dim clrMap3 As Map
	clrMap3.Initialize
	clrMap3.Put(0, xui.Color_Blue)		'Set lots of colours
	clrMap3.Put(20, xui.Color_Red)
	clrMap3.Put(40, xui.Color_Yellow)
	clrMap3.Put(60, xui.Color_Green)
	clrMap3.Put(80, xui.Color_Magenta)
	clrMap3.Put(100, xui.Color_Cyan)
	JNSlider3.SetColorMap (clrMap3)

	Dim clrMap4 As Map
	clrMap4.Initialize
	clrMap4.Put(0, xui.Color_Red)		'Different gradient widths
	clrMap4.Put(25, xui.Color_Green)
	clrMap4.Put(75, xui.Color_Green)
	clrMap4.Put(100, xui.Color_Blue)
	JNSlider4.SetColorMap (clrMap4)
	
End Sub

Private Sub Button1_Click
	ShowAllSliders (True)
End Sub

Private Sub Button2_Click
	ShowAllSliders (False)
End Sub

Private Sub ShowAllSliders (show As Boolean)
	
	If show Then
		JNSlider1.OpenSeekBar
		JNSlider2.OpenSeekBar
		JNSlider3.OpenSeekBar
		JNSlider4.OpenSeekBar
	Else
		JNSlider1.CloseSeekBar
		JNSlider2.CloseSeekBar
		JNSlider3.CloseSeekBar
		JNSlider4.CloseSeekBar
	End If
End Sub