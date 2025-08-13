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
	
	AS_AppSummary1.SetTitleText("Welcome to"," Parcel ","!")
	
'	AS_AppSummary1.AddItem("Supported worldwide","With more than 320 delivery agents supported, you can be sure that your next delivery will be tracked via Parcel.",Null,"")
'	AS_AppSummary1.AddItem("Powerful functions","Daily payers, barcode scanners, card support and many other functions make tracking much easier.",Null,"")
'	AS_AppSummary1.AddItem("Push notifications","With a Premium subscription, receive push notifications when there is news about the delivery.",Null,"")
	
	AS_AppSummary1.AddItem("Supported worldwide","With more than 320 delivery agents supported, you can be sure that your next delivery will be tracked via Parcel.",AS_AppSummary1.FontToBitmap(Chr(0xE894),True,35,AS_AppSummary1.ItemIconProperties.Color),"")
	AS_AppSummary1.AddItem("Powerful functions","Daily payers, barcode scanners, card support and many other functions make tracking much easier.",AS_AppSummary1.FontToBitmap(Chr(0xF02A),False,35,AS_AppSummary1.ItemIconProperties.Color),"")
	AS_AppSummary1.AddItem("Push notifications","With a Premium subscription, receive push notifications when there is news about the delivery.",AS_AppSummary1.FontToBitmap(Chr(0xE7F4),True,35,AS_AppSummary1.ItemIconProperties.Color),"")

	AS_AppSummary1.ConfirmButtonText = "Start using Parcel"
	
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

Private Sub AS_AppSummary1_ItemClicked(Item As AS_AppSummary_Item)
	Log("ItemClicked: " & Item.Name)
End Sub