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
	Private AS_Chips1 As AS_Chips
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS Chips Example")
	
	'Wait For B4XPage_Resize (Width As Int, Height As Int)
	
	For i = 1 To 21 -1
		
		AS_Chips1.ChipPropertiesGlobal.BackgroundColor = xui.Color_White
		AS_Chips1.ChipPropertiesGlobal.TextColor = xui.Color_Black
		AS_Chips1.AddChip("Test " & i,AS_Chips1.FontToBitmap(Chr(0xE0C8),True,30,xui.Color_Black),"Value" & i)
		'AS_Chips1.AddChip("#Test " & i,Null,"")
		
	Next
	Sleep(0)
	AS_Chips1.RefreshChips

End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	
End Sub

'Only affected if AutoExpand = True
Private Sub AS_Chips1_HeightChanged (Height As Float)
	Log("HeightChanged: " & Height)
End Sub

Private Sub AS_Chips1_ChipRemoved (Chip As ASChips_Chip)
	Log($"Chip "${Chip.Text}" removed"$)
End Sub

Private Sub AS_Chips1_ChipClick (Chip As ASChips_Chip)
	Log($"Chip "${Chip.Text}" clicked"$)
End Sub

Private Sub AS_Chips1_ChipLongClick (Chip As ASChips_Chip)
	'In B4J the long click is right click
	#If B4J 
	Log($"Chip "${Chip.Text}" right clicked"$)
	#Else
	Log($"Chip "${Chip.Text}" long clicked"$)
	#End If
End Sub

Private Sub AS_Chips1_HiddenChipsClicked (ListChips As List)
	Log("Hidden Chips Count: " & ListChips.Size)
	For Each Chip As ASChips_Chip In ListChips
		Log("HiddenChip: " & Chip.Text)
	Next
End Sub

'*************Example****************
Private Sub xswitch_ShowRemoveButton_ValueChanged (Value As Boolean)
	AS_Chips1.ShowRemoveIcon = Value
	AS_Chips1.RefreshChips
End Sub

Private Sub xswitch_AutoExpand_ValueChanged (Value As Boolean)
	AS_Chips1.AutoExpand = Value
	AS_Chips1.RefreshChips
End Sub

Private Sub xswitch_ShowIcons_ValueChanged (Value As Boolean)
	For i = 0 To AS_Chips1.Size -1
		If Value = True Then
			AS_Chips1.GetChip(i).Icon = AS_Chips1.FontToBitmap(Chr(0xE0C8),True,30,xui.Color_Black)
		Else
			AS_Chips1.GetChip(i).Icon = Null
		End If
	Next
	AS_Chips1.RefreshChips
End Sub


Private Sub AS_Chips1_CustomDrawChip(Item As ASChips_CustomDraw)

End Sub