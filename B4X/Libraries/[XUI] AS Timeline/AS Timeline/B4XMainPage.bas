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
	Private AS_Timeline1 As AS_Timeline
	Private xlbl_SelectedValue As B4XView
	Private xlbl_Title As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	B4XPages.SetTitle(Me,"AS Timeline Example")
	
	xlbl_Title.Text = "Notable inventions, 1910–2000"
	
	AS_Timeline1.AddItem("1910","headset","And future Call of Duty players would thank them.")
	AS_Timeline1.AddItem("1920","jungle gym","Because every kid should get to be Tarzan for a day.")
	AS_Timeline1.AddItem("1930","chocolate chip cookie","And the world rejoiced.")
	AS_Timeline1.AddItem("1940","Jeep","Because building roads is inconvenient.")
	AS_Timeline1.AddItem("1950","leaf blower","Ain’t nobody got time to rake.")
	AS_Timeline1.AddItem("1960","magnetic stripe card","Because paper currency is for noobs.")
	AS_Timeline1.AddItem("1970","wireless LAN","Nobody likes cords. Nobody.")
	AS_Timeline1.AddItem("1980","flash memory","Brighter than glow memory.")
	AS_Timeline1.AddItem("1990","World Wide Web","To capitalize on an as-yet nascent market for cat photos.")
	AS_Timeline1.AddItem("2000","Google AdWords","Because organic search rankings take work.")
	
	AS_Timeline1.CreateTimeline
	
End Sub

Private Sub AS_Timeline1_SelectionChanged(Item As AS_Timeline_Item)
	xlbl_SelectedValue.Text = Item.Value
End Sub
