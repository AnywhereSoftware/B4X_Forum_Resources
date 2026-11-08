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
	Private ASWheelPicker1 As ASWheelPicker
	Private xlbl_Counter As B4XView
	
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,"AS WheelPicker Example")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	'ASWheelPicker1.mBase.Top = Height - B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom - ASWheelPicker1.mBase.Height - 10dip
	#End If
	
	Dim tmp_lst As List : tmp_lst.Initialize
	For i = 0 To 10 -1
		tmp_lst.Add("Test " & i)
	Next
	#If B4J
	Sleep(0) 'needed in B4J, i dont know, but the first wheel is buggy then
	#End If
	
	
	'ASWheelPicker1.SetItems(0,tmp_lst)
	'ASWheelPicker1.SetItems(1,tmp_lst)
	ASWheelPicker1.AddItems(tmp_lst)
	ASWheelPicker1.AddItems(tmp_lst)
	
	Dim tmp_lst As List : tmp_lst.Initialize
	For i = 0 To 50 -1
		Dim Item As ASWheelPicker_Item
		Item.Initialize
		Item.Text = "Test " & i
		Item.Value = i
		Item.Enabled = True
		
		Item.ItemTextProperties = ASWheelPicker1.ItemTextProperties
		Item.ItemTextProperties.TextColor = Rnd(0x8fffffff, -1)
		
		tmp_lst.Add(Item)
	Next
	'ASWheelPicker1.SetItems(2,tmp_lst)
	ASWheelPicker1.AddItems(tmp_lst)

	ASWheelPicker1.SetSeperator(0,40dip,"Test")
	ASWheelPicker1.SetSeperator(1,40dip,"Test2")
	'ASWheelPicker1.SetSeperator(2,40dip,"Test3")

	ASWheelPicker1.Refresh

	'ASWheelPicker1.SelectRow(0,1,False)

End Sub

'Private Sub B4XPage_Resize (Width As Int, Height As Int)
'	If ASWheelPicker1.NumberOfLists = 2 Then
'		ASWheelPicker1.SetWheelWidth(0,(Width*70)/100)
'		ASWheelPicker1.SetWheelWidth(1,(Width*30)/100)
'	End If
'End Sub


Private Sub ASWheelPicker1_ItemChange(Column As Int,ListIndex As Int)
	xlbl_Counter.Text = ASWheelPicker1.GetSelectedItem(Column).Text
End Sub





Private Sub ASWheelPicker1_CustomDrawItemChange(NewItem As ASWheelPicker_CustomDraw,OldItem As ASWheelPicker_CustomDraw)
	NewItem.Views.TextLabel.Text = "New Text"
	
	OldItem.Views.TextLabel.Text = OldItem.Item.Text
End Sub

Private Sub Label1_Click
	ASWheelPicker1.NextItem(0,False)
End Sub

Private Sub Label2_Click
	ASWheelPicker1.PreviousItem(0,False)
End Sub