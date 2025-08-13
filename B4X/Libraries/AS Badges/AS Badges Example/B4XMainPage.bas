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
	
	Private AS_Badges1 As AS_Badges
	
	Private xlbl_Label As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS Badges Example")
	
	AS_Badges1.Initialize(Me,"Badges1")
	
	AS_Badges1.Radius = 12dip
	AS_Badges1.TextAnimation = AS_Badges1.TextAnimation_FadeIn
	
	For i = 0 To 20 -1	
		
		If i > 5 Then
			Dim BadgeProperties As AS_Badges_BadgeProperties = AS_Badges1.BadgeProperties
			BadgeProperties.BackgroundColor = xui.Color_Red
			BadgeProperties.Orientation = AS_Badges1.Orientation_TopRight
			AS_Badges1.SetBadge2(xlbl_Label,i,BadgeProperties)
		Else if i = 2 Or i = 3 Or i = 4 Then
			Dim BadgeProperties As AS_Badges_BadgeProperties = AS_Badges1.BadgeProperties
			If i = 2 Then
				BadgeProperties.Orientation = AS_Badges1.Orientation_TopLeft
			else if i = 3 Then
				BadgeProperties.Orientation = AS_Badges1.Orientation_BottomLeft
			else if i = 4 Then
				BadgeProperties.Orientation = AS_Badges1.Orientation_BottomRight
			End If
			AS_Badges1.SetBadge2(xlbl_Label,i,BadgeProperties)
		Else
			AS_Badges1.SetBadge(xlbl_Label,i)
		End If
		
		Sleep(1000)
		
	Next
	

	
End Sub

Private Sub Badges1_Click (Parent As B4XView)
	AS_Badges1.SetBadge(Parent,AS_Badges1.GetBadgeCounter(Parent) +1)
End Sub

