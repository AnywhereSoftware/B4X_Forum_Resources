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

End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	B4XPages.SetTitle(Me,"AS Settings CustomProperty Example")
	
	'************MainPage*****************
	AS_Settings1.MainPage.AddGroup("Group1","Group")

	AS_Settings1.MainPage.AddProperty_Boolean("Group1","Prop1","Prop 1","",Null,True)
	AS_Settings1.MainPage.AddProperty_Boolean("Group1","Prop2","Prop 2","",Null,False)
	
	AS_Settings1.MainPage.AddProperty_Custom("Group1","Custom1",250dip) 'Custom Property in Group
	
	AS_Settings1.MainPage.AddProperty_Boolean("Group1","Prop3","Prop 3","",Null,True)
	AS_Settings1.MainPage.AddProperty_Boolean("Group1","Prop4","Prop 4","",Null,False)
	
	AS_Settings1.MainPage.AddSpaceItem("MainPage","",20dip)
	
	AS_Settings1.MainPage.AddProperty_Custom("","Custom2",50dip) 'Custom Property without a group
	
	AS_Settings1.MainPage.Create
	
End Sub




Private Sub AS_Settings1_CustomDrawCustomProperty(CustomProperty As AS_Settings_CustomDrawCustomProperty)
	
	Select CustomProperty.Property.PropertyName
		Case "Custom1"
			
			CustomProperty.BackgroundPanel.LoadLayout("frm_CustomLayout_1")
			
			Dim xiv_CustomImage1 As B4XImageView = CustomProperty.BackgroundPanel.GetView(0).Tag
			xiv_CustomImage1.ResizeMode = "FILL_WIDTH"
			xiv_CustomImage1.Bitmap = xui.LoadBitmap(File.DirAssets,"mycat01.jpg")
			
		Case "Custom2"
			
			CustomProperty.BackgroundPanel.LoadLayout("frm_CustomLayout_2")
			CustomProperty.BackgroundPanel.Color = AS_Settings1.BackgroundColor
			
			Dim B4XBreadCrumb1 As B4XBreadCrumb = CustomProperty.BackgroundPanel.GetView(0).Tag
			B4XBreadCrumb1.Items.Add("Item 1")
			B4XBreadCrumb1.Items.Add("Item 2")
			B4XBreadCrumb1.Items.Add("Item 3")
			B4XBreadCrumb1.Items.Add("Item 4")
			B4XBreadCrumb1.Items.Add("Item 5")
			
			#If B4A
			B4XBreadCrumb1.Base_Resize(B4XBreadCrumb1.mBase.Width,B4XBreadCrumb1.mBase.Height) 'is needed in B4A for some reasons
			#End If
	End Select
	
End Sub