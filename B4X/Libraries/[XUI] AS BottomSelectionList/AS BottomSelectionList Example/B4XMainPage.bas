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
	
	Private BottomSelectionList As AS_BottomSelectionList
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS BottomSelectionList Example")
	
End Sub

Private Sub OpenSheet(DarkMode As Boolean)
	BottomSelectionList.Initialize(Me,"BottomSelectionList",Root)
	BottomSelectionList.Theme = IIf(DarkMode,BottomSelectionList.Theme_Dark,BottomSelectionList.Theme_Light)
	BottomSelectionList.ActionButtonVisible = True

	For i = 0 To 20 -1
		BottomSelectionList.AddItem("Test " & i,Null,i)
	Next
	
	BottomSelectionList.ShowPicker
	
	BottomSelectionList.ActionButton.Text = "Confirm"
	
End Sub

Private Sub OpenDarkDatePicker
	OpenSheet(True)
End Sub

Private Sub OpenLightDatePicker
	OpenSheet(False)
End Sub

#Region Events

Private Sub BottomSelectionList_SelectionChanged
	
	For Each Item As AS_SelectionList_Item In BottomSelectionList.GetSelections
		Log("SelectionChanged: " & Item.Text)
	Next

End Sub

Private Sub BottomSelectionList_ActionButtonClicked
	Log("ActionButtonClicked")
	BottomSelectionList.HidePicker
End Sub

#End Region


#Region ButtonEvents

#If B4J
Private Sub xlbl_OpenDark_MouseClicked (EventData As MouseEvent)
	OpenDarkDatePicker
End Sub
#Else
Private Sub xlbl_OpenDark_Click
	OpenDarkDatePicker
End Sub
#End If

#If B4J
Private Sub xlbl_OpenLight_MouseClicked (EventData As MouseEvent)
	OpenLightDatePicker
End Sub
#Else
Private Sub xlbl_OpenLight_Click
	OpenLightDatePicker
End Sub
#End If

#End Region


