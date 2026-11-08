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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=MembershipProject.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Dim pgAdd As actAdd
	Dim pgDashboard As actDashboard
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	#if b4j
	xui.SetDataFolder("Membership")
	#End If

	
	pgAdd.Initialize
	B4XPages.AddPageAndCreate("idAdd",pgAdd)
	
	pgDashboard.Initialize
	B4XPages.AddPage("idDash",pgDashboard)
	
	initializeDB
	
	Sleep(3000)
	
	
	B4XPages.ShowPage("idDash")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.



Sub initializeDB
	If File.Exists(xui.DefaultFolder,"membership.db") = False Then
		File.Copy(File.DirAssets,"membership.db",xui.DefaultFolder,"membership.db")
		Log("New DB copied")
	End If
	
	If Main.sql.IsInitialized = False Then
		#if B4J
		Main.sql.InitializeSQLite(xui.DefaultFolder,"membership.db",True)
		#Else
		Main.sql.Initialize(xui.DefaultFolder,"membership.db",True)
		#End If
		
		Log("DB Started")
	End If
	
End Sub