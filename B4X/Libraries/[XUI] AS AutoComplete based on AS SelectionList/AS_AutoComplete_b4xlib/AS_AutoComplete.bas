B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
V1.01
	-New FontToBitmap
	-New TextToBitmap
	-BugFixes and Improvements
V1.02
	-New DisableTextChanged - If True then the menu is not opened via the TextChanged property
		-e.g. If you assign a text to the TextField in the code, the menu would otherwise be opened
	-BugFix DataSource1 had a logic error where duplicate entries were seen
V1.03
	-New SetCustomLayout - You decide where the Auto complete list should appear
	-New StandoutTextField
		-Default: True
		-If True, the background is darkened and the text field is brought to the foreground
		-If False, the list is simply displayed
			-The background panel remains transparent and the autocomplete is closed as soon as you click next to the menu
	-New get SelectionList
#End If

#Event: ItemClicked(Item As AS_SelectionList_Item)
#Event: RequestNewData(SearchText As String)

Sub Class_Globals
	Type AS_AutoComplete_InputViewSource(Left As Int,Top As Int,Width As Int,Height As Int,RootLeft As Int,RootTop As Int)
	Type AS_AutoComplete_DataSource1(Database As SQL,TableName As String,SearchColumn As String,ValueColumn As String)
	
	Private g_DataSource1 As AS_AutoComplete_DataSource1
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Public Tag As Object
	Private m_RootPanel As B4XView
	Private m_InputView As B4XView
	Private m_InputParent As B4XView
	
	Private xpnl_BackgroundPanel As B4XView
	
	Private g_InputViewSource As AS_AutoComplete_InputViewSource
	
	Private xiv_RefreshImage As B4XView
	
	Private AS_SelectionList1 As AS_SelectionList
	Private m_SuggestionMatchCount As Int = 2
	Private m_MaxVisibleItems As Int = 5
	Private isOpen As Boolean = False
	Private m_AfterItemClickCoolDown As Long = 1000
	Private m_AutoCloseOnItemClick As Boolean = True
	Private m_IgnoreTextChange As Boolean = False
	Private m_TextField2ListGap As Float = 5dip
	Private m_AutoCloseOnNoResults As Boolean = True
	Private m_KeyboardHeight As Float
	Private m_AnimationDuration As Long = 150
	Private m_DisableTextChanged As Boolean = False
	Private m_StandoutTextField As Boolean = True
	
	Private m_CustomLeft,m_CustomTop,m_CustomWidth,m_CustomHeight As Float = 0
	
End Sub

Public Sub setTheme(Theme As AS_SelectionList_Theme)
	AS_SelectionList1.Theme = Theme
End Sub

Public Sub getTheme_Dark As AS_SelectionList_Theme
	Return AS_SelectionList1.Theme_Dark
End Sub

Public Sub getTheme_Light As AS_SelectionList_Theme
	Return AS_SelectionList1.Theme_Light
End Sub

'InputView - Can be any view, e.g. B4XFloatTextField or AS_TextFieldAdvanced
Public Sub Initialize (Callback As Object, EventName As String,RootPanel As B4XView,InputView As B4XView)
	mEventName = EventName
	mCallBack = Callback
	m_RootPanel = RootPanel
	m_InputView = InputView
	
	xpnl_BackgroundPanel = xui.CreatePanel("xpnl_BackgroundPanel")
	xpnl_BackgroundPanel.Visible = False
	RootPanel.AddView(xpnl_BackgroundPanel,m_RootPanel.Left,-m_RootPanel.Top,Max(1dip,m_RootPanel.Width),Max(1dip,m_RootPanel.Height + m_RootPanel.Top))
	xpnl_BackgroundPanel.Color = xui.Color_ARGB(0,0,0,0)
	
	m_InputParent = InputView.Parent
	
	xiv_RefreshImage = CreateImageView("")
	xiv_RefreshImage.Visible = False
	xpnl_BackgroundPanel.AddView(xiv_RefreshImage,m_RootPanel.Left,m_RootPanel.Top,Max(1dip,m_RootPanel.Width),Max(1dip,m_RootPanel.Height))
	
	AS_SelectionList1.Initialize(Me,"AS_SelectionList1")
	AS_SelectionList1.CreateViewPerCode(xpnl_BackgroundPanel,0,0,xpnl_BackgroundPanel.Width,100dip)
	AS_SelectionList1.SelectionMode = AS_SelectionList1.SelectionMode_Single
	AS_SelectionList1.CornerRadius = 0
	AS_SelectionList1.SideGap = 0
	
End Sub

#Region Methods

'You decide where the Auto complete list should appear
'<code>AS_AutoComplete1.SetCustomLayout(TextField1.Left,TextField1.Top + TextField1.Height + 20dip,TextField1.Width,400dip)</code>
Public Sub SetCustomLayout(Left As Float,Top As Float,Width As Float,Height As Float)
	
	m_CustomLeft = Left
	m_CustomTop = Top
	m_CustomWidth = Width
	m_CustomHeight = Height

	If m_CustomLeft <> 0 Or m_CustomTop <> 0 Or m_CustomWidth <> 0 Or m_CustomHeight <> 0 Then
		AS_SelectionList1.Base_Resize(m_CustomWidth,m_CustomHeight)
		
		If m_StandoutTextField = False Then
			xpnl_BackgroundPanel.SetLayoutAnimated(0,m_CustomLeft,m_CustomTop,AS_SelectionList1.mBase.Width,AS_SelectionList1.mBase.Height)
			AS_SelectionList1.mBase.left = 0
			AS_SelectionList1.mBase.Top = 0
		Else
			AS_SelectionList1.mBase.left = m_CustomLeft
			AS_SelectionList1.mBase.Top = m_CustomTop
		End If

	End If
	
End Sub

Public Sub Show
	If xpnl_BackgroundPanel.Visible = False And isOpen = False Then
		isOpen = True
		
		If m_InputView.Parent = m_InputParent Then
			g_InputViewSource.Initialize
			g_InputViewSource.Left = m_InputView.Left
			g_InputViewSource.Top = m_InputView.Top
			g_InputViewSource.Width = m_InputView.Width
			g_InputViewSource.Height = m_InputView.Height
			g_InputViewSource.RootLeft = ViewScreenPosition(m_InputView)(0)
			g_InputViewSource.RootTop = ViewScreenPosition(m_InputView)(1)
		End If
		
		#If B4I
		xiv_RefreshImage.SetBitmap(m_RootPanel.Snapshot)
		xiv_RefreshImage.Visible = True
		#End if
		xpnl_BackgroundPanel.SetVisibleAnimated(0,True)
		
		'Sleep(0)
		
		If m_StandoutTextField Then
			
		#If B4I
		Dim ThisDummyTextField As B4XView = DummyTextField
		#End If
			
			m_InputView.RemoveViewFromParent
			xpnl_BackgroundPanel.AddView(m_InputView,g_InputViewSource.RootLeft,g_InputViewSource.RootTop,g_InputViewSource.Width,g_InputViewSource.Height)
			'm_InputView.RequestFocus
			SetInputViewFocus
			
			#If B4I
			ThisDummyTextField.RemoveViewFromParent
			#End If
			
		End If
		
		If m_CustomLeft <> 0 Or m_CustomTop <> 0 Or m_CustomWidth <> 0 Or m_CustomHeight <> 0 Then
			AS_SelectionList1.mBase.left = m_CustomLeft
			AS_SelectionList1.mBase.Top = m_CustomTop
			AS_SelectionList1.Base_Resize(m_CustomWidth,m_CustomHeight)
		Else
			AS_SelectionList1.mBase.left = g_InputViewSource.RootLeft
			AS_SelectionList1.mBase.Top = g_InputViewSource.RootTop + g_InputViewSource.Height + m_TextField2ListGap
			AS_SelectionList1.Base_Resize(g_InputViewSource.Width,AS_SelectionList1.ItemProperties.Height*m_MaxVisibleItems)
		End If
		
		If m_StandoutTextField = False Then
			xpnl_BackgroundPanel.SetLayoutAnimated(0,AS_SelectionList1.mBase.Left,AS_SelectionList1.mBase.Top,AS_SelectionList1.mBase.Width,AS_SelectionList1.mBase.Height)
			AS_SelectionList1.mBase.left = 0
			AS_SelectionList1.mBase.Top = 0
		End If
		
		'Sleep(2000)
		'Log("jetzt")
		xiv_RefreshImage.Visible = False
		xpnl_BackgroundPanel.SetVisibleAnimated(m_AnimationDuration,True)
		xpnl_BackgroundPanel.SetColorAnimated(m_AnimationDuration,xpnl_BackgroundPanel.Color,IIf(m_StandoutTextField,xui.Color_ARGB(152,0,0,0),xui.Color_Transparent))

	End If
End Sub

Private Sub SetInputViewFocus
	
'	Log(GetType(m_InputView))
'	Log(GetType(m_InputView.Tag))
	
	If GetType(m_InputView.Tag).Contains("as_textfieldadvanced") And xui.SubExists(m_InputView.Tag,"Focus",0) Then 'AS_TextFieldAdvanced
		CallSub(m_InputView.Tag,"Focus")'Ignore
	else If GetType(m_InputView.Tag).Contains("b4xfloattextfield") And xui.SubExists(m_InputView.Tag,"RequestFocusAndShowKeyboard",0) Then 'B4XFloatTextField
		CallSub(m_InputView.Tag,"RequestFocusAndShowKeyboard")
	Else
		m_InputView.RequestFocus
	End If
	
End Sub

#If B4I
'A dummy textfield to keep the keyboard open if the parent of the target textfield is changing
Private Sub DummyTextField As B4XView
	Dim tmpTextField As TextField
	tmpTextField.Initialize("")
	tmpTextField.Text = m_InputView.Text
	xpnl_BackgroundPanel.AddView(tmpTextField,0,0,0,0)
	If m_KeyboardHeight > 0 Then tmpTextField.RequestFocus
	Return tmpTextField
End Sub
	#End If

Public Sub Close
	If isOpen = False Then Return
	isOpen = False
	xpnl_BackgroundPanel.SetVisibleAnimated(m_AnimationDuration,False)
	
	If m_StandoutTextField Then
		
		If m_KeyboardHeight > 0 Then
		#If B4I
			Dim ThisDummyTextField As B4XView = DummyTextField
		#End If
		End If
	
		m_InputView.RemoveViewFromParent
		m_InputParent.AddView(m_InputView,g_InputViewSource.Left,g_InputViewSource.Top,g_InputViewSource.Width,g_InputViewSource.Height)
		If m_KeyboardHeight > 0 Then SetInputViewFocus
	
		If m_KeyboardHeight > 0 Then
		#If B4I
			ThisDummyTextField.RemoveViewFromParent
		#End If
		End If
		
	End If
	
	Sleep(m_AnimationDuration)
	
	xpnl_BackgroundPanel.Color = xui.Color_Transparent
End Sub

'If the RootPanel resize
Public Sub Resize(Width As Float,Height As Float)
	xpnl_BackgroundPanel.SetLayoutAnimated(0,m_RootPanel.Left,-m_RootPanel.Top,m_RootPanel.Width,m_RootPanel.Height + m_RootPanel.Top)
	xiv_RefreshImage.SetLayoutAnimated(0,m_RootPanel.Left,m_RootPanel.Top,m_RootPanel.Width,m_RootPanel.Height)
	
	g_InputViewSource.Width = m_InputView.Width
	g_InputViewSource.Height = m_InputView.Height
	
	If m_CustomLeft <> 0 Or m_CustomTop <> 0 Or m_CustomWidth <> 0 Or m_CustomHeight <> 0 Then
		AS_SelectionList1.Base_Resize(m_CustomWidth,m_CustomHeight)
	Else
		AS_SelectionList1.Base_Resize(g_InputViewSource.Width,AS_SelectionList1.ItemProperties.Height*m_MaxVisibleItems)
	End If
	
End Sub

'The view can automatically keep the items in the list visible even when the keyboard is out
'And the keyboard remains open when the menu is closed
Public Sub KeyboardStateChanged (Height As Float)
	m_KeyboardHeight = Height
End Sub


Public Sub TextChanged(Text As String)
	If m_IgnoreTextChange Or m_DisableTextChanged Then Return
	If Text.Length >= m_SuggestionMatchCount Then
		Wait For (FetchNewData(Text)) complete (ItemsFound As Boolean)
		If ItemsFound Then Show
	Else if isOpen Then
		Close
	End If
End Sub

Private Sub FetchNewData(SearchText As String) As ResumableSub
	
	If g_DataSource1.IsInitialized Then
        
		Dim lstParameters As List
		lstParameters.Initialize
        
		Dim Query As String = ""
		Query = $"SELECT ${g_DataSource1.SearchColumn},MAX(${g_DataSource1.ValueColumn}) AS ValueColumn FROM ${g_DataSource1.TableName}"$

		Dim WhereClause As StringBuilder
		Dim OrderByClause As StringBuilder
		WhereClause.Initialize
		OrderByClause.Initialize

		Dim Counter As Int = 0

		' WHERE-Klausel für Teilstring-Suche
		If WhereClause.Length > 0 Then WhereClause.Append(" OR ")
		WhereClause.Append(g_DataSource1.SearchColumn).Append(" LIKE ?")
		lstParameters.Add("%" & SearchText & "%")

		' ORDER BY für Treffer an erster Stelle
		If OrderByClause.Length > 0 Then OrderByClause.Append(", ")
		OrderByClause.Append("CASE WHEN ").Append(g_DataSource1.SearchColumn).Append(" LIKE ? THEN 0 ELSE 1 END")
		lstParameters.Add(SearchText & "%") ' Treffer nur am Anfang
		Counter = Counter + 1

		' Finaler Query-Aufbau
		Query = Query & " WHERE " & WhereClause.ToString
		' GROUP BY entfernen, wenn nicht benötigt
		Query = Query & " GROUP BY " & g_DataSource1.SearchColumn
		Query = Query & " ORDER BY " & OrderByClause.ToString

        
		'Log(Query)
        #If B4A
		Dim Paras(lstParameters.Size) As String
		For i = 0 To lstParameters.Size -1
			Paras(i) = lstParameters.Get(i)
		Next
		
		Dim DR As ResultSet = g_DataSource1.Database.ExecQuery2(Query,Paras)
		#Else
		Dim DR As ResultSet = g_DataSource1.Database.ExecQuery2(Query, lstParameters)
		#End If
        
		AS_SelectionList1.StartRefresh
		' Ergebnisse verarbeiten
		AS_SelectionList1.Clear
		AS_SelectionList1.SearchText = SearchText
		Do While DR.NextRow
			AS_SelectionList1.AddItem(DR.GetString(g_DataSource1.SearchColumn), Null, DR.GetString("ValueColumn"))
		Loop
		DR.Close
		AS_SelectionList1.StopRefresh
		
	Else 'Manual Mode
			
		AS_SelectionList1.StartRefresh
		' Ergebnisse verarbeiten
		AS_SelectionList1.Clear
		AS_SelectionList1.SearchText = SearchText
		RequestNewData(SearchText)
		Wait For ManualFillingFinished
		AS_SelectionList1.StopRefresh
		
	End If
	
	If AS_SelectionList1.Size = 0 And m_AutoCloseOnNoResults Then Close
	
	Return AS_SelectionList1.Size > 0
	
End Sub

Public Sub CreateItem(Text As String,Icon As B4XBitmap,Value As Object) As AS_SelectionList_Item
	Dim Item As AS_SelectionList_Item
	Item.Initialize
	Item.Text = Text
	Item.Icon = Icon
	Item.Value = Value
	Return Item
End Sub

Public Sub SetDataSource1(Database As SQL,TableName As String,SearchColumn As String,ValueColumn As String) As AS_AutoComplete_DataSource1
	g_DataSource1.Initialize
	g_DataSource1.Database = Database
	g_DataSource1.TableName = TableName
	g_DataSource1.SearchColumn = SearchColumn
	g_DataSource1.ValueColumn = ValueColumn
	Return g_DataSource1
End Sub

Public Sub SetNewData(ItemList As List)
	For Each Item As AS_SelectionList_Item In ItemList
		AS_SelectionList1.AddItem2(Item)
	Next
	CallSubDelayed(Me,"ManualFillingFinished")
End Sub

#End Region

#Region Properties

'If True, the background is darkened and the text field is brought to the foreground
'If False, the list is simply displayed
'	-The background panel remains transparent and all around can be clicked without closing the list 
'Default: True
Public Sub setStandoutTextField(StandoutTextField As Boolean)
	m_StandoutTextField = StandoutTextField
End Sub

Public Sub getStandoutTextField As Boolean
	Return m_StandoutTextField
End Sub

'If True then the menu is not opened via the TextChanged property
'e.g. If you assign a text to the TextField in the code, the menu would otherwise be opened
Public Sub getDisableTextChanged As Boolean
	Return m_DisableTextChanged
End Sub

Public Sub setDisableTextChanged(Disable As Boolean)
	m_DisableTextChanged = Disable
End Sub

'The duration for the opening and closing animation of the popup
'Default: 150 - Ticks/Milliseconds
Public Sub setAnimationDuration(Duration As Long)
	m_AnimationDuration = Duration
End Sub

Public Sub getAnimationDuration As Long
	Return m_AnimationDuration
End Sub

'Closes the autocomplete if no search results are found
'Default: True
Public Sub setAutoCloseOnNoResults(AutoCloseOnNoResults As Boolean)
	m_AutoCloseOnNoResults = AutoCloseOnNoResults
	AS_SelectionList1.EmptyListTextVisibility = AutoCloseOnNoResults = False
End Sub

Public Sub getAutoCloseOnNoResults As Boolean
	Return m_AutoCloseOnNoResults
End Sub

'The Gap between the TextField and the top of the List
'Default: 5dip
Public Sub setTextField2ListGap(Gap As Float)
	m_TextField2ListGap = Gap
End Sub

Public Sub getTextField2ListGap As Float
	Return m_TextField2ListGap
End Sub

'How long should the TextChange event be ignored after an item has been clicked on?
'Should prevent the autocomplete from opening again as soon as the text is added to the text field
'Default: 1000 = 1 Second
Public Sub setAfterItemClickCoolDown(Duration As Long)
	m_AfterItemClickCoolDown = Duration
End Sub

Public Sub getAfterItemClickCoolDown As Long
	Return m_AfterItemClickCoolDown
End Sub

'Should the dialog close automatically when an item is clicked
'Default: True
Public Sub setAutoCloseOnItemClick(AutoClose As Boolean)
	m_AutoCloseOnItemClick = AutoClose
End Sub

Public Sub getAutoCloseOnItemClick As Boolean
	Return m_AutoCloseOnItemClick
End Sub

'Default: 5
Public Sub setMaxVisibleItems(MaxItems As Int)
	m_MaxVisibleItems= MaxItems
End Sub

Public Sub getMaxVisibleItems As Int
	Return m_MaxVisibleItems
End Sub

'The minimum number of matching characters required to trigger suggestions with highlighted matches
'Default: 2
Public Sub setSuggestionMatchCount(Count As Int)
	m_SuggestionMatchCount = Count
End Sub

Public Sub getSuggestionMatchCount As Int
	Return m_SuggestionMatchCount
End Sub

Public Sub setSearchTextHighlightedColor(Color As Int)
	AS_SelectionList1.SearchTextHighlightedColor = Color
End Sub

Public Sub getSearchTextHighlightedColor As Int
	Return AS_SelectionList1.SearchTextHighlightedColor
End Sub

Public Sub getSelectionList As AS_SelectionList
	Return AS_SelectionList1
End Sub

#End Region

#Region Events

Private Sub RequestNewData(SearchText As String)
	If xui.SubExists(mCallBack, mEventName & "_RequestNewData",1) Then
		CallSub2(mCallBack, mEventName & "_RequestNewData",SearchText)
	End If
End Sub

Private Sub ItemClicked(Item As AS_SelectionList_Item)
	m_IgnoreTextChange = True
	If xui.SubExists(mCallBack, mEventName & "_ItemClicked",1) Then
		CallSub2(mCallBack, mEventName & "_ItemClicked",Item)
	End If
	Sleep(m_AfterItemClickCoolDown)
	m_IgnoreTextChange = False
End Sub

#End Region

#Region ViewEvents

'Private Sub AS_SelectionList1_CustomDrawItem(Item As Object,Views As AS_SelectionList_CustomDrawItemViews)
'
'End Sub

Private Sub AS_SelectionList1_SelectionChanged
	For Each Item As AS_SelectionList_Item In AS_SelectionList1.GetSelections
		ItemClicked(Item)
		If m_AutoCloseOnItemClick Then Close
		Exit
	Next
End Sub

#If B4J
Private Sub xpnl_BackgroundPanel_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xpnl_BackgroundPanel_Click	
#End If
	Close
End Sub

#End Region

#Region Functions

Private Sub ViewScreenPosition (view As B4XView) As Int()
    
	Dim leftTop(2) As Int
    #IF B4A
	Dim parent As B4XView = view
	Do While parent.IsInitialized and parent <> m_RootPanel
		leftTop(0) = leftTop(0) + parent.Left
		leftTop(1) = leftTop(1) + parent.Top
		parent = parent.Parent
	Loop
    #Else If B4I
	'https://www.b4x.com/android/forum/threads/absolute-position-of-view.56821/#content
    Dim parent As B4XView = view
    Do While GetType(parent) <> "B4IMainView"
        Dim no As NativeObject = parent
        leftTop(0) = leftTop(0) + parent.Left
        leftTop(1) = leftTop(1) + parent.Top
        parent = no.GetField("superview")
   Loop
    #Else
	Dim parent As B4XView = view
	Do While parent.IsInitialized
		leftTop(0) = leftTop(0) + parent.Left
		leftTop(1) = leftTop(1) + parent.Top
		parent = parent.Parent
	Loop
    #End If

	Return Array As Int(leftTop(0), leftTop(1))
End Sub

Private Sub CreateImageView(EventName As String) As B4XView
	Dim iv As ImageView
	iv.Initialize(EventName)
	Return iv
End Sub

'https://www.b4x.com/android/forum/threads/fontawesome-to-bitmap.95155/post-603250
Public Sub FontToBitmap (text As String, IsMaterialIcons As Boolean, FontSize As Float, color As Int) As B4XBitmap
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	Dim fnt As B4XFont
	If IsMaterialIcons Then fnt = xui.CreateMaterialIcons(FontSize) Else fnt = xui.CreateFontAwesome(FontSize)
	Dim r As B4XRect = cvs1.MeasureText(text, fnt)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(text, cvs1.TargetRect.CenterX, BaseLine, fnt, color, "CENTER")
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
End Sub

Public Sub TextToBitmap (Text As String, xFont As B4XFont, Color As Int) As B4XBitmap
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 32dip, 32dip)
	Dim cvs1 As B4XCanvas
	cvs1.Initialize(p)
	Dim r As B4XRect = cvs1.MeasureText(Text, xFont)
	Dim BaseLine As Int = cvs1.TargetRect.CenterY - r.Height / 2 - r.Top
	cvs1.DrawText(Text, cvs1.TargetRect.CenterX, BaseLine, xFont, Color, "CENTER")
	Dim b As B4XBitmap = cvs1.CreateBitmap
	cvs1.Release
	Return b
End Sub

#End Region
