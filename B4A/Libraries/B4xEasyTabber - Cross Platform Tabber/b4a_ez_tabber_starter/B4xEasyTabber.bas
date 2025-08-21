B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.5
@EndOfDesignText@
'Custom View class 
'Written by: Jack Cole, Mindware Consulting, Inc.
'Create date: 11/13/2019
#Event: TabChanged (ActiveTabNumber As Int)
#DesignerProperty: Key: VisibleStartTab, DisplayName: Tab visible at Load, FieldType: Int, DefaultValue: 0
#DesignerProperty: Key: TabHeight, DisplayName: Tab strip height, FieldType: Int, DefaultValue: 50
#DesignerProperty: Key: TabNames, DisplayName: Tab names, FieldType: String, DefaultValue: Tab Name 1,TabName 2, Description: Enter tab names separated by a comma.
#DesignerProperty: Key: SelectedTabColor, DisplayName: Selected tab color, FieldType: Color, DefaultValue: 0xFFCFDCDC, Description: Color of the selected tab.
#DesignerProperty: Key: SelectedTabTextColor, DisplayName: Selected title text, FieldType: Color, DefaultValue: 0xFF252525, Description: Text color of the selected tab.
#DesignerProperty: Key: SelectedTabUnderlineColor, DisplayName: Selected underline color, FieldType: Color, DefaultValue: 0xFF212121, Description: Color of the line under the selected tab.
#DesignerProperty: Key: UnselectedTabColor, DisplayName: Unselected tab color, FieldType: Color, DefaultValue: 0xFFB7B7B7, Description: Color of the unselected tab.
#DesignerProperty: Key: UnselectedTabTextColor, DisplayName: Unselected title text, FieldType: Color, DefaultValue: 0xFF626161, Description: Text color of the unselected tabs.
#DesignerProperty: Key: UnselectedTabUnderlineColor, DisplayName: Unselected underline, FieldType: Color, DefaultValue: 0xFF757575, Description: Color of the line under the unselected tabs.
#DesignerProperty: Key: SeparatorColor, DisplayName: Separator, FieldType: Color, DefaultValue: 0xFF757575, Description: Color of the line separating tabs.
#DesignerProperty: Key: AnimationDuration, DisplayName: Animation Duration, FieldType: Int, DefaultValue: 400


Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private NumTabs As Int
	Private TabHeight, TabWidth As Int
	Type TabPanel (TabTitle As String, TabHolderPanel As Panel, TabUnderlinePanel As Panel,  TabTitleLabel As Label, TabRightSeparatorPanel As Panel, TabScreenContentPanel As Panel, Selected As Boolean)
	Type TabColors (TitleTextColor As Int, TabBackgroundColor As Int, UnderlineColor As Int, SeparatorColor As Int)
	Private SelectedTabColors, UnselectedTabColors As TabColors
	Private TheCurrentTab As Int
	Private AnimationDuration As Int
	Private TabsList As List
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	TabsList.Initialize
End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	mBase = Base
	InitTabColors(Props)
	TabHeight = Props.Get("TabHeight")*1dip
	TabsList.Initialize
	Dim TabTitles As String = Props.Get("TabNames")
	Dim TabTitlesList As List = Regex.Split(",", TabTitles)
	
	NumTabs = TabTitlesList.Size
	AnimationDuration = Props.Get("AnimationDuration")
	TabWidth=mBase.Width/NumTabs
	Dim StartPanel As Int = Props.Get("VisibleStartTab")
	For x = 0 To NumTabs-1
		Dim ThisTab As TabPanel 
		InitTab(ThisTab, TabTitlesList.Get(x), (x=0), x)	
		mBase.AddView(ThisTab.TabHolderPanel, x*TabWidth, 0, TabWidth, TabHeight)
		ThisTab.TabHolderPanel.AddView(ThisTab.TabUnderlinePanel, 0, TabHeight-5dip, TabWidth, 5dip)
		ThisTab.TabHolderPanel.AddView(ThisTab.TabRightSeparatorPanel, TabWidth-1dip, 0, 1dip, TabHeight-5dip)
		ThisTab.TabHolderPanel.AddView(ThisTab.TabTitleLabel, 0, 0, TabWidth, TabHeight)
		mBase.AddView(ThisTab.TabScreenContentPanel, 0, TabHeight, mBase.Width, mBase.Height-TabHeight)
#if b4a		
		Dim ro As RippleOverlay
		ro.Initialize(Me, mBase, ThisTab.TabTitleLabel, "Tab", Colors.ARGB(150, 200, 200, 200), TabWidth, False, 0, True, False, 150)
#end if
		TabsList.Add(ThisTab)
	Next
	setCurrentTab(StartPanel)
End Sub

Public Sub GetBase As Panel
	Return mBase
End Sub

Private Sub InitTabColors(Properties As Map)
	SelectedTabColors.Initialize
	SelectedTabColors.SeparatorColor=Properties.Get("SeparatorColor")
	SelectedTabColors.TabBackgroundColor=Properties.Get("SelectedTabColor")
	SelectedTabColors.TitleTextColor=Properties.Get("SelectedTabTextColor")
	SelectedTabColors.UnderlineColor=Properties.Get("SelectedTabUnderlineColor")
	UnselectedTabColors.Initialize
	UnselectedTabColors.SeparatorColor=Properties.Get("SeparatorColor")
	UnselectedTabColors.TabBackgroundColor=Properties.Get("UnselectedTabColor")
	UnselectedTabColors.TitleTextColor=Properties.Get("UnselectedTabTextColor")
	UnselectedTabColors.UnderlineColor=Properties.Get("UnselectedTabUnderlineColor")
End Sub

Private Sub InitTab(TabToInit As TabPanel, Title As String, Selected As Boolean, TabNumber As Int)
	TabToInit.Initialize
	TabToInit.TabHolderPanel.Initialize("")
	TabToInit.TabTitleLabel.Initialize("Tab")
	TabToInit.TabTitleLabel.Color=Colors.transparent
	TabToInit.TabUnderlinePanel.Initialize("")
	TabToInit.TabRightSeparatorPanel.Initialize("")
	TabToInit.TabScreenContentPanel.Initialize("")
	TabToInit.TabTitleLabel.Text=Title
	TabToInit.TabTitleLabel.Tag=TabNumber
	TabToInit.TabScreenContentPanel.Visible=Selected
	Dim b4xl As B4XView = TabToInit.TabTitleLabel
	b4xl.SetTextAlignment("CENTER", "CENTER")
	TabToInit.TabTitle=Title
End Sub

Private Sub SetTabColors(TabToColor As TabPanel, FromColors As TabColors, ToColors As TabColors, WithAnimation As Boolean)
	Dim AnimDuration As Int
	If WithAnimation Then AnimDuration = AnimationDuration
	Dim b4xp As B4XView = TabToColor.TabHolderPanel
	b4xp.SetColorAnimated(AnimDuration, FromColors.TabBackgroundColor, ToColors.TabBackgroundColor)
	b4xp=TabToColor.TabUnderlinePanel
	b4xp.SetColorAnimated(AnimDuration, FromColors.UnderlineColor, ToColors.UnderlineColor)
	TabToColor.TabTitleLabel.TextColor=ToColors.TitleTextColor
	TabToColor.TabTitleLabel.Color=Colors.Transparent
	'set separator color unless it is the last tab
	If Not(TabsList.IndexOf(TabToColor)=NumTabs-1) Then
		b4xp=TabToColor.TabRightSeparatorPanel
		b4xp.SetColorAnimated(AnimDuration, FromColors.SeparatorColor, ToColors.SeparatorColor)
	Else
		TabToColor.TabRightSeparatorPanel.Color=Colors.Transparent
	End If
End Sub


#Region Getters and Setters
'Change the current tab
Sub setCurrentTab(TabNumber As Int)
	Dim CurrentTabPanel As TabPanel = TabsList.Get(TabNumber)
	'if the tab is not set to selected then apply formatting and make visible
	If Not(CurrentTabPanel.Selected) Then
		Dim b4xv As B4XView = CurrentTabPanel.TabScreenContentPanel
		b4xv.SetVisibleAnimated(AnimationDuration, True)
		SetTabColors(CurrentTabPanel, UnselectedTabColors, SelectedTabColors, True)
		CurrentTabPanel.Selected=True
	End If
	
	'if another tab is selected besides TabNumber, then make the panel invisible.
	For x = 0 To TabsList.Size-1
		If x<>TabNumber Then
			Dim t As TabPanel = TabsList.Get(x)
			If t.selected Then
				Dim b4xv As B4XView = t.TabScreenContentPanel
				b4xv.SetVisibleAnimated(AnimationDuration, False)
				SetTabColors(t, SelectedTabColors, UnselectedTabColors, True)
				t.Selected=False
			Else
				Dim b4xv As B4XView = t.TabScreenContentPanel
				b4xv.SetVisibleAnimated(AnimationDuration, False)
				SetTabColors(t, UnselectedTabColors, UnselectedTabColors, False)
			End If
'			p.Visible=False
		End If
	Next
	TheCurrentTab=TabNumber
	CallSub2(mCallBack, mEventName & "_TabChanged", getCurrentTab)
End Sub

Public Sub getCurrentTab As Int
	Return TheCurrentTab
End Sub

'Public Sub LoadLayoutToPanel(PanelNumber As Int, Layout As String)
'	Dim CurrentPanel As Panel = PanelsList.Get(PanelNumber)
'	CurrentPanel.LoadLayout(Layout)
'End Sub

Public Sub GetTab(TabNumber As Int) As TabPanel
	Return TabsList.Get(TabNumber)
End Sub

Public Sub GetTabPanel(TabNumber As Int) As Panel
	Dim t As TabPanel = TabsList.Get(TabNumber)
	Return t.TabScreenContentPanel
End Sub

Public Sub GetTabTitlePanel(TabNumber As Int) As Panel
	Dim t As TabPanel = TabsList.Get(TabNumber)
	Return t.TabHolderPanel	
End Sub

Public Sub GetTabTitleLabel(TabNumber As Int) As Label
	Dim t As TabPanel = TabsList.Get(TabNumber)
	Return t.TabTitleLabel
End Sub

Public Sub SetColorsActiveTab(BackgroundColor As Int, TextColor As Int, UnderlineColor As Int, SeparatorColor As Int)
	SelectedTabColors.TabBackgroundColor=BackgroundColor
	SelectedTabColors.TitleTextColor=TextColor
	SelectedTabColors.SeparatorColor=SeparatorColor
	SelectedTabColors.UnderlineColor=UnderlineColor
	SetTabColors(GetTab(TheCurrentTab), SelectedTabColors, SelectedTabColors, False)
'	setCurrentTab(getCurrentTab)
End Sub

Public Sub SetColorsInactiveTab(BackgroundColor As Int, TextColor As Int, UnderlineColor As Int, SeparatorColor As Int)
	UnselectedTabColors.TabBackgroundColor=BackgroundColor
	UnselectedTabColors.TitleTextColor=TextColor
	UnselectedTabColors.SeparatorColor=SeparatorColor
	UnselectedTabColors.UnderlineColor=UnderlineColor
	setCurrentTab(getCurrentTab)
End Sub

#End Region

Private Sub Base_Resize (Width As Double, Height As Double)
	TabWidth=Width/NumTabs
	For x = 0 To TabsList.Size-1
		Dim t As TabPanel = TabsList.Get(x)
		t.TabHolderPanel.Width=TabWidth
		t.TabHolderPanel.Left=x*TabWidth
		t.TabRightSeparatorPanel.Left=TabWidth-1dip
		t.TabUnderlinePanel.Left=0
		t.TabUnderlinePanel.Width=TabWidth
		t.TabTitleLabel.Left=0
		t.TabTitleLabel.Width=TabWidth
		t.TabScreenContentPanel.Width=Width
		t.TabScreenContentPanel.Height=Height-TabHeight
	Next
End Sub

Sub Tab_Click
	Log("Tab_Click")
	Dim l As Label
#if b4i
	l = Sender
#else
	Dim ro As RippleOverlay = Sender
	l = ro.ViewOverlayed
#end if
	setCurrentTab(l.tag)
End Sub