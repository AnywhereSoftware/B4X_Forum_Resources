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
	
	B4XPages.SetTitle(Me,"AS Settings SegmentedTab Example")
	
	AS_Settings1.MainPage.AddGroup("Basic","Basic Settings")
	
	AS_Settings1.MainPage.AddProperty_SegmentedTab("Basic","PropertyName_1","Segmented Example 1","",Null,1,CreateMap("Option 1":"Value1","Option 2":"Value2"),200dip)
	AS_Settings1.MainPage.AddProperty_SegmentedTab("Basic","PropertyName_2","Segmented Example 2","",Null,1,CreateMap("Option 1":"Value1","Option 2":"Value2","Option 3":"Value3","Option 4":"Value4"),0)
	
	AS_Settings1.MainPage.Create
	
End Sub

Private Sub B4XPage_KeyboardStateChanged (Height As Float)
	
	AS_Settings1.Base_Resize(Root.Width,Root.Height - Height)
	
End Sub

Private Sub AS_Settings1_ValueChanged(Property As AS_Settings_Property, Value As Object)
	Log("ValueChanged " & Property.PropertyName & ": " & Value)
End Sub
