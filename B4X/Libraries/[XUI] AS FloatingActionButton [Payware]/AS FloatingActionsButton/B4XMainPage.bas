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
	Private ASFloatingActionButton1 As ASFloatingActionButton
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,"AS FloatingActionButton Example")
	
	#If B4I
	Wait For B4XPage_Resize (Width As Int, Height As Int)
	#End If
	
	'ASFloatingActionButton1.ButtonIcon = ASFloatingActionButton1.FontToBitmap(Chr(0xE145),True,30,xui.Color_White)
	
	ASFloatingActionButton1.ButtonIconText.Font = xui.CreateMaterialIcons(24)'because the icon we want to display is an Material Icon
	ASFloatingActionButton1.ButtonIconText.Text = Chr(0xE145)
	
	
	ASFloatingActionButton1.ItemButtonProperties.IconText_Font = xui.CreateMaterialIcons(20)'because the next 2 item we want to add is a Material Icon
	ASFloatingActionButton1.AddItem(Null,Chr(0xE859),"Test Text","")
	ASFloatingActionButton1.AddItem(Null,Chr(0xE87D),"Test Text","")
	
	ASFloatingActionButton1.ItemButtonProperties.BackgroundColor = xui.Color_ARGB(255,73, 98, 164)'the next item should be a blue button
	ASFloatingActionButton1.ItemButtonProperties.IconText_Font = xui.CreateFontAwesome(20)'because the next item we want to add is a FontAwesome Icon
	ASFloatingActionButton1.AddItem(Null,Chr(0xF179),"Test Text","")
	
'	ASFloatingActionButton1.AddItem(ASFloatingActionButton1.FontToBitmap(Chr(0xE859),True,20,xui.Color_White),"","")
'	ASFloatingActionButton1.AddItem(ASFloatingActionButton1.FontToBitmap(Chr(0xF179),False,20,xui.Color_White),"Test 2","")
'	ASFloatingActionButton1.AddItem(ASFloatingActionButton1.FontToBitmap(Chr(0xE87D),True,20,xui.Color_White),"Test 3","")
'	ASFloatingActionButton1.AddItem(ASFloatingActionButton1.FontToBitmap(Chr(0xE0BE),True,20,xui.Color_White),"Test 4","")
'	ASFloatingActionButton1.AddItem(ASFloatingActionButton1.FontToBitmap(Chr(0xE029),True,20,xui.Color_White),"Test 50000000","")

End Sub


Sub ASFloatingActionButton1_ItemClicked(index As Int,Value As Object)
	Log("ASFloatingActionButton1_ItemClicked: " & index)
	'ASFloatingActionButton1.CloseMenu
End Sub

Sub ASFloatingActionButton1_ButtonClicked(open As Boolean)	
	Log("ASFloatingActionButton1_ButtonClicked: " & open)
	'works only if you set a image as icon
'	If open = True Then
'		ASFloatingActionButton1.Base.GetView(1).SetRotationAnimated(250,135)
'	Else
'		ASFloatingActionButton1.Base.GetView(1).SetRotationAnimated(250,0)
'	End If

	If open = True Then
		ASFloatingActionButton1.ButtonIconText.SetRotationAnimated(250,135)
	Else
		ASFloatingActionButton1.ButtonIconText.SetRotationAnimated(250,0)
	End If
End Sub