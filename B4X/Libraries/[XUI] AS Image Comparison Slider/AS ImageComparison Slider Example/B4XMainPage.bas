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
	
	Private ASImageComparisonSlider1 As ASImageComparisonSlider
	Private ASImageComparisonSlider2 As ASImageComparisonSlider
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS ImageComparisonSlider Example")
	
	ASImageComparisonSlider1.SetImages(xui.LoadBitmap(File.DirAssets,"img-modified.png"),xui.LoadBitmap(File.DirAssets,"img-original.jpg"))
	ASImageComparisonSlider2.SetImages(xui.LoadBitmap(File.DirAssets,"img_forest.jpg"),xui.LoadBitmap(File.DirAssets,"img_snow.jpg"))
	
End Sub


Private Sub ASImageComparisonSlider1_SliderPositionChanged(x As Int)
	Log("SliderPositionChanged: " & x)
End Sub

Private Sub ASImageComparisonSlider2_SliderPositionChanged(x As Int)
	Log("SliderPositionChanged: " & x)
End Sub