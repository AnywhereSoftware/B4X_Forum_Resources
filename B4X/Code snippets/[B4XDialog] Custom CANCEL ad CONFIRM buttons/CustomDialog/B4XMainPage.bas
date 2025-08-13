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

	Private xDialog As B4XDialog
	Private xListTemplate As B4XListTemplate
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	xDialog.Initialize(Root)
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

' Standard dialog, code taken from docs
' =====================================
Private Sub Button1_Click
	xDialog.Title = "Standard Dialog"
	
	xListTemplate.Initialize
	xListTemplate.Options = Array("Cat", "Dog", "Fish", "Crocodile")
	
	Wait For (xDialog.ShowTemplate(xListTemplate, "OK", "", "Cancel")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		xDialog.Show($"You selected: ${xListTemplate.As(B4XListTemplate).SelectedItem}"$, "OK", "", "")
	End If
End Sub

' Customized dialog: Cancel button sided right on title bar, Confirm button taking full width
' ===========================================================================================
Private Sub Button2_Click
	xDialog.Title = "Custom Dialog"
	
	xListTemplate.Initialize
	xListTemplate.Options = Array("Cat", "Dog", "Fish", "Crocodile")
	
	'xDialog.ButtonsColor = 0xFFFFFFFF
	xDialog.ButtonsOrder = Array As Int(xui.DialogResponse_Cancel, xui.DialogResponse_Positive, xui.DialogResponse_Negative)
	
	' do not Wait For Complete here, but later using a ResumableSub, so we retake control of program flow
	' and modify layout after it is created
	' specify any text as Cancel object, in this case its a FA boxed X
	Dim rs As ResumableSub = xDialog.ShowTemplate(xListTemplate, "OK", "", Chr(0xF2D4))
	
	' now dialog is waiting for user input, modify on-the-fly
	Dim titleBar As B4XView = xDialog.TitleBar
	If titleBar.IsInitialized Then
		Dim lblCancel As B4XView = xDialog.GetButton(xui.DialogResponse_Cancel)
		If lblCancel.IsInitialized Then
			lblCancel.RemoveViewFromParent
			' here goes the customization
			lblCancel.Color = 0
			lblCancel.TextColor = 0xffffffff
#If B4J
			lblCancel.Font = xui.CreateFontAwesome(lblCancel.TextSize * 0.8)
			lblCancel.As(Button).Alignment = "TOP_RIGHT"
			titleBar.AddView(lblCancel, titleBar.Width - 40dip, 0, 45dip, titleBar.Height) ' right alignment
#Else
			lblCancel.Font = xui.CreateFontAwesome(lblCancel.TextSize * 1.5)
			titleBar.AddView(lblCancel, titleBar.Width - 31dip, 1dip, 30dip, 30dip) ' right alignment
#End If
		End If
	End If
	' customizing Confirm button
	Dim lblConfirm As B4XView = xDialog.GetButton(xui.DialogResponse_Positive)
	lblConfirm.SetLayoutAnimated(0, 4dip, lblConfirm.Top, lblConfirm.Left + lblConfirm.Width - 4dip, lblConfirm.Height)
	lblConfirm.SetColorAndBorder(0xFFFFFFFF, 1dip, 0xFF909090, 3dip)
	
	Wait For (rs) Complete (Result As Int)
	
	If Result = xui.DialogResponse_Positive Then
		xDialog.Show($"You selected: ${xListTemplate.As(B4XListTemplate).SelectedItem}"$, "OK", "", "")
	End If
End Sub
