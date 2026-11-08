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
	Private AS_ScrollingChips1 As AS_ScrollingChips
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	B4XPages.SetTitle(Me,"AS ScrollingChips Example")

	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)	
	#End If
	
	For i = 1 To 21 -1'21 -1
		
		AS_ScrollingChips1.ChipPropertiesGlobal.BackgroundColor = xui.Color_White
		AS_ScrollingChips1.ChipPropertiesGlobal.TextColor = xui.Color_Black
		AS_ScrollingChips1.AddChip("Test " & i,AS_ScrollingChips1.FontToBitmap(Chr(0xE0C8),True,30,xui.Color_Black),"")
		'AS_ScrollingChips1.AddChip("#Test " & i,Null,"")
		
	Next
	Sleep(0)
	AS_ScrollingChips1.RefreshChips
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Sub AS_ScrollingChips1_ItemClick (Index As Int, Value As Object)
	Log("ItemClick Index: " & Index)
	Dim xpnl_background As B4XView = AS_ScrollingChips1.GetBackgroundAt(Index)
	
	If xpnl_background.Tag = Null Or xpnl_background.Tag = True Then
		xpnl_background.Tag = False
		xpnl_background.Color = xui.Color_Black
	Else
		xpnl_background.Tag = True
		xpnl_background.Color = xui.Color_ARGB(255,Rnd(1,256), Rnd(1,256), Rnd(1,256))
	End If
End Sub

Sub AS_ScrollingChips1_ItemLongClick (Index As Int, Value As Object)
	Log("ItemLongClick Index: " & Index)
End Sub

Private Sub AS_ScrollingChips1_ChipClick (Chip As ASScrollingChips_Chip)
	Log($"Chip "${Chip.Text}" clicked"$)
End Sub

Private Sub AS_ScrollingChips1_ChipLongClick (Chip As ASScrollingChips_Chip)
	'In B4J the long click is right click
	#If B4J 
	Log($"Chip "${Chip.Text}" right clicked"$)
	#Else
	Log($"Chip "${Chip.Text}" long clicked"$)
	#End If
End Sub

Private Sub AS_ScrollingChips1_ChipRemoved (Chip As ASScrollingChips_Chip)
	Log($"Chip "${Chip.Text}" removed"$)
End Sub
