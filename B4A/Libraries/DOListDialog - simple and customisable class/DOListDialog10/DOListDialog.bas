B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
'Class: DOListDialog
'Version: 1.0
'Author:	Dave O'Brien (dmnobrien@gmail.com)
'Last updated: 12 May 2024
'
'Shows a dialog that lets the user pick from a list.
'Simple to use with default settings, but can be easily customised.
'
'Example: dialog.show("Pick an item", yourList, dialog.LAYOUT_AUTO_BOTH, dialog.CANCELABLE)
'
'Requires no additional libraries.

'Still to do:
'- make it work with the Abstract Designer.
'- Check compatibility with B4XPages.
'- make it respect the current device theme (e.g. dark mode).

#Event: result(index As Int)

'~set these up eventually
#DesignerProperty: Key: BooleanExample, DisplayName: Boolean Example, FieldType: Boolean, DefaultValue: True, Description: Example of a boolean property.
#DesignerProperty: Key: IntExample, DisplayName: Int Example, FieldType: Int, DefaultValue: 10, MinRange: 0, MaxRange: 100, Description: Note that MinRange and MaxRange are optional.
#DesignerProperty: Key: StringWithListExample, DisplayName: String With List, FieldType: String, DefaultValue: Sunday, List: Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday
#DesignerProperty: Key: StringExample, DisplayName: String Example, FieldType: String, DefaultValue: Text
#DesignerProperty: Key: ColorExample, DisplayName: Color Example, FieldType: Color, DefaultValue: 0xFFCFDCDC, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: DefaultColorExample, DisplayName: Default Color Example, FieldType: Color, DefaultValue: Null, Description: Setting the default value to Null means that a nullable field will be displayed.

Sub Class_Globals
	Type twoLineItem(firstLine As String, secondLine As String)
	
	'constants
	Public const LAYOUT_FULL As Int = 0
	Public const LAYOUT_AUTO_WIDTH As Int = 1
	Public const LAYOUT_AUTO_HEIGHT As Int = 2
	Public const LAYOUT_AUTO_BOTH As Int = 3
	Public const CANCELABLE As Boolean = True
	Public const NO_VALUE As Int = -1
	
	Private const MARGIN As Int = 8dip
	Private const TITLE_HEIGHT As Int = 24dip
	Private const BUTTON_HEIGHT As Int = 48dip
	Private const FADE_DURATION As Int = 300
'	Private Const DEFAULT_COLOR As Int = -984833

	'variables
	Private mCallback As Object
	Private mActivity As Activity
	Private mEventName As String
	Private mList As List
	Private mCancelable As Boolean = True
	Private mLayout As Int
'	Private mBase As Panel

	'views
	Public maskPanel, dialogPanel As Panel
	Public titleLabel As Label
	Public lv As ListView
	Public cancelButton As Button
	
End Sub

#region public subs

'Initializes the object.
'activityArg is the calling activity
'eventPrefixArg is the prefix for event handlers (e.g. "dialog" means you can write a "dialog_Result" sub).
Public Sub Initialize(objectArg As Object, activityArg As Activity, eventPrefixArg As String)
	mCallback = objectArg
	mActivity = activityArg
	mEventName = eventPrefixArg
	createDialog
End Sub

'Public Sub DesignerCreateView(Base As Panel, Lbl As Label, Props As Map)
'	mBase = Base
'End Sub

'Public Sub GetBase As Panel
'	Return mBase
'End Sub

'Single-line lists should be strings.
'Double-line lists should use the twoLineItem type (firstLine, secondLine).
'The layout defaults to LAYOUT_FULL (fitting the screen), but width or height can be auto-shrink-to-fit.
'The dialog can allow canceling (via button, tapping background, or Back button) or not.
'Back button must be handled by the activity's KeyPress event - see demo app for code.
'Returns the index of the chosen list item (starting at 0), or -1 (NO_VALUE) for cancel.
public Sub show(titleArg As String, listArg As List, layoutArg As Int, cancelArg As Boolean)
	titleLabel.text = titleArg
	mList = listArg
	mLayout = Max(layoutArg, 0)
	mCancelable = cancelArg
	cancelButton.Visible = mCancelable
	If loadListIntoDialog Then
		If mLayout <> LAYOUT_FULL Then sizeDialog
'		maskPanel.Visible = True
		maskPanel.SetVisibleAnimated(FADE_DURATION, True)
	End If
End Sub

public Sub getVisible As Boolean
	Return maskPanel.Visible
End Sub

public Sub setVisible(flag As Boolean)
	maskPanel.Visible = flag
End Sub

'close the dialog and call the Result event with -1
public Sub cancel
	closeDialog(NO_VALUE)
End Sub

public Sub getisCancelable As Boolean
	Return mCancelable
End Sub

public Sub createStateListDrawableFromColor(uncheckedColor As Int, pressedColor As Int) As StateListDrawable
	Dim cd As ColorDrawable
	Dim sld As StateListDrawable
	sld.Initialize
	
	cd.Initialize(pressedColor, 0)
	sld.AddState(sld.State_Pressed, cd)
	sld.AddState(sld.State_Checked, cd)
	
	cd.Initialize(uncheckedColor, 0)
	sld.AddState(sld.State_Unchecked, cd)

	Return sld
End Sub

#End Region


#Region private subs

'build the dialog, ready for later list population and sizing.
'sizes to the equivalent of LAYOUT_FULL (full activity - margins)
private Sub createDialog
	maskPanel.Initialize("maskPanel")
	maskPanel.Color = Colors.ARGB(50, 0, 0, 0)
	maskPanel.Elevation = 24dip
	maskPanel.Visible = False
	mActivity.AddView(maskPanel, 0, 0, mActivity.Width, mActivity.Height)
	
	dialogPanel.Initialize("")
	dialogPanel.Color = Colors.white		'~eventually handle themes
	dialogPanel.Elevation = 24dip
	maskPanel.AddView(dialogPanel, MARGIN*4, MARGIN*4, maskPanel.Width - MARGIN*8, maskPanel.Height - MARGIN*8)

	titleLabel.Initialize("")
	titleLabel.Color = Colors.Transparent
	titleLabel.TextColor = Colors.Black
	titleLabel.TextSize = 18
	titleLabel.Typeface = Typeface.DEFAULT_BOLD
	titleLabel.SingleLine = True
	titleLabel.Gravity = Bit.Or(Gravity.CENTER_VERTICAL, Gravity.CENTER_HORIZONTAL)
	dialogPanel.AddView(titleLabel, MARGIN*2, MARGIN*2, dialogPanel.Width - MARGIN*4, TITLE_HEIGHT)

	If mCancelable Then
		cancelButton.Initialize("cancelButton")
		cancelButton.Text = "Cancel"
		cancelButton.Background = createStateListDrawableFromColor(Colors.Transparent, Colors.LightGray)
		cancelButton.TextColor = Colors.Black
		cancelButton.TextSize = 16
		Dim buttonTop As Int = dialogPanel.Height - BUTTON_HEIGHT
		dialogPanel.AddView(cancelButton, 0, buttonTop, dialogPanel.Width, BUTTON_HEIGHT)
	End If
	
	lv.Initialize("lv")
	lv.Color = Colors.Transparent
'	lv.SingleLineLayout.ItemHeight = 48dip
	lv.SingleLineLayout.Label.TextSize = 16
	lv.SingleLineLayout.Label.TextColor = Colors.Black
	lv.TwoLinesLayout.Label.Typeface = Typeface.DEFAULT_BOLD
	lv.TwoLinesLayout.Label.TextSize = 16
	lv.TwoLinesLayout.Label.TextColor = Colors.Black
	lv.TwoLinesLayout.SecondLabel.TextSize = 14
	lv.TwoLinesLayout.SecondLabel.TextColor = Colors.Black
	Dim lvTop As Int = titleLabel.Top + titleLabel.Height + MARGIN*2
	Dim lvHeight As Int = getListviewHeight(lvTop)
	dialogPanel.AddView(lv, MARGIN*2, lvTop, dialogPanel.Width - MARGIN*4, lvHeight)
End Sub

private Sub getListviewHeight(lvTop As Int) As Int
	If mCancelable Then
		Return cancelButton.Top - lvTop - MARGIN
	Else
		Return dialogPanel.Height - lvTop - MARGIN*2
	End If
End Sub

'for non-empty lists, check the list type, then load it into the listview accordingly
Private Sub loadListIntoDialog As Boolean
	If mList.Size = 0 Then
		LogColor("DOListDialog: list cannot be empty", Colors.Red)
		Return False
	End If
	lv.Clear
	If listIsDoubleLine Then
		For Each itemInstance As twoLineItem In mList
			lv.AddTwoLines(itemInstance.firstLine, itemInstance.secondLine)
		Next
	Else
		For Each itemString As String In mList
			lv.AddSingleLine(itemString)
		Next
	End If
	Return True
End Sub

'~show progress spinner while dialog is sizing?
'auto-size the dialog to the list, up to a max that allows margins on all sides.
private Sub sizeDialog
	Dim bestWidth As Int = getBestWidth
	Dim tempLeft As Int = maskPanel.Width/2 - bestWidth/2
	Dim bestHeight As Int = getBestHeight
	Dim tempTop As Int = maskPanel.Height/2 - bestHeight/2
	dialogPanel.SetLayout(tempLeft, tempTop, bestWidth, bestHeight)
	'adjust all views in dialogPanel
	titleLabel.SetLayout(MARGIN*2, MARGIN*2, dialogPanel.Width - MARGIN*4, titleLabel.Height)
	If mCancelable Then
		cancelButton.SetLayout(0, dialogPanel.Height - cancelButton.Height, dialogPanel.Width, cancelButton.Height)
	End If
	Dim lvTop As Int = titleLabel.Top + titleLabel.Height + MARGIN*2
	Dim lvHeight As Int = getListviewHeight(lvTop)
	lv.SetLayout(MARGIN*2, lvTop, dialogPanel.Width - MARGIN*4, lvHeight)
End Sub

'if layout requests best width, set width to largest of title width or Cancel button or longest item string,
'up to a max width allowing margin.
private Sub getBestWidth As Int
	If (mLayout = LAYOUT_AUTO_WIDTH) Or (mLayout = LAYOUT_AUTO_BOTH) Then
		Dim titleWidth As Int = measureTextWidth(titleLabel.Text, titleLabel.Typeface, titleLabel.TextSize)
		Dim itemWidth As Int
		Dim cancelWidth As Int
		If mCancelable Then
			cancelWidth = measureTextWidth(cancelButton.Text, cancelButton.Typeface, cancelButton.TextSize) + MARGIN*4
		End If
		Dim longestSingleString, longestDoubleString1, longestDoubleString2 As String
		If listIsDoubleLine Then
			longestDoubleString1 = findLongestFirstStringInDoubleList
			Dim line1Width As Int = measureTextWidth(longestDoubleString1, lv.TwoLinesLayout.Label.Typeface, _
				lv.TwoLinesLayout.Label.TextSize)
			longestDoubleString2 = findLongestSecondStringInDoubleList
			Dim line2Width As Int = measureTextWidth(longestDoubleString2, lv.TwoLinesLayout.SecondLabel.Typeface, _
				lv.TwoLinesLayout.SecondLabel.TextSize)
			itemWidth = Max(line1Width, line2Width)
		Else
			longestSingleString = findLongestStringInSingleList
			itemWidth = measureTextWidth(longestSingleString, lv.SingleLineLayout.Label.Typeface, _
				lv.SingleLineLayout.Label.TextSize)
		End If
		Dim biggestWidth As Int = Max(Max(titleWidth, cancelWidth), itemWidth)
		biggestWidth = biggestWidth + MARGIN*4 + MARGIN		'extra margin for safety
		'make sure it fits on the screen with space around it
		Return Min(maskPanel.Width - MARGIN*8, biggestWidth)
	Else
		Return dialogPanel.Width		'for other layouts, leave width unchanged
	End If
End Sub

'find the longest string in a single-line list
private Sub findLongestStringInSingleList As String
	Dim maxLength As Int
	Dim maxString As String
	For Each tempString As String In mList
		If tempString.Length > maxLength Then
			maxLength = tempString.Length
			maxString = tempString
		End If
	Next
	Return maxString
End Sub

private Sub findLongestFirstStringInDoubleList As String
	Dim maxLength As Int
	Dim maxString As String
	For Each tempItem As twoLineItem In mList
		If tempItem.firstLine.Length > maxLength Then
			maxLength = tempItem.firstLine.Length
			maxString = tempItem.firstLine
		End If
	Next
	Return maxString
End Sub

private Sub findLongestSecondStringInDoubleList As String
	Dim maxLength As Int
	Dim maxString As String
	For Each tempItem As twoLineItem In mList
		If tempItem.secondLine.Length > maxLength Then
			maxLength = tempItem.secondLine.Length
			maxString = tempItem.secondLine
		End If
	Next
	Return maxString
End Sub

'set height to fit items in list, up to max height allowing margin
private Sub getBestHeight As Int
	If (mLayout = LAYOUT_AUTO_HEIGHT) Or (mLayout = LAYOUT_AUTO_BOTH) Then
		Dim itemsHeight, smallestHeight As Int
		If listIsDoubleLine Then
			itemsHeight = lv.Size * lv.TwoLinesLayout.ItemHeight
		Else
			itemsHeight = lv.Size * lv.SingleLineLayout.ItemHeight
		End If
		smallestHeight = titleLabel.Top + titleLabel.Height + MARGIN + itemsHeight + MARGIN*2
		If mCancelable Then
			smallestHeight = smallestHeight + cancelButton.Height + MARGIN
		End If
		Return Min(maskPanel.Height - MARGIN*8, smallestHeight)
	Else
		Return dialogPanel.Height		'for other layouts, leave height unchanged
	End If
End Sub

private Sub listIsDoubleLine As Boolean
	Dim tempObject As Object = mList.Get(0)
	Return (tempObject Is twoLineItem)
End Sub

'If cancelable, tapping the background mask cancels the dialog and returns -1.
'Otherwise ignores clicks
private Sub maskPanel_Click
	If mCancelable Then
		closeDialog(NO_VALUE)
	Else
		'ignore click
	End If
End Sub

private Sub lv_ItemClick(Position As Int, Value As Object)
	closeDialog(Position)
End Sub

private Sub cancelButton_Click
	closeDialog(NO_VALUE)
End Sub

private Sub closeDialog(value As Int)
	maskPanel.SetVisibleAnimated(FADE_DURATION, False)
'	maskPanel.Visible = False
	Dim subName As String = mEventName & "_result"
	If SubExists(mCallback, subName) Then
		CallSub2(mCallback, subName, value)
	End If
End Sub

private Sub measureTextWidth(textArg As String, fontArg As Typeface, textSizeArg As Int) As Float
	Dim tempBitmap As Bitmap
	tempBitmap.InitializeMutable(10dip, 10dip)		'dimensions don't matter
	Dim cv As Canvas
	cv.Initialize2(tempBitmap)
	Return cv.MeasureStringWidth(textArg, fontArg, textSizeArg)
End Sub

'Private Sub Base_Resize (Width As Double, Height As Double)
'End Sub
#End Region