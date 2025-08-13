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
	Dim d As UIDrawerMenu
	Dim tbar As UITitleBar
	Dim load As UILoadingIndicator

End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1

	'Initialize the drawer component with the following parameters:
	' - Me: The current activity
	' - "Drawer": The name of the drawer component
	' - Activity: The current activity
	' - 85%x: The width of the drawer
	' - 25%y: The height of the drawer
	' - xui.Color_White: The background color of the drawer
	D.Initialize(Me, "Drawer", Root, 85%x,25%y,xui.Color_White)

	menu

	'Initialize the iconfont, valsend, valcontacts, valgroup, and valtemplates components.
	tbar.Initialize(d.CenterPanel,xui.Color_RGB(99, 160, 180),xui.Color_RGB(99, 160, 180),xui.CreateFontAwesome(32),Chr(0xF039),True,"DailyTaskMaster",xui.CreateDefaultBoldFont(20),Colors.White,10,Me)
	
	' example: designer and code to add theUILoadingIndicator view, color, size etc. can be changed in both
	' this layout has all the UILoadingIndicator as views added in designer
	' also has UIButton
	' the bounching UILoadingIndicator is added by code below
	d.Centerpanel.LoadLayout("MainPage")

	load.Initialize("", "")
	load.AddToParent(d.Centerpanel,100,500,200,200,Colors.Red,"BouncingBall",500)
	Sleep(1000)

End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Sub menu
	' This sub creates the main menu of the application.
	d.addpanel_title( Colors.Green,xui.LoadBitmap(File.DirAssets, "BULK-SMS.png"),"BULK SMS", xui.CreateDefaultBoldFont(16) ,16,Colors.RGB(245, 227, 179))
	' Adds menu items to the main menu.
	d.AddMenuImageItem("SendSms",File.DirAssets, "icons8_paper_plane_480px.png","Send sms",xui.Color_DarkGray,"Send bulk SMS to your group contacts",xui.Color_Gray)
	d.AddMenuImageItem("TemplatesApp",File.DirAssets, "icons8_messaging_480px_1.png","Templates",xui.Color_DarkGray,"Create and manage sms templates for your mailings",xui.Color_Gray)
	d.AddMenuImageItem("ContactApp",File.DirAssets, "address-book@512px.png","Contacts",xui.Color_DarkGray,"Manage, add and delete your contacts",xui.Color_Gray)
	d.AddMenuImageItem("GroupApp",File.DirAssets, "united.png","Groups",xui.Color_DarkGray,"Manage, add and remove your contact  groups",xui.Color_Gray)
	d.AddMenuImageItem("AboutApp",File.DirAssets, "icons8_info_480px.png","About",xui.Color_DarkGray,"information about the app",xui.Color_Gray)
	d.AddMenuImageItem("ExitApp",File.DirAssets, "icons8_close_window_480px.png","Close",xui.Color_DarkGray,"Exit the application",xui.Color_Gray)
End Sub

Private Sub TitleBarClicked
	If d.OpenMenu = True Then
		d.OpenMenu = False
	else if  d.OpenMenu = False Then
		d.OpenMenu = True
	End If
End Sub

Private Sub UIButton1_Click
	Dim act As PageLoadingFinished
 
'	Initialize the PageLoadingFinished instance.
	act.Initialize(Root,Me,xui.Color_RGB(192, 157, 133))
	
	' Start the animation.
	act.Start_Animation
	
	' Add the title image and title text to the animation.
	act.Add_TitleImage(File.DirAssets,"address-book@512px.png","Contacts",xui.Color_White)
	
	' Add the second page to the animation.
	act.Add_SecondPage(contacts_activity,4000)
	
End Sub
