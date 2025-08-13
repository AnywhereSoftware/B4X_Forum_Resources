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
	
	Private ASRatingBar1 As ASRatingBar
	Private ASRatingBar2 As ASRatingBar
	Private ASRatingBar3 As ASRatingBar
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	B4XPages.SetTitle(Me,"AS RatingBar B4X Example")
	
	ASRatingBar1.SetImages(ASRatingBar1.FontToBitmap(Chr(0xF005),False,30,xui.Color_Yellow),ASRatingBar1.FontToBitmap(Chr(0xF005),False,30,xui.Color_Gray))
	ASRatingBar2.SetImages(ASRatingBar2.FontToBitmap(Chr(0xF17B),False,30,xui.Color_Green),ASRatingBar2.FontToBitmap(Chr(0xF17B),False,30,xui.Color_Gray))
	ASRatingBar3.SetImages(ASRatingBar3.FontToBitmap(Chr(0xF1EB),False,30,xui.Color_Green),ASRatingBar3.FontToBitmap(Chr(0xF1EB),False,30,xui.Color_Gray))
	
End Sub

Sub ASRatingBar1_RatingChange(rating As Int)
	Log("ASRatingBar1_RatingChange: " & rating)
End Sub

Sub ASRatingBar2_RatingChange(rating As Int)
	Log("ASRatingBar2_RatingChange: " & rating)
End Sub

Sub ASRatingBar3_RatingChanged(rating As Int)
	Log("ASRatingBar3_RatingChanged: " & rating)
End Sub