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
	
	Private BottomActionSheet As AS_BottomActionSheet
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS BottomActionSheet Example")
	
End Sub

Private Sub OpenSheet(DarkMode As Boolean)
	BottomActionSheet.Initialize(Me,"BottomActionSheet",Root)
	
	BottomActionSheet.Theme = IIf(DarkMode,BottomActionSheet.Theme_Dark,BottomActionSheet.Theme_Light)
	BottomActionSheet.ActionButtonVisible = True
	
	BottomActionSheet.AddItem("Item #1",Null,0)
	BottomActionSheet.AddItem("Item #2",Null,1)
	BottomActionSheet.AddItem("Item #3",Null,2)
	BottomActionSheet.AddItem2("Item #4",Null,BottomActionSheet.FontToBitmap(Chr(0xE897),True,25dip,IIf(DarkMode,xui.Color_White,xui.Color_Black)),4)
	
'	BottomActionSheet.AddItem("Item #1",BottomActionSheet.FontToBitmap(Chr(0xE190),True,30dip,xui.Color_White),0)
'	BottomActionSheet.AddItem("Item #2",BottomActionSheet.FontToBitmap(Chr(0xE190),True,30dip,xui.Color_White),1)
'	BottomActionSheet.AddItem("Item #3",BottomActionSheet.FontToBitmap(Chr(0xE190),True,30dip,xui.Color_White),2)
	
	BottomActionSheet.ShowPicker
	
	BottomActionSheet.ActionButton.Text = "Abort"
	
	Wait For BottomActionSheet_ItemClicked(Item As AS_BottomActionSheet_Item)
	
	BottomActionSheet.HidePicker
	
	Select Item.Value
		Case 0
			Log(Item.Text & " clicked")
		Case 1
			Log(Item.Text & " clicked")
		Case 2
			Log(Item.Text & " clicked")
	End Select
End Sub

Private Sub OpenDarkDatePicker
	OpenSheet(True)
End Sub

Private Sub OpenLightDatePicker
	OpenSheet(False)
End Sub

#Region BottomDatePickerEvents

Private Sub BottomActionSheet_ActionButtonClicked
	Log("ActionButtonClicked")
End Sub

#End Region


#Region ButtonEvents

#If B4J
Private Sub xlbl_OpenDarkPicker_MouseClicked (EventData As MouseEvent)
	OpenDarkDatePicker
End Sub
#Else
Private Sub xlbl_OpenDarkPicker_Click
	OpenDarkDatePicker
End Sub
#End If

#If B4J
Private Sub xlbl_OpenLightPicker_MouseClicked (EventData As MouseEvent)
	OpenLightDatePicker
End Sub
#Else
Private Sub xlbl_OpenLightPicker_Click
	OpenLightDatePicker
End Sub
#End If

#End Region


