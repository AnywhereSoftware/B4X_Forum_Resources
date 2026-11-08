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
	
	Private BottomAppSummary As AS_BottomAppSummary
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS BottomAppSummary Example")
	
End Sub

Private Sub OpenSheet(DarkMode As Boolean)
	BottomAppSummary.Initialize(Me,"BottomAppSummary",Root)
	BottomAppSummary.Theme = IIf(DarkMode,BottomAppSummary.Theme_Dark,BottomAppSummary.Theme_Light)

'	BottomAppSummary.SetTitleText("Welcome to"," Parcel ","!")
'	BottomAppSummary.AddItem("Supported worldwide","With more than 320 delivery agents supported, you can be sure that your next delivery will be tracked via Parcel.",BottomAppSummary.FontToBitmap(Chr(0xE894),True,35,BottomAppSummary.ItemIconProperties.Color),"")
'	BottomAppSummary.AddItem("Powerful functions","Daily payers, barcode scanners, card support and many other functions make tracking much easier.",BottomAppSummary.FontToBitmap(Chr(0xF02A),False,35,BottomAppSummary.ItemIconProperties.Color),"")
'	BottomAppSummary.AddItem("Push notifications","With a Premium subscription, receive push notifications when there is news about the delivery.",BottomAppSummary.FontToBitmap(Chr(0xE7F4),True,35,BottomAppSummary.ItemIconProperties.Color),"")

	
	BottomAppSummary.AddImageItem(xui.LoadBitmap(File.DirAssets,"newfeature.png"),400dip,"")
	BottomAppSummary.AddPlaceholder(10dip)
	BottomAppSummary.AddTitleItem("Detailed Task Distribution Overview","")
	BottomAppSummary.AddPlaceholder(10dip)
	BottomAppSummary.AddDescriptionItem("Pie chart showing task distribution by category and time range for quick performance insights.","")
	
	
	'BottomAppSummary.ShowPicker(500dip)
	BottomAppSummary.ShowPicker(600dip)
	
	BottomAppSummary.ConfirmButtonText = "Continue"
	
End Sub

Private Sub OpenDarkDatePicker
	OpenSheet(True)
End Sub

Private Sub OpenLightDatePicker
	OpenSheet(False)
End Sub

#Region Events


Private Sub BottomAppSummary_ActionButtonClicked
	Log("ActionButtonClicked")
	BottomAppSummary.HidePicker
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


