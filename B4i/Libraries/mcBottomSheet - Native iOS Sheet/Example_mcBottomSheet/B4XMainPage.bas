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
	
	Dim bs As mcBottomSheet
	Private clv As CustomListView
	
	'Create your content panel
	Dim pnlContent As Panel
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	'Init the panel
	pnlContent.Initialize("")
End Sub


Sub btnClose_Click
	bs.Dismiss
End Sub

Private Sub btnFull_Click
	'====================METHOD 1 - Adding Views Directly===================
	'
	'Not Needed if you are using only one method
	pnlContent.RemoveAllViews
	
	'Add components to pnlContent
	Dim lblTitle As Label
	lblTitle.Initialize("")
	pnlContent.AddView(lblTitle, 10dip, 10dip, 100%x - 20dip, 40dip)
	lblTitle.Text = "Bottom Sheet Title"
	lblTitle.Font.CreateNew(20)
	
	'Add buttons
	Dim btnClose As Button
	btnClose.Initialize("btnClose",btnClose.STYLE_SYSTEM)
	pnlContent.AddView(btnClose, 10dip, 60dip, 100dip, 40dip)
	btnClose.Text = "Close"
	
	
	'Show the sheet in Full
	bs.initSheet(pnlContent)	
	
	bs.ShowFull
	
End Sub



Private Sub btnHalfwithLayout_Click
	'====================METHOD 1 - Adding Layout with Views===================
		
	'Not Needed if you are using only one method
	pnlContent.RemoveAllViews
	
	
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0,0,0,Root.Width,500dip)
	p.LoadLayout("lyItem")
	
	
	For i = 0 To 20
		clv.AddTextItem("Text " & i,i)
	Next
	
	
	'Show the Sheet as half
	bs.initSheet(p)
	bs.ShowHalf
	
End Sub

Private Sub clv_ItemClick (Index As Int, Value As Object)
	Log("Item " & Value & " clicked")
	xui.MsgboxAsync("Hello","world")
End Sub