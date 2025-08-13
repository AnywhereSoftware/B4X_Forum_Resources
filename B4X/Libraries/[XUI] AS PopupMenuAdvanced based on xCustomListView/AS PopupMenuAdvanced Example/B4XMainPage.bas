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
	Private xlbl_open As B4XView
	
	Private aspma_Main As ASPopupMenuAdvanced
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If

	aspma_Main.Initialize(Root,Me,"aspma_Main")
	
	aspma_Main.CornerRadius = 10dip
	
End Sub

#If B4J
Private Sub xlbl_open_MouseClicked (EventData As MouseEvent)
	OpenMenu
End Sub
#Else
Private Sub xlbl_open_Click
	OpenMenu
End Sub
#End If

Private Sub OpenMenu
	aspma_Main.Clear
	aspma_Main.AddTitle("Title",60dip)
	
	For i = 0 To 20 -1
		
		Dim xpnl As B4XView = xui.CreatePanel("")
		xpnl.SetLayoutAnimated(0,0,0,200dip,50dip)
		xpnl.Color = Rnd(xui.Color_Black,xui.Color_White)
		aspma_Main.AddItem(xpnl,"")
		If i <> 19 Then aspma_Main.AddSeparator(2dip)
	Next
	
	aspma_Main.OpenMenu(200dip,500dip)
End Sub
