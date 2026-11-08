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
	Private xlbl_like As B4XView
	Private xlbl_like_colored As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,"AS Like Animation Example")
End Sub

#If B4J
Sub xlbl_like_MouseClicked (EventData As MouseEvent)
	LikeAnimation(xlbl_like,250)
End Sub
Sub xlbl_like_colored_MouseClicked (EventData As MouseEvent)
	LikeAnimationColored(xlbl_like_colored,250,xui.Color_ARGB(255,221, 95, 96),xui.Color_White)
End Sub
#Else
Sub xlbl_like_Click
	LikeAnimation(xlbl_like,250)
End Sub
Sub xlbl_like_colored_Click
	LikeAnimationColored(xlbl_like_colored,250,xui.Color_ARGB(255,221, 95, 96),xui.Color_White)
End Sub
#End If

Private Sub LikeAnimation(xlbl As B4XView,duration As Int)
	Dim txt_size As Float = xlbl.TextSize
	If xlbl.Text = Chr(0xE87E) Then
		xlbl.SetTextSizeAnimated(duration/2,1)
		Sleep(duration/2)
		xlbl.Text = Chr(0xE87D)
		xlbl.SetTextSizeAnimated(duration/2,txt_size)
	Else
		xlbl.SetTextSizeAnimated(duration/2,1)
		Sleep(duration/2)
		xlbl.Text = Chr(0xE87E)
		xlbl.SetTextSizeAnimated(duration/2,txt_size)
	End If
End Sub

Private Sub LikeAnimationColored(xlbl As B4XView,duration As Int,liked_color As Int,unliked_color As Int)
	Dim txt_size As Float = xlbl.TextSize
	If xlbl.Text = Chr(0xE87E) Then
		xlbl.SetTextSizeAnimated(duration/2,1)
		Sleep(duration/2)
		xlbl.Text = Chr(0xE87D)
		xlbl.TextColor = liked_color
		xlbl.SetTextSizeAnimated(duration/2,txt_size)
	Else
		xlbl.SetTextSizeAnimated(duration/2,1)
		Sleep(duration/2)
		xlbl.Text = Chr(0xE87E)
		xlbl.TextColor = unliked_color
		xlbl.SetTextSizeAnimated(duration/2,txt_size)
	End If
End Sub
