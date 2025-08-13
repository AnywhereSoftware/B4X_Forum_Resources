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
	Private AS_Settings1 As AS_Settings
	Private Page_SingleSelect As AS_SettingsPage
	Private Page_MultiSelect As AS_SettingsPage
	Private lst_Items As List
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	B4XPages.SetTitle(Me,"AS Settings SelectionList Example")
	
	'************MainPage*****************
	AS_Settings1.MainPage.AddGroup("Group1","Group")
	AS_Settings1.MainPage.AddProperty_Action("Group1","SingleSelect","Single Select","",Null,AS_Settings1.CreateList(Array("Item1")))
	AS_Settings1.MainPage.AddProperty_Action("Group1","MultiSelect","Multi Select","",Null,AS_Settings1.CreateList(Array("Item1","Item3")))
	
	'************Items********************
	lst_Items.Initialize
	lst_Items.Add(AS_Settings1.CreateSelectionListItem("Item #1",Null,"Item1"))
	lst_Items.Add(AS_Settings1.CreateSelectionListItem("Item #2",Null,"Item2"))
	lst_Items.Add(AS_Settings1.CreateSelectionListItem("Item #3",Null,"Item3"))
	lst_Items.Add(AS_Settings1.CreateSelectionListItem("Item #4",Null,"Item4"))
	lst_Items.Add(AS_Settings1.CreateSelectionListItem("Item #5",Null,"Item5"))
	
	'************Single Select************
	Page_SingleSelect.Initialize(AS_Settings1,"Single Select")
	Page_SingleSelect.AddGroup("Group1","")
	Page_SingleSelect.AddProperty_SelectionList("Group1","SingleSelect",lst_Items,Array("Item1"),False,False)
	
	'************Multi Select*************
	Page_MultiSelect.Initialize(AS_Settings1,"Multi Select")
	Page_MultiSelect.AddGroup("Group1","")
	Page_MultiSelect.AddProperty_SelectionList("Group1","MultiSelect",lst_Items,Array("Item1","Item3"),True,False)
	
	
	AS_Settings1.MainPage.Create
	
End Sub

Private Sub AS_Settings1_ActionClicked(Property As AS_Settings_Property)
	Select Property.PropertyName
		Case "SingleSelect"
			Page_SingleSelect.ShowPage
		Case "MultiSelect"
			Page_MultiSelect.ShowPage
	End Select
End Sub

Private Sub AS_Settings1_ValueChanged(Property As AS_Settings_Property, Value As Object)
	Select Property.PropertyName
		Case "SingleSelect", "MultiSelect"
			AS_Properties.PutProperty(Property.PropertyName,Value)
			AS_Settings1.MainPage.Refresh 'Refresh the text and triggers the custom draw event
	End Select
End Sub

Private Sub AS_Settings1_CustomDrawProperty(CustomDrawProperty As AS_Settings_CustomDrawProperty)
	
	If CustomDrawProperty.Group.Key = "Group1" And CustomDrawProperty.Property.PropertyName = "SingleSelect" Then

		'We need just one item text
		Dim SelectedValue As String = CustomDrawProperty.Property.Value.As(List).Get(0).As(String)
		Dim NewDisplayText As String = ""
		For i = 0 To lst_Items.Size -1
			If lst_Items.Get(i).As(AS_Settings_SelectionListItem).Value = SelectedValue Then
				NewDisplayText = lst_Items.Get(i).As(AS_Settings_SelectionListItem).DisplayName
			End If
		Next

		CustomDrawProperty.PropertySettingViews.ActionValueLabel.Text = NewDisplayText
		
	Else If CustomDrawProperty.Group.Key = "Group1" And CustomDrawProperty.Property.PropertyName = "MultiSelect" Then
		
		'We need multiple item text
		Dim lst_SelectedItems As List = CustomDrawProperty.Property.Value
		Dim NewDisplayText As String = ""

		For Each SelectedValue As String In lst_SelectedItems
			For i = 0 To lst_Items.Size -1
				If lst_Items.Get(i).As(AS_Settings_SelectionListItem).Value = SelectedValue Then
					NewDisplayText = NewDisplayText & lst_Items.Get(i).As(AS_Settings_SelectionListItem).DisplayName & ", "
				End If
			Next
		Next

		CustomDrawProperty.PropertySettingViews.ActionValueLabel.Text = NewDisplayText.Trim.SubString2(0,NewDisplayText.Trim.Length -1) 'Removes the last comma
		
	End If

End Sub
