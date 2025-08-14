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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=IME_Example.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private ime As IME
	Private EditText2 As B4XView
	Private EditText3 As B4XView
	Private EditText4 As B4XView
	Private btnShowKeyboard As B4XView
	Private EditText1 As B4XView
	Private btnHideKeyboard As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	ime.Initialize("IME")
	ime.AddHandleActionEvent(EditText2)
	ime.SetCustomFilter(EditText3, EditText3.As(EditText).INPUT_TYPE_NUMBERS, "0123456789.")
	ime.SetCustomFilter(EditText4, Bit.Or(EditText4.As(EditText).INPUT_TYPE_TEXT, 0x00080000), _ '0x0080000 is the flag of NO_SUGGESTIONS.
		"01234567890abcdef")
	IME_HeightChanged(Root.Height, 0)
End Sub

Private Sub IME_HandleAction As Boolean
	Dim e As EditText
	e = Sender
	If e.Text.StartsWith("a") = False Then
		ToastMessageShow("Text must start with 'a'.", True)
		'Consume the event.
		'The keyboard will not be closed
		Return True
	Else
		Return False 'will close the keyboard
	End If
End Sub

Private Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	btnHideKeyboard.Top = NewHeight - btnHideKeyboard.Height
	EditText1.Height = btnHideKeyboard.Top - EditText1.Top
End Sub

Private Sub btnShowKeyboard_Click
	ime.ShowKeyboard(EditText2)
End Sub

Private Sub btnHideKeyboard_Click
	ime.HideKeyboard
End Sub