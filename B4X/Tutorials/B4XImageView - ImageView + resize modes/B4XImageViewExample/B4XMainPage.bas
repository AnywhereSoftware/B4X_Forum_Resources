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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip&VMArgs=-DZeroSharedFiles%3DTrue

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private B4XImageView1 As B4XImageView
	Private B4XImageView2 As B4XImageView
	Private B4XSwitch1 As B4XSwitch
	Private B4XPlusMinus1 As B4XPlusMinus
End Sub

Public Sub Initialize
	
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPlusMinus1.SetStringItems(Array("FIT", "FILL", "FILL_NO_DISTORTIONS", "FILL_WIDTH", "FILL_HEIGHT", "NONE"))
	B4XPlusMinus1.SelectedValue = "FIT"
	B4XImageView1.Load(File.DirAssets, "1.png")
	B4XImageView2.Load(File.DirAssets, "2.jpg")
End Sub

Sub B4XPlusMinus1_ValueChanged (Value As Object)
	B4XImageView1.ResizeMode = Value
	B4XImageView2.ResizeMode = Value
End Sub

Sub B4XSwitch1_ValueChanged (Value As Boolean)
	B4XImageView1.RoundedImage = Value
	B4XImageView2.RoundedImage = Value
End Sub