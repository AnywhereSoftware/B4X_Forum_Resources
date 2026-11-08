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
	Private AS_SelectionList1 As AS_SelectionList
	Private xtf_Search As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS_SelectionList Example")
	AS_SelectionList1.ThemeChangeTransition = AS_SelectionList1.ThemeChangeTransition_None
	AS_SelectionList1.Theme = AS_SelectionList1.Theme_Dark
	AS_SelectionList1.SideGap = 100dip
	
'	AS_SelectionList1.MaxSelectionCount = 3
	
	'SubItems Example
	Dim RootItem As AS_SelectionList_Item = AS_SelectionList1.AddItem("House", Null, "House")
	AS_SelectionList1.AddSubItem(RootItem, "Living Room", Null, "LivingRoom")
	AS_SelectionList1.AddSubItem(RootItem, "Bedroom", Null, "SleepingRoom")
	AS_SelectionList1.AddSubItem(RootItem, "Kitchen", Null, "Kitchen")

	Dim RootItem2 As AS_SelectionList_Item = AS_SelectionList1.AddItem("Car", Null, "Car")
	AS_SelectionList1.AddSubItem(RootItem2, "Steering Wheel", Null, "Steeringwheel")
	AS_SelectionList1.AddSubItem(RootItem2, "Air Conditioning", Null, "Climate")
	AS_SelectionList1.AddSubItem(RootItem2, "Rearview Mirror", Null, "BackMirror")
	AS_SelectionList1.AddSubItem(RootItem2, "Side Mirror", Null, "SideMirror")

	Dim RootItem3 As AS_SelectionList_Item = AS_SelectionList1.AddItem("Clothes", Null, "Clothes")
	AS_SelectionList1.AddSubItem(RootItem3, "T-Shirt", Null, "Shirt")
	AS_SelectionList1.AddSubItem(RootItem3, "Hoodie", Null, "Hoodie")
	AS_SelectionList1.AddSubItem(RootItem3, "Pants", Null, "Pants")
	AS_SelectionList1.AddSubItem(RootItem3, "Socks", Null, "Socks")
	AS_SelectionList1.AddSubItem(RootItem3, "Underpants", Null, "Underpants")

	
	
	
	For i = 0 To 80 -1
		'AS_SelectionList1.AddItem("Test " & (i+1),AS_SelectionList1.FontToBitmap(Chr(0xF179),False,30,xui.Color_Black),i)
		AS_SelectionList1.AddItem("Test " & (i+1),Null,i)	
	Next
	
	


End Sub


Private Sub xtf_Search_TextChanged (OldText As String, NewText As String)
	Sleep(0)
	AS_SelectionList1.SearchByText(NewText)
End Sub

Private Sub AS_SelectionList1_SelectionChanged
	
	For Each Item As Object In AS_SelectionList1.GetSelections
		If Item Is AS_SelectionList_Item Then
			Log("Item selected: " & Item.As(AS_SelectionList_Item).Text)
		Else
			Log("SubItem selected: " & Item.As(AS_SelectionList_SubItem).Text)
		End If
	Next

End Sub