B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=11.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
	
	'Required for all activities that use AppCompat
	#Extends: android.support.v7.app.AppCompatActivity
#End Region

Sub Process_Globals

	Public lstScales As List
	Private currentIndexSlidingPanel As Int
End Sub


Sub Globals
	
	Private ACToolBarDark1 As ACToolBarDark		'ToolBarDark so that the icon of Navigation Item is white (back arrow)
	Dim ABHelper As ACActionBar					'AppCompat library
	
	Dim SlidPan1 As SlidingPanels				'SlidingPanels class
	Dim ScaleImageView1 As ScaleImageView		'ScaleImageView library
	Dim itemDelete As ACMenuItem				'AppCompat library
	Private NumItems As Int
End Sub


Sub Activity_Create(FirstTime As Boolean)
	
	Activity.LoadLayout("LayoutAppCompat")
	ACToolBarDark1.SetAsActionBar
	ACToolBarDark1.InitMenuListener		'For the ACToolBarDark1_NavigationItemClick and for the Sub ActionBar_MenuItemClick
	
	ABHelper.Initialize
	ABHelper.ShowUpIndicator = True
	
	ToolBarColor
	
	
	If FirstTime Then lstScales.Initialize
	
	'When you come back here. The scales change when the device is rotated
	lstScales.Clear

	NumItems = Main.lstFilenames.Size

	For i = 0 To NumItems - 1
		lstScales.Add(0.0)
	Next


	PaintSlidingPanels
End Sub


Sub Activity_Resume
	
	If SlidPan1.IsInitialized And currentIndexSlidingPanel <> 0 Then		
		SlidPan1.JumpToPanel(currentIndexSlidingPanel, 0, 0)
	End If
	

	If SlidPan1.IsInitialized Then
		
	'	ProgressDialogShow2("In progress", False)
	'	Sleep(0)
		
		Dim siv2 As ScaleImageView = SlidPan1.Panels(currentIndexSlidingPanel).GetView(0)
		
		'Necessary
		Do Until siv2.IsReady
			Log("Not yet")
'			Log(siv2.IsReady)
			Sleep(0)	'So it doesn't overload the app or freeze the UI.
		Loop
		
		'We convert it to float to make sure so that later it does not fail with the number of decimals
		Private scale As Float = siv2.Scale
		
		'On my Android 6.1 device sometimes it is 0 and sometimes 0.0
		If lstScales.Get(currentIndexSlidingPanel) = 0.0 Or lstScales.Get(currentIndexSlidingPanel) = 0 Then lstScales.Set(currentIndexSlidingPanel,scale)		'More new
		
		Log(lstScales)
		
'		ProgressDialogHide
	End If
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Sub Activity_KeyPress (KeyCode As Int) As Boolean 		'return true if you want to consume the event
	
	If KeyCode = KeyCodes.KEYCODE_BACK Then
'		If Msgbox2("Do you want to close?", "", "Yes", "Cancel", "No", Null) = DialogResponse.POSITIVE Then

'		To start at position 0 when returning to this activity
		currentIndexSlidingPanel = 0
		Activity.Finish
	End If
	
	Return True
End Sub


Sub Activity_CreateMenu(Menu As ACMenu)
	
	Dim item As ACMenuItem					'AppCompat library
	Dim xml As XmlLayoutBuilder				'XmlLayoutBuilder library
	
	Menu.Clear
'	Menu.Add(0, 0, "Overflow1", Null)
'	Menu.Add(0, 0, "Overflow2", Null)
'	Menu.Add(0, 0, "Overflow3", Null)

	If NumItems > 1 Then
		itemDelete = ACToolBarDark1.Menu.Add2(10, 1, "Delete", xml.GetDrawable("baseline_delete_white_24"))
		itemDelete.ShowAsAction = itemDelete.SHOW_AS_ACTION_ALWAYS
	End If
	
	item = ACToolBarDark1.Menu.Add2(10, 1, "CropAndRotate", xml.GetDrawable("baseline_crop_rotate_white_24"))
	item.ShowAsAction = item.SHOW_AS_ACTION_ALWAYS
End Sub


Sub ACToolBarDark1_MenuItemClick (Item As ACMenuItem)
	
	Log("Clicked: " & Item.Title)

	If Item.Title = "Delete" And ScaleImageView1.IsInitialized Then
'		Msgbox2Async("Do you want to remove the selected image from the selection list?", "Title", "Yes", "", "No", Null, False)
'		Wait For Msgbox_Result (result As Int)
'		If result = DialogResponse.NEGATIVE Then Return

		RemoveImage
	End If
	
'	It remains to create the panel that overlaps and with which we can rotate and cut the selected image with https://www.b4x.com/android/forum/threads/b4x-xui-xresizeandcrop.100109/#content
	If Item.Title = "CropAndRotate" And ScaleImageView1.IsInitialized Then ToastMessageShow("Function not available in this example", True)
	
End Sub


#If Java

public boolean _onCreateOptionsMenu(android.view.Menu menu) {
    if (processBA.subExists("activity_createmenu")) {
        processBA.raiseEvent2(null, true, "activity_createmenu", false, new de.amberhome.objects.appcompat.ACMenuWrapper(menu));
        return true;
    }
    else
        return false;
}
#End If


Private Sub ACToolBarDark1_NavigationItemClick
	
	'To start at position 0 when returning to this activity
	currentIndexSlidingPanel = 0
	Activity.Finish
End Sub


Sub ToolBarColor
	
	Dim ac As AppCompat
	
	If Activity.Width > Activity.Height Then
		'Change the color of the ToolBar
		ACToolBarDark1.Color = Colors.ARGB(60, 0,0,0)
	Else
		ACToolBarDark1.Color = ac.GetThemeAttribute("colorPrimary")
	End If
End Sub


Sub PaintSlidingPanels
	
	Private FileName As String
	
	SlidPan1.Initialize("SlidPan1", 300, Activity, Me, False,lstScales)		'Initialize the Class
	SlidPan1.ModeFullScreen(NumItems, False)								'Creates the mode of SlidingPanels
	
	
	'---Add elements to Panels---
'	Dim c As Int
	For c = 0 To SlidPan1.panels.Length-1	'NumItems - 1		'Main.lstFilenames.Size - 1
		
'		SlidPan1.panels(c).Color = Colors.RGB(Rnd(0,256),Rnd(0,256),Rnd(0,256))	
		SlidPan1.panels(c).LoadLayout("LayoutViewer")

		ScaleImageView1.PanLimit = ScaleImageView1.PAN_LIMIT_INSIDE			'It does not allow dragging the image around the screen
		ScaleImageView1.Tag = c

		FileName = Main.lstFilenames.Get(c)
		Log(FileName)
		
		ScaleImageView1.BringToFront
		ScaleImageView1.DoubleTapZoomDuration = 250
		ScaleImageView1.Orientation = ScaleImageView1.ORIENTATION_USE_EXIF
'		ScaleImageView1.Image = bmp		'Crashing in this version?
		ScaleImageView1.ImageFile = Main.ImagesFolder & "/" & FileName		'Does not read from DirAssets
		ScaleImageView1.EnableCircle = False


'		Log(ScaleImageView1.Scale)		'It always gives zero here	:(
		
'		Dim siv As ScaleImageView = SlidPan1.Panels(c).GetView(0)		'It always gives zero here	:(
'		Log("siv.Scale = " & siv.Scale)
		
		
		'We paint the indicator triangles:
		If Activity.Width < Activity.Height Then
			If c <> SlidPan1.panels.Length-1 Then DrawEquilateralTriangle (SlidPan1.panels(c), SlidPan1.panels(c).Width - 50dip, SlidPan1.panels(c).Height - 28dip, 25dip, Colors.Black, 3)
			If c <> 0 Then DrawEquilateralTriangle (SlidPan1.panels(c), 25dip, SlidPan1.panels(c).Height - 53dip, 25dip, Colors.Black, 1)
		Else
			If c <> SlidPan1.panels.Length-1 Then DrawEquilateralTriangle (SlidPan1.panels(c), SlidPan1.panels(c).Width - 35dip, SlidPan1.panels(c).Height / 2 - 15dip, 25dip, Colors.Black, 3)
			If c <> 0 Then DrawEquilateralTriangle (SlidPan1.panels(c), 10dip, SlidPan1.panels(c).Height / 2 - 38dip, 25dip, Colors.Black, 1)
		End If
	Next
	
	SlidPan1.Start(0) 'Start the SlidingPanels
End Sub


Sub DrawEquilateralTriangle (view As Object, x1 As Int, y1 As Int, size As Int, color As Int, direction As Int)
	
	Dim cnv As Canvas
	cnv.Initialize(view)
	Dim p As Path
	p.Initialize(x1, y1)
	
	Select direction
		Case 0	'UP
			
			p.LineTo(x1 + size, y1 + size)
			p.LineTo(x1 - size, y1 + size)
			
		Case 1	'RIGHT
			
			p.LineTo(x1 + size, y1 + size)
			p.LineTo(x1, y1 + (size * 2))
			
		Case 2	'DOWN
			
			p.LineTo(x1 + (size * 2), y1)
			p.LineTo(x1 + size, y1 + size)
			
		Case 3	'LEFT
			
			p.LineTo(x1 + size, y1 + size)
			p.LineTo(x1 + size, y1 - size)

	End Select
	
	cnv.ClipPath(p)
	cnv.DrawColor(color)
	cnv.RemoveClip
End Sub


Sub RemoveImage
	
	NumItems = NumItems - 1
	If NumItems = 1 Then itemDelete.Visible = False

	
	For Each p As Panel In SlidPan1.Panels
		p.RemoveView
	Next
	

	'And we extract their values ​​from the two lists by their index
	Main.lstFilenames.RemoveAt(currentIndexSlidingPanel)
	lstScales.RemoveAt(currentIndexSlidingPanel)

	
	'And delete the image from the folder?
	
	PaintSlidingPanels
	
	
	'We control which panel it goes to
	If SlidPan1.Panels.Length > 1 Then
		If currentIndexSlidingPanel = 0 Then
'			currentIndexSlidingPanel = currentIndexSlidingPanel
		Else
			currentIndexSlidingPanel = currentIndexSlidingPanel - 1
		End If
	End If


	SlidPan1.JumpToPanel(currentIndexSlidingPanel, 0, 0)
End Sub


Sub SlidPan1_Click (TouchData As TouchData)
	
	ToastMessageShow("Clicked on Panel: "&TouchData.Tag&" / X: "&TouchData.X&" / Y: "&TouchData.Y,False)
	Dim siv As ScaleImageView = SlidPan1.Panels(TouchData.Tag).GetView(0)

	Log("siv.Scale on SlidPan1_Click = " & siv.Scale)
	LogColor(lstScales, Colors.Blue)
End Sub


Sub SlidPan1_LongClick (TouchData As TouchData)
	
	ToastMessageShow("LongClick on Panel n°: "&TouchData.Tag&" / X: "&TouchData.X&" / Y: "&TouchData.Y,False)
End Sub


Sub SlidPan1_Change (cp As Int)

	currentIndexSlidingPanel = cp

	Dim siv3 As ScaleImageView = SlidPan1.Panels(cp).GetView(0)
	
	Do Until siv3.IsReady
		Log("Not yet")
'		Log(siv3.IsReady)
		Sleep(0)		'So it doesn't overload the app or freeze the UI.
	Loop
	
	'We convert it to float to make sure so that later it does not fail with the number of decimals
	Private scale As Float = siv3.Scale
	
	'On my Android 6.1 device sometimes it is 0 and sometimes 0.0
	If lstScales.Get(currentIndexSlidingPanel) = 0.0 Or lstScales.Get(currentIndexSlidingPanel) = 0 Then lstScales.Set(cp, scale)		'More new
	Sleep(0)
	
	Log(lstScales)
End Sub