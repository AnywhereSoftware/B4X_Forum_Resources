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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=KeyboardAndList.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private CustomListView1 As CustomListView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	CustomListView1.DefaultTextBackgroundColor = xui.Color_White
	For i = 1 To 100
		CustomListView1.AddTextItem(i, "")
	Next
End Sub

Private Sub CustomListView1_ItemClick (Index As Int, Value As Object)
	If IsStub(Value) Then Return
End Sub

Private Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
	Dim KeyboardHeight As Int = Root.Height - NewHeight
	SetCLVHeight(CustomListView1, KeyboardHeight, 0)
End Sub

Private Sub B4XPage_KeyboardStateChanged (Height As Float)
	SetCLVHeight(CustomListView1, Height, 0)
End Sub

Private Sub SetCLVHeight(CLV As CustomListView, KeyboardHeight As Int, DistanceFromBottom As Int)
	If KeyboardHeight > 0 And IsLastItemStub = False Then
		Dim delta As Int = KeyboardHeight - DistanceFromBottom
		Dim NewPanel As B4XView = xui.CreatePanel("")
		NewPanel.Color = CLV.DefaultTextBackgroundColor
		NewPanel.SetLayoutAnimated(0, 0, 0, CLV.AsView.Width, delta)
		CLV.Add(NewPanel, "~stub")
	Else If KeyboardHeight = 0 And IsLastItemStub Then
		CLV.RemoveAt(CLV.Size - 1)
	End If
End Sub

Private Sub IsStub (Value As Object) As Boolean
	Return "~stub" = Value
End Sub

Private Sub IsLastItemStub As Boolean
	If CustomListView1.Size = 0 Then Return False
	Return "~stub" = CustomListView1.GetValue(CustomListView1.Size - 1)
End Sub