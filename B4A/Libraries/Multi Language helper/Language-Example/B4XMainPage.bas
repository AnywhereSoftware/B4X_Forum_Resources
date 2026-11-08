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
	Private lang As Translation
	Private Button1 As Button
	Private Button2 As Button
	Private Button3 As Button
End Sub

Public Sub Initialize
	lang.Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Button1.Text = lang.getWord("button1","greek")
	Button2.Text = lang.getWord("button2","english")
	Button3.Text = lang.getWord("button3","french")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	xui.MsgboxAsync(lang.getWord("msg_hello_world", "greek"), "B4X")
End Sub

Private Sub Button2_Click
	xui.MsgboxAsync(lang.getWord("msg_hello_world", "english"), "B4X")
End Sub

Private Sub Button3_Click
	xui.MsgboxAsync(lang.getWord("msg_hello_world", "french"), "B4X")
End Sub