B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	' Data source — the real order of items is always here
	' Only updated when the drag ends, not during drag
	Dim panelList As List

	' Visual representation of each item (Panel with icon + text inside)
	Dim panels() As Panel

	' Index of the panel currently being dragged
	Dim dragIndex As Int

	' Vertical offset between finger position and panel top when drag starts
	' Without this, the panel would "jump" to center under the finger
	Dim dragOffsetY As Float

	' True while the finger is actively dragging a panel
	Dim isDragging As Boolean

	' True once the finger has moved beyond DRAG_THRESHOLD before long press fired
	' In that case the gesture is treated as scroll, not drag or click
	Dim isScrollGesture As Boolean

	' Finger position when TOUCH_DOWN fired
	' Used to detect movement before long press fires
	Dim touchDownX As Float
	Dim touchDownY As Float

	' Direct reference to the panel being dragged
	' Avoids repeated panels(dragIndex) lookups during move
	Dim dragPanel As Panel
	
	' Image indicating the drag
	Dim imgDrag As ImageView

	' Timer that fires after LONG_PRESS_DELAY ms to activate drag mode
	' If the finger moves before it fires, the gesture becomes scroll instead
	Dim longPressTimer As Timer

	' Transparent panel covering the entire screen
	' Intercepts ALL touch events because B4XPage does not route
	' Touch events from child views to the page module correctly —
	' only Click works. The overlay solves this by being the single
	' touch receiver for the whole screen.
	Dim overlayPanel As Panel

	' ScrollView that contains all item panels
	Dim scrollPanel As ScrollView

	' Base panel assigned from the layout — declared globally to avoid
	' "parameter name cannot hide global variable name" error in B4XPage
	Dim pnlBase As Panel

	' Item height in dip units
	Dim Const ITEM_HEIGHT As Int = 80

	' Vertical gap between items — larger than before to make scroll easier
	' The gap area always triggers scroll, never drag or click
	Dim Const ITEM_MARGIN As Int = 6

	' Minimum finger movement in dip before long press is cancelled
	' and the gesture is treated as scroll instead
	Dim Const DRAG_THRESHOLD As Int = 8

	' Long press duration in milliseconds before drag mode activates
	Dim Const LONG_PRESS_DELAY As Int = 500

	' Zone in dip near top/bottom edge that triggers auto-scroll during drag
	Dim Const EDGE_ZONE As Int = 80

	' Touch action constants — we cannot use Activity.ACTION_* in B4XPage
	' because Activity is not directly accessible. These are the standard
	' Android values for touch actions.
	Dim Const TOUCH_DOWN As Int = 0
	Dim Const TOUCH_UP As Int = 1
	Dim Const TOUCH_MOVE As Int = 2
	Dim Const TOUCH_CANCEL As Int = 3
	
	' Icon name list (simpler than a Map when only iteration is needed)
	Private iconNames As List
	
	Dim SQL1 As SQL
	Dim LastError As String
	
	Dim Const TOP_PADDING As Int = 12    ' Top margin before first item. Raw dip value — converted in GetSlotY
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("EditItems")
	
	' Open or create the database
	SQL1.Initialize(File.DirInternal, "database.db", True)

	' Create table and insert initial data if needed
	InitDatabase

	' Load data and render panels
	InitAdapter
	
	
	
	' Examples:
	' Update both text and icon at once
	' UpdateItem(0, "New text", "ic_arrow_square_right")

	' Update only the text of item at index 2
	' UpdateItemText(2, "Renamed item")

	' Update only the icon of item at index 1
	UpdateItemIcon(1, "ic_thunderstorm")

	' Add a new item at the end
	' AddItem("Item 7", "ic_mood")

	' Insert a new item at position 2
	' InsertItem("Inserted item", "ic_mood", 2)

	' Remove item at index 3
	' RemoveItem(3)

	' Remove item by its text value
	' RemoveItemByText("Item 1")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


' ==========================================
' === INITIALIZATION ===
' ==========================================
' Centralized slot Y position — single source of truth for all vertical placement
Private Sub GetSlotY(index As Int) As Float
	Return (TOP_PADDING + index * (ITEM_HEIGHT + ITEM_MARGIN)) * 1dip
End Sub

Sub InitAdapter
	panelList.Initialize

	' Load items from DB ordered by sort field
	Dim rs As ResultSet = SQL1.ExecQuery("SELECT id, text, icon, sort FROM items ORDER BY sort ASC")
	Do While rs.NextRow
		' Store all fields as a Map per item
		Dim itemMap As Map
		itemMap.Initialize
		itemMap.Put("id",   rs.GetInt("id"))
		itemMap.Put("text", rs.GetString("text"))
		itemMap.Put("icon", rs.GetString("icon"))
		itemMap.Put("sort", rs.GetInt("sort"))
		panelList.Add(itemMap)
	Loop
	rs.Close


	' Long press timer — fires once after LONG_PRESS_DELAY ms
	' Disabled by default, enabled on each TOUCH_DOWN over a panel
	longPressTimer.Initialize("LongPress", LONG_PRESS_DELAY)
	longPressTimer.Enabled = False

	' Initialize ScrollView vertically with 1000dip internal height
	' Initialize2 is the correct B4A syntax: Initialize2(height, eventName)
	scrollPanel.Initialize2(1000dip, "ScrollPanel")
	pnlBase.AddView(scrollPanel, 0, 0, pnlBase.Width, pnlBase.Height)

	' Force inner panel width to match container
	' Without this, the inner panel may be narrower than expected
	scrollPanel.Panel.Width = pnlBase.Width

	' Set inner panel height to fit all items
	Dim totalHeight As Int = TOP_PADDING + panelList.Size * (ITEM_HEIGHT + ITEM_MARGIN) + ITEM_MARGIN * 2
	scrollPanel.Panel.Height = totalHeight * 1dip

	RenderPanels

	' Overlay panel — always visible and enabled, sits on top of everything
	' This is the key workaround for B4XPage touch routing:
	' instead of listening to each panel individually (which doesn't work),
	' we let this single overlay capture all touch events and then calculate
	' which item is underneath the finger by position math.
	overlayPanel.Initialize("OverlayTouch")
	overlayPanel.Color = Colors.Transparent
	overlayPanel.Enabled = True
	overlayPanel.Visible = True
	pnlBase.AddView(overlayPanel, 0, 0, pnlBase.Width, pnlBase.Height)
End Sub


' ==========================================
' === RENDER ===
' ==========================================
Sub RenderPanels
	scrollPanel.Panel.RemoveAllViews
	
	Dim totalHeight As Int = TOP_PADDING + panelList.Size * (ITEM_HEIGHT + ITEM_MARGIN) + ITEM_MARGIN * 2
	scrollPanel.Panel.Height = totalHeight * 1dip
	
	Dim count As Int = panelList.Size
	Dim panels(count) As Panel

	' Build drawable map from panelList data (replaces mapIcons)
	Dim iconMap As Map
	iconMap.Initialize
	For i = 0 To count - 1
		Dim itemMap As Map = panelList.Get(i)
		iconMap.Put(itemMap.Get("icon"), Null)
	Next

	Dim res As AndroidResources		' AndroidResources lib
	' Single library call — resolves all drawables at once
'	Pass a Map To this method where each Map key Is an android Drawable resource name.
'	The method will Return the same Map object where the Map values are the android resource Drawables defined by the Map keys.
'	If an android resource Drawable Is Not found the Map value will Not be changed.
	Dim mapLoadedDrawables As Map = res.GetApplicationDrawables(iconMap)
'	Dim drawableNames As List = res.GetApplicationResourceNames("drawable")


	'To add rounded edges to the panels
	Dim cd As ColorDrawable
	cd.Initialize(Colors.LightGray, 15dip)

	For i = 0 To count - 1
		Dim itemMap As Map = panelList.Get(i)        ' <-- source of truth

		Dim pnlItem As Panel
		pnlItem.Initialize("")
		pnlItem.Color = Colors.LightGray
		pnlItem.Tag = i
		pnlItem.Background = cd
		scrollPanel.Panel.AddView(pnlItem, 10dip, GetSlotY(i), scrollPanel.Panel.Width - 20dip, ITEM_HEIGHT * 1dip)

		' === Icon on the left (child view index 0) ===
		Dim imgIcon As ImageView
		imgIcon.Initialize("")
		'imgIcon.Bitmap = LoadBitmap(File.DirAssets, "ic_warning_circle.png")
		
		' Loop only assigns — no library overhead per iteration
		Dim drawableName As String = itemMap.Get("icon")    ' <-- from DB, not mapIcons
		Dim bd As BitmapDrawable = mapLoadedDrawables.Get(drawableName)
		If bd <> Null Then
			imgIcon.Background = bd
		Else
			imgIcon.Bitmap = LoadBitmap(File.DirAssets, "ic_warning_circle.png")
		End If
		imgIcon.Gravity = Gravity.FILL
		pnlItem.AddView(imgIcon, 8dip, (ITEM_HEIGHT / 2 - 20) * 1dip, 40dip, 40dip)

		' === Text label (child view index 1) ===
		' Starts after the icon (58dip from left)
		Dim lblText As Label
		lblText.Initialize("")
		lblText.Text = itemMap.Get("text")                  ' <-- from DB, not panelList string
		lblText.Gravity = Gravity.CENTER_VERTICAL
		lblText.TextSize = 16
		lblText.TextColor = Colors.Black
		pnlItem.AddView(lblText, 58dip, 0, pnlItem.Width - 66dip, ITEM_HEIGHT * 1dip)

		' === Icon on the right (child view index 2) ===
		Dim imgIconDrag As ImageView
		imgIconDrag.Initialize("")
		SetDrawableBackground(imgIconDrag, "ic_equal")
		imgIconDrag.Gravity = Gravity.FILL
		imgIconDrag.Visible = False
		pnlItem.AddView(imgIconDrag, pnlItem.Width - 50dip, (ITEM_HEIGHT / 2 - 20) * 1dip, 40dip, 40dip)
		
		' Read text from map instead of plain string
'		lblText.Text = itemMap.Get("text")
'		SetDrawableBackground(imgIcon, itemMap.Get("icon"))
		''		imgIcon.Bitmap = LoadBitmap(File.DirAssets, itemMap.Get("icon"))		'With extension

		panels(i) = pnlItem
	Next
End Sub

' Retrieve icons from drawable folders using the AndroidResources library
Private Sub SetDrawableBackground(imgTarget As ImageView, drawableName As String)
	Dim res As AndroidResources			' AndroidResources lib
	Dim bd As BitmapDrawable = res.GetApplicationDrawable(drawableName)
	If bd <> Null Then
		imgTarget.Background = bd
	End If
End Sub


' ==========================================
' === LONG PRESS TIMER EVENT ===
' ==========================================
' Fires after LONG_PRESS_DELAY ms if the finger hasn't moved
' This is the only way drag mode can be activated —
' movement before this fires always results in scroll instead
Sub LongPress_Tick
	' Disable timer — it should only fire once per touch
	longPressTimer.Enabled = False

	' Only activate if finger is still on a valid panel
	If dragIndex < 0 Then Return

	' Activate drag mode
	isDragging = True
	dragPanel.BringToFront

	' Visual feedback — panel turns white to signal drag is ready
	dragPanel.Color = Colors.White
	
	imgDrag = dragPanel.GetView(2)
	imgDrag.Visible = True
	

	' Vibration API changed in Android 8 (API 26)
	' Below API 26: vibrate(long milliseconds)
	' API 26 and above: vibrate(VibrationEffect)
	Try
		Dim buildVersion As JavaObject
		Dim sdkInt As Int = buildVersion.InitializeStatic("android.os.Build$VERSION").GetField("SDK_INT")

		Dim ctx As JavaObject
		ctx.InitializeContext

		' DEFAULT_AMPLITUDE (-1) works on devices without amplitude control
		Dim duration As Long = 150
		Dim amplitude As Int = -1

		' Build VibrationEffect — same for all SDK >= 26
		Dim effect As JavaObject
		effect = effect.InitializeStatic("android.os.VibrationEffect").RunMethod( _
            "createOneShot", Array As Object(duration, amplitude))

		If sdkInt >= 31 Then
			' Android 12+ requires VibratorManager instead of direct vibrator service
			Dim vibratorManager As JavaObject
			vibratorManager = ctx.RunMethod("getSystemService", Array As Object("vibrator_manager"))
			Dim vibrator As JavaObject
			vibrator = vibratorManager.RunMethod("getDefaultVibrator", Null)

			If sdkInt >= 33 Then
				' Android 13+ silently ignores vibration without VibrationAttributes
				' USAGE_TOUCH (2) tells the system this is a tactile UI feedback
				Dim attrs As JavaObject
				attrs = attrs.InitializeStatic("android.os.VibrationAttributes").RunMethod( _
                    "createForUsage", Array As Object(2))
				vibrator.RunMethod("vibrate", Array As Object(effect, attrs))
			Else
				' Android 12 — VibratorManager but no VibrationAttributes needed
				vibrator.RunMethod("vibrate", Array As Object(effect))
			End If

		Else If sdkInt >= 26 Then
			' Android 8-11 — direct vibrator service + VibrationEffect
			Dim vibrator As JavaObject
			vibrator = ctx.RunMethod("getSystemService", Array As Object("vibrator"))
			vibrator.RunMethod("vibrate", Array As Object(effect))

		Else
			' Android 7 and below — legacy vibrate(long) API
			Dim vibrator As JavaObject
			vibrator = ctx.RunMethod("getSystemService", Array As Object("vibrator"))
			Dim legacyDuration As Long = 150
			vibrator.RunMethod("vibrate", Array As Object(legacyDuration))
		End If

	Catch
		' Vibration not available or permission missing — silently ignore
		Log("Vibration error: " & LastException.Message)
	End Try
End Sub


' ==========================================
' === OVERLAY TOUCH — handles everything ===
' ==========================================
' Since B4XPage does not correctly route Touch events from child views,
' this single overlay panel receives ALL touch input for the whole list.
' From here we decide whether the gesture is: scroll, click, or drag.
' Drag can ONLY be activated via long press — movement before long press
' always cancels it and triggers scroll instead.
Sub OverlayTouch_Touch(action As Int, x As Float, y As Float)
	Select Case action
		Case TOUCH_DOWN
			touchDownX = x
			touchDownY = y
			isDragging = False
			isScrollGesture = False

			' Determine which panel (if any) is under the finger
			' Gap areas between panels always return -1 = scroll
			Dim touchedIndex As Int = GetIndexFromScreenY(y)
			If touchedIndex >= 0 Then
				dragIndex = touchedIndex
				dragPanel = panels(dragIndex)
				Dim scrollOffset As Int = GetScrollOffset
				' Calculate offset so the panel doesn't jump when dragged
				' dragOffsetY = distance from finger to panel top
				dragOffsetY = y - (GetSlotY(dragIndex) - scrollOffset)

				' Start long press countdown — if finger stays still long enough,
				' LongPress_Tick will fire and activate drag mode
				longPressTimer.Enabled = True
				
'				imgDrag = dragPanel.GetView(2)
'				imgDrag.Visible = True
			Else
				' Finger is in the gap between panels — no long press, only scroll
				dragIndex = -1
				longPressTimer.Enabled = False
			End If

		Case TOUCH_MOVE
			Dim deltaX As Float = Abs(x - touchDownX)
			Dim deltaY As Float = Abs(y - touchDownY)

			If Not (isDragging) Then
				If (deltaX > DRAG_THRESHOLD * 1dip Or deltaY > DRAG_THRESHOLD * 1dip) Then
					' Finger moved before long press fired — cancel drag, start scroll
					' This applies whether finger is on a panel or in the gap
					longPressTimer.Enabled = False
					isScrollGesture = True
					dragIndex = -1
				End If

				If isScrollGesture Then
					' Manual scroll — touchDownY resets each frame for incremental delta
					Dim scrollDelta As Int = touchDownY - y
					Dim currentScroll As Int = GetScrollOffset
					Dim maxScroll As Int = scrollPanel.Panel.Height - scrollPanel.Height
					ScrollPanelTo(Min(Max(currentScroll + scrollDelta, 0), maxScroll))
					touchDownY = y
				End If
			End If

			If isDragging Then
				Dim scrollOffset As Int = GetScrollOffset
				Dim adjustedY As Float = y + scrollOffset - dragOffsetY

				dragPanel.SetLayoutAnimated(0, dragPanel.Left, adjustedY, dragPanel.Width, dragPanel.Height)

				' Use panel center (not top edge) to detect shift moment
				' This gives a natural feel: shift happens when centers cross
				Dim centerY As Float = adjustedY + (ITEM_HEIGHT * 1dip) / 2
				Dim newIndex As Int = GetIndexFromPosition(centerY)
				If newIndex <> dragIndex And newIndex >= 0 And newIndex < panelList.Size Then
					' Shift all intermediate panels consecutively instead of
					' swapping only two — creates a natural pushing effect
					ShiftPanels(dragIndex, newIndex)
					dragIndex = newIndex
				End If

				' Auto-scroll when finger is near the top or bottom edge
				AutoScrollIfNeeded(y)
			End If

		Case TOUCH_UP, TOUCH_CANCEL
			' Always stop the long press timer on finger lift
			longPressTimer.Enabled = False

			If isDragging Then
				' Long press was confirmed and finger dragged = finalize drop
				FinalizeDrag
			Else If Not (isScrollGesture) And dragIndex >= 0 Then
				' No movement, no long press fired = short tap = click
				HandlePanelClick(dragIndex)
			End If

			' Reset state
			isScrollGesture = False
	End Select
End Sub


' ==========================================
' === CLICK HANDLER ===
' ==========================================
Private Sub HandlePanelClick(index As Int)
	' Replace with your click logic
	Log("Clicked: " & panelList.Get(index))
End Sub


' ==========================================
' === DRAG HELPERS ===
' ==========================================

' Called when the finger is lifted after a confirmed drag
Private Sub FinalizeDrag
	isDragging = False
	dragPanel.Color = Colors.LightGray
	imgDrag.Visible = False
	' Sync panelList data with the final visual order of panels
	' panelList is not modified during drag — only here on drop
	RebuildPanelList
	' Snap all panels to their mathematically correct grid positions
	SnapAllToPosition
	' Persist new sort order to DB immediately after drag ends
	SaveOrder
End Sub

' Animate all panels back to their exact slot positions
' This corrects any small visual drift that may accumulate during drag
Private Sub SnapAllToPosition
	For i = 0 To panels.Length - 1
		panels(i).SetLayoutAnimated(200, panels(i).Left, GetSlotY(i), panels(i).Width, panels(i).Height)
	Next
End Sub

' Shift all panels between fromIdx and toIdx one slot in the opposite direction
' Unlike a simple swap, this pushes every intermediate panel along consecutively
' creating a natural cascading effect as the dragged panel moves through the list
Private Sub ShiftPanels(fromIdx As Int, toIdx As Int)
	' Save reference to the dragged panel before shifting
	Dim tempPnl As Panel = panels(fromIdx)

	If toIdx > fromIdx Then
		' Dragging down: shift each intermediate panel up one slot
		For i = fromIdx To toIdx - 1
			panels(i) = panels(i + 1)
			panels(i).SetLayoutAnimated(150, panels(i).Left, GetSlotY(i), panels(i).Width, panels(i).Height)
		Next
	Else
		' Dragging up: shift each intermediate panel down one slot
		For i = fromIdx To toIdx + 1 Step -1
			panels(i) = panels(i - 1)
			panels(i).SetLayoutAnimated(150, panels(i).Left, GetSlotY(i), panels(i).Width, panels(i).Height)
		Next
	End If

	' Place the dragged panel at its new index in the array
	' Its visual position is still controlled by the finger in OverlayTouch_Touch
	panels(toIdx) = tempPnl
End Sub

' Rebuild panelList from the final visual order of panels after drag ends
' During drag only panels() array is reordered — panelList stays untouched
' to avoid unnecessary data operations on every TOUCH_MOVE frame
' Adapt RebuildPanelList to update the Map
' After drag ends, rebuild panelList Maps with new sort values
Private Sub RebuildPanelList
	Dim newList As List
	newList.Initialize
	For i = 0 To panels.Length - 1
		' Tag holds the original index assigned at render time
		Dim originalIndex As Int = panels(i).Tag
		Dim itemMap As Map = panelList.Get(originalIndex)
		itemMap.Put("sort", i)
		newList.Add(itemMap)
	Next
	' Replace panelList content with the reordered version
	panelList.Clear
	For i = 0 To newList.Size - 1
		panelList.Add(newList.Get(i))
	Next
End Sub

' Automatically scroll the list when the finger reaches the screen edges during drag
Private Sub AutoScrollIfNeeded(touchY As Float)
	Dim panelH As Int = overlayPanel.Height
	Dim currentScroll As Int = GetScrollOffset
	Dim maxScroll As Int = scrollPanel.Panel.Height - scrollPanel.Height

	If touchY < EDGE_ZONE * 1dip Then
		' Near top edge — scroll up
		Dim newScrollUp As Int = Max(currentScroll - 15dip, 0)
		ScrollPanelTo(newScrollUp)
	Else If touchY > panelH - EDGE_ZONE * 1dip Then
		' Near bottom edge — scroll down
		Dim newScrollDown As Int = Min(currentScroll + 15dip, maxScroll)
		ScrollPanelTo(newScrollDown)
	End If
End Sub

' Programmatic scroll via JavaObject
' ScrollView.ScrollTo does not exist in B4A — we call the native
' Android smoothScrollTo method directly through JavaObject
Private Sub ScrollPanelTo(yPos As Int)
	Dim jo As JavaObject = scrollPanel
	jo.RunMethod("smoothScrollTo", Array As Object(0, yPos))
End Sub

' Get current scroll position via JavaObject
' We cannot use scrollPanel.Panel.Top because the ScrollView internally
' uses FrameLayout$LayoutParams instead of BALayout$LayoutParams,
' causing a ClassCastException when B4A tries to read .Top directly.
' getScrollY() is the safe native Android alternative.
Private Sub GetScrollOffset As Int
	Dim jo As JavaObject = scrollPanel
	Return jo.RunMethod("getScrollY", Null)
End Sub

' Find which panel index is under the finger on screen
' Returns -1 if finger is in the gap between panels (ITEM_MARGIN area)
' or in the vertical padding zone at top/bottom of each panel
' Gap areas are intentionally larger (ITEM_MARGIN = 20dip) to make
' scroll easy to trigger without needing to aim precisely
Private Sub GetIndexFromScreenY(screenY As Float) As Int
	Dim scrollOffset As Int = GetScrollOffset
	Dim adjustedY As Float = screenY + scrollOffset
	
	' Small vertical padding inside each panel also acts as scroll zone
	' This widens the effective gap between panels
	Dim verticalPadding As Float = 6dip

	For i = 0 To panels.Length - 1
		Dim lTop As Float = GetSlotY(i) + verticalPadding
		Dim lBottom As Float = lTop + ITEM_HEIGHT * 1dip - verticalPadding * 2
		' Full width is valid — no horizontal restriction
		' Scroll is triggered by movement, not by position
		If adjustedY >= lTop And adjustedY <= lBottom Then
			Return i
		End If
	Next
	Return -1
End Sub

' Convert a Y position (panel center) to a slot index
' Uses integer division instead of Round to avoid premature
' or delayed shifts at the top and bottom extremes of the list
Private Sub GetIndexFromPosition(centerY As Float) As Int
	Dim slotHeight As Int = (ITEM_HEIGHT + ITEM_MARGIN) * 1dip
	Dim idx As Int = (centerY - TOP_PADDING * 1dip) / slotHeight
	Return Min(Max(idx, 0), panelList.Size - 1)
End Sub


' ==========================================
' === PUBLIC API — ADD / REMOVE / UPDATE ===
' ==========================================

' Add a new item at the end of the list
Public Sub AddItem(text As String, iconName As String)
	Dim itemMap As Map
	itemMap.Initialize
	itemMap.Put("text", text)
	itemMap.Put("icon", iconName)
	itemMap.Put("sort", panelList.Size + 1)
	
	' Insert in DB first to get the auto-generated id
	SQL1.ExecNonQuery2("INSERT INTO items (text, icon, sort) VALUES (?, ?, ?)", _
        Array As Object(text, iconName, panelList.Size + 1))
	itemMap.Put("id", SQL1.ExecQuerySingleResult("SELECT last_insert_rowid()"))
	
	panelList.Add(itemMap)
	RenderPanels
End Sub

' Insert a new item at a specific index
Public Sub InsertItem(text As String, iconName As String, index As Int)
	Dim itemMap As Map
	itemMap.Initialize
	itemMap.Put("text", text)
	itemMap.Put("icon", iconName)
	itemMap.Put("sort", index)
	panelList.InsertAt(index, itemMap)
	
	' INSERT first to get the auto-generated id
	SQL1.ExecNonQuery2("INSERT INTO items (text, icon, sort) VALUES (?, ?, ?)", _
        Array As Object(text, iconName, index))
	itemMap.Put("id", SQL1.ExecQuerySingleResult("SELECT last_insert_rowid()"))
	
	SaveOrder    ' Reindex sort of remaining items
	RenderPanels
End Sub

' Remove item by index
Public Sub RemoveItem(index As Int)
	If index < 0 Or index >= panelList.Size Then Return
	Dim itemMap As Map = panelList.Get(index)
	SQL1.ExecNonQuery2("DELETE FROM items WHERE id = ?", Array As Object(itemMap.Get("id")))
	panelList.RemoveAt(index)
	SaveOrder    ' Reindex sort of remaining items
	RenderPanels
End Sub

' Remove item by text value
Public Sub RemoveItemByText(text As String)
	For i = 0 To panelList.Size - 1
		Dim itemMap As Map = panelList.Get(i)
		If itemMap.Get("text") = text Then
			SQL1.ExecNonQuery2("DELETE FROM items WHERE id = ?", Array As Object(itemMap.Get("id")))
			panelList.RemoveAt(i)
			SaveOrder    ' Reindex sort of remaining items
			RenderPanels
			Return
		End If
	Next
End Sub

' Update both text and icon of an existing item without full re-render
' GetView(0) = ImageView (first child), GetView(1) = Label (second child)
Public Sub UpdateItem(index As Int, newText As String, newIconName As String)
	If index < 0 Or index >= panelList.Size Then Return
	Dim itemMap As Map = panelList.Get(index)
	itemMap.Put("text", newText)
	itemMap.Put("icon", newIconName)
	Dim lblText As Label = panels(index).GetView(1)
	lblText.Text = newText
	Dim imgIcon As ImageView = panels(index).GetView(0)
	SetDrawableBackground(imgIcon, newIconName)
End Sub

' Update only the text of an existing item
Public Sub UpdateItemText(index As Int, newText As String)
	If index < 0 Or index >= panelList.Size Then Return
	Dim itemMap As Map = panelList.Get(index)
	itemMap.Put("text", newText)
	' panelList.Set(index, itemMap)  ' It is no longer necessary. Map is a reference — itemMap.Put already modifies the object within panelList without needing to do Set again
	
	' Update visual
	Dim lblText As Label = panels(index).GetView(1)
	lblText.Text = newText
End Sub

' Update only the icon of an existing item
Public Sub UpdateItemIcon(index As Int, newIconName As String)
	If index < 0 Or index >= panelList.Size Then Return
    
	' Update data source
	Dim itemMap As Map = panelList.Get(index)
	itemMap.Put("icon", newIconName)
	' panelList.Set(index, itemMap)  ' It is no longer necessary. Map is a reference — itemMap.Put already modifies the object within panelList without needing to do Set again
    
	' Update view without re-render
	Dim imgIcon As ImageView = panels(index).GetView(0)
	SetDrawableBackground(imgIcon, newIconName)
	
'	imgIcon.Bitmap = LoadBitmap(File.DirAssets, newIconFile)
End Sub


' The necessary code needs to be moved to a class with touch calling the class methods, if reused on other pages

' With DB:

Sub InitIconList
	iconNames = Array As String( _
        "ic_domain", "ic_emoji_emotions", "ic_emoji_objects", "ic_face_3", _
        "ic_group", "ic_interests", "ic_mood", "ic_notifications", _
        "ic_pages", "ic_precision_manufacturing", "ic_psychology", "ic_sign_language")
End Sub

Sub InitDatabase
	' Create table if it doesn't exist yet
	SQL1.ExecNonQuery("CREATE TABLE IF NOT EXISTS items (" & _
        "id      INTEGER PRIMARY KEY AUTOINCREMENT, " & _
        "text    TEXT, " & _
        "icon    TEXT, " & _
        "sort    INTEGER)")

	' Only insert initial data if table is empty
	Dim rs As ResultSet = SQL1.ExecQuery("SELECT COUNT(*) AS total FROM items")
	rs.NextRow
	Dim total As Int = rs.GetInt("total")
	rs.Close

	If total = 0 Then
		InitIconList
		InsertDefaultValues
	End If
End Sub

Private Sub InsertDefaultValues
	' Build a List of Maps — each Map represents one row (column -> value)
	Dim rows As List
	rows.Initialize

	For i = 0 To iconNames.Size - 1    ' <-- iconNames, not panelList
		Dim row As Map
		row.Initialize
		row.Put("text", "Item " & (i + 1))
		row.Put("icon", iconNames.Get(i))
		row.Put("sort", i + 1)
		rows.Add(row)
	Next

	If InsertMultiple("items", rows, True) Then
		ToastMessageShow("All records inserted", False)
	Else
		If LastError.Contains("UNIQUE constraint failed") Then
			MsgboxAsync("Error inserting: at least one record already exists. Insertion aborted.", "Attention")
		Else
			MsgboxAsync("Error inserting: " & LastError, "Attention")
		End If
	End If
End Sub

' Inserts multiple rows into a table using a List of Maps.
' Each Map must have identical keys (column names); columns are inferred from the first row.
Public Sub InsertMultiple(TableName As String, Rows As List, UseTransaction As Boolean) As Boolean
	If SQL1.IsInitialized = False Or Rows.Size = 0 Then Return False

	' 1. Infer column names from the first row map
	Dim firstRow As Map = Rows.Get(0)

	' Map.Keys returns an IterableMap, not a List — must copy explicitly
	Dim columns As List
	columns.Initialize
	For Each key As String In firstRow.Keys
		columns.Add(key)
	Next

	' 2. Build parameterized INSERT query
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("INSERT INTO ").Append(TableName).Append(" (")
	For i = 0 To columns.Size - 1
		sb.Append(columns.Get(i))
		If i < columns.Size - 1 Then sb.Append(", ")
	Next
	sb.Append(") VALUES (")
	For i = 0 To columns.Size - 1
		sb.Append("?")
		If i < columns.Size - 1 Then sb.Append(", ")
	Next
	sb.Append(")")

	Dim query As String = sb.ToString

	' 3. Execute with optional transaction
	If UseTransaction Then SQL1.BeginTransaction

	Try
		For Each rowMap As Map In Rows
			' Extract values in the same order as the columns
			Dim values(columns.Size) As Object
			For i = 0 To columns.Size - 1
				values(i) = rowMap.Get(columns.Get(i))
			Next
			SQL1.ExecNonQuery2(query, values)
		Next

		If UseTransaction Then
			SQL1.TransactionSuccessful
            #If B4A
			SQL1.EndTransaction
            #End If
		End If
		Return True

	Catch
		LastError = LastException.Message
		If UseTransaction Then SQL1.EndTransaction
		Return False
	End Try
End Sub


'Fill in the database

' Save new sort order to DB after drag ends
' Called from FinalizeDrag or from a Save button
Public Sub SaveOrder
	SQL1.BeginTransaction
	Try
		For i = 0 To panelList.Size - 1
			Dim itemMap As Map = panelList.Get(i)
			SQL1.ExecNonQuery2("UPDATE items SET sort = ? WHERE id = ?", _
                Array As Object(i, itemMap.Get("id")))
		Next
		SQL1.TransactionSuccessful
	Catch
		LastError = LastException.Message
	End Try
	SQL1.EndTransaction
End Sub

' Save text and icon changes for a single item to DB
' The `sort` field may be outdated. `itemMap.Get("sort")` reflects the original value loaded from the database, not the current position after a drag. It's safer to pass it as a parameter.
Public Sub SaveItem(index As Int)
	If index < 0 Or index >= panelList.Size Then Return
	Dim itemMap As Map = panelList.Get(index)
	SQL1.ExecNonQuery2("UPDATE items SET text = ?, icon = ?, sort = ? WHERE id = ?", _
        Array As Object(itemMap.Get("text"), itemMap.Get("icon"), index, itemMap.Get("id")))
End Sub

'Save everything — order, text and icon — in a single transaction
Public Sub SaveAll
	SQL1.BeginTransaction
	Try
		For i = 0 To panelList.Size - 1
			Dim itemMap As Map = panelList.Get(i)
			SQL1.ExecNonQuery2("UPDATE items SET text = ?, icon = ?, sort = ? WHERE id = ?", _
                Array As Object(itemMap.Get("text"), itemMap.Get("icon"), i, itemMap.Get("id")))
		Next
		SQL1.TransactionSuccessful
	Catch
		LastError = LastException.Message
	End Try
	SQL1.EndTransaction
End Sub


'## Full flow
'```
'BD (ORDER BY sort)
'       ↓
'   InitAdapter → panelList (List of Maps)
'       ↓
'   RenderPanels → panels() Array
'       ↓
'   User drags
'       ↓
'   ShiftPanels → reorder panels() visually
'       ↓
'   FinalizeDrag → RebuildPanelList → update sort in Maps
'       ↓
'   SaveOrder / SaveAll → persists in DB


' Returns True if the device uses gesture navigation (no back button)
Private Sub IsGestureNavigation As Boolean
	Try
		Dim res As JavaObject
		res.InitializeContext
		Dim resources As JavaObject = res.RunMethod("getResources", Null)
		Dim config As JavaObject = resources.RunMethod("getConfiguration", Null)
		' 2 = NAVIGATION_NONAV (gesture), 1 = NAVIGATION_UNKNOWN,
		' 3 = NAVIGATION_DPAD, 4 = NAVIGATION_TRACKBALL, no physical back = 2
		Dim navHidden As Int = config.GetField("navigationHidden")
		Return navHidden = 2    ' NAVIGATIONHIDDEN_YES = gestures only
	Catch
		Return False
	End Try
End Sub


' Not yet applied:
'Sub btnRename_Click
'	UpdateItemText(0, "First item renamed")
'End Sub
'
'Sub btnAdd_Click
'	AddItem("New item", "ic_mood")
'End Sub
'
'Sub btnRemove_Click
'	RemoveItem(panelList.Size - 1)    ' Remove last item
'End Sub