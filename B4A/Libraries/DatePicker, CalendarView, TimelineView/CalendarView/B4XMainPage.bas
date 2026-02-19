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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

		
	Private Button1 As Button
	

	Private CalendarView1 As CalendarView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	
	'CalendarBox1.AddEvent(Colors.ARGB(255,37, 150, 190), "Buy cookies", DateTime.Now)
	'CalendarBox1.AddEvent(Colors.ARGB(255,84, 119, 146), "Buy books", DateTime.Now)
	'CalendarBox1.AddEvent(Colors.ARGB(255,250, 185, 91), "Buy cards", DateTime.Now)
		
	Dim bAirplane As B4XBitmap=LoadBitmapResize(File.DirAssets,"airplane.png", 20dip, 20dip, True)  'resizes the image
	Dim bMeeting As B4XBitmap=LoadBitmapResize(File.DirAssets,"hangouts-meet.png", 20dip, 20dip, True)  'resizes the image
	Dim bTeam As B4XBitmap=LoadBitmapResize(File.DirAssets,"team.png", 20dip, 20dip, True)  'resizes the image
	'CalendarBox2.BitMap = b
	Log(DateTime.Now)
	
	
	
	'DrawCalendar(DateTime.Now)
	
	Dim color1 As Int = Colors.ARGB(255,91, 35, 255)
	Dim color2 As Int = Colors.ARGB(255,0, 139, 255)
	Dim color3 As Int = Colors.ARGB(255,228, 255, 48)
	Dim color4 As Int = Colors.ARGB(255,54, 47, 79)
	Dim color5 As Int = Colors.ARGB(255, 246, 48, 73)
	
	Dim color6 As Int = Colors.ARGB(255,251, 239, 118)
	Dim color7 As Int = Colors.ARGB(255, 254, 194, 136)
	Dim color8 As Int = Colors.ARGB(255, 250, 92, 92)
			
	CalendarView1.AddBitmap(DateTime.Now, bAirplane)
	CalendarView1.AddBitmap(DateTime.DateParse("4/13/2026"), bMeeting)
	CalendarView1.AddBitmap(DateTime.DateParse("4/24/2026"), bTeam)
	
	CalendarView1.DrawCalendar(DateTime.DateParse("4/1/2026"))
	
	
	CalendarView1.AddEvent(color1, "Add event", DateTime.DateParse("4/21/2026"))
	CalendarView1.AddEvent(color2, "Add event", DateTime.DateParse("4/21/2026"))
	CalendarView1.AddEvent(color3, "Add event", DateTime.DateParse("4/21/2026"))
	
	CalendarView1.AddEvent(color5, "Add event", DateTime.DateParse("4/15/2026"))
	
	CalendarView1.AddEvent(color6, "Add event", DateTime.DateParse("4/4/2026"))
	CalendarView1.AddEvent(color7, "Add event", DateTime.DateParse("4/4/2026"))
	
End Sub

Sub CalendarView1_ItemClick(date As Long)
	Log("--------------")
	Log(date)
End Sub