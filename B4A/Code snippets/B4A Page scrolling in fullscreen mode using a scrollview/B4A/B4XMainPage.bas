B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Button1 As Button
	Private EditText1 As EditText
	Private Panel1 As Panel
	Private ScrollView1 As ScrollView
	Private B4XSwitch1 As B4XSwitch
	Private CustomListView1 As CustomListView
End Sub
Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	For i = 0 To 9
		CustomListView1.AddTextItem("item " & i,i)
	Next
End Sub
Private Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub
Private Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	Log("item " & index & " selected with value " & Value)
End Sub
Private Sub B4XSwitch1_ValueChanged (Value As Boolean)
	If Value = True Then
		Panel1.RemoveView
		ScrollView1.Panel.AddView(Panel1,0,0,Panel1.Width,Panel1.Height)
		ScrollView1.Panel.Height = Panel1.Height + 300dip
	Else
		Panel1.RemoveView
		Root.AddView(Panel1,0dip,0dip,Panel1.Width,Panel1.Height)
	End If
End Sub