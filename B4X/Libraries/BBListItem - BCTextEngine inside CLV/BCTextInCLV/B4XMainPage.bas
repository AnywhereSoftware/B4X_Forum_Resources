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
	Private CustomListView1 As CustomListView
	Private TextEngine As BCTextEngine
	Private BBListItemIndexInItems As Int = 1
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	If Root.Width = 0 Then
		Wait For B4XPage_Resize (Width As Int, Height As Int)
	End If
	Root.LoadLayout("MainPage")
	TextEngine.Initialize(Root)
	For i = 1 To 30
		Dim pnl As B4XView = xui.CreatePanel("")
		pnl.SetLayoutAnimated(0, 0, 0, CustomListView1.AsView.Width, 100dip)
		pnl.LoadLayout("Item")
		Dim BB As BBListItem = pnl.GetView(BBListItemIndexInItems).Tag 
		Dim orig As Int = BB.mBase.Height
		BB.TextEngine = TextEngine
		BB.Text = CreateItemText(i)
		pnl.SetLayoutAnimated(0, 0, 0, pnl.Width, Max(pnl.Height, pnl.Height + BB.mBase.Height - orig))
		CustomListView1.Add(pnl, "")
	Next
	CustomListView1_ScrollChanged(0)
End Sub

Private Sub CreateItemText(index As Int) As String
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append($"[alignment=center][b]Item #${index}[/b][/alignment]"$)
	For i = 1 To Rnd(1, 20)
		sb.Append(CRLF).Append($"[u]Line ${i}[/u]: [color=red]alksd[/color] [url="https://www.b4x.com"]jalksd jklasd[/url] kalsd "$)
	Next
	Return sb.ToString
End Sub

Private Sub BBListItem1_LinkClicked (URL As String)
	Log(URL)
	Dim bb As BBListItem = Sender
	Dim index As Int = CustomListView1.GetItemFromView(bb.mBase)
	Log(index)
End Sub


Private Sub CustomListView1_ScrollChanged (Offset As Int)
	For i = 0 To CustomListView1.Size - 1
		Dim BB As BBListItem = CustomListView1.GetPanel(i).GetView(BBListItemIndexInItems).Tag
		BB.ParentScrolled(Offset, CustomListView1.AsView.Height, 40dip) '40dip - height of the "title" pane in the layout
	Next
End Sub