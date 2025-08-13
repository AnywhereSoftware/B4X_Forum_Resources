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
	
	Private BottomCard As ASDraggableBottomCard
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS BottomDatePicker Example")
	
End Sub

Private Sub OpenDarkDatePicker
	
	Dim SafeAreaHeight As Float = 0
	Dim HeaderHeight As Float = 20dip
	Dim BodyHeight As Float = 150dip
	
	#If B4I
	SafeAreaHeight = B4XPages.GetNativeParent(B4XPages.MainPage).SafeAreaInsets.Bottom
	BodyHeight = BodyHeight + SafeAreaHeight
	#Else
	SafeAreaHeight = 20dip
	BodyHeight = BodyHeight + SafeAreaHeight
	#End If
	
	BottomCard.Initialize(Me,"BottomCard")
	BottomCard.BodyDrag = True
	BottomCard.Create(Root,BodyHeight,BodyHeight,HeaderHeight,Root.Width,BottomCard.Orientation_MIDDLE)
	BottomCard.CornerRadius_Header = 30dip/2

	'DragIndicator
	Dim xpnl_DragIndicator As B4XView = xui.CreatePanel("")
	BottomCard.HeaderPanel.AddView(xpnl_DragIndicator,Root.Width/2 - 70dip/2,HeaderHeight - 6dip,70dip,6dip)
	xpnl_DragIndicator.SetColorAndBorder(xui.Color_ARGB(80,255,255,255),0,0,3dip)

	'ConfirmationButton
	Dim xlbl_ConfirmationButton As B4XView = CreateLabel("xlbl_ConfirmationButton")
	xlbl_ConfirmationButton.Text = "Confirm"
	xlbl_ConfirmationButton.TextColor = xui.Color_White
	xlbl_ConfirmationButton.SetColorAndBorder(xui.Color_ARGB(255,45, 136, 121),0,0,10dip)
	xlbl_ConfirmationButton.SetTextAlignment("CENTER","CENTER")
	Dim ConfirmationButtoHeight As Float = 40dip	
	BottomCard.BodyPanel.AddView(xlbl_ConfirmationButton,Root.Width/2 - 220dip/2,BodyHeight - ConfirmationButtoHeight - SafeAreaHeight,220dip,ConfirmationButtoHeight)
	
	'Optional Code
	BottomCard.HeaderPanel.Color = xui.Color_ARGB(255,32, 33, 37)
	BottomCard.BodyPanel.Color = xui.Color_ARGB(255,32, 33, 37)
	
	BottomCard.Show(False)
	
End Sub

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Private Sub xlbl_ConfirmationButton_Click
	Log("ConfirmationButton Clicked")
	BottomCard.Hide(False)
End Sub

#If B4J
Private Sub xlbl_ConfirmationButton_MouseClicked (EventData As MouseEvent)
	Log("ConfirmationButton Clicked")
	BottomCard.Hide(False)
End Sub

#End If

#Region ButtonEvents

#If B4J
Private Sub xlbl_OpenDarkDatePicker_MouseClicked (EventData As MouseEvent)
	OpenDarkDatePicker
End Sub
#Else
Private Sub xlbl_OpenDarkDatePicker_Click
	OpenDarkDatePicker
End Sub
#End If

#End Region


