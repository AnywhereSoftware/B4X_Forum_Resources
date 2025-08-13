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
	
	Private BottomEmojiPicker As AS_BottomEmojiPicker
	Private xlbl_EmojiResult As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS BottomEmojiPicker Example")
	
End Sub

Private Sub OpenDark
	
	BottomEmojiPicker.Initialize(Me,"BottomEmojiPicker",Root)
	
	BottomEmojiPicker.BackgroundColor = xui.Color_ARGB(255,32, 33, 37)
	BottomEmojiPicker.CategoryTextColor = xui.Color_White
	BottomEmojiPicker.CategoryIndicatorColor = xui.Color_White
	
	BottomEmojiPicker.ShowPicker
	
End Sub

Private Sub OpenLight
	
	BottomEmojiPicker.Initialize(Me,"BottomEmojiPicker",Root)
	
	BottomEmojiPicker.BackgroundColor = xui.Color_White
	BottomEmojiPicker.CategoryTextColor = xui.Color_Black
	BottomEmojiPicker.CategoryIndicatorColor = xui.Color_Black
	
	BottomEmojiPicker.ShowPicker
	
End Sub

Private Sub OpenCustom
	
	BottomEmojiPicker.Initialize(Me,"BottomEmojiPicker",Root)
	
	BottomEmojiPicker.BackgroundColor = xui.Color_ARGB(255,32, 33, 37)
	BottomEmojiPicker.CategoryTextColor = xui.Color_White
	BottomEmojiPicker.CategoryIndicatorColor = xui.Color_White
	BottomEmojiPicker.EmojiSize = 50
	BottomEmojiPicker.BodyHeight = 300dip
	BottomEmojiPicker.Rows = 3
	
	BottomEmojiPicker.ShowPicker

End Sub

Private Sub BottomEmojiPicker_EmojiSelected (Emoji As String)
	xlbl_EmojiResult.Text = xlbl_EmojiResult.Text & Emoji
End Sub

#If B4J
Private Sub xlbl_OpenDark_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenDark_Click
#End If
	OpenDark
End Sub

#If B4J
Private Sub xlbl_OpenLight_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenLight_Click
#End If
	OpenLight
End Sub

#If B4J
Private Sub xlbl_OpenCustom_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_OpenCustom_Click
#End If
	OpenCustom
End Sub

