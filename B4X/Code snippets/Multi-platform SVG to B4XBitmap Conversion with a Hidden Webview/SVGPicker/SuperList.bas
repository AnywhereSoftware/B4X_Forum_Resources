B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@

'	SL.NewItemEnabled = True
'	SL.Searchable = True
'	SL.MultipleSelection = True
'	SL.ConfirmSelection = True
'	SL.SearchStartWith = True
'
'	SL.Title =
'	SL.Hint =
'	SL.SmallHint =
'	SL.PresetText = 
'		
'	SL.BackColor
'	SL.ClearColor
'	SL.DoneColor
'	SL.ArrowColor
'	SL.SwitchColor


Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
#If B4J	
	Private fx As JFX
#End If
	Private cv As B4XCanvas
	Private cvRect As B4XRect
	Private textWidth, kbHeight As Float

	Private FTF As B4XFloatTextField
	Private CLVSearch, CLVResult As CustomListView 	'ignore
	Public LBLTitle As B4XView

	Private allSearches As Map
	Private itemList, currentList, selectedList As List

	Public dataOrderedMap As B4XOrderedMap
	Public dataMap As Map
	Public dataList As List
	Private activeKey As String
	Private busy, isSelected, saveStatus As Boolean

	Private callBack As Object
	Private searchPnl, resultPnl As B4XView
	Public layoutName As String
	Private eventName, customItem, completed As String
	Public Response As String
#If B4A
	Private kb As IME
#End If

'_________________________________________________________Settings
	'defaults are False
	Public NewItemEnabled As Boolean		'If true, a new entry in the search field (not present in the list) can be selected.
	Public Searchable As Boolean			'If true the list will be searchable
	Public MultipleSelection As Boolean		'If true, two CLV lists are shown with an arrow to transfer selected items from first panel to second panel
	Public ConfirmSelection As Boolean		'If true, the window is not closed when a selection is made. Not applicable when MultipleSelection is true
	Public SearchStartWith As Boolean		'If true, items have to start with the search string, not just contain it

	'defaults are blank
	Public Title As String					'B4XPage title
	Public Hint As String					'Prior to keystrokes - can be empty string
	Public SmallHint As String				'After keystrokes - can be empty string
	Public PresetText As String				'starts the textfield with text - start searching by backspacing or clearing - or check if this is what you want
		
	'defaults are Red, DarkGreen, Black and Black
	Public BackColor, ClearColor, DoneColor, ArrowColor, SwitchColor As Int	'arrow, clear and done are only visible when doing a multiple selection
	
	Public Background As B4XBitmap			'the image is shown behind the SuperList elements - default is no image
	Public OverlayColor As Int				'Used when a background is supplied - default is ARGB(125,255,255,255)
End Sub

'Initialize instance of SuperList, Items_ can be either List or Map, layoutName_ is the suffix of layout files
Public Sub Initialize(CallBack_ As Object, eventName_ As String) As Object
	callBack = CallBack_
	dataOrderedMap.Initialize
	dataMap.Initialize
	dataList.Initialize
	layoutName = "Default"
	eventName = eventName_
	customItem = eventName & "_Custom"
	completed = eventName & "_Complete"
	
	currentList.Initialize
	selectedList.Initialize
	allSearches.Initialize
	
	ClearColor = xui.Color_Red
	DoneColor = 0xFF418C4D
	ArrowColor = xui.Color_Black
	SwitchColor = xui.Color_Gray
	OverlayColor = xui.Color_ARGB(125,220,220,220)
	BackColor = xui.Color_RGB(220,220,220)
	Return Me
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	B4XPages.SetTitle(Me, "")
	Root = Root1
#If B4A
	kb.Initialize("")
#End If
	'itemList is the text version of the items
	If dataOrderedMap.Size > 0 Then
		itemList.Initialize
		For Each kw As String In dataOrderedMap.Keys
			itemList.Add(kw)
		Next
	Else If dataMap.Size > 0 Then
		itemList.Initialize
		For Each kw As String In dataMap.Keys
			itemList.Add(kw)
		Next
	Else if dataList.Size > 0 Then
		itemList = dataList
	End If
	
	'this sets the background to an image or simply a color	
	cv.Initialize(Root)
	Dim cvRect As B4XRect
	cvRect.Initialize(0, 0, Root.width, Root.Height)
	If Background.IsInitialized Then
		cv.DrawBitmap(Background, cvRect)
		cv.DrawRect(cvRect, OverlayColor, True, 0)
	Else
		cv.DrawRect(cvRect, BackColor, True, 0)
	End If
	
	'the screen is organized into two container panels (one if not multiple selections)
	searchPnl = xui.CreatePanel("")
	textWidth = (Root.Width - 20dip) / 2
	If Root.Width < Root.Height Then textWidth = (Root.Width - 20dip) / 1.5
	kbHeight = 180dip
	Dim resultHeight As Float = (Root.Height - kbHeight - 20dip) / 2
	If MultipleSelection Then		'An extra result panel requires some extra room
		If Root.Width > Root.Height Then
			Root.AddView(searchPnl, 10dip, 0, textWidth, Root.Height - kbHeight - 20dip)
		Else
			Dim dif As Float = 100dip
			resultHeight = (Root.Height - kbHeight - 20dip) / 1.5
			Root.AddView(searchPnl, Root.Width / 2 - textWidth / 2, 0, textWidth, resultHeight)
		End If
	Else
		Root.AddView(searchPnl, Root.Width / 2 - textWidth / 2, 0, textWidth, Root.Height - kbHeight - 20dip)
	End If
	searchPnl.LoadLayout("SLSearch_" & layoutName)
	Sleep(15)
	
	'hide the textfield if this is the simplest list
	If Searchable Or NewItemEnabled Or ConfirmSelection Then
		'FTF.textField.SetColorAndBorder(xui.Color_White, 0, 0, 0)
		FTF.HintText = Hint
		If MultipleSelection Then FTF.lblV.SendToBack
		FTF.Update
		If SubExists(callBack, "Switch") Then
			addTool(Chr(0xE915), "switch", xui.CreateMaterialIcons(20), ArrowColor, Root.Width - 50dip, 50dip)
		End If
	Else
		FTF.mBase.parent.Visible = False
		LBLTitle.Top = LBLTitle.Top + FTF.mBase.height
	End If
	
#If B4A
	'stop auto complete and suggestions	
	Dim et As EditText = FTF.Textfield	
	et.InputType = et.INPUT_TYPE_TEXT
	et.InputType = Bit.Or(et.InputType, 524288)
#End If
	CLVSearch.PressedColor = CLVSearch.GetBase.Color
	CLVSearch.sv.SetColorAndBorder(xui.Color_White, 0, 0, 0)
	If MultipleSelection Then		'Add second list
		resultPnl = xui.CreatePanel("")
		If Root.Width > Root.Height Then		'use landscape - side by side multiple selection
			Root.AddView(resultPnl, Root.Width - textWidth, CLVSearch.getBase.parent.top, textWidth - 25dip, CLVSearch.getBase.parent.Height)
		Else
			Dim dif As Float = 100dip
			resultHeight = (Root.Height - kbHeight - 20dip) / 1.5
			Root.AddView(resultPnl, Root.Width / 2 - (textWidth - 25) / 2, resultHeight + 20dip, textWidth - 25dip, resultHeight / 2 - dif)
		End If
		resultPnl.LoadLayout("SLMultiple_" & layoutName)
		Sleep(50)
		CLVResult.PressedColor = CLVResult.GetBase.Color
		CLVResult.sv.SetColorAndBorder(xui.Color_White, 0, 0, 0)
		If Root.Width > Root.Height Then
			addTool(Chr(0xE5C8), "all", xui.CreateMaterialIcons(20), ArrowColor, Root.Width / 2 - 15dip, resultHeight)
		Else
			addTool(Chr(0xE5DB), "all", xui.CreateMaterialIcons(20), ArrowColor, Root.Width / 2 - 5dip, resultPnl.Top - 20dip)
		End If
		addTool("CLEAR", "clearResults", xui.CreateDefaultBoldFont(14), ClearColor, resultPnl.Left + resultPnl.Width/2 - 45dip, resultPnl.Top + resultPnl.Height)
		addTool("DONE", "done", xui.CreateDefaultBoldFont(14), DoneColor, resultPnl.Left + resultPnl.Width/2 + 15dip, resultPnl.Top + resultPnl.Height)
	End If
	LBLTitle.Text = Title
End Sub

Private Sub B4Xpage_Appear
	If saveStatus Then		'switched to calling module
		saveStatus = False
		'FTF.RequestFocusAndShowKeyboard
	Else					'reset superList
		If MultipleSelection Then CLVResult.Clear
		resetList
		If FTF.mBase.parent.Visible Then
			If PresetText.length > 0 Then
				If Searchable Then
					'Simulate typing to allow creation of successive indices
					For i = 0 To PresetText.Length - 1
						FTF.Text = PresetText.SubString2(0, i + 1)
						FTF.TextField.SetSelection(PresetText.Length, 0)
						Sleep(50)
					Next
				Else If NewItemEnabled Or ConfirmSelection Then
					busy = True
					FTF.Text = PresetText
					FTF.TextField.SetSelection(PresetText.Length, 0)
				End If
			Else
				FTF.Text = ""
			End If
			busy = False
			'FTF.RequestFocusAndShowKeyboard
		End If
	End If
End Sub

Private Sub addTool(caption As String, eName As String, fnt As B4XFont, clr As Int, left As Float, top As Float)
	Dim toolX As B4XView = CreateLabel(eName)
	toolX.Font = fnt
	toolX.TextColor = clr
	toolX.Text = caption
	Root.AddView(toolX, left, top, 50dip, 20dip)
	If caption <> Chr(0xE915) Then toolX.Visible = MultipleSelection
End Sub

Private Sub resetList
	allSearches.Clear
	activeKey = "*all*"
	allSearches.Put(activeKey , itemList)
	selectedList.Clear
	CLVSearch.Clear
	Dim currentList As List: currentList.Initialize
	For Each s As String In itemList
		currentList.Add(s)
		addCLVItem(s)
	Next
End Sub

Private Sub FTF_EnterPressed
	If MultipleSelection Then 
		doneClicked
	Else
		Dim text As String = FTF.Text
		Dim found As Boolean
		For Each item As String In currentList
			Dim v() As String = Regex.Split("~", item)
			If text = v(0) Then
				found = True
				Exit
			End If
		Next
		If found = False And NewItemEnabled = False Then
			Sleep(0)
			FTF.RequestFocusAndShowKeyboard
			FTF.TextField.SetSelection(text.Length, 0)
			Return
		End If
		If MultipleSelection = False Then selectedList.Add(FTF.Text)
		composeResultAndClose
	End If
End Sub

Private Sub FTF_TextChanged (Old As String, New As String)
	If busy Then Return		'ignore when changing text with code
	If isSelected = False And Searchable = False And NewItemEnabled = False Then
		busy = True
		FTF.Text = ""
		busy = False
		Return
	End If
	If New.Length = 0 Then FTF.HintText = Hint Else FTF.HintText = SmallHint
	FTF.update
	
	If New.length < 2 Then
		If activeKey <> "*all*" Then resetList
	Else If Searchable Then 
		activeKey = New.toLowerCase
		If allSearches.ContainsKey(activeKey) = False Then
			Dim foundItems As List: foundItems.Initialize
			For Each item As String In currentList
				Dim v() As String = Regex.Split("~", item)
				Dim newKey As String = v(0) & "~" & activeKey
				If SearchStartWith Then
					If v(0).ToLowerCase.StartsWith(activeKey) Then foundItems.Add(newKey)
				Else
					If v(0).ToLowerCase.Contains(activeKey) Then foundItems.Add(newKey)
				End If
			Next
			CLVSearch.Clear
			Dim currentList As List: currentList.Initialize
			For Each item As String In foundItems
				currentList.Add(item)
				addCLVItem(item)
			Next
			Dim note As String = "__not in existing list__"
			If foundItems.size = 1 Then isSelected = True
			If foundItems.Size = 0 Then addCLVItem(note)
			allSearches.Put(activeKey, currentList)
			CLVSearch.JumpToItem(0)
		Else
			currentList = allSearches.Get(activeKey)
			CLVSearch.Clear
			For Each item As String In currentList
				addCLVItem(item)
			Next
			CLVSearch.JumpToItem(0)
		End If
	End If
End Sub

Private Sub CLVSearch_ItemClick (Index As Int, Value As Object)
	If Value = "__not in existing list__" Then Return
	busy = True
	If MultipleSelection Then
		transferItem(Value)
	Else
		If ConfirmSelection = False Then
			selectedList.Add(Value)
			composeResultAndClose
		Else
			isSelected = True
			FTF.Text = Value
			FTF.TextField.RequestFocus
			FTF.TextField.SetSelection(FTF.Text.Length, 0)
		End If
	End If
	Sleep(100)
	busy = False
End Sub

Private Sub CLVResult_ItemClick (Index As Int, Value As Object)
	Dim sf As Object = xui.Msgbox2Async("Remove item: " & Value, "Warning", "Yes", "Cancel", "", Null)
	Wait For (sf) Msgbox_Result (answer As Int)
	If answer = xui.DialogResponse_Positive Then
		CLVResult.RemoveAt(Index)
		selectedList.RemoveAt(Index)
	End If
End Sub

Private Sub addCLVItem(s As String)
	Dim pnl As B4XView = xui.CreatePanel("")
	pnl.Color = CLVSearch.GetBase.Color
	pnl.SetLayoutAnimated(0, 0, 0, CLVSearch.GetBase.Width, 40dip)
	If xui.IsB4J Then AddTextFlow(pnl, s) Else AddCSString(pnl, s)
End Sub

Private Sub transferItem(s As String)
	Dim pnl As B4XView = xui.CreatePanel("")
	pnl.Color = xui.Color_White
	pnl.SetLayoutAnimated(0, 0, 0, CLVResult.GetBase.Width - 50dip, 30dip)
	Dim lblx As B4XView = CreateLabel("")
	lblx.Text = s
	pnl.AddView(lblx, 0, 0, pnl.Width, pnl.Height)
	CLVResult.Add(pnl, s)
	selectedList.Add(s)
End Sub

#if B4J
Private Sub clearResults_MouseClicked(Ev As MouseEvent)
	clearResultsClicked
End Sub

Private Sub done_MouseClicked(Ev As MouseEvent)
	doneClicked
End Sub

Private Sub switch_MouseClicked (EventdataMap As MouseEvent)
	switchClicked
End Sub

Private Sub all_MouseClicked (EventdataMap As MouseEvent)
	allClicked
End Sub

#else if B4A Or B4i
Private Sub clearResults_Click
	clearResultsClicked
End Sub

Private Sub done_Click
	doneClicked
End Sub

Private Sub switch_Click
	switchClicked
End Sub

Private Sub all_Click
	allClicked
End Sub
#End If

Private Sub allClicked
	If currentList.Size = 0 And MultipleSelection = True And FTF.Text.Length > 0 And NewItemEnabled Then
		transferItem(FTF.Text)
	Else
		For Each item As String In currentList
			Dim v() As String = Regex.Split("~", item)
			transferItem(v(0))
		Next
	End If
End Sub

Private Sub switchClicked
	saveStatus = True
	If SubExists(callBack, "Switch") Then CallSub(callBack, "Switch")		'ignore
End Sub

Private Sub clearResultsClicked
	selectedList.Clear
	CLVResult.Clear
End Sub

Private Sub doneClicked
	composeResultAndClose
End Sub

'These two subs are needed to highlight search substrings in B4J, B4A, B4i, extracted from B4XSearchTemplate
Private Sub AddCSString(pnl As B4XView, s As String) 'ignore
#If B4A or B4
	Dim v() As String = Regex.Split("~", s)
	Dim cs As CSBuilder
	cs.Initialize
	If v.Length = 2 Then
		Dim k As Int = v(0).toLowerCase.IndexOf(v(1).toLowerCase)
		cs.Color(xui.Color_Black).Append(v(0).SubString2(0, k)).Pop
		cs.Color(xui.Color_Blue).Underline.Append(v(0).SubString2(k, k + v(1).length)).Pop.Pop
		cs.Color(xui.Color_Black).Append(v(0).SubString(k + v(1).length)).PopAll
	Else
		cs.Color(xui.Color_Black).Append(s).PopAll
	End If
	Dim lbl As Label
	lbl.Initialize("")
#if B4A
	lbl.Text = cs
#Else if B4i
	lbl.AttributedText = cs
#End If
	pnl.AddView(lbl, 0, 0, pnl.Width, pnl.Height)
	CLVSearch.Add(pnl, v(0))
#End If	
End Sub

Private Sub AddTextFlow(pnl As B4XView, s As String) 'ignore
#If B4J
	Dim tf As TextFlow
	tf.Initialize
	Dim v() As String = Regex.Split("~", s)
	tf.Initialize
	If v.Length = 2 Then
		Dim k As Int = v(0).toLowerCase.IndexOf(v(1).toLowerCase)
		tf.AddText(v(0).SubString2(0, k)).SetColor(fx.colors.Black)
		tf.AddText(v(0).SubString2(k, k + v(1).length)).SetColor(fx.colors.Blue).SetUnderline(True)
		tf.AddText(v(0).SubString(k + v(1).length)).SetColor(fx.colors.Black).SetUnderline(False)
	Else
		tf.AddText(s).SetColor(fx.colors.Black)
	End If
	Dim TextPane As B4XView = tf.CreateTextFlow
	TextPane.Color = xui.Color_White
	Dim textHeight As Float = cv.MeasureText("Xg", xui.CreateDefaultFont(FTF.TextField.textsize)).height
	pnl.AddView(TextPane, 0, pnl.Height / 2 - textHeight / 2 - 2dip, pnl.Width, textHeight)
	CLVSearch.Add(pnl, v(0))
#End If
End Sub

'Cancels search and closes instance of SuperList
Public Sub CancelSearch
	B4XPages.ClosePage(Me)
End Sub

'Needed to create custom item panels - lazy loading
Private Sub CLVSearch_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	If CLVSearch.Size = 0 Then Return
	For i = FirstIndex To LastIndex
		If LastIndex > CLVSearch.Size - 1 Then Exit
		Dim pnl As B4XView = CLVSearch.GetPanel(i)
		Dim txt As String = CLVSearch.GetValue(i)
		Dim textPnl As B4XView = pnl.GetView(0)
		If pnl.NumberOfViews = 1 And SubExists(callBack, customItem) Then
			Dim subpnl As B4XView = CallSub3(callBack, customItem, txt, pnl.Height.As(Float))
			pnl.AddView(subpnl, textPnl.Width - subpnl.width - 30, pnl.Height / 2 - subpnl.Height / 2, subpnl.Width, subpnl.Height)
		End If
	Next
End Sub

'Returns contents of the textfield, could be the last search substring or a new item
Public Sub GetEditText As String
	Return FTF.text
End Sub

'Creates a Label as a B4XView
Public Sub CreateLabel(eName As String) As B4XView	'ignore
	Dim lbl As Label
	lbl.Initialize(eName)
	Return lbl.As(B4XView)
End Sub

Private Sub composeResultAndClose
	isSelected = False
	Dim result As List: result.Initialize
	If currentList.Size = 0 And selectedList.Size = 1 Then
		Dim item As String = selectedList.Get(0)
		result.add(CreateKeyValues(item, Array As String("NEW ITEM")))
	Else
		For Each item As String In selectedList
			If dataOrderedMap.Size > 0 Then
				If dataOrderedMap.ContainsKey(item) Then
					Dim aList As List = dataOrderedMap.Get(item)
					For Each value() As String In aList
						result.add(CreateKeyValues(item, value))
					Next
				Else
					result.add(CreateKeyValues(item, Array As String("NEW ITEM")))
				End If
			Else If dataMap.Size > 0 Then
				If dataMap.ContainsKey(item) Then
					Dim aList As List = dataMap.Get(item)
					For Each value() As String In aList
						result.add(CreateKeyValues(item, value))
					Next
				Else
					result.add(CreateKeyValues(item, Array As String("NEW ITEM")))
				End If
			Else
				result.add(CreateKeyValues(item, Array As String()))
			End If
		Next
	End If
#If B4A
	kb.HideKeyboard
#End If
	If SubExists(callBack, completed) Then
		CallSubDelayed2(callBack, completed, result)
	End If
	B4XPages.ClosePage(Me)
End Sub

'Creates a KeyValues pair, values Is a string Array
Public Sub CreateKeyValues (key As String, values() As String) As KeyValues
	Dim t1 As KeyValues
	t1.Initialize
	t1.key = key
	t1.values = values
	Return t1
End Sub

Public Sub ApplyData
	itemList = dataList
End Sub