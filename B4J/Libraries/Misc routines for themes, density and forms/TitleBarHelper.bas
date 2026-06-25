B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
' TitleBarHelper - the engine behind the custom title bar. Attach it to an existing Form: it
' builds the card/header/content inside the form's RootPane and handles move, edge-resize,
' Aero-snap, theming and the window buttons. It owns the views it creates (so their mouse/button
' events route here), but the FORM's own events (Resize, FocusChanged) belong to whoever created
' the form - that owner forwards them via OnResize / OnFocusChanged.
'
' Colors use AtlantaFX looked-up vars so it follows the light/dark theme. Pure JavaFX, no native
' calls. See TitleBar.bas for the thin form wrapper.
' Inspiration: https://github.com/Oshan96/CustomStage , https://github.com/goxr3plus/FX-BorderlessScene
Sub Class_Globals
	Private xui As XUI
	Private frm As Form
	Private helper As formHelpers
	Private mRoot As B4XView			'the form RootPane (transparent in rounded mode)
	Private mCard As B4XView			'the visible window body (rounded + shadow when enabled)
	Private mHeader As B4XView			'the title bar strip
	Private mContent As B4XView			'where the caller puts its UI
	Private mTitleLbl As Label
	Private mBtnMin, mBtnMax, mBtnClose As Button
	Private mAccentBorder As Boolean		'always-on accent border
	Private mFocusBorder As Boolean			'accent when focused, muted when not
	Private mHasFocus As Boolean = True
	Private mShowMin As Boolean = True
	Private mShowMax As Boolean = True
	Private mRounded As Boolean				'rounded corners + drop shadow
	Private mDocked As Boolean				'maximized or edge-snapped (flush: square, no shadow gap)
	Private mSnapped As Boolean				'currently edge-snapped to a half/quarter
	Private mMoving As Boolean				'a header move-drag is in progress
	Private mRestoreW, mRestoreH As Double	'floating size to restore after un-dock

	Private Const BAR_H As Double = 38
	Private Const BTN_W As Double = 46
	Private Const RESIZE_MARGIN As Double = 6
	Private Const MIN_W As Double = 220
	Private Const MIN_H As Double = 140
	Private Const SHADOW_PAD As Double = 16
	Private Const CORNER As Double = 10
	Private Const SNAP_EDGE As Double = 8

	'resize zones
	Private Const Z_NONE As Int = 0, Z_N As Int = 1, Z_S As Int = 2, Z_E As Int = 3, Z_W As Int = 4
	Private Const Z_NE As Int = 5, Z_NW As Int = 6, Z_SE As Int = 7, Z_SW As Int = 8

	'drag/resize state
	Private mZone As Int
	Private mPressOnHeader As Boolean
	Private mStartX, mStartY, mStartW, mStartH As Double
	Private mStartScrX, mStartScrY As Double
	Private mLastCursor As String = ""
End Sub

'Attaches the title bar to an already-created Form and builds its UI.
Public Sub Initialize (TargetForm As Form, Title As String)
	frm = TargetForm
	helper.Initialize(frm)
	helper.FormBorderStyle = helper.BORDER_NONE	'undecorated (must be set before Show)
	frm.Resizable = False						'we do our own edge-resize
	mRoot = frm.RootPane
	BuildBar(Title)
End Sub

Private Sub BuildBar (Title As String)
	'transparent root; the visible window is the "card" inside it (room around it for the shadow)
	NodeStyle(mRoot, "-fx-background-color: transparent;")
	mCard = xui.CreatePanel("card")
	mRoot.AddView(mCard, 0, 0, mRoot.Width, mRoot.Height)

	'header strip (named "header" so it raises mouse events)
	mHeader = xui.CreatePanel("header")
	mCard.AddView(mHeader, 0, 0, mCard.Width, BAR_H)

	mTitleLbl.Initialize("")
	mTitleLbl.Text = Title
	mHeader.AddView(mTitleLbl, 12dip, 0, 200dip, BAR_H)
	NodeStyle(mTitleLbl, "-fx-text-fill: -color-fg-default; -fx-font-weight: bold;")

	mBtnMin.Initialize("btnMin") : mBtnMin.Text = Chr(0x2013)	'minimize  (-)
	mBtnMax.Initialize("btnMax") : mBtnMax.Text = Chr(0x25A1)	'maximize  (square)
	mBtnClose.Initialize("btnClose") : mBtnClose.Text = Chr(0x2715)	'close  (x)
	mHeader.AddView(mBtnMin, 0, 0, BTN_W, BAR_H)
	mHeader.AddView(mBtnMax, 0, 0, BTN_W, BAR_H)
	mHeader.AddView(mBtnClose, 0, 0, BTN_W, BAR_H)
	StyleButton(mBtnMin, "")
	StyleButton(mBtnMax, "")
	StyleButton(mBtnClose, "danger")

	'content area (named "content" so it raises mouse events for edge-resize)
	mContent = xui.CreatePanel("content")
	mCard.AddView(mContent, 0, BAR_H, mCard.Width, mCard.Height - BAR_H)
	NodeStyle(mContent, "-fx-background-color: transparent;")	'let the card background show

	ApplyCardStyle
	LayoutBar
End Sub

'--- public API ---
Public Sub getContentPane As B4XView
	Return mContent
End Sub

Public Sub getForm As Form
	Return frm
End Sub

Public Sub setTitle (Title As String)
	mTitleLbl.Text = Title
	frm.Title = Title
End Sub

'Optional accent-colored border around the whole window (follows the theme accent).
Public Sub setAccentBorder (Enabled As Boolean)
	mAccentBorder = Enabled
	ApplyCardStyle
End Sub

Public Sub getAccentBorder As Boolean
	Return mAccentBorder
End Sub

'Optional focus-aware border: accent color while the window is focused, muted when it isn't.
Public Sub setFocusBorder (Enabled As Boolean)
	mFocusBorder = Enabled
	ApplyCardStyle
End Sub

Public Sub getFocusBorder As Boolean
	Return mFocusBorder
End Sub

'Optional rounded corners + drop shadow (modern floating look). MUST be set before Show -
'it switches the stage to a transparent style, which JavaFX only applies before the form is shown.
Public Sub setRoundedShadow (Enabled As Boolean)
	mRounded = Enabled
	If Enabled Then
		helper.FormBorderStyle = helper.BORDER_TRANSPARENT
		SetSceneTransparent
	Else
		helper.FormBorderStyle = helper.BORDER_NONE
	End If
	ApplyCardStyle
	LayoutBar
End Sub

Public Sub getRoundedShadow As Boolean
	Return mRounded
End Sub

'Show/hide the minimize and maximize buttons (like WinForms MinimizeBox / MaximizeBox).
Public Sub setShowMinimize (ShowMe As Boolean)
	mShowMin = ShowMe
	LayoutBar
End Sub

Public Sub getShowMinimize As Boolean
	Return mShowMin
End Sub

Public Sub setShowMaximize (ShowMe As Boolean)
	mShowMax = ShowMe
	LayoutBar
End Sub

Public Sub getShowMaximize As Boolean
	Return mShowMax
End Sub

'Show the form, then lay out (RootPane is sized once shown).
Public Sub Show
	frm.Show
	LayoutBar
End Sub

'--- form events, forwarded by the owner (the form belongs to whoever created it) ---
Public Sub OnResize
	LayoutBar
End Sub

Public Sub OnFocusChanged (HasFocus As Boolean)
	mHasFocus = HasFocus
	ApplyCardStyle
End Sub

'--- layout ---
Private Sub LayoutBar
	If mRoot.Width <= 0 Then Return
	'card fills the window minus the shadow padding
	Dim pad As Double = EffectivePad
	Dim cw As Double = mRoot.Width - (pad * 2)
	Dim ch As Double = mRoot.Height - (pad * 2)
	mCard.SetLayoutAnimated(0, pad, pad, cw, ch)
	mHeader.SetLayoutAnimated(0, 0, 0, cw, BAR_H)
	mContent.SetLayoutAnimated(0, 0, BAR_H, cw, ch - BAR_H)

	'place buttons right-to-left; skip hidden ones so the title fills the freed space
	Dim x As Double = cw
	x = PlaceButton(mBtnClose, True, x)
	x = PlaceButton(mBtnMax, mShowMax, x)
	x = PlaceButton(mBtnMin, mShowMin, x)

	Dim lbl As B4XView = mTitleLbl
	lbl.SetLayoutAnimated(0, 12dip, 0, x - 12dip, BAR_H)
	UpdateMaxGlyph
End Sub

'Positions a button at the right (if visible) and returns the new right-edge x; hides it otherwise.
Private Sub PlaceButton (b As Button, Visible As Boolean, RightX As Double) As Double
	Dim bx As B4XView = b
	bx.Visible = Visible
	If Visible = False Then Return RightX
	Dim left As Double = RightX - BTN_W
	bx.SetLayoutAnimated(0, left, 0, BTN_W, BAR_H)
	Return left
End Sub

'Maximize button shows a 'restore' glyph while maximized, 'maximize' otherwise.
Private Sub UpdateMaxGlyph
	If helper.WindowState = helper.STATE_MAXIMIZED Then
		mBtnMax.Text = Chr(0x29C9)	'restore (two squares)
	Else
		mBtnMax.Text = Chr(0x25A1)	'maximize (square)
	End If
End Sub

'Effective padding/rounding: suppressed while docked (maximized/snapped) so it sits flush.
Private Sub EffectivePad As Double
	If mRounded And mDocked = False Then Return SHADOW_PAD
	Return 0
End Sub

Private Sub EffectiveRounded As Boolean
	Return mRounded And mDocked = False
End Sub

'Make the scene background see-through so only the rounded card (and its shadow) are visible.
Private Sub SetSceneTransparent
	Dim joRoot As JavaObject = mRoot
	Dim joScene As JavaObject = joRoot.RunMethodJO("getScene", Null)
	Dim colorClass As JavaObject
	colorClass.InitializeStatic("javafx.scene.paint.Color")
	joScene.RunMethod("setFill", Array(colorClass.GetField("TRANSPARENT")))
End Sub

'--- styling ---
'Styles the visible card: background, optional rounded corners + drop shadow, optional border.
Private Sub ApplyCardStyle
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("-fx-background-color: -color-bg-default;")
	If EffectiveRounded Then
		sb.Append($" -fx-background-radius: ${CORNER};"$)
		sb.Append(" -fx-effect: dropshadow(gaussian, rgba(0,0,0,0.45), 18, 0.1, 0, 3);")
	End If
	If HasBorder Then
		sb.Append($" -fx-border-color: ${BorderColor}; -fx-border-width: 2;"$)
		If EffectiveRounded Then sb.Append($" -fx-border-radius: ${CORNER};"$)
	End If
	NodeStyle(mCard, sb.ToString)
	ApplyHeaderStyle
End Sub

'Header background + border. When a border is active the whole title bar is outlined in the
'border color; otherwise just a neutral bottom separator. Top corners are rounded in rounded mode.
Private Sub ApplyHeaderStyle
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("-fx-background-color: -color-bg-default;")
	If EffectiveRounded Then sb.Append($" -fx-background-radius: ${CORNER} ${CORNER} 0 0;"$)
	If HasBorder Then
		sb.Append($" -fx-border-color: ${BorderColor}; -fx-border-width: 1;"$)
	Else
		sb.Append(" -fx-border-color: -color-border-default; -fx-border-width: 0 0 1 0;")
	End If
	NodeStyle(mHeader, sb.ToString)
End Sub

Private Sub HasBorder As Boolean
	Return mAccentBorder Or mFocusBorder
End Sub

'Accent while focused; a neutral color when the window is not focused (only if FocusBorder is on).
Private Sub BorderColor As String
	If mFocusBorder And mHasFocus = False Then Return "-color-border-default"
	Return "-color-accent-emphasis"
End Sub

'--- window control buttons ---
Private Sub btnMin_Click
	helper.WindowState = helper.STATE_MINIMIZED
End Sub

Private Sub btnMax_Click
	ToggleMaximize
End Sub

Private Sub btnClose_Click
	helper.Close
End Sub

Private Sub ToggleMaximize
	If mShowMax = False Then Return		'maximize disabled
	If helper.WindowState = helper.STATE_MAXIMIZED Then
		helper.WindowState = helper.STATE_NORMAL
		SetDocked(False)
	Else
		SaveRestoreSize
		helper.WindowState = helper.STATE_MAXIMIZED
		SetDocked(True)
	End If
	LayoutBar
End Sub

'--- mouse: move (header) + edge resize (header + content) ---
Private Sub header_MouseMoved (EventData As MouseEvent)
	HandleMove(EventData, 0)
End Sub

Private Sub content_MouseMoved (EventData As MouseEvent)
	HandleMove(EventData, BAR_H)
End Sub

Private Sub header_MousePressed (EventData As MouseEvent)
	HandlePress(EventData, 0, True)
End Sub

Private Sub content_MousePressed (EventData As MouseEvent)
	HandlePress(EventData, BAR_H, False)
End Sub

Private Sub header_MouseDragged (EventData As MouseEvent)
	HandleDrag(EventData)
End Sub

Private Sub content_MouseDragged (EventData As MouseEvent)
	HandleDrag(EventData)
End Sub

'Releasing a header move-drag near a screen edge snaps the window (Aero-snap).
Private Sub header_MouseReleased (EventData As MouseEvent)
	If mMoving = False Then Return
	mMoving = False
	Dim e As JavaObject = EventData
	Dim sx As Double = e.RunMethod("getScreenX", Null)
	Dim sy As Double = e.RunMethod("getScreenY", Null)
	TrySnap(sx, sy)
End Sub

Private Sub header_MouseClicked (EventData As MouseEvent)
	Dim e As JavaObject = EventData
	Dim clicks As Int = e.RunMethod("getClickCount", Null)
	If clicks >= 2 Then ToggleMaximize
End Sub

Private Sub HandleMove (EventData As MouseEvent, OffsetY As Double)
	If helper.WindowState = helper.STATE_MAXIMIZED Then Return
	Dim e As JavaObject = EventData
	Dim x As Double = e.RunMethod("getX", Null)
	Dim y As Double = e.RunMethod("getY", Null)
	UpdateCursor(ZoneAt(x, y + OffsetY))
End Sub

Private Sub HandlePress (EventData As MouseEvent, OffsetY As Double, OnHeader As Boolean)
	Dim e As JavaObject = EventData
	Dim x As Double = e.RunMethod("getX", Null)
	Dim y As Double = e.RunMethod("getY", Null)
	mZone = ZoneAt(x, y + OffsetY)
	mPressOnHeader = (OnHeader And mZone = Z_NONE)
	mMoving = mPressOnHeader
	mStartX = helper.Left
	mStartY = helper.Top
	mStartW = helper.Width
	mStartH = helper.Height
	Dim sx As Double = e.RunMethod("getScreenX", Null)
	Dim sy As Double = e.RunMethod("getScreenY", Null)
	mStartScrX = sx
	mStartScrY = sy
End Sub

Private Sub HandleDrag (EventData As MouseEvent)
	If helper.WindowState = helper.STATE_MAXIMIZED Then Return
	Dim e As JavaObject = EventData
	Dim sx As Double = e.RunMethod("getScreenX", Null)
	Dim sy As Double = e.RunMethod("getScreenY", Null)
	Dim dx As Double = sx - mStartScrX
	Dim dy As Double = sy - mStartScrY
	If mZone = Z_NONE Then
		If mPressOnHeader = False Then Return
		If mDocked Then
			RestoreFromDock(sx, sy)		'dragging a snapped/maximized window restores it under the cursor
			Return
		End If
		helper.Left = mStartX + dx
		helper.Top = mStartY + dy
		Return
	End If
	ResizeBy(dx, dy)
End Sub

Private Sub ResizeBy (dx As Double, dy As Double)
	Dim nx As Double = mStartX, ny As Double = mStartY, nw As Double = mStartW, nh As Double = mStartH
	Select mZone
		Case Z_E, Z_NE, Z_SE
			nw = mStartW + dx
		Case Z_W, Z_NW, Z_SW
			nw = mStartW - dx
			nx = mStartX + dx
	End Select
	Select mZone
		Case Z_S, Z_SE, Z_SW
			nh = mStartH + dy
		Case Z_N, Z_NE, Z_NW
			nh = mStartH - dy
			ny = mStartY + dy
	End Select
	'clamp to minimum, keeping the opposite (anchored) edge fixed
	If nw < MIN_W Then
		Select mZone
			Case Z_W, Z_NW, Z_SW
				nx = (mStartX + mStartW) - MIN_W
		End Select
		nw = MIN_W
	End If
	If nh < MIN_H Then
		Select mZone
			Case Z_N, Z_NE, Z_NW
				ny = (mStartY + mStartH) - MIN_H
		End Select
		nh = MIN_H
	End If
	helper.SetBounds(nx, ny, nw, nh)
End Sub

'--- Aero-snap: snap to screen edges/corners on release; restore on drag-away ---
Private Sub TrySnap (scrX As Double, scrY As Double)
	Dim wa() As Double = WorkArea(scrX, scrY)
	Dim wx As Double = wa(0), wy As Double = wa(1), ww As Double = wa(2), wh As Double = wa(3)
	'top edge -> maximize
	If scrY <= wy + SNAP_EDGE Then
		SaveRestoreSize
		helper.WindowState = helper.STATE_MAXIMIZED
		SetDocked(True)
		LayoutBar
		Return
	End If
	Dim atLeft As Boolean = (scrX <= wx + SNAP_EDGE)
	Dim atRight As Boolean = (scrX >= wx + ww - SNAP_EDGE)
	If atLeft = False And atRight = False Then Return
	SaveRestoreSize
	Dim half As Double = ww / 2
	Dim hh As Double = wh / 2
	Dim x0 As Double = wx
	If atRight Then x0 = wx + half
	Dim y0 As Double = wy
	Dim hgt As Double = wh
	If scrY <= wy + (wh / 3) Then				'top corner -> top quarter
		hgt = hh
	Else If scrY >= wy + (wh * 2 / 3) Then		'bottom corner -> bottom quarter
		y0 = wy + hh
		hgt = hh
	End If
	helper.SetBounds(x0, y0, half, hgt)
	mSnapped = True
	SetDocked(True)
	LayoutBar
End Sub

'Un-maximize / un-snap, restoring the floating size centered under the cursor; resets drag refs.
Private Sub RestoreFromDock (curScrX As Double, curScrY As Double)
	If helper.WindowState = helper.STATE_MAXIMIZED Then helper.WindowState = helper.STATE_NORMAL
	SetDocked(False)
	Dim newW As Double = mRestoreW
	Dim newH As Double = mRestoreH
	If newW <= 0 Then newW = MIN_W * 2
	If newH <= 0 Then newH = MIN_H * 2
	Dim newLeft As Double = curScrX - (newW / 2)
	Dim newTop As Double = curScrY - (BAR_H / 2)
	helper.SetBounds(newLeft, newTop, newW, newH)
	mStartX = newLeft
	mStartY = newTop
	mStartScrX = curScrX
	mStartScrY = curScrY
	LayoutBar
End Sub

Private Sub SaveRestoreSize
	If mDocked = False And helper.WindowState <> helper.STATE_MAXIMIZED Then
		mRestoreW = helper.Width
		mRestoreH = helper.Height
	End If
End Sub

Private Sub SetDocked (Docked As Boolean)
	mDocked = Docked
	If Docked = False Then mSnapped = False
	ApplyCardStyle		'flush (square, no shadow) while docked
End Sub

'Visual bounds (work area, excludes taskbar) of the screen containing the given point.
Private Sub WorkArea (atX As Double, atY As Double) As Double()
	Dim sc As JavaObject
	sc.InitializeStatic("javafx.stage.Screen")
	Dim list As JavaObject = sc.RunMethodJO("getScreensForRectangle", Array(atX, atY, 1.0, 1.0))
	Dim screen As JavaObject
	If list.RunMethod("isEmpty", Null) Then
		screen = sc.RunMethodJO("getPrimary", Null)
	Else
		screen = list.RunMethodJO("get", Array(0))
	End If
	Dim vb As JavaObject = screen.RunMethodJO("getVisualBounds", Null)
	Dim minX As Double = vb.RunMethod("getMinX", Null)
	Dim minY As Double = vb.RunMethod("getMinY", Null)
	Dim wdth As Double = vb.RunMethod("getWidth", Null)
	Dim hght As Double = vb.RunMethod("getHeight", Null)
	Return Array As Double(minX, minY, wdth, hght)
End Sub

'Which resize zone a card-relative point falls in (card = visible window minus shadow padding).
Private Sub ZoneAt (x As Double, y As Double) As Int
	Dim w As Double = helper.Width - (EffectivePad * 2)
	Dim h As Double = helper.Height - (EffectivePad * 2)
	Dim m As Double = RESIZE_MARGIN
	Dim lft As Boolean = (x <= m)
	Dim rgt As Boolean = (x >= w - m)
	Dim top As Boolean = (y <= m)
	Dim bot As Boolean = (y >= h - m)
	If top And lft Then Return Z_NW
	If top And rgt Then Return Z_NE
	If bot And lft Then Return Z_SW
	If bot And rgt Then Return Z_SE
	If lft Then Return Z_W
	If rgt Then Return Z_E
	If top Then Return Z_N
	If bot Then Return Z_S
	Return Z_NONE
End Sub

Private Sub UpdateCursor (Zone As Int)
	Dim c As String
	Select Zone
		Case Z_N : c = "N_RESIZE"
		Case Z_S : c = "S_RESIZE"
		Case Z_E : c = "E_RESIZE"
		Case Z_W : c = "W_RESIZE"
		Case Z_NE : c = "NE_RESIZE"
		Case Z_NW : c = "NW_RESIZE"
		Case Z_SE : c = "SE_RESIZE"
		Case Z_SW : c = "SW_RESIZE"
		Case Else : c = helper.CURSOR_DEFAULT
	End Select
	If c <> mLastCursor Then
		helper.Cursor = c
		mLastCursor = c
	End If
End Sub

'--- styling helpers ---
'Set a node's inline CSS (works on B4XView panels, labels and buttons).
Private Sub NodeStyle (View As B4XView, Css As String)
	Dim jo As JavaObject = View
	jo.RunMethod("setStyle", Array(Css))
End Sub

'Apply AtlantaFX 'flat' button styling (+ optional extra class like 'danger').
Private Sub StyleButton (b As Button, ExtraClass As String)
	Dim jo As JavaObject = b
	Dim classes As JavaObject = jo.RunMethodJO("getStyleClass", Null)
	classes.RunMethod("add", Array("flat"))
	If ExtraClass <> "" Then classes.RunMethod("add", Array(ExtraClass))
End Sub
