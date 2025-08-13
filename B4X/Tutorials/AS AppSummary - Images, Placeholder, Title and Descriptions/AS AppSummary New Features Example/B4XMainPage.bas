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
	Private AS_AppSummary1 As AS_AppSummary
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	B4XPages.SetTitle(Me,"AS AppSummary Example")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	B4XPage_Resize(Width,Height)
	#End If
	
	AS_AppSummary1.TitleTop = 0
	AS_AppSummary1.AddImageItem(xui.LoadBitmap(File.DirAssets,"NewFeature.png"),Root.Width,"")
	AS_AppSummary1.AddPlaceholder(10dip)
	AS_AppSummary1.AddTitleItem("Detailed Task Distribution Overview","")
	AS_AppSummary1.AddPlaceholder(10dip)
	AS_AppSummary1.AddDescriptionItem("Pie chart showing task distribution by category and time range for quick performance insights.","")

	AS_AppSummary1.ConfirmButtonText = "Continue"
	AS_AppSummary1.Refresh
	
End Sub


#If B4I
Private Sub B4XPage_Resize (Width As Int, Height As Int)
	AS_AppSummary1.mBase.Height = Height - B4XPages.GetNativeParent(Me).SafeAreaInsets.Bottom - 10dip
	AS_AppSummary1.Refresh
End Sub
#End If


Private Sub AS_AppSummary1_ConfirmButtonClick
	Log("ConfirmButtonClick")
End Sub

