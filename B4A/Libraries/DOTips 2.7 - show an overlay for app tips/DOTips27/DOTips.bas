B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class Module: DOTips
'Author:	Dave O'Brien (dmnobrien@gmail.com)
'Code version: 2.7
'Last updated: 29 Nov 2022
'- Fixed crash on showing tips for views on certain versions of Android (e.g. Android 11 Go Edition)

'To do:
'- replace user-visible strings with CSBuilder (as Object parameter externally)?

'Requires the following internal (and free) B4A libraries (see the B4A site for these):
'- JavaObject
'- StringUtils
'- Accessibility

'To add tips to an activity:
'- Add this class module to your B4A project.
'- In the Libraries Manager, make sure the libraries listed above are ticked.
'- In the activity's Sub Globals, add "Dim tips As DOTips".
'- In the activity's Activity_Create, add "tips.Initialize(Me, Activity, "tips")".
'- In the activity_KeyPress sub, handle the Back button when the tips are visible:
'		If KeyCode = KeyCodes.KEYCODE_BACK Then
'			If (tips.Visible = True) And (tips.CanSkip) Then
'				tips.hide(true)
'				Return True
'			else...
'- Where you want to show tips, add them to the tips list and call Show:
'		tips.addGeneralTip("Insert title here", "Insert description here")
'		tips.addPictureTip("picture.png", "Insert description here")
'		tips.addTipForView(someView, "Insert title here", "Insert description here")
'		tips.addTipForArea(someRect, someScrollview, "Insert title here", "Insert description here")
'		tips.show
'- To customize tips, set the properties you want first. All tips you add after that will use those settings.
'		tips.HighlightColor = Colors.Magenta
'		tips.LandscapePosition = POSITION_LEFT
'		tips.addTipForView(someView, "Insert title here", "Insert description here")
'- To trigger something after the tips are closed, use the OnHide event (e.g. "sub tips_OnHide").
'- To resume tips after orientation changes, use GetIndexOfCurrentTip and Resume - see the demo code.
'- Normally users can skip tips. If you want to hide the Skip All button, set canSkip to false.

'sample signature: sub tips_OnHide(tipsSkipped as int)
'...where tipsSkipped is the # of tips that the user skipped (i.e. didn't see)

#Event: OnHide(tipsSkipped as int)

Private Sub Class_Globals
	Type tipSettings(target As Int, targetView As View, targetRect As Rect, targetSV As ScrollView, _
		title As String, description As String, backgroundColor As Int, maskColor As Int, _
		highlightColor As Int, highlightRadius As Int, highlightWidth As Int, _
		highlightPadding As Int, descColor As Int, titleSize As Int, descSize As Int, _
		skipText As String, nextButtonColor As Int, nextButtonTextColor As Int, nextText As String, _
		doneText As String, portraitPosition As Int, portraitAlign As Int, _
		landscapePosition As Int, landscapeAlign As Int, spacer As Int, picName As String, _
		canSkip As Boolean, elevation As Int)

	'public constants
	Public Const POSITION_AUTO As Int = 0
	Public Const POSITION_ABOVE As Int = 1
	Public Const POSITION_BELOW As Int = 2
	Public Const POSITION_LEFT As Int = 3
	Public Const POSITION_RIGHT As Int = 4
	
	Public Const ALIGN_AUTO As Int = 0
	Public Const ALIGN_LEFT As Int = 1
	Public Const ALIGN_CENTER As Int = 2
	Public Const ALIGN_RIGHT As Int = 3
	
	Public Const DEFAULT_BACKGROUND_COLOR As Int = Colors.ARGB(170, 0, 0, 0)		'semi-transparent black
	Public Const DEFAULT_MASK_ALPHA As Int = 100
	Public Const DEFAULT_HIGHLIGHT_COLOR As Int = Colors.Green
	Public Const DEFAULT_HIGHLIGHT_RADIUS As Int = 40dip
	Public Const DEFAULT_HIGHLIGHT_WIDTH As Int = 10dip
	Public Const DEFAULT_HIGHLIGHT_PADDING As Int = 20dip
	Public Const DEFAULT_TITLE_SIZE As Int = 30
	Public Const DEFAULT_DESC_SIZE As Int = 20
	Public Const DEFAULT_DESC_COLOR As Int = Colors.white
	Public Const DEFAULT_SKIP_TEXT As String = "Skip All"
	Public Const DEFAULT_NEXT_TEXT As String = "Next"
	Public Const DEFAULT_NEXT_BUTTON_COLOR As Int = Colors.Gray
	Public Const DEFAULT_NEXT_BUTTON_TEXT_COLOR As Int  = Colors.White
	Public Const DEFAULT_DONE_TEXT As String = "Done"
	Public Const DEFAULT_BUTTON_TEXT_SIZE As Int = 20
	Public Const DEFAULT_PORTRAIT_POSITION As Int = POSITION_AUTO
	Public Const DEFAULT_PORTRAIT_ALIGN As Int = ALIGN_AUTO
	Public Const DEFAULT_LANDSCAPE_POSITION As Int = POSITION_AUTO
	Public Const DEFAULT_LANDSCAPE_ALIGN As Int = ALIGN_AUTO
	Public Const DEFAULT_SPACER As Int = 10dip
	Public const DEFAULT_CAN_SKIP As Boolean = True
	Public const DEFAULT_ELEVATION As Int = 20
	
	'private constants
	Private Const ORIENTATION_LANDSCAPE As Int = 0		'same as in Phone library
	Private Const ORIENTATION_PORTRAIT As Int = 1
	
	Private Const TARGET_VIEW As Int = 1
	Private Const TARGET_RECT As Int = 2
	Private Const TARGET_GENERAL As Int = 3
	Private Const TARGET_PICTURE As Int = 4
	
	Private const ASPECT_TALL As Int = 1
	Private const ASPECT_SQUARE As Int = 2
	Private const ASPECT_WIDE As Int = 3
	
	Private const DURATION_FADE As Int = 500				'milliseconds

	'variables
	Private tipList As List
	Private currentOrientation As Int
	Private maskFollowsBackground As Boolean = True			'mask defaults to same color (different alpha) as background
	Private tip As tipSettings
	Private callbackObject As Object
	Private eventName As String
	Private fontScale, systemFontScale As Float
	Private tipBitmap As Bitmap
	Private startingTotal As Int

	Private internalBackgroundColor As Int = DEFAULT_BACKGROUND_COLOR
	Private internalMaskColor As Int
	Private internalHighlightColor As Int = DEFAULT_HIGHLIGHT_COLOR
	Private internalHighlightRadius As Int = DEFAULT_HIGHLIGHT_RADIUS
	Private internalHighlightWidth As Int = DEFAULT_HIGHLIGHT_WIDTH
	Private internalHighlightPadding As Int = DEFAULT_HIGHLIGHT_PADDING
	Private internalDescriptionColor As Int = DEFAULT_DESC_COLOR
	Private internalSkipText As String = DEFAULT_SKIP_TEXT
	Private internalNextText As String = DEFAULT_NEXT_TEXT
	Private internalNextButtonColor As Int = DEFAULT_NEXT_BUTTON_COLOR
	Private internalNextButtonTextColor As Int = DEFAULT_NEXT_BUTTON_TEXT_COLOR
	Private internalDoneText As String = DEFAULT_DONE_TEXT
	Private internalTitleSize As Int = DEFAULT_TITLE_SIZE
	Private internalDescSize As Int = DEFAULT_DESC_SIZE
	Private internalPortraitPosition As Int = DEFAULT_PORTRAIT_POSITION
	Private internalPortraitAlign As Int = DEFAULT_PORTRAIT_ALIGN
	Private internalLandscapePosition As Int = DEFAULT_LANDSCAPE_POSITION
	Private internalLandscapeAlign As Int = DEFAULT_LANDSCAPE_ALIGN
	Private internalSpacer As Int = DEFAULT_SPACER
	Private internalCanSkip As Boolean = DEFAULT_CAN_SKIP
	Private internalElevation As Int = DEFAULT_ELEVATION 

	'views
	Private tipsPanel, tipsContentPanel As Panel
	Private tipsTitleLabel As Label
	Private tipsDescLabel As Label
	Private tipsNextButton As Button
	Private tipsSkipButton As Button
	Private tipsPicture As ImageView
	Private tipActivity As Activity
End Sub

'Initializes the object.
'objectArg is the calling module (usually Me).
'activityArg is the activity that will be overlaid by the tip (e.g. Activity).
'eventPrefixArg is the prefix for event handlers (e.g. "tips" means you can write a "tips_OnHide" sub).
Public Sub Initialize(objectArg As Object, activityArg As Activity, eventPrefixArg As String)
	callbackObject = objectArg
	tipActivity = activityArg
	eventName = eventPrefixArg
	resetSettings
	addControls
	tipList.Initialize
	fontScale = GetDeviceLayoutValues.ApproximateScreenSize / 4.5		'adjust compared to Note 3
'	Log("fontScale = " & fontScale)
	Dim access As Accessibility
'	Log("access.GetUserFontScale = " & access.GetUserFontScale)
	'system font size - ignore small fonts, reduce the scaling of large fonts
	systemFontScale = ((Max(access.GetUserFontScale, 1) - 1) * 1.1) + 1
'	Log("systemFontScale = " & systemFontScale)
End Sub

Private Sub addControls
	tipsPanel.Initialize("tipsPanel")
	tipActivity.AddView(tipsPanel, 0, 0, tipActivity.Width, tipActivity.Height)
	tipsPanel.Visible = False
	tipsPanel.Elevation = DEFAULT_ELEVATION

	tipsContentPanel.Initialize("tipsContentPanel")
	tipsPanel.AddView(tipsContentPanel, 0, 0, tipsPanel.Width, tipsPanel.Height)
	tipsContentPanel.Color = Colors.Transparent
	
	tipsTitleLabel.Initialize("tipsTitleLabel")
	tipsContentPanel.AddView(tipsTitleLabel, DEFAULT_SPACER, DEFAULT_SPACER, tipsContentPanel.width - DEFAULT_SPACER*2, 50dip)
	tipsTitleLabel.Typeface = Typeface.DEFAULT_BOLD
	
	tipsPicture.Initialize("tipsPicture")
	tipsContentPanel.AddView(tipsPicture, DEFAULT_SPACER, DEFAULT_SPACER, tipsContentPanel.width - DEFAULT_SPACER*2, tipsContentPanel.height - (80dip + DEFAULT_SPACER*2))
	
	tipsDescLabel.Initialize("tipsDescLabel")
	tipsContentPanel.AddView(tipsDescLabel, DEFAULT_SPACER, tipsTitleLabel.Top + tipsTitleLabel.Height, tipsTitleLabel.width, 80dip)
	tipsDescLabel.Typeface = Typeface.DEFAULT
	
	tipsSkipButton.Initialize("tipsSkipButton")
	tipsContentPanel.AddView(tipsSkipButton, DEFAULT_SPACER, tipsDescLabel.Top + tipsDescLabel.Height + DEFAULT_SPACER, 120dip, 50dip)
	
	tipsNextButton.Initialize("tipsNextButton")
	tipsContentPanel.AddView(tipsNextButton, tipsSkipButton.Left + tipsSkipButton.Width + DEFAULT_SPACER, tipsSkipButton.top, 120dip, 50dip)
	
	If tip.target <> TARGET_PICTURE Then
		tipsContentPanel.Height = tipsSkipButton.Top + tipsSkipButton.Height + DEFAULT_SPACER*2
	End If
End Sub

'Add a view tip to the list of tips to show.
'The tip will highlight the supplied view.
'The tip will be displayed with the settings in effect when it was added.
'If the view is not visible when the tips are shown, the tip for that view will be skipped.
'viewArg = the view to highlight
'titleArg = the title of the tip
'descArg = the text description
Public Sub addTipForView(viewArg As View, titleArg As String, descArg As String)
	Dim tempItem As tipSettings
	tempItem.Initialize
	tempItem.target = TARGET_VIEW
	tempItem.targetView = viewArg
	tempItem.targetRect = Null
'	tempItem.targetSV.Initialize(0)
	tempItem.targetSV = Null
	tempItem.picName = ""
	getRemainingProperties(tempItem, titleArg, descArg, "")
	tipList.Add(tempItem)
End Sub

'Add an area tip to the list of tips to show.
'The tip will highlight the given rectangular area.
'Use this when you want to highlight something that is not a single view.
'The tip will be displayed with the settings in effect when it was added.
'rectArg = the rectangular area to highlight (relative to the scrollview (or activity if there's no scrollview)).
'svArg = the scrollview that the rect is inside (null if not in a scrollview)
'titleArg = the title of the tip
'descArg = the text description
Public Sub addTipForArea(rectArg As Rect, svArg As ScrollView, titleArg As String, descArg As String)
	Dim tempItem As tipSettings
	tempItem.Initialize
	tempItem.target = TARGET_RECT
	tempItem.targetView = Null
	If (svArg <> Null) And svArg.IsInitialized Then		'adjust the given rect to include the offset from the scrollview's top
		rectArg.top = rectArg.Top + svArg.Top
		rectArg.Bottom = rectArg.Bottom + svArg.top
	End If
	tempItem.targetRect = rectArg
	tempItem.targetSV = svArg
	tempItem.picName = ""
	getRemainingProperties(tempItem, titleArg, descArg, "")
	tipList.Add(tempItem)
End Sub

'Add a general tip to the list of tips to show.
'The tip will be displayed in the center of the screen, without highlighting a view or area.
'The tip will be displayed with the settings in effect when it was added.
'titleArg = the title of the tip
'descArg = the text description
Public Sub addGeneralTip(titleArg As String, descArg As String)
	Dim tempItem As tipSettings
	tempItem.Initialize
	tempItem.target = TARGET_GENERAL
	tempItem.targetView = Null
	tempItem.targetRect = Null
	tempItem.targetSV = Null
	tempItem.picName = ""
	getRemainingProperties(tempItem, titleArg, descArg, "")
	tipList.Add(tempItem)
End Sub

'Add a picture tip to the list of tips to show.
'The picture will be auto-sized to fit in the center of the screen, with the description under it.
'The tip will be displayed with the settings in effect when it was added.
'If no valid picture is found, a small green placeholder is shown instead.
'pictureArg = the picture's file name, in the Files folder of your B4A project
'descArg = the text description
Public Sub addPictureTip(pictureArg As String, descArg As String)
	Dim tempItem As tipSettings
	tempItem.Initialize
	tempItem.target = TARGET_PICTURE
	tempItem.targetView = Null
	tempItem.targetRect = Null
	tempItem.targetSV = Null
	tempItem.picName = pictureArg
	getRemainingProperties(tempItem, "", descArg, pictureArg)
	tipList.Add(tempItem)
End Sub

Private Sub	getRemainingProperties(tempItem As tipSettings, titleArg As String, descArg As String, pictureArg As String)
	tempItem.title = titleArg
	tempItem.titleSize = getTitleSize
	tempItem.description = descArg
	tempItem.descSize = getDescriptionSize
	tempItem.backgroundColor = getBackgroundColor
	tempItem.maskColor = getMaskColor
	tempItem.highlightColor = getHighlightColor
	tempItem.highlightRadius = getHighlightRadius
	tempItem.highlightWidth = getHighlightWidth
	tempItem.highlightPadding = getHighlightPadding
	tempItem.descColor = getDescriptionColor
	tempItem.skipText = getSkipText
	tempItem.nextText = getNextText
	tempItem.doneText = getDoneText
	tempItem.nextButtonColor = getNextButtonColor
	tempItem.nextButtonTextColor = getNextButtonTextColor
	tempItem.portraitPosition = getPortraitPosition
	tempItem.portraitAlign = getPortraitAlign
	tempItem.landscapePosition = getLandscapePosition
	tempItem.landscapeAlign = getLandscapeAlign
	tempItem.spacer = getSpacer
	tempItem.picName = pictureArg
	tempItem.canSkip = getCanSkip
	tempItem.elevation = getElevation
End Sub

'absorb clicks on the panel so they are not passed through
Private Sub tipsPanel_Click	
End Sub

'absorb clicks on the panel so they are not passed through
Private Sub tipsContentPanel_Click	
End Sub

'Show the tips you've added one by one.
'The tips panel will close when the user finishes the last tip, clicks the Skip button,
'or presses the Back hard button (if you've captured that - see the Hide method).
'As the tips are shown, they are removed from the tips list, so if you want to show tips again, you must rebuild the list each time.
Public Sub show
	If startingTotal = 0 Then								'only store once at the beginning
		startingTotal = tipList.size
	End If
	If tipActivity.width < tipActivity.height Then
		currentOrientation = ORIENTATION_PORTRAIT
	Else
		currentOrientation = ORIENTATION_LANDSCAPE
	End If
	If tipList.Size > 0 Then								'remember how many tips we started with
		tip = tipList.get(0)									'get next tip in list
		tipsPicture.Bitmap = Null
		tipBitmap = Null
		resetBackground
		If tip.target = TARGET_VIEW Then					'get rect from view and continue
			If tip.targetView.visible = True Then
				setTargetRectFromView
				ensureRectIsOnScreen
				highlightRect
			Else													'view is not visible, so skip to the next one
				tipList.RemoveAt(0)
				show
			End If
		Else If tip.target = TARGET_RECT Then
			ensureRectIsOnScreen
			highlightRect
		End If
		setupTextAndButtons
		If tip.target = TARGET_PICTURE Then
			tipBitmap = getBitmapFromFile(File.DirAssets, tip.picName)
			positionControlsForPicture
			alignControlsForPicture
		Else If tip.target = TARGET_GENERAL Then
			positionControlsForGeneral
			alignControlsForGeneral
		Else
			positionControlsForOther
			alignControlsForOther
		End If
		tipList.RemoveAt(0)
		tipsPanel.Elevation = tip.elevation
		tipsPanel.BringToFront
		tipsPanel.SetVisibleAnimated(DURATION_FADE, True)
	Else															'empty list
		hide(True)
	End If
End Sub

'Resume showing the tips at the given index (where 0 is the first tip).
'If the device was rotated while the tips were visible, activity_pause should store
'the index of the current tip (using getIndexOfCurrentTip) and later (on activity_resume) call this
'sub using that index. For an example, see the demo code.
public Sub resume(indexArg As Int)
	If indexArg < 0 Then
		LogColor("DOTips.resume: supplied index was invalid = " & indexArg, Colors.Yellow)
	Else
		For i = 1 To indexArg
			tipList.RemoveAt(0)				'remove the tips they've already seen
		Next
		startingTotal = 0 
		show
	End If
End Sub

'If the device was rotated while the tips were visible, call this (on activity_pause) to get
'the index of the current tip (where 0 is the first tip). Later, on activity_resume, 
'you can call the Resume sub using that value. For an example, see the demo code.
public Sub getIndexOfCurrentTip As Int
	Return (startingTotal - tipList.size) - 1
End Sub

'assign text and colors to the labels and buttons
Private Sub setupTextAndButtons
	tipsContentPanel.Color = tip.maskColor
	tipsTitleLabel.Text = tip.title
	tipsTitleLabel.TextColor = tip.highlightColor
	tipsTitleLabel.TextSize = (tip.titleSize * fontScale) / systemFontScale
	tipsTitleLabel.Visible = True				'set visibility later
	tipsPicture.Visible = True					'set visibility later
	tipsPicture.Gravity = Gravity.FILL
	tipsDescLabel.Text = tip.description
	tipsDescLabel.TextColor = tip.descColor
	tipsDescLabel.TextSize = (tip.descSize * fontScale) / systemFontScale
	setupSkipButton
	setupNextButton
	If tipList.size = 1 Then						'no more tips after this one
		tipsSkipButton.visible = False
		tipsNextButton.Text = tip.doneText
	Else													'more tips coming
		tipsSkipButton.visible = tip.canSkip
		tipsNextButton.Text = tip.nextText
	End If
End Sub

Private Sub setupSkipButton
	tipsSkipButton.Text = tip.skipText
	'~don't use fontScale until we can resize the button
	tipsSkipButton.TextSize = (DEFAULT_BUTTON_TEXT_SIZE - 2) / systemFontScale
	tipsSkipButton.TextColor = tip.descColor
	Dim sld As StateListDrawable
	sld.Initialize
	Dim cd As ColorDrawable
	cd.Initialize(tip.highlightColor, 0)
	sld.AddState(sld.State_Pressed, cd)
	cd.Initialize(Colors.Transparent, 0)
	sld.AddState(sld.State_Enabled, cd)
	tipsSkipButton.Background = sld
End Sub

Private Sub setupNextButton
	tipsNextButton.TextColor = tip.nextButtonTextColor
	tipsNextButton.TextSize = DEFAULT_BUTTON_TEXT_SIZE / systemFontScale
	Dim sld As StateListDrawable
	sld.Initialize
	Dim cd As ColorDrawable
	cd.Initialize(tip.highlightColor, 0)
	sld.AddState(sld.State_Pressed, cd)
	cd.Initialize(tip.nextButtonColor, 0)
	sld.AddState(sld.State_Enabled, cd)
	tipsNextButton.Background = sld
End Sub

're-fill the background after having had holes punched in it for view tips
private Sub resetBackground
	Dim tempCanvas As Canvas
	tempCanvas.Initialize(tipsPanel)
	tempCanvas.DrawColor(Colors.Transparent)
	tempCanvas.DrawColor(tip.backgroundColor)
End Sub

'converts targetView to targetRect, relative to the outer container (activity or scrollview)
Private Sub setTargetRectFromView
	Dim tempLeft, tempTop, tempRight, tempBottom As Int
	tip.targetSV = findSvAncestor
'	If Not(tip.targetSV.IsInitialized) Or (tip.targetSV = Null) Then		'activity, so find cumulative position (e.g. for nested panels)
'		Dim leftTop(2) As Int = getScreenPosition(tip.targetView)
'		tempLeft = leftTop(0)
'		tempTop = leftTop(1)
'	Else																						'scrollview
'		tempLeft = tip.targetView.Left
'		tempTop = tip.targetView.Top
'	End If
'	Dim leftTop(2) As Int = getCumulativePosition(tip.targetView)			'get position relative to scrollview (if any) or activity
'	tempLeft = leftTop(0)
'	tempTop = leftTop(1)
	tempLeft = GetRelativeLeft(tip.targetView)
	tempTop = GetRelativeTop(tip.targetView)
	tempRight = tempLeft + tip.targetView.Width
	tempBottom = tempTop + tip.targetView.Height
	tip.targetRect.Initialize(tempLeft, tempTop, tempRight, tempBottom)
End Sub

'For the current tip's view, return its scrollview from somewhere up the view tree.
'If there is no scrollview, return null.
private Sub findSvAncestor As ScrollView
	Dim parentView As View = tip.targetView.parent
	Do Until (parentView Is ScrollView) Or (parentView = tipActivity)
		parentView = parentView.Parent
	Loop
	If parentView Is ScrollView Then
		Return parentView
	Else
'		Log("DOTips findSvAncestor: didn't find scrollview")
		Return Null
	End If
End Sub

'if the target rect is off screen (e.g. in a scrollview), scroll it onto the screen and calc the rect's new position
private Sub ensureRectIsOnScreen
	If (tip.targetSV <> Null) And tip.targetSV.IsInitialized Then
		If rectIsWithinScreenBounds Then											'convert to screen coordinates for tipsPanel
			tip.targetRect.Top = tip.targetRect.Top - tip.targetSV.ScrollPosition
			tip.targetRect.bottom = tip.targetRect.bottom - tip.targetSV.ScrollPosition
		Else
			'leave some breathing space at top of screen
			Dim topMargin As Int = Min(tip.targetRect.Top, 30dip)
			Dim newTop As Int = tip.targetRect.Top - topMargin
			tip.targetSV.ScrollToNow(newTop)														'scroll to get rect on screen
			Dim scrollCorrection As Int = newTop - tip.targetSV.ScrollPosition		'in case we can't scroll that far
			'adjust the rect coordinates accordingly
			Dim rectHeight As Int = tip.targetRect.Bottom - tip.targetRect.top
			tip.targetRect.Top = topMargin + scrollCorrection
			tip.targetRect.bottom = tip.targetRect.Top + rectHeight
		End If
	End If
End Sub

'assuming a scrollview, check that the current tip's rect is within the screen bounds
'(assume left and right are OK)
private Sub rectIsWithinScreenBounds As Boolean
	Dim currentTop As Int = tip.targetRect.Top - tip.targetSV.ScrollPosition
	If (currentTop >= 0) And (currentTop <= tip.targetSV.Height) Then					'top is within bounds
		Dim currentBottom As Int = tip.targetRect.bottom - tip.targetSV.ScrollPosition
		If (currentBottom >= 0) And (currentBottom <= tip.targetSV.Height) Then		'bottom is within bounds too
			Return True
		Else
			Return False
		End If
	Else
		Return False
	End If
End Sub

Private Sub highlightRect
	Dim tempCanvas As Canvas
	tempCanvas.Initialize(tipsPanel)
	Dim tempRect As Rect
	tempRect.Initialize(tip.targetRect.Left - tip.highlightPadding, tip.targetRect.top - tip.highlightPadding, _
		tip.targetRect.Right + tip.highlightPadding, tip.targetRect.Bottom + tip.highlightPadding) 
	drawRoundRect(tempCanvas, tempRect, tip.highlightRadius, tip.highlightColor, Colors.Transparent, tip.highlightWidth)
End Sub

Private Sub positionControlsForPicture
	Dim tempAspect As Int = getPictureAspect(tipBitmap)
	Dim tempPosition As Int = getPositionForPicture(tempAspect)
	tipsContentPanel.SetLayout(0, tip.spacer, tipsPanel.Width, tipsPanel.Height - tip.spacer*2)		'top and bottom margins
	layoutContentControlsForPicture(tempPosition, tempAspect)
	If ((currentOrientation = ORIENTATION_PORTRAIT) And (tempAspect <> ASPECT_TALL)) _
	Or ((currentOrientation = ORIENTATION_LANDSCAPE) And (tempAspect = ASPECT_WIDE)) Then		'adjust content panel's height to fit
		tipsContentPanel.Height = tipsSkipButton.Top + tipsSkipButton.Height + tip.spacer*2
		tipsContentPanel.Top = tipsPanel.Height/2 - tipsContentPanel.Height/2
	End If
End Sub

'picture tips only allow certain positions depending on orientation and picture aspect
private Sub getPositionForPicture(aspectArg As Int) As Int
	Dim tempPosition As Int 
	If currentOrientation = ORIENTATION_PORTRAIT Then
		tempPosition = tip.portraitPosition
		If (tempPosition = POSITION_AUTO) Or (tempPosition = POSITION_LEFT) Or (tempPosition = POSITION_RIGHT) Then
			tempPosition = POSITION_ABOVE
		End If
	Else
		tempPosition = tip.landscapePosition
		If aspectArg = ASPECT_WIDE Then
			If (tempPosition = POSITION_AUTO) Or (tempPosition = POSITION_LEFT) Or (tempPosition = POSITION_RIGHT) Then
				tempPosition = POSITION_ABOVE
			End If
		Else
			If (tempPosition = POSITION_AUTO) Or (tempPosition = POSITION_ABOVE) Or (tempPosition = POSITION_BELOW) Then
				tempPosition = POSITION_LEFT
			End If
		End If
	End If
	Return tempPosition
End Sub

'resize and move the tip-content panel's controls according to orientation and position
Private Sub layoutContentControlsForPicture(positionArg As Int, aspectArg As Int)
	Dim su As StringUtils
	tipsTitleLabel.Visible = False
	Select positionArg
		Case POSITION_ABOVE
			If aspectArg = ASPECT_TALL Then
				tipsSkipButton.Top = tipsContentPanel.Height - tip.spacer - tipsSkipButton.Height
				tipsNextButton.Top = tipsSkipButton.Top
				tipsDescLabel.Width = tipsContentPanel.Width - tip.spacer*2
				tipsDescLabel.Height = su.MeasureMultilineTextHeight(tipsDescLabel, tipsDescLabel.Text)	'fit label to height needed
				tipsDescLabel.Top = tipsSkipButton.Top - tip.spacer*2 - tipsDescLabel.Height
				Dim picHeight As Int = tipsDescLabel.Top - tip.spacer*3
				tipBitmap = resizeBitmapWithinMax(tipBitmap, tipsDescLabel.Width, picHeight)
				tipsPicture.Bitmap = tipBitmap
				tipsPicture.SetLayout(tipsContentPanel.Width/2 - tipBitmap.Width/2, tip.spacer, tipBitmap.Width, tipBitmap.Height)
			Else		'wide or square
				tipsDescLabel.Width = tipsContentPanel.Width - tip.spacer*2
				tipsDescLabel.Height = su.MeasureMultilineTextHeight(tipsDescLabel, tipsDescLabel.Text)	'fit label to height needed
				Dim picHeight As Int = tipsContentPanel.Height - (tip.spacer + (tipsDescLabel.Height + tip.spacer*2) + (tipsSkipButton.Height + tip.spacer*3))
				Dim picWidth As Int = tipsContentPanel.Width - tip.spacer*2
				tipBitmap = resizeBitmapWithinMax(tipBitmap, picWidth, picHeight)
				tipsPicture.Bitmap = tipBitmap
				tipsPicture.SetLayout(tipsContentPanel.Width/2 - tipBitmap.Width/2, tip.spacer, tipBitmap.Width, tipBitmap.Height)
				tipsDescLabel.Left = tip.spacer
				tipsDescLabel.Top = tipsPicture.Top + tipsPicture.Height + tip.spacer*2
				tipsSkipButton.Top = tipsDescLabel.Top + tipsDescLabel.Height + tip.spacer*2
				tipsNextButton.Top = tipsSkipButton.Top
			End If
		Case POSITION_BELOW
			If aspectArg = ASPECT_TALL Then
				tipsSkipButton.Top = tipsContentPanel.Height - tip.spacer - tipsSkipButton.Height
				tipsNextButton.Top = tipsSkipButton.Top
				tipsDescLabel.Width = tipsContentPanel.Width - tip.spacer*2
				tipsDescLabel.Height = su.MeasureMultilineTextHeight(tipsDescLabel, tipsDescLabel.Text)	'fit label to height needed
				tipsDescLabel.Top = tip.spacer
				Dim picTop As Int = tipsDescLabel.Top + tipsDescLabel.Height + tip.spacer*2
				Dim picHeight As Int = (tipsSkipButton.Top - tip.spacer*2) - picTop
				tipBitmap = resizeBitmapWithinMax(tipBitmap, tipsDescLabel.Width, picHeight)
				tipsPicture.Bitmap = tipBitmap
				tipsPicture.SetLayout(tipsContentPanel.Width/2 - tipBitmap.Width/2, picTop, tipBitmap.Width, tipBitmap.Height)
			Else		'wide or square
				tipsDescLabel.Width = tipsContentPanel.Width - tip.spacer*2
				tipsDescLabel.Height = su.MeasureMultilineTextHeight(tipsDescLabel, tipsDescLabel.Text)	'fit label to height needed
				tipsDescLabel.Top = tip.spacer
				Dim picHeight As Int = tipsContentPanel.Height - ((tipsDescLabel.Top + tipsDescLabel.Height + tip.spacer*2) + (tipsSkipButton.Height + tip.spacer*3))
				Dim picWidth As Int = tipsContentPanel.Width - tip.spacer*2
				tipBitmap = resizeBitmapWithinMax(tipBitmap, picWidth, picHeight)
				tipsPicture.Bitmap = tipBitmap
				tipsPicture.SetLayout(tipsContentPanel.Width/2 - tipBitmap.Width/2, tipsDescLabel.Top + tipsDescLabel.Height + tip.spacer*2, tipBitmap.Width, tipBitmap.Height)
				tipsSkipButton.Top = tipsPicture.Top + tipsPicture.Height + tip.spacer*2
				tipsNextButton.Top = tipsSkipButton.Top
			End If
		Case POSITION_LEFT		'only used by landscape/tall and landscape/square
			If (aspectArg = ASPECT_TALL) Or (aspectArg = ASPECT_SQUARE) Then
				Dim picHeight As Int = tipsContentPanel.Height - tip.spacer*2
				tipBitmap = resizeBitmapWithinMax(tipBitmap, tipsContentPanel.Width, picHeight)		'width doesn't matter
				tipsPicture.Bitmap = tipBitmap
				tipsPicture.SetLayout(tip.spacer, tip.spacer, tipBitmap.Width, tipBitmap.Height)
				tipsDescLabel.Left = tipsPicture.Left + tipsPicture.Width + tip.spacer*2
				tipsDescLabel.Width = tipsContentPanel.Width - tipsDescLabel.Left - tip.spacer
				tipsDescLabel.Height = su.MeasureMultilineTextHeight(tipsDescLabel, tipsDescLabel.Text)	'fit label to height needed
				Dim descAndButtonHeight As Int = tipsDescLabel.Height + tip.spacer*2 + tipsSkipButton.Height + tip.spacer*2
				tipsDescLabel.Top = (tipsContentPanel.Height - descAndButtonHeight) / 2
				tipsSkipButton.Top = tipsDescLabel.Top + tipsDescLabel.Height + tip.spacer*2
				tipsNextButton.Top = tipsSkipButton.Top
			Else
				MsgboxAsync("POSITION_LEFT not allowed for landscape/wide", "Oops")
			End If
		Case POSITION_RIGHT		'only used by landscape/tall and landscape/square
			If (aspectArg = ASPECT_TALL) Or (aspectArg = ASPECT_SQUARE) Then
				Dim picHeight As Int = tipsContentPanel.Height - tip.spacer*2
				tipBitmap = resizeBitmapWithinMax(tipBitmap, tipsContentPanel.Width, picHeight)		'width doesn't matter
				tipsPicture.Bitmap = tipBitmap
				Dim picLeft As Int = tipsContentPanel.Width - tip.spacer - tipBitmap.Width
				tipsPicture.SetLayout(picLeft, tip.spacer, tipBitmap.Width, tipBitmap.Height)
				tipsDescLabel.Left = tip.spacer
				tipsDescLabel.Width = tipsPicture.left - tip.spacer*3
				tipsDescLabel.Height = su.MeasureMultilineTextHeight(tipsDescLabel, tipsDescLabel.Text)	'fit label to height needed
				Dim descAndButtonHeight As Int = tipsDescLabel.Height + tip.spacer*2 + tipsSkipButton.Height + tip.spacer*2
				tipsDescLabel.Top = (tipsContentPanel.Height - descAndButtonHeight) / 2
				tipsSkipButton.Top = tipsDescLabel.Top + tipsDescLabel.Height + tip.spacer*2
				tipsNextButton.Top = tipsSkipButton.Top
			Else
				MsgboxAsync("POSITION_RIGHT not allowed for landscape/wide", "Oops")
			End If
		Case Else
			MsgboxAsync("layoutContentControlsForPicture: tip position is invalid: " & positionArg, "Oops")
	End Select
End Sub

Private Sub alignControlsForPicture
	Dim tempAspect As Int = getPictureAspect(tipBitmap)	
	Dim tempPosition As Int = getPositionForPicture(tempAspect)
	Dim tempAlign As Int
	If currentOrientation = ORIENTATION_PORTRAIT Then
		tempAlign = tip.portraitAlign
	Else
		tempAlign = tip.landscapeAlign
	End If
	If tempAlign = ALIGN_AUTO Then
		Select tempPosition
			Case POSITION_ABOVE, POSITION_BELOW
				tempAlign = ALIGN_CENTER
			Case POSITION_LEFT
				tempAlign = ALIGN_LEFT
			Case POSITION_RIGHT
				tempAlign = ALIGN_RIGHT
		End Select
	End If
	Select tempAlign
		Case ALIGN_LEFT
			tipsDescLabel.Gravity = Bit.Or(Gravity.LEFT, Gravity.CENTER_VERTICAL)
			If tipsSkipButton.visible = True Then
				tipsSkipButton.Left = tipsDescLabel.Left
				tipsNextButton.Left = tipsSkipButton.Left + tipsSkipButton.Width + tip.spacer
			Else
				tipsNextButton.Left = tipsDescLabel.Left
			End If
			'align picture for above and below, but not for left/right positions
			If (tempPosition = POSITION_ABOVE) Or (tempPosition = POSITION_BELOW) Then
				tipsPicture.Left = tip.spacer
			End If
		Case ALIGN_CENTER
			tipsDescLabel.Gravity = Bit.Or(Gravity.CENTER_HORIZONTAL, Gravity.CENTER_VERTICAL)
			If tipsSkipButton.visible = True Then
				tipsSkipButton.left = (tipsDescLabel.Left + tipsDescLabel.Width/2) - (tipsSkipButton.Width + tip.spacer)
				tipsNextButton.Left = tipsSkipButton.Left + tipsSkipButton.Width + tip.spacer*2
			Else
				tipsNextButton.left = (tipsDescLabel.Left + tipsDescLabel.Width/2) - (tipsNextButton.Width/2)
			End If
			'assume that picture is already centered
		Case ALIGN_RIGHT
			tipsDescLabel.Gravity = Bit.Or(Gravity.RIGHT, Gravity.CENTER_VERTICAL)
			tipsNextButton.Left = tipsDescLabel.Left + tipsDescLabel.Width - tipsNextButton.Width
			tipsSkipButton.Left = tipsNextButton.Left - tip.spacer*2 - tipsSkipButton.Width
			If (tempPosition = POSITION_ABOVE) Or (tempPosition = POSITION_BELOW) Then
				tipsPicture.Left = tipsContentPanel.Width - tip.spacer - tipsPicture.Width
			End If
	End Select
End Sub

Private Sub positionControlsForGeneral
	tipsContentPanel.SetLayout(0, tip.spacer, tipsPanel.Width, tipsPanel.Height - tip.spacer*2)		'top and bottom margins
	layoutContentControlsForGeneral
	tipsContentPanel.Height = tipsSkipButton.Top + tipsSkipButton.Height + tip.spacer*2
	tipsContentPanel.Top = tipsPanel.Height/2 - tipsContentPanel.Height/2
End Sub

'resize and move the tip-content panel's controls according to orientation and position
Private Sub layoutContentControlsForGeneral
	Dim su As StringUtils
	tipsPicture.Visible = False
	tipsTitleLabel.Visible = True
	tipsTitleLabel.Left = tip.spacer
	tipsTitleLabel.Width = tipsContentPanel.Width - tip.spacer*2
	tipsTitleLabel.top = tip.spacer
	tipsTitleLabel.Height = su.MeasureMultilineTextHeight(tipsTitleLabel, tipsTitleLabel.Text)	'fit label to height needed
	tipsDescLabel.Left = tipsTitleLabel.Left
	tipsDescLabel.Width = tipsTitleLabel.Width
	tipsDescLabel.Top = tipsTitleLabel.top + tipsTitleLabel.Height + tip.spacer
	tipsDescLabel.Height = su.MeasureMultilineTextHeight(tipsDescLabel, tipsDescLabel.Text)	'fit label to height needed
	tipsSkipButton.Top = tipsDescLabel.Top + tipsDescLabel.Height + tip.spacer*2
	tipsNextButton.Top = tipsSkipButton.Top
End Sub

Private Sub alignControlsForGeneral
	Dim tempAlign As Int
	If currentOrientation = ORIENTATION_PORTRAIT Then
		tempAlign = tip.portraitAlign
	Else
		tempAlign = tip.landscapeAlign
	End If
	If tempAlign = ALIGN_AUTO Then
		tempAlign = ALIGN_CENTER
	End If
	Select tempAlign
		Case ALIGN_LEFT
			tipsTitleLabel.Gravity = Bit.Or(Gravity.LEFT, Gravity.CENTER_VERTICAL)
			tipsDescLabel.Gravity = Bit.Or(Gravity.LEFT, Gravity.CENTER_VERTICAL)
			If tipsSkipButton.visible = True Then
				tipsSkipButton.Left = tipsDescLabel.Left
				tipsNextButton.Left = tipsSkipButton.Left + tipsSkipButton.Width + tip.spacer
			Else
				tipsNextButton.Left = tipsDescLabel.Left
			End If
		Case ALIGN_CENTER
			tipsTitleLabel.Gravity = Bit.Or(Gravity.CENTER_HORIZONTAL, Gravity.CENTER_VERTICAL)
			tipsDescLabel.Gravity = Bit.Or(Gravity.CENTER_HORIZONTAL, Gravity.CENTER_VERTICAL)
			If tipsSkipButton.visible = True Then
				tipsSkipButton.left = (tipsDescLabel.Left + tipsDescLabel.Width/2) - (tipsSkipButton.Width + tip.spacer)
				tipsNextButton.Left = tipsSkipButton.Left + tipsSkipButton.Width + tip.spacer*2
			Else
				tipsNextButton.left = (tipsDescLabel.Left + tipsDescLabel.Width/2) - (tipsNextButton.Width/2)
			End If
		Case ALIGN_RIGHT
			tipsTitleLabel.Gravity = Bit.Or(Gravity.RIGHT, Gravity.CENTER_VERTICAL)
			tipsDescLabel.Gravity = Bit.Or(Gravity.RIGHT, Gravity.CENTER_VERTICAL)
			tipsNextButton.Left = tipsDescLabel.Left + tipsDescLabel.Width - tipsNextButton.Width
			tipsSkipButton.Left = tipsNextButton.Left - tip.spacer*2 - tipsSkipButton.Width
	End Select
End Sub

Private Sub positionControlsForOther
	Dim tempPosition As Int
	If currentOrientation = ORIENTATION_PORTRAIT Then
		tempPosition = tip.portraitPosition
	Else
		tempPosition = tip.landscapePosition
	End If
	If tempPosition = POSITION_AUTO Then
		Dim spaceAbove As Int = tip.targetRect.Top - tip.highlightPadding - tip.spacer
		Dim spaceBelow As Int = tipsPanel.Height - (tip.targetRect.Bottom + tip.highlightPadding + tip.spacer)
		If spaceAbove > spaceBelow Then
			tempPosition = POSITION_ABOVE
		Else
			tempPosition = POSITION_BELOW
		End If
	End If
	Select tempPosition
		Case POSITION_ABOVE
			tipsContentPanel.Left = 0
			tipsContentPanel.Width = tipsPanel.Width
			layoutContentControlsForOther
			tipsContentPanel.top = Max(0, tip.targetRect.Top - tip.highlightPadding - tip.spacer - tipsContentPanel.height)
		Case POSITION_BELOW
			tipsContentPanel.Left = 0
			tipsContentPanel.Width = tipsPanel.Width
			layoutContentControlsForOther
			Dim tempBottom As Int = (tip.targetRect.Bottom + tip.highlightPadding + tip.spacer) + tipsContentPanel.Height
			If tempBottom > tipsPanel.Height Then
				tipsContentPanel.top = tipsPanel.Height - tipsContentPanel.Height
			Else
				tipsContentPanel.Top = tempBottom - tipsContentPanel.Height
			End If
		Case POSITION_LEFT
			tipsContentPanel.Left = 0
			tipsContentPanel.Width = Max(tipsPanel.Width/2, tip.targetRect.Left - tip.highlightPadding - tip.spacer)	'at least half the screen width
			layoutContentControlsForOther
			tipsContentPanel.top = Max(0, tip.targetRect.Top - tip.highlightPadding)
			If (tipsContentPanel.top + tipsContentPanel.Height) > tipsPanel.Height Then
				tipsContentPanel.top = tipsPanel.Height - tipsContentPanel.Height
			End If
		Case POSITION_RIGHT
			tipsContentPanel.left = Min(tipsPanel.Width/2, tip.targetRect.Right + tip.highlightPadding + tip.spacer)	'at least half of screen width
			tipsContentPanel.Width = tipsPanel.Width - tipsContentPanel.left
			layoutContentControlsForOther
			tipsContentPanel.top = Max(0, tip.targetRect.Top - tip.highlightPadding)
			If (tipsContentPanel.top + tipsContentPanel.Height) > tipsPanel.Height Then
				tipsContentPanel.top = tipsPanel.Height - tipsContentPanel.Height
			End If
		Case Else
			MsgboxAsync("positionControlsForOther: tip position is invalid: " & tempPosition, "Oops")
	End Select
End Sub

'for view and rect tips
Private Sub layoutContentControlsForOther
	Dim su As StringUtils
	tipsTitleLabel.Left = tip.spacer
	tipsTitleLabel.Width = tipsContentPanel.Width - tip.spacer*2
	tipsTitleLabel.top = tip.spacer
	tipsTitleLabel.Height = su.MeasureMultilineTextHeight(tipsTitleLabel, tipsTitleLabel.Text)	'fit label to height needed
	tipsDescLabel.Left = tipsTitleLabel.Left
	tipsDescLabel.Width = tipsTitleLabel.Width
	tipsDescLabel.Top = tipsTitleLabel.top + tipsTitleLabel.Height + tip.spacer
	tipsDescLabel.Height = su.MeasureMultilineTextHeight(tipsDescLabel, tipsDescLabel.Text)		'fit label to height needed
	tipsSkipButton.Top = tipsDescLabel.Top + tipsDescLabel.Height + tip.spacer*2
	tipsNextButton.Top = tipsSkipButton.Top
	tipsContentPanel.Height = tipsSkipButton.Top + tipsSkipButton.Height + tip.spacer*2
	tipsPicture.Visible = False
End Sub

'return the aspect of the picture - tall, wide, or square
private Sub getPictureAspect(bitmapArg As Bitmap) As Int
	If (bitmapArg.Height / bitmapArg.Width) > 1.3 Then
		Return ASPECT_TALL
	else if (bitmapArg.width / bitmapArg.Height) > 1.3 Then
		Return ASPECT_WIDE
	Else
		Return ASPECT_SQUARE
	End If
End Sub

Private Sub alignControlsForOther
	Dim tempAlign As Int
	If currentOrientation = ORIENTATION_PORTRAIT Then
		tempAlign = tip.portraitAlign
	Else
		tempAlign = tip.landscapeAlign
	End If
	If tempAlign = ALIGN_AUTO Then
		If (tip.target = TARGET_GENERAL) Or (tip.target = TARGET_PICTURE) Then		'untargeted tip, so center it
			tempAlign = ALIGN_CENTER
		else If tip.targetRect.CenterX < tipsPanel.Width/2 Then		'if middle of target is in left half
			tempAlign = ALIGN_RIGHT												'align right, to minimize collisions
		Else
			tempAlign = ALIGN_LEFT
		End If
	End If
	Select tempAlign
		Case ALIGN_LEFT
			tipsTitleLabel.Gravity = Bit.Or(Gravity.LEFT, Gravity.CENTER_VERTICAL)
			tipsDescLabel.Gravity = Bit.Or(Gravity.LEFT, Gravity.CENTER_VERTICAL)
			tipsSkipButton.Left = tipsTitleLabel.Left
			If tipsSkipButton.visible = True Then
				tipsNextButton.Left = tipsSkipButton.Left + tipsSkipButton.Width + tip.spacer
			Else
				tipsNextButton.Left = tipsTitleLabel.Left
			End If
		Case ALIGN_CENTER
			tipsTitleLabel.Gravity = Bit.Or(Gravity.CENTER_HORIZONTAL, Gravity.CENTER_VERTICAL)
			tipsDescLabel.Gravity = Bit.Or(Gravity.CENTER_HORIZONTAL, Gravity.CENTER_VERTICAL)
			If tipsSkipButton.visible = True Then
				tipsSkipButton.left = tipsContentPanel.Width/2 - (tipsSkipButton.Width + tip.spacer)
				tipsNextButton.Left = tipsContentPanel.Width/2 + tip.spacer
			Else
				tipsNextButton.left = tipsContentPanel.Width/2 - tipsNextButton.Width/2
			End If
		Case ALIGN_RIGHT
			tipsTitleLabel.Gravity = Bit.Or(Gravity.RIGHT, Gravity.CENTER_VERTICAL)
			tipsDescLabel.Gravity = Bit.Or(Gravity.RIGHT, Gravity.CENTER_VERTICAL)
			tipsNextButton.Left = tipsContentPanel.Width - tip.spacer - tipsNextButton.Width
			tipsSkipButton.Left = tipsNextButton.Left - tip.spacer - tipsSkipButton.Width
	End Select
End Sub

Private Sub tipsNextButton_Click
	If tipList.Size < 1 Then							'no more tips left
		hide(True)
	Else
		show
	End If
End Sub

Private Sub tipsSkipButton_Click
	hide(True)
End Sub

'Skip any remaining tips and hide the tips panel.
'hide(true) fires the OnHide event, triggering an optional OnHide sub you've supplied.
'hide(false) hides the tips without firing the OnHide event (so your OnHide sub is ignored).
'Typically used for capturing the Back button in the activity_KeyPress sub:
'If KeyCode = KeyCodes.KEYCODE_BACK Then
'	If (tips.Visible = True) And (tips.CanSkip) Then
'		tips.hide(True)
'		Return True
'	Else...
Public Sub hide(callbackFlag As Boolean)
	Dim tipsSkipped As Int = tipList.Size
	clear
	tipsPanel.SetVisibleAnimated(DURATION_FADE, False)
	
	'if they have an OnHide event handler, trigger it now
	If callbackFlag = True Then
		Dim subName As String = eventName & "_OnHide"
		If SubExists(callbackObject, subName) Then
			CallSub2(callbackObject, subName, tipsSkipped)
		End If
	End If
End Sub

'Clears the tips list.
'You should always call this before adding tips (to properly handle pause/resume cases).
public Sub clear
	tipList.Clear
	startingTotal = 0
	tipsPicture.Bitmap = Null
	tipBitmap = Null
End Sub

'Color of the tip background.
'Applies to tips added after this.
'Defaults to semi-transparent black.
Sub getBackgroundColor As Int
	Return internalBackgroundColor
End Sub

Sub setBackgroundColor(colorArg As Int)
	internalBackgroundColor = colorArg
	If maskFollowsBackground Then
		internalMaskColor = combineColorAndAlpha(internalBackgroundColor, DEFAULT_MASK_ALPHA)
	End If
End Sub

'Color of the text/button panel.
'By default, the mask color is a darker shade (+100 alpha) of the background color.
'If you set the mask color manually, it becomes independent of the background color.
'Applies to tips added after this.
Sub getMaskColor As Int
	Return internalMaskColor
End Sub

Sub setMaskColor(colorArg As Int)
	internalMaskColor = colorArg
	maskFollowsBackground = False			'user explicitly set color, so separate from background
End Sub

'Color of the view's outline, the title, and the button highlights.
'Applies to tips added after this.
'Defaults to green.
Sub getHighlightColor As Int
	Return internalHighlightColor
End Sub

Sub setHighlightColor(colorArg As Int)
	internalHighlightColor = colorArg
End Sub

'Radius of the rounded rectangle used for the highlight.
'Applies to tips added after this.
'Defaults to 20dip.
Sub getHighlightRadius As Int
	Return internalHighlightRadius
End Sub

Sub setHighlightRadius(radiusArg As Int)
	internalHighlightRadius = radiusArg
End Sub

'Width of the highlight border.
'Applies to tips added after this.
'Defaults to 10dip.
Sub getHighlightWidth As Int
	Return internalHighlightWidth
End Sub

Sub setHighlightWidth(widthArg As Int)
	internalHighlightWidth = widthArg
End Sub

'Padding between the view and its highlight border.
'Applies to tips added after this.
'Defaults to 20dip.
Sub getHighlightPadding As Int
	Return internalHighlightPadding
End Sub

Sub setHighlightPadding(paddingArg As Int)
	internalHighlightPadding = paddingArg
End Sub

'Text size of the title.
'Applies to tips added after this.
'Defaults to 30.
Sub getTitleSize As Int
	Return internalTitleSize
End Sub

Sub setTitleSize(sizeArg As Int)
	internalTitleSize = sizeArg
End Sub

'Text size of the description.
'Applies to tips added after this.
'Defaults to 20.
Sub getDescriptionSize As Int
	Return internalDescSize
End Sub

Sub setDescriptionSize(sizeArg As Int)
	internalDescSize = sizeArg
End Sub

'Color of the text description and Skip button text.
'Applies to tips added after this.
'Defaults to white.
Sub getDescriptionColor As Int
	Return internalDescriptionColor
End Sub

Sub setDescriptionColor(colorArg As Int)
	internalDescriptionColor = colorArg
End Sub

'Text of the Skip All button.
'Applies to tips added after this.
'Defaults to "Skip All".
Sub getSkipText As String
	Return internalSkipText
End Sub

Sub setSkipText(textArg As String)
	internalSkipText = textArg
End Sub

'Text of the Next button.
'Applies to tips added after this.
'Defaults to "Next".
Sub getNextText As String
	Return internalNextText
End Sub

Sub setNextText(textArg As String)
	internalNextText = textArg
End Sub

'Text of the Done button.
'Applies to tips added after this.
'Defaults to "Done".
Sub getDoneText As String
	Return internalDoneText
End Sub

Sub setDoneText(textArg As String)
	internalDoneText = textArg
End Sub

'Color of the unpressed Next button.
'Applies to tips added after this.
'Defaults to gray.
Sub getNextButtonColor As Int
	Return internalNextButtonColor
End Sub

Sub setNextButtonColor(colorArg As Int)
	internalNextButtonColor = colorArg
End Sub

'Color of the Next button text.
'Applies to tips added after this.
'Defaults to white.
Sub getNextButtonTextColor As Int
	Return internalNextButtonTextColor
End Sub

Sub setNextButtonTextColor(colorArg As Int)
	internalNextButtonTextColor = colorArg
End Sub

'The position (above/below/left/right) for portrait (tall) orientation.
'Applies to tips added after this.
'Defaults to POSITION_AUTO.
Sub getPortraitPosition As Int
	Return internalPortraitPosition
End Sub

Sub setPortraitPosition(positionArg As Int)
	internalPortraitPosition = positionArg
End Sub

'The position (above/below/left/right) for landscape (wide) orientation.
'Applies to tips added after this.
'Defaults to POSITION_AUTO.
Sub getLandscapePosition As Int
	Return internalLandscapePosition
End Sub

Sub setLandscapePosition(positionArg As Int)
	internalLandscapePosition = positionArg
End Sub

'The alignment (left/center/right) for portrait (tall) orientation.
'Applies to tips added after this.
'Defaults to ALIGN_AUTO.
Sub getPortraitAlign As Int
	Return internalPortraitAlign
End Sub

Sub setPortraitAlign(positionArg As Int)
	internalPortraitAlign = positionArg
End Sub

'The alignment (left/center/right) for landscape (wide) orientation.
'Applies to tips added after this.
'Defaults to ALIGN_AUTO.
Sub getLandscapeAlign As Int
	Return internalLandscapeAlign
End Sub

Sub setLandscapeAlign(positionArg As Int)
	internalLandscapeAlign = positionArg
End Sub

'Spacing between elements.
'Applies to tips added after this.
'Defaults to 10dip.
Sub getSpacer As Int
	Return internalSpacer
End Sub

Sub setSpacer(spacerArg As Int)
	internalSpacer = spacerArg
End Sub

'Show or hide the Skip All button.
'Applies to tips added after this.
'Defaults to true.
Sub getCanSkip As Boolean
	Return internalCanSkip
End Sub

Sub setCanSkip(skipArg As Boolean)
	internalCanSkip = skipArg
End Sub

'Get or set the elevation of the tips overlay.
'If you have views with elevations over 9, set this bigger so the tip appears on top of your view.
'Applies to tips added after this.
'Defaults to 20.
Sub getElevation As Int
	Return internalElevation
End Sub

Sub setElevation(elevationArg As Int)
	internalElevation = elevationArg
End Sub

'Resets all properties back to default settings.
'Only affects tips added after this.
Public Sub resetSettings
	setBackgroundColor(DEFAULT_BACKGROUND_COLOR)
	setMaskColor(combineColorAndAlpha(getBackgroundColor, DEFAULT_MASK_ALPHA))
	maskFollowsBackground = True							'mask follows color of background by default
	setHighlightColor(DEFAULT_HIGHLIGHT_COLOR)
	setHighlightRadius(DEFAULT_HIGHLIGHT_RADIUS)
	setHighlightWidth(DEFAULT_HIGHLIGHT_WIDTH)
	setHighlightPadding(DEFAULT_HIGHLIGHT_PADDING)
	setDescriptionColor(DEFAULT_DESC_COLOR)
	setTitleSize(DEFAULT_TITLE_SIZE)
	setDescriptionSize(DEFAULT_DESC_SIZE)
	setSkipText(DEFAULT_SKIP_TEXT)
	setNextText(DEFAULT_NEXT_TEXT)
	setDoneText(DEFAULT_DONE_TEXT)
	setNextButtonColor(DEFAULT_NEXT_BUTTON_COLOR)
	setNextButtonTextColor(DEFAULT_NEXT_BUTTON_TEXT_COLOR)
	setPortraitPosition(DEFAULT_PORTRAIT_POSITION)
	setPortraitAlign(DEFAULT_PORTRAIT_ALIGN)
	setLandscapePosition(DEFAULT_LANDSCAPE_POSITION)
	setLandscapeAlign(DEFAULT_LANDSCAPE_ALIGN)
	setSpacer(DEFAULT_SPACER)
	setCanSkip(DEFAULT_CAN_SKIP)
	setElevation(DEFAULT_ELEVATION)
End Sub

'Returns true if the tips are currently visible.
'Typically used to track the Back keypress - see Hide for details.
Public Sub getVisible As Boolean
	Return tipsPanel.Visible
End Sub

'from Erel in the B4A forums
'item 0 = A (alpha)
'item 1 = R (red)
'item 2 = G (green)
'item 3 = B (blue)
private Sub getARGB(Color As Int) As Int()
    Dim res(4) As Int
    res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
    res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
    res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
    res(3) = Bit.And(Color, 0xff)
    Return res
End Sub

private Sub combineColorAndAlpha(colorArg As Int, alphaArg As Int) As Int
	Dim argb() As Int = getARGB(colorArg)
	Return Colors.argb(alphaArg, argb(1), argb(2), argb(3))
End Sub

'draw rounded rectangle using JavaObject calls
Private Sub drawRoundRect(cvs As Canvas, rect1 As Rect, radius As Float, strokeColor As Int, fillColor As Int, strokeWidth As Float)
	Dim left, top, right, bottom As Float
	left = rect1.left
	top = rect1.top
	right = rect1.right
	bottom = rect1.bottom
   Dim tempRect As JavaObject
	tempRect.InitializeNewInstance("android.graphics.RectF", Array As Object(left, top, right, bottom))
	Dim paintStyle As JavaObject
	paintStyle.InitializeStatic("android.graphics.Paint.Style")
	Dim paint1 As JavaObject
   paint1.InitializeNewInstance("android.graphics.Paint", Null)
	paint1.RunMethod("setStrokeWidth", Array As Object(1.0f))
	paint1.RunMethod("setColor", Array As Object(fillColor))
	paint1.RunMethod("setStyle", Array As Object(paintStyle.GetField("FILL_AND_STROKE")))
	paint1.RunMethod("setAntiAlias", Array As Object(True))
	If fillColor = Colors.Transparent Then
		Dim pdMode As JavaObject
		pdMode.InitializeNewInstance("android.graphics.PorterDuffXfermode", Array As Object("CLEAR"))
		paint1.RunMethod("setXfermode", Array As Object(pdMode))
	End If
	Dim solidCanvasJO As JavaObject = cvs
	solidCanvasJO = solidCanvasJO.GetField("canvas")
	solidCanvasJO.RunMethod("drawRoundRect", Array As Object(tempRect, radius, radius, paint1))

	Dim paint2 As JavaObject
   paint2.InitializeNewInstance("android.graphics.Paint", Null)
	paint2.RunMethod("setStrokeWidth", Array As Object(strokeWidth))
	paint2.RunMethod("setColor", Array As Object(strokeColor))
	paint2.RunMethod("setStyle", Array As Object(paintStyle.GetField("STROKE")))
	paint2.RunMethod("setAntiAlias", Array As Object(True))
	If strokeColor = Colors.Transparent Then
		Dim pdMode As JavaObject
		pdMode.InitializeNewInstance("android.graphics.PorterDuffXfermode", Array As Object("CLEAR"))
		paint2.RunMethod("setXfermode", Array As Object(pdMode))
	End If
	Dim solidCanvasJO As JavaObject = cvs
	solidCanvasJO = solidCanvasJO.GetField("canvas")
	solidCanvasJO.RunMethod("drawRoundRect", Array As Object(tempRect, radius, radius, paint2))
End Sub

'resize a bitmap to the given maximums, maintaining its aspect ratio
private Sub resizeBitmapWithinMax(bitmapArg As Bitmap, maxWidthArg As Int, maxHeightArg As Int) As Bitmap
	Dim aspectRatio As Float = (bitmapArg.Width / bitmapArg.Height)
	Dim newWidth, newHeight As Int 
	
	'size to the max height first
	newWidth = maxHeightArg * aspectRatio
	
	'check that the resizing is also within the max width
	If newWidth <= maxWidthArg Then
		newHeight = maxHeightArg
	Else
		newWidth = maxWidthArg
		newHeight = maxWidthArg / aspectRatio
	End If
	
	Return createScaledBitmap(bitmapArg, newWidth, newHeight, True)
End Sub

'return the file's bitmap, or a placeholder if the file isn't a picture (or doesn't exist)
Private Sub getBitmapFromFile(pathArg As String, fileNameArg As String) As Bitmap
	Dim tempBitmap As Bitmap
	If File.Exists(pathArg, fileNameArg) Then
		Try
			tempBitmap = LoadBitmap(pathArg, fileNameArg)
		Catch
			tempBitmap = createPlaceholder(tempBitmap)
		End Try
	Else
		tempBitmap = createPlaceholder(tempBitmap)
	End If
	Return tempBitmap
End Sub

'take the given bitmap and return a small green placeholder
private Sub createPlaceholder(bitmapArg As Bitmap) As Bitmap
	bitmapArg.InitializeMutable(100dip, 100dip)
	Dim tempCanvas As Canvas
	tempCanvas.Initialize2(bitmapArg)
	tempCanvas.DrawColor(Colors.Green)
	Return bitmapArg
End Sub

'from Erel in the B4A forums
private Sub createScaledBitmap(Original As Bitmap, Width As Int, Height As Int, Filter As Boolean) As Bitmap
	Dim jo As JavaObject
	jo.InitializeStatic("android.graphics.Bitmap")
	Return jo.RunMethod("createScaledBitmap", Array (Original, Width, Height, Filter))
End Sub

'Iterative sub to get the view's Top relative to the activity window
'from stevel05 in the B4A forums
'Private Sub getRelativeTop(V As JavaObject) As Int
	'I tried several methods to do this, this was the only one that worked across APIs and devices
	'One of these will always be the last parent
'	If GetType(V) = "android.view.ViewRoot" Or GetType(V) = "android.view.ViewRootImpl" Then
'		Return 0
'	Else
'		'If V.Top is valid for this view returns a value then add it, else skip to the next parent
'		Try
'			Dim VW As View = V
'			Return VW.Top + getRelativeTop(V.RunMethod("getParent",Null))
'		Catch
'			Return getRelativeTop(V.RunMethod("getParent",Null))
'		End Try
'	End If
'End Sub
Public Sub GetRelativeTop(V As JavaObject) As Int		'!change
    'I tried several methods to do this, this was the only one that worked across API's and devices
    'One of these should always be the last parent
    If GetType(V) = "android.view.ViewRoot" Or GetType(V) = "android.view.ViewRootImpl" Or GetType(V) = "android.widget.FrameLayout$LayoutParams" Then
        Return 0
    Else
        'If V.Top is valid for this view returns a value then add it, else skip to the next parent
        Try
            Try
                Dim VW As View = V
                Return VW.Top + GetRelativeTop(V.RunMethod("getParent",Null))
            Catch
                Return 0
            End Try
        Catch
            Try
                Return GetRelativeTop(V.RunMethod("getParent",Null))
            Catch
                Return 0
            End Try
        End Try
    End If
End Sub

'Iterative sub to get the view's Left relative to the activity window
'from stevel05 in the B4A forums
'Private Sub getRelativeLeft(V As JavaObject) As Int
'	'I tried several methods to do this, this was the only one that worked across API's and devices
'	'One of these will always be the last parent
'	If GetType(V) = "android.view.ViewRoot" Or GetType(V) = "android.view.ViewRootImpl" Then
'		Return 0
'	Else
'		'If V.Left is valid for this view returns a value then add it, else skip to the next parent
'		Try
'			Dim VW As View = V
'			Return VW.Left + getRelativeLeft(V.RunMethod("getParent",Null))
'		Catch
'			Return getRelativeLeft(V.RunMethod("getParent",Null))
'		End Try
'	End If
'End Sub
'
Public Sub GetRelativeLeft(V As JavaObject) As Int		'!change
    'I tried several methods to do this, this was the only one that worked across API's and devices
    'One of these should always be the last parent
    If GetType(V) = "android.view.ViewRoot" Or GetType(V) = "android.view.ViewRootImpl" Or GetType(V) = "android.widget.FrameLayout$LayoutParams" Then
        Return 0
    Else
        'If V.Left is valid for this view returns a value then add it, else skip to the next parent
        Try
            Try
                Dim VW As View = V
                Return VW.Left + GetRelativeLeft(V.RunMethod("getParent",Null))
            Catch
                Return 0
            End Try
        Catch
            Try
                Return GetRelativeLeft(V.RunMethod("getParent",Null))
            Catch
                Return 0
            End Try
        End Try
    End If
End Sub

