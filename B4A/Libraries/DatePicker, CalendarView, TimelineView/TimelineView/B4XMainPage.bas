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
	Private ImageView1 As ImageView
	Private Panel1 As Panel
	Private Panel3 As Panel
	Private scrollLv As ScrollView
	Type TimelineItem(icon As B4XBitmap, title As String, des As String, approve As Boolean, time As Long, color as int)
	Private lblTitle As Label
	Private lblTime As Label
	Private lblContent As Label
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	'Dim bCircle As B4XBitmap=LoadBitmapResize(File.DirAssets,"circle.png", 20dip, 20dip, True)
	Dim bMeeting As B4XBitmap=LoadBitmapResize(File.DirAssets,"icons8-meeting-50.png", 20dip, 20dip, True)  
	Dim bRunning As B4XBitmap=LoadBitmapResize(File.DirAssets,"running.png", 20dip, 20dip, True)
	Dim bRound As B4XBitmap=LoadBitmapResize(File.DirAssets,"round.png", 20dip, 20dip, True)
	Dim bCircle As B4XBitmap=LoadBitmapResize(File.DirAssets,"circle.png", 20dip, 20dip, True)
	'Dim bC As BitmapCreator
	'bC.Initialize(ImageView1.Width, ImageView1.Height)
	'bC.DrawLine(5dip, 15dip, 5dip, bC.mHeight, xui.Color_Red, 1dip)
	
	'Dim rct As B4XRect
	'rct.Initialize(0dip, 0dip, 10dip, 10dip)
	
	'bC.DrawBitmap(bRunning, rct, True)
	
  ' bc.DrawCircle(10dip, 10dip, 5dip, xui.Color_Red, True, 1dip)
  
  	'Dim item_timeLine As TimelineBox
	'item_timeLine.Initialize(Me, "", Panel3.Width, Panel3.Height)
	
	'Panel3.AddView(item_timeLine.GetView, 0, 0, Panel3.Width, Panel3.Height)
	
	'ImageView1.Bitmap = bC.Bitmap
	
	Dim time_line_content As List
	time_line_content.Initialize
	
	Dim item As TimelineItem
	item.Initialize
	item.icon = bRound
	item.title = "Project Kickoff"
	item.des = "Meeting with stakeholders completed."
	item.approve = False
	item.time = DateTime.Now
	item.color = Colors.ARGB(255, 237, 247, 86)
	time_line_content.Add(item)

	Dim item As TimelineItem
	item.Initialize
	item.icon = bCircle
	item.title = "Design System Approval"
	item.des = "Final review of typography, color palette And compoment library."
	item.approve = True
	item.time = DateTime.Now + 3600000
	item.color = Colors.ARGB(255, 157, 249, 239)
	time_line_content.Add(item)

	Dim item As TimelineItem
	item.Initialize
	item.icon = bCircle
	item.title = "Alpha release"
	item.des = "Deployment To staging server."
	item.approve = False
	item.time = DateTime.Now + 4600000
	item.color = Colors.ARGB(255, 255, 246, 133)
	time_line_content.Add(item)

	Dim item As TimelineItem
	item.Initialize
	item.icon = bCircle
	item.title = "Testing And review"
	item.des = "Send project To teste team."
	item.approve = False
	item.time = DateTime.Now + 7600000
	item.color = Colors.ARGB(255, 0, 221, 255)
	time_line_content.Add(item)
	
	Dim box_height As Int = 90dip
	Dim positionY As Int = 0
		
	For i=0 To time_line_content.Size - 1
		Dim item1 As TimelineItem = time_line_content.Get(i)
		
		Dim boxTimeLine As TimelineBox
				
		If item1.approve = True Then
			box_height = 140dip
		Else		
			box_height = 90dip			
		End If
		
		boxTimeLine.Initialize(Me, "TimeLine", scrollLv.Width, box_height)
		scrollLv.Panel.AddView(boxTimeLine.GetView,0,positionY, scrollLv.Width, box_height)
		positionY = positionY + box_height
						
		boxTimeLine.Title = item1.title
		boxTimeLine.Time = DateTime.Time(item1.time)
		boxTimeLine.Description = item1.des		
		boxTimeLine.Bitmap = item1.icon
		boxTimeLine.Color = item1.color
		
		If item1.approve = False Then
			boxTimeLine.HideButton		
		End If
		
	Next
	scrollLv.Panel.Height = positionY
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	xui.MsgboxAsync("Hello world!", "B4X")
End Sub
