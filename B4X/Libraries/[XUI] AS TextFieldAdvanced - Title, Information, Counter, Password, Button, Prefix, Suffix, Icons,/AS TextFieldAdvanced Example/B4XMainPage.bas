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
	Private AS_TextFieldAdvanced_1 As AS_TextFieldAdvanced
	Private AS_TextFieldAdvanced_2 As AS_TextFieldAdvanced
	Private AS_TextFieldAdvanced_3 As AS_TextFieldAdvanced
	Private AS_TextFieldAdvanced_4 As AS_TextFieldAdvanced
	Private AS_TextFieldAdvanced_5 As AS_TextFieldAdvanced
	Private AS_TextFieldAdvanced_6 As AS_TextFieldAdvanced
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS TextFieldAdvanced Example")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	B4XPage_Resize(Width,Height)
	#End If

	'Leading and Trailing Icon
	AS_TextFieldAdvanced_4.LeadingIcon.Icon = xui.LoadBitmap(File.DirAssets,"search.png")
	AS_TextFieldAdvanced_4.TrailingIcon.Icon = xui.LoadBitmap(File.DirAssets,"warning.png")
	
	AS_TextFieldAdvanced_4.LeftGap = 0
	AS_TextFieldAdvanced_4.Refresh
	
	'Prefix Suffix Example
	AS_TextFieldAdvanced_5.LeftGap = 0
	AS_TextFieldAdvanced_5.TextField.SetTextAlignment("CENTER","RIGHT")
	AS_TextFieldAdvanced_5.Hint.View.xlbl_Hint.SetTextAlignment("CENTER","RIGHT")
	AS_TextFieldAdvanced_5.Prefix.Text = "$"
	AS_TextFieldAdvanced_5.Suffix.Text = "@gmail.com"
	AS_TextFieldAdvanced_5.Refresh


'Sleep(3000)
'	AS_TextFieldAdvanced_1.ShowDisplayMissingField("This field is required")

End Sub

Private Sub AS_TextFieldAdvanced_2_TextChanged(Text As String)
	Log("TextChanged")
End Sub

#If B4I
Private Sub B4XPage_Resize (Width As Int, Height As Int)
	
End Sub
#End If

Private Sub AS_TextFieldAdvanced_1_PasswordRevealChanged (Revealed As Boolean)
	Log("PasswordRevealChanged: " & Revealed)
End Sub

Private Sub AS_TextFieldAdvanced_1_EnterPressed
	Log("EnterPressed")
End Sub

Private Sub AS_TextFieldAdvanced_2_EnterPressed
	Log("EnterPressed")
End Sub

Private Sub AS_TextFieldAdvanced_3_EnterPressed
	Log("EnterPressed")
End Sub

Private Sub AS_TextFieldAdvanced_1_FocusChanged (HasFocus As Boolean)
	Log("FocusChanged: " & HasFocus)
End Sub

Private Sub AS_TextFieldAdvanced_2_FocusChanged (HasFocus As Boolean)
	Log("FocusChanged: " & HasFocus)
End Sub

Private Sub AS_TextFieldAdvanced_3_FocusChanged (HasFocus As Boolean)
	Log("FocusChanged: " & HasFocus)
End Sub

Private Sub AS_TextFieldAdvanced_4_LeadingIconClick
	Log("LeadingIconClick")
End Sub

Private Sub AS_TextFieldAdvanced_4_TrailingIconClick
	Log("TrailingIconClick")
	AS_TextFieldAdvanced_4.Hint.Text = "luuul"
	AS_TextFieldAdvanced_4.Refresh
End Sub