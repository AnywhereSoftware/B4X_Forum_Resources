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
	Private ime As IME
	
	Private BottomSheet1 As CustomBottomSheet
	Private Spinner1 As Spinner
	Private ImageView1 As ImageView
	Private ImageView2 As ImageView
	Private ivWithinPnl As ImageView
	Private edtAddress As EditText
	Private SwiftButton1 As SwiftButton		' from the XUI Views library
	Private pnlCircleIcon1 As B4XView	
	Private pnlCircleIcon2 As B4XView
	Private pnlSimBtnFav As B4XView
	Private lblFavIcon As B4XView

	Private const NORMAL_GRAY_COLOR As Int = 0xFFF0F0F0   ' Equivalente a xui.Color_RGB(240,240,240) Light gray
	Private const PRESSED_GRAY_COLOR As Int = 0xFFC8C8C8  ' Equivalente a xui.Color_RGB(200,200,200)
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Root.Color = xui.Color_ARGB(255, 255, 210, 195)

	' Wait for UI layout stabilization (prevents Root.Height from being 0)
	Sleep(0)

	BottomSheet1.Initialize(Root, Me, "BottomSheet1")
	BottomSheet1.Build(60%y, Array As Float(1, 0.55, 0.25))

	' Dynamic layout inflation inside the Custom BottomSheet container
	' In B4X, properties that start with "get" (such As getContentPanel) can be called directly by omitting the "get" (BottomSheet1.ContentPanel)
	BottomSheet1.ContentPanel.LoadLayout("LayoutA")
	
	' Open the panel at one of the positions (e.g., index 1)
	BottomSheet1.OpenAt(1)
	
	' Assigned via code. It can also be done from the Designer if the image is in assets
	ImageView1.Bitmap = LoadBitmapSample(File.DirAssets, "image.png", 60dip, 600dip)
	ImageView2.Bitmap = LoadBitmapSample(File.DirAssets, "image.png", 60dip, 600dip)
	ivWithinPnl.Bitmap = LoadBitmapSample(File.DirAssets, "image.png", 30dip, 300dip)
	
	Dim countries As List
	countries.Initialize2(Array As String("Chile", "Perú", "Ecuador"))
	Spinner1.AddAll(countries)
	
	ime.Initialize("")

	' 1. Custom simulated button setup (with icon)
	pnlSimBtnFav.SetColorAndBorder(xui.Color_RGB(240, 240, 240), 0, 0, 8dip)

	' 2. We design the internal LABEL (dark star icon with no background)
	lblFavIcon.Font = xui.CreateFontAwesome(18)
	lblFavIcon.Text = Chr(0xF005)				' It could also be done in the designer.
	lblFavIcon.TextColor = xui.Color_RGB(64, 64, 64)
	lblFavIcon.SetTextAlignment("CENTER", "CENTER")
	lblFavIcon.Color = xui.Color_Transparent 	' Transparent so that the background of the panel is visible
	
	
	pnlCircleIcon1.SetColorAndBorder(xui.Color_Transparent, 2dip, xui.Color_Black, pnlCircleIcon1.Width / 2)
	pnlCircleIcon2.SetColorAndBorder(xui.Color_Transparent, 2dip, xui.Color_Black, pnlCircleIcon2.Width / 2)
	
	' Used in the Designer: bici.png
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


' Centralized Touch Event Router for all internal elements inside LayoutA
Private Sub ViewsSheet_Touch (Action As Int, X As Float, Y As Float)
	Dim viewTouched As B4XView = Sender ' "Sender" nos dice exactamente qué vista causó el toque
	
	' Absolute Coordinate Bridge: Computes fixed screen position to bypass parent coordinate clipping
	' Calculate the actual finger position relative to the fixed screen
	' Add the panel height (Top), the button's position within the panel (Top), and the local touch position (Y)
	Dim AbsoluteY As Float = BottomSheet1.Top + viewTouched.Top + Y   ' (The class's `getTop` sub. It is the secret bridge connecting the main page to the inner workings of the class.)
	
	' It tells you if a touch is detected on the view.
'	If Action = 0 Then Log("¡Tocado: " & viewTouched.Tag & "!")
	
	' Diagnostic line
'	Log("-> EVENT TRIGGERED by: " & GetType(viewTouched) & " | Its Tag is: '" & viewTouched.Tag & "' | Action: " & Action)

	' --- ENGINE BLOCK: Update Physics and Drag State First --- Declared here
	Dim CleanClick As Boolean = BottomSheet1.ProcessSharedTouch(viewTouched, Action, AbsoluteY)


	' --- BLOCK 0: Native Interception for XUI Custom Views (SwiftButton) ---
	' We force the button's internal state to use its own drawing canvas
	If viewTouched.Tag = "pnlOverlapSwiftButton1" Then
		Dim joBtn As JavaObject = SwiftButton1	'ignore (I know the types don't match)
		
		Select Action
			Case 0 ' ACTION_DOWN:
				joBtn.SetField("_pressed", True) ' We activate the internal pressed state
				joBtn.RunMethod("_draw", Null)   ' We instruct it to redraw itself natively
                
			Case 2 ' ACTION_MOVE:
				' State Encapsulation: Synchronize button release with class drag threshold
				If BottomSheet1.IsDragging Then
					joBtn.SetField("_pressed", False) ' We remove the pressed state
					joBtn.RunMethod("_draw", Null)    ' We restore the original appearance
				End If
				
			Case 1, 3 ' ACTION_UP o ACTION_CANCEL:
				joBtn.SetField("_pressed", False)
				joBtn.RunMethod("_draw", Null)
		End Select
	End If

	
	' --- BLOCK 1: Dynamic Visual Feedback Control ---
	' TRACKING CONTROL: We avoid overloading Android
	Select Action
		Case 0 ' ACTION_DOWN:
		
			' We lower the opacity to 60% to lighten it
			If viewTouched.Tag = "pnlSimulatedButton" Then viewTouched.Alpha = 0.6
			
			If viewTouched.Tag = "pnlSimBtnFav" Then
				UIUtils.SetButtonState(viewTouched, True, NORMAL_GRAY_COLOR, PRESSED_GRAY_COLOR, 8dip)
			End If
			
			If viewTouched.Tag = "pnlSimBtnImgText" Then
				UIUtils.SetButtonState(viewTouched, True, NORMAL_GRAY_COLOR, PRESSED_GRAY_COLOR, 8dip)
			End If
				
		Case 2 ' ACTION_MOVE
			' Cancel pressed states instantly if the panel begins a physical drag gesture
			If BottomSheet1.IsDragging Then
			
				If viewTouched.Tag = "pnlSimulatedButton" Then viewTouched.Alpha = 1.0
				
				' Si arrastra, cancelamos el efecto y vuelve a su gris claro original
				If viewTouched.Tag = "pnlSimBtnFav" Or viewTouched.Tag = "pnlSimBtnImgText" Then
					UIUtils.SetButtonState(viewTouched, False, NORMAL_GRAY_COLOR, PRESSED_GRAY_COLOR, 8dip)
				End If
			End If
		
		Case 1, 3 ' ACTION_UP o ACTION_CANCEL
			If viewTouched.Tag = "pnlSimulatedButton" Then viewTouched.Alpha = 1.0
			
			If viewTouched.Tag = "pnlSimBtnFav" Or viewTouched.Tag = "pnlSimBtnImgText" Then
				UIUtils.SetButtonState(viewTouched, False, NORMAL_GRAY_COLOR, PRESSED_GRAY_COLOR, 8dip)
			End If
	End Select
	
	

	
	' --- BLOCK 3: Real Click Management ---
	' If the user did NOT drag but instead performed a quick tap, we identify what was pressed
	If CleanClick Then
		' We redirect the action based on the common Tag we assigned to it in the Designer
		Select viewTouched.Tag
			Case "pnlBaseTitle":      Log("Click: pnlBaseTitle")
			Case "pnlOverlapLvlText": Log("Click: pnlOverlapLvlText")
			Case "pnlAction1":        Log("Click: pnlAction1")
			Case "ImageView1":        Log("Click: ImageView1")
			Case "Spinner1":          Log("Click: Spinner1")
			Case "pnlOverlapIv1":     Log("Click: pnlOverlapIv1")
			Case "pnlBaseIv2":        Log("Click: pnlBaseIv2")
				
			Case "pnlOverlapEdtAddress"
				
				BottomSheet1.OpenAt(0) ' Fully expand panel via code API
				Sleep(300)             ' Allow snapping animation to complete gracefully
				edtAddress.RequestFocus
				ime.ShowKeyboard(edtAddress)
				
			Case "pnlSimulatedButton": Log("Click: pnlSimulatedButton")
				
			Case "pnlOverlapSpinner1"
'				Log("Clicked the Spinner panel! Forcing it to open...")
			
				' We force the native Spinner to open its dropdown
				Dim jo As JavaObject = Spinner1
				jo.RunMethod("performClick", Null)

			Case "pnlOverlapSwiftButton1"
'				Log("Click on SwiftButton detected!")
				SwiftButton1_Click
				
			Case "pnlSimBtnFav"
'				Log("Click the Favorites button!")
				pnlSimBtnFav_Click
				
			Case "pnlSimBtnImgText":       Log("Click: pnlSimBtnImgText")
			Case "pnlBaseIvTextCircle":    Log("Click: pnlBaseIvTextCircle")
			Case "pnlBaseLblTextCircle":   Log("Click: pnlBaseLblTextCircle")
		End Select
	End If
End Sub


' Callback invoked exclusively once per gesture by the custom sheet core
Private Sub BottomSheet1_HidingKeyboard
	' Soft-reset input focus state to clear Android's persistent native blue caret cursor
	edtAddress.Enabled = False
	edtAddress.Enabled = True
End Sub

Private Sub BottomSheet1_StateChanged(Index As Int)
	Log("BottomSheet snapped to anchor index: " & Index)
End Sub



' ------------ INDEPENDENT VIEW EVENTS ------------

Private Sub Button1_Click		' Outside the CustomBottomSheet
	xui.MsgboxAsync("Button1 Click", "B4X")
End Sub

Private Sub edtAddress_TextChanged (Old As String, New As String)
	Log("Address input: " & New)
End Sub

Private Sub Spinner1_ItemClick (Position As Int, Value As Object)
	Log("Selected country: " & Value)
	ToastMessageShow("Selected country: " & Value, False)
End Sub

Private Sub SwiftButton1_Click
	Log("Executing search routine...")
End Sub

Private Sub pnlSimBtnFav_Click
	Log("Executing bookmarks routine...")
End Sub