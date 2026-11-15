B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
#If Documentation
V1.00
	-Release
#End If
#DesignerProperty: Key: Theme, DisplayName: Theme, FieldType: String, DefaultValue: Auto, List: Auto|Dark|Light
#DesignerProperty: Key: TriggerText, DisplayName: Trigger Text, FieldType: String, DefaultValue: •••
#DesignerProperty: Key: MenuWidth, DisplayName: Menu Width, FieldType: Int, DefaultValue: 270, MinRange: 100
#DesignerProperty: Key: CornerRadius, DisplayName: Corner Radius, FieldType: Int, DefaultValue: 26, MinRange: 0
#DesignerProperty: Key: OpenOnPress, DisplayName: Open On Press, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: AnimationDuration, DisplayName: Animation Duration, FieldType: Int, DefaultValue: 220, MinRange: 0
#DesignerProperty: Key: CloseOnOutsideTap, DisplayName: Close On Outside Tap, FieldType: Boolean, DefaultValue: True
#Event: ItemClick (Index As Int, Item As AS_GlassMenu_Item)
#Event: OpenChanged (IsOpen As Boolean)
#Event: ItemFocusChanged (Index As Int)

Sub Class_Globals
	Type AS_GlassMenu_Item(Id As String, Title As String, Subtitle As String, IconName As String, Icon As B4XBitmap, Enabled As Boolean, Destructive As Boolean, Checked As Boolean, ShowCheck As Boolean, KeepOpen As Boolean, Value As Object, Kind As String, Content As B4XView, ContentHeight As Float, Callback As Object, EventName As String, AccessibilityLabel As String, IconView As B4XView, ContentWidth As Float, CheckBehavior As String, GroupId As String)
	Type AS_GlassMenu_MotionProperties(Jelly As Float, Speed As Float, Damping As Float, MorphBlur As Float, HighlightOpacity As Float, Shine As Float, Rim As Float, ReduceMotion As Boolean, AutoWidth As Boolean, MinWidth As Float, MaxWidth As Float, OverlayColor As Int)
	Type AS_GlassMenu_TriggerProperties(Glass As Boolean, CornerRadius As Float, BlurRadius As Float, GlassTint As Int, Saturation As Float, RefractionHeight As Float, Rim As Float, Shine As Float, Jelly As Float, MorphOrigin As String, ShrinkDuration As Int, ShrinkScale As Float, ShrinkDamping As Float, AbsorbDuration As Int, AbsorbDamping As Float, AccessibilityLabel As String)
	Type AS_GlassMenu_MenuProperties(Width As Float, RowHeight As Float, SubtitleRowHeight As Float, HeaderHeight As Float, SeparatorHeight As Float, CornerRadius As Float, Padding As Float, Margin As Float, Gap As Float, BlurRadius As Float, RefractionHeight As Float, BevelWidth As Float, DispersionStrength As Float, Saturation As Float, GlassTint As Int, TextColor As Int, SubtitleColor As Int, DestructiveColor As Int, SeparatorColor As Int, HighlightColor As Int, TitleFont As B4XFont, SubtitleFont As B4XFont, HeaderFont As B4XFont, IconSize As Float)
	Private xui As XUI
	Private mCallBack As Object
	Private mEventName As String
	Public mBase As B4XView
	Public Tag As Object
	Private m_Trigger As AS_LiquidGlass
	Private m_Glass As AS_LiquidGlass
	Private m_TriggerLabel As B4XView
	Private m_Parent As B4XView
	Private m_Backdrop As B4XView
	Private m_ParentBackdrop As B4XBitmap
	Private m_AutoBackdrop As Boolean = True
	Private xpnl_Overlay As B4XView
	Private xpnl_Input As B4XView
	Private xiv_Morph As B4XView
	Private xiv_TriggerMorph As B4XView
	Private xiv_MorphBlur As B4XView
	Private xpnl_TriggerInput As B4XView
	Private m_TriggerButtons As List
	Private m_CustomRows As Map
	Private m_CustomIcons As Map
	Private m_AccessibleRows As List
	Private m_Motion As AS_GlassMenu_MotionProperties
	Private m_TriggerProperties As AS_GlassMenu_TriggerProperties
	Private m_ReservesCheck As Boolean
	Private m_PressX, m_PressY As Float
	Private m_HasPress As Boolean
	Private m_PointerX As Float
	Private m_ActiveTrigger As B4XView
	Private m_OriginView As B4XView
	Private m_OriginWasVisible As Boolean
	Private m_Physics As Timer
	Private m_OffsetX, m_OffsetY, m_VelocityX, m_VelocityY As Float
	Private m_TargetX, m_TargetY As Float
	Private m_SystemTheme As String = "Dark"
	Private m_AppliedTheme As String
	Private m_MenuRenderKey As String
	Private m_TriggerRenderKey As String
	Private m_BackdropRevision As Int
	Private m_SystemReduceMotion As Boolean
	Private m_MorphAmount As Float
	Private m_TextCache As Map
	Private m_IconFont, m_CheckFont As B4XFont
	Private cvs As B4XCanvas
	Private m_Items As List
	Private m_Properties As AS_GlassMenu_MenuProperties
	Private m_Theme As String = "Auto"
	Private m_TriggerText As String = "•••"
	Private m_Alignment As String = "Auto"
	Private m_State As String = "Closed"
	Private m_Token As Int
	Private m_Disposed As Boolean
	Private m_OpenNotified As Boolean
	Private m_MorphReady As Boolean
	Private m_HideTrigger As Boolean
	Private m_TriggerWasVisible As Boolean
	Private m_Anchor, m_Bounds, m_MorphOrigin As B4XRect
	Private m_ScrollOffset As Float
	Private m_TotalHeight As Float
	Private m_SelectedIndex As Int = -1
	Private m_Dragging As Boolean
	Private m_PointerY As Float
	Private m_RowTops As List
	Private m_RowHeights As List
	Private tmr_Scroll As Timer
	Private m_OpenOnPress As Boolean = True
	Public CloseOnOutsideTap As Boolean = True
	Public AnimationDuration As Int = 220
End Sub

Public Sub Initialize(Callback As Object, EventName As String)
	mCallBack = Callback
	mEventName = EventName
	m_Items.Initialize
	m_TextCache.Initialize
	m_IconFont = xui.CreateFontAwesome(19)
	m_CheckFont = xui.CreateFontAwesome(16)
	m_TriggerButtons.Initialize
	m_CustomRows.Initialize
	m_CustomIcons.Initialize
	m_AccessibleRows.Initialize
	m_Physics.Initialize("Physics", 16)
	m_Motion.Initialize
	m_Motion.Jelly = 1
	m_Motion.Speed = 1
	m_Motion.Damping = 0.9
	m_Motion.MorphBlur = 0
	m_Motion.HighlightOpacity = 1
	m_Motion.Shine = 1
	m_Motion.Rim = 1
	m_Motion.AutoWidth = True
	m_Motion.MinWidth = 250dip
	m_Motion.MaxWidth = 420dip
	m_Motion.OverlayColor = 0x18000000
	m_TriggerProperties.Initialize
	m_TriggerProperties.Glass = True
	m_TriggerProperties.CornerRadius = -1
	m_TriggerProperties.BlurRadius = 1dip
	m_TriggerProperties.Saturation = 1
	m_TriggerProperties.RefractionHeight = 12dip
	m_TriggerProperties.Rim = 1
	m_TriggerProperties.Shine = 1
	m_TriggerProperties.Jelly = 1
	m_TriggerProperties.MorphOrigin = "Trigger"
	m_TriggerProperties.ShrinkDuration = 210
	m_TriggerProperties.ShrinkScale = 0.85
	m_TriggerProperties.ShrinkDamping = 0.85
	m_TriggerProperties.AbsorbDuration = 200
	m_TriggerProperties.AbsorbDamping = 0.9
	m_TriggerProperties.AccessibilityLabel = "Options"
	m_RowTops.Initialize
	m_RowHeights.Initialize
	tmr_Scroll.Initialize("tmr_Scroll", 40)
	m_Properties.Initialize
	m_Properties.Width = 270dip
	m_Properties.RowHeight = 42dip
	m_Properties.SubtitleRowHeight = 58dip
	m_Properties.HeaderHeight = 30dip
	m_Properties.SeparatorHeight = 21dip
	m_Properties.CornerRadius = 26dip
	m_Properties.Padding = 10dip
	m_Properties.Margin = 12dip
	m_Properties.Gap = 8dip
	m_Properties.BlurRadius = 12dip
	m_Properties.RefractionHeight = 10dip
	m_Properties.BevelWidth = 18dip
	m_Properties.DispersionStrength = 0.1
	m_Properties.Saturation = 1
	m_Properties.TitleFont = xui.CreateDefaultFont(17)
	m_Properties.SubtitleFont = xui.CreateDefaultFont(13)
	m_Properties.HeaderFont = xui.CreateDefaultBoldFont(12)
	m_Properties.IconSize = 20dip
	setTheme("Auto")
End Sub

Public Sub CreateViewPerCode(Parent As B4XView, Left As Float, Top As Float, Width As Float, Height As Float)
	Dim base As B4XView = xui.CreatePanel("")
	Parent.AddView(base, Left, Top, Width, Height)
	Dim lbl As Label
	lbl.Initialize("")
	DesignerCreateView(base, lbl, CreateMap())
End Sub

Public Sub DesignerCreateView(Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	m_Parent = mBase.Parent
	m_TriggerText = Props.GetDefault("TriggerText", "•••")
	m_Properties.Width = DipToCurrent(Props.GetDefault("MenuWidth", 270))
	m_Properties.CornerRadius = DipToCurrent(Props.GetDefault("CornerRadius", 26))
	m_OpenOnPress = Props.GetDefault("OpenOnPress", True)
	CloseOnOutsideTap = Props.GetDefault("CloseOnOutsideTap", True)
	AnimationDuration = Max(0, Props.GetDefault("AnimationDuration", 220))
	setTheme(Props.GetDefault("Theme", "Auto"))
	mBase.Color = xui.Color_Transparent
	m_Trigger.Initialize(Me, "Trigger")
	m_Trigger.CreateViewPerCode(mBase, 0, 0, mBase.Width, mBase.Height)
	Dim label As Label
	label.Initialize("")
	m_TriggerLabel = label
	m_TriggerLabel.SetTextAlignment("CENTER", "CENTER")
	m_TriggerLabel.Font = xui.CreateDefaultBoldFont(22)
	m_Trigger.ContentPanel.AddView(m_TriggerLabel, 0, 0, mBase.Width, mBase.Height)
	xpnl_TriggerInput = CreateTriggerButton(mBase, 0, 0, mBase.Width, mBase.Height)
	xpnl_TriggerInput.Visible = m_OpenOnPress
	m_ActiveTrigger = xpnl_TriggerInput
	#If B4J
	m_TriggerLabel.As(JavaObject).RunMethod("setMouseTransparent", Array(True))
	#Else If B4i
	m_TriggerLabel.As(Label).UserInteractionEnabled = False
	#End If
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Private Sub Base_Resize(Width As Double, Height As Double)
	If m_Trigger.IsInitialized = False Then Return
	m_Trigger.BeginUpdate
	If m_Trigger.ContentPanel.Width <> Width Or m_Trigger.ContentPanel.Height <> Height Then m_Trigger.Resize(Width, Height)
	m_TriggerLabel.SetLayoutAnimated(0, 0, 0, Width, Height)
	If xpnl_TriggerInput.IsInitialized Then xpnl_TriggerInput.SetLayoutAnimated(0, 0, 0, Width, Height)
	CaptureParentBackdrop
	RefreshTrigger
	m_Trigger.EndUpdate
End Sub

Public Sub Resize(Width As Float, Height As Float)
	mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top, Width, Height)
	Base_Resize(Width, Height)
End Sub

'Use a root panel to cover the whole page when the trigger is nested.
'Call while closed. Anchor/source coordinates must be descendants of this parent.
Public Sub SetOverlayParent(Parent As B4XView)
	If m_State <> "Closed" Then Return
	m_Parent = Parent
	RefreshTrigger
End Sub

'A separate scene panel behind the trigger/menu. Never use their common ancestor.
Public Sub SetBackdropView(Source As B4XView)
	If mBase.IsInitialized Then
		Dim ancestor As B4XView = mBase
		Do While ancestor.IsInitialized
			If ancestor = Source Then
				Log("AS_GlassMenu: backdrop must not contain the trigger.")
				Return
			End If
			ancestor = ParentViewOrEmpty(ancestor)
		Loop
	End If
	m_Backdrop = Source
	m_BackdropRevision = m_BackdropRevision + 1
	Refresh
End Sub

'Returns a mutable item. After editing returned fields, call RefreshMenu.
Public Sub AddItem(Id As String, Title As String, IconName As String, Value As Object) As AS_GlassMenu_Item
	Dim item As AS_GlassMenu_Item
	item.Initialize
	item.Id = Id
	item.Title = Title
	item.IconName = IconName
	item.Enabled = True
	item.Value = Value
	item.Kind = "Item"
	m_Items.Add(item)
	Return item
End Sub

'Standard action without a separate Value argument.
Public Sub AddAction(Id As String, Title As String, IconName As String) As AS_GlassMenu_Item
	Return AddItem(Id, Title, IconName, Null)
End Sub

Public Sub AddDestructiveAction(Id As String, Title As String, IconName As String) As AS_GlassMenu_Item
	Dim item As AS_GlassMenu_Item = AddAction(Id, Title, IconName)
	item.Destructive = True
	Return item
End Sub

'Checked state toggles automatically when selected. No host refresh/state code needed.
Public Sub AddCheckItem(Id As String, Title As String, IconName As String, Checked As Boolean) As AS_GlassMenu_Item
	Dim item As AS_GlassMenu_Item = AddAction(Id, Title, IconName)
	item.CheckBehavior = "Toggle"
	item.Checked = Checked
	item.ShowCheck = True
	item.KeepOpen = True
	Return item
End Sub

'Exactly one selected row per GroupId. Selecting a row updates its whole group.
Public Sub AddRadioItem(Id As String, Title As String, IconName As String, GroupId As String, Checked As Boolean) As AS_GlassMenu_Item
	Dim item As AS_GlassMenu_Item = AddCheckItem(Id, Title, IconName, Checked)
	item.CheckBehavior = "Radio"
	item.GroupId = GroupId
	If Checked Then
		For Each sibling As AS_GlassMenu_Item In m_Items
			If sibling <> item And sibling.CheckBehavior = "Radio" And sibling.GroupId = GroupId Then sibling.Checked = False
		Next
	End If
	Return item
End Sub

Public Sub AddSeparator
	Dim item As AS_GlassMenu_Item
	item.Initialize
	item.Kind = "Separator"
	m_Items.Add(item)
End Sub

Public Sub AddLabel(Text As String)
	Dim item As AS_GlassMenu_Item
	item.Initialize
	item.Kind = "Label"
	item.Title = Text
	m_Items.Add(item)
End Sub

Public Sub GetItem(Index As Int) As AS_GlassMenu_Item
	Return m_Items.Get(Index)
End Sub

Public Sub RemoveItem(Index As Int)
	m_Items.RemoveAt(Index)
	RefreshMenu
End Sub

Public Sub Clear
	m_Items.Clear
	Close
End Sub

'Creates a dedicated touch target inside a larger custom trigger/pill.
'Add custom artwork to this panel. With OpenOnPress=False only these subbuttons open.
Public Sub CreateTriggerButton(Parent As B4XView, Left As Float, Top As Float, Width As Float, Height As Float) As B4XView
	Dim panel As B4XView = xui.CreatePanel("TriggerButton")
	Parent.AddView(panel, Left, Top, Width, Height)
	panel.Color = xui.Color_Transparent
	m_TriggerButtons.Add(panel)
	#If B4A
	Dim native As JavaObject = Me
	native.RunMethod("configureTriggerAccessibility", Array(panel, m_TriggerProperties.AccessibilityLabel))
	#End If
	Return panel
End Sub

'Arbitrary B4X icon view, including your own SVG/image/custom control.
Public Sub SetItemIconView(Index As Int, IconView As B4XView)
	Dim item As AS_GlassMenu_Item = GetItem(Index)
	item.IconView = IconView
	RefreshMenu
End Sub

'Custom content replaces the built-in icon/title/subtitle; metadata stays available.
'The supplied panel is reparented on opening. Custom controls keep their own events.
Public Sub SetItemContent(Index As Int, Content As B4XView, Height As Float)
	Dim item As AS_GlassMenu_Item = GetItem(Index)
	item.Content = Content
	item.ContentWidth = Content.Width
	item.ContentHeight = Max(1dip, Height)
	RefreshMenu
End Sub

'The named event receives (Index As Int, Item As AS_GlassMenu_Item).
Public Sub SetItemCallback(Index As Int, Callback As Object, EventName As String)
	Dim item As AS_GlassMenu_Item = GetItem(Index)
	item.Callback = Callback
	item.EventName = EventName
End Sub

Private Sub TriggerPointer(Target As B4XView, Action As Int, X As Float, Y As Float)
	If m_Disposed Or m_State <> "Closed" Then Return
	If Target = xpnl_TriggerInput And m_OpenOnPress = False Then Return
	If Action = 0 Or Action = 2 Then
		m_ActiveTrigger = Target
		Dim anchor As B4XRect = RelativeBounds(Target)
		m_PressX = anchor.Left + X
		m_PressY = anchor.Top + Y
		m_HasPress = True
		Dim swell As Float = IIf(EffectiveReduceMotion, 0, 0.04 * Max(0, m_TriggerProperties.Jelly))
		ApplyTransform(m_Trigger.mBase, 1 + swell, 1 + swell, 0, 0)
	Else
		ApplyTransform(m_Trigger.mBase, 1, 1, 0, 0)
		If Action = 1 And m_HasPress And X >= 0 And Y >= 0 And X <= Target.Width And Y <= Target.Height Then
			If Target = xpnl_TriggerInput Then
				Show
			Else
				ShowOnView(Target)
			End If
		Else
			m_HasPress = False
		End If
	End If
End Sub

#If B4J
Private Sub TriggerButton_MousePressed(EventData As MouseEvent)
	EventData.Consume
	TriggerPointer(Sender, 0, EventData.X, EventData.Y)
End Sub
Private Sub TriggerButton_MouseDragged(EventData As MouseEvent)
	EventData.Consume
	TriggerPointer(Sender, 2, EventData.X, EventData.Y)
End Sub
Private Sub TriggerButton_MouseReleased(EventData As MouseEvent)
	EventData.Consume
	TriggerPointer(Sender, 1, EventData.X, EventData.Y)
End Sub
#Else
Private Sub TriggerButton_Touch(Action As Int, X As Float, Y As Float)
	TriggerPointer(Sender, Action, X, Y)
End Sub
#End If

Private Sub Trigger_Click
	If m_OpenOnPress Then Show
End Sub

Public Sub Show
	If mBase.IsInitialized = False Then Return
	ShowOnView(mBase)
End Sub

'Anchors to a view within OverlayParent. Its visible bounds are the morph origin.
'Untransformed panel hierarchies are supported; scrolling offsets are not inferred.
Public Sub ShowOnView(Anchor As B4XView)
	If m_Disposed Or m_State <> "Closed" Or m_Items.Size = 0 Then Return
	Dim bounds As B4XRect = RelativeBounds(Anchor)
	If bounds.Width <= 0 Then
		m_HideTrigger = False
		Return
	End If
	m_HideTrigger = Anchor = mBase
	m_ActiveTrigger = Anchor
	If m_HideTrigger = False Then
		m_OriginView = Anchor
		m_OriginWasVisible = Anchor.Visible
	End If
	ShowAt(bounds.Left, bounds.Top, bounds.Width, bounds.Height)
End Sub

'Anchor rectangle in OverlayParent coordinates. Width/height also define close origin.
Public Sub ShowAt(Left As Float, Top As Float, Width As Float, Height As Float)
	If m_Disposed Or m_State <> "Closed" Or m_Items.Size = 0 Then Return
	If m_Parent.IsInitialized = False Then Return
	If m_Parent.Width < 1dip Or m_Parent.Height < 1dip Then Return
	SampleSystemReduceMotion
	If m_Theme = "Auto" And m_AppliedTheme <> ResolvedTheme Then ApplyThemeColors
	CaptureParentBackdrop
	RefreshTrigger
	m_Anchor.Initialize(Left, Top, Left + Max(1dip, Width), Top + Max(1dip, Height))
	Dim origin As B4XRect
	origin.Initialize(m_Anchor.Left, m_Anchor.Top, m_Anchor.Right, m_Anchor.Bottom)
	If m_TriggerProperties.MorphOrigin.ToLowerCase = "press" And m_HasPress Then origin.Initialize(m_PressX - 12dip, m_PressY - 12dip, m_PressX + 12dip, m_PressY + 12dip)
	m_MorphOrigin = origin
	m_HasPress = False
	If mBase.IsInitialized Then m_TriggerWasVisible = mBase.Visible
	m_State = "Opening"
	m_MorphReady = False
	m_Token = m_Token + 1
	Dim token As Int = m_Token
	m_SelectedIndex = -1
	m_ScrollOffset = 0
	CreatePopup
	If m_Bounds.Width <= 0 Or m_Bounds.Height <= 0 Then
		CloseImmediately
		Return
	End If
	'Keep the full-size popup concealed until the first transition frame.
	SetViewOpacity(m_Glass.mBase, 0)
	'Allow native views/canvas to finish their first layout before taking the morph image.
	Sleep(0)
	If token <> m_Token Then Return
	SetViewOpacity(m_Glass.mBase, 1)
	SetMorphBitmap(m_Glass.mBase.Snapshot)
	If m_ActiveTrigger.IsInitialized Then
		Dim bc As BitmapCreator
		bc.Initialize(1, 1)
		Dim triggerImage As B4XBitmap = m_ActiveTrigger.Snapshot
		If m_HideTrigger Then triggerImage = mBase.Snapshot
		bc.SetBitmapToImageView(triggerImage, xiv_TriggerMorph)
	End If
	m_Glass.mBase.Visible = False
	If m_HideTrigger And mBase.IsInitialized Then
		mBase.Visible = False
	End If
	If m_OriginView.IsInitialized Then m_OriginView.Visible = False
	xiv_Morph.Visible = True
	xiv_MorphBlur.Visible = True
	Wait For (AnimateMorph(True, origin, token)) Complete (completed As Boolean)
	If completed = False Then Return
	If token <> m_Token Then Return
	xiv_Morph.Visible = False
	xiv_MorphBlur.Visible = False
	xiv_TriggerMorph.Visible = False
	m_Glass.mBase.Visible = True
	SetViewOpacity(m_Glass.mBase, 1)
	m_State = "Open"
	m_OpenNotified = True
	NotifyOpenChanged(True)
	If m_State = "Open" And token = m_Token Then BuildAccessibleRows
End Sub

Private Sub CreatePopup
	m_MenuRenderKey = ""
	xpnl_Overlay = xui.CreatePanel("Overlay")
	m_Parent.AddView(xpnl_Overlay, 0, 0, m_Parent.Width, m_Parent.Height)
	xpnl_Overlay.Color = m_Motion.OverlayColor
	m_Glass.Initialize(Me, "MenuGlass")
	m_Glass.CreateViewPerCode(xpnl_Overlay, 0, 0, 1dip, 1dip)
	xpnl_Input = xui.CreatePanel("MenuInput")
	m_Glass.ContentPanel.AddView(xpnl_Input, 0, 0, 1dip, 1dip)
	cvs.Initialize(xpnl_Input)
	Dim blurIV As ImageView
	blurIV.Initialize("")
	xiv_MorphBlur = blurIV
	xpnl_Overlay.AddView(xiv_MorphBlur, 0, 0, 1dip, 1dip)
	xiv_MorphBlur.Visible = False
	Dim iv As ImageView
	iv.Initialize("")
	xiv_Morph = iv
	xpnl_Overlay.AddView(xiv_Morph, 0, 0, 1dip, 1dip)
	xiv_Morph.Visible = False
	Dim triggerIV As ImageView
	triggerIV.Initialize("")
	xiv_TriggerMorph = triggerIV
	xpnl_Overlay.AddView(xiv_TriggerMorph, 0, 0, 1dip, 1dip)
	xiv_TriggerMorph.Visible = False
	#If B4J
	xiv_Morph.As(JavaObject).RunMethod("setMouseTransparent", Array(True))
	xiv_MorphBlur.As(JavaObject).RunMethod("setMouseTransparent", Array(True))
	xiv_TriggerMorph.As(JavaObject).RunMethod("setMouseTransparent", Array(True))
	xpnl_Overlay.As(JavaObject).RunMethod("setFocusTraversable", Array(True))
	xpnl_Overlay.As(JavaObject).RunMethod("requestFocus", Null)
	#Else If B4i
	xiv_Morph.As(ImageView).UserInteractionEnabled = False
	xiv_MorphBlur.As(ImageView).UserInteractionEnabled = False
	xiv_TriggerMorph.As(ImageView).UserInteractionEnabled = False
	#End If
	RefreshMenu
	#If B4A
	Dim native As JavaObject = Me
	native.RunMethod("configureOverlayKeys", Array(xpnl_Overlay))
	#End If
End Sub

'Redraw after changing item fields or MenuProperties. Geometry changes reset selection.
Public Sub RefreshMenu
	If m_State = "Closed" Or m_Disposed Then Return
	m_TextCache.Clear
	m_RowTops.Clear
	m_RowHeights.Clear
	m_TotalHeight = 0
	m_ReservesCheck = False
	For Each item As AS_GlassMenu_Item In m_Items
		If item.ShowCheck Or item.Checked Then m_ReservesCheck = True
	Next
	For Each item As AS_GlassMenu_Item In m_Items
		Dim h As Float = m_Properties.RowHeight
		If item.Kind = "Label" Then h = m_Properties.HeaderHeight
		If item.Kind = "Separator" Then h = m_Properties.SeparatorHeight
		If item.Kind = "Item" And item.Subtitle <> "" Then h = m_Properties.SubtitleRowHeight
		If item.Content.IsInitialized Then h = Max(1dip, item.ContentHeight)
		h = Max(1dip, h)
		m_RowTops.Add(m_TotalHeight)
		m_RowHeights.Add(h)
		m_TotalHeight = m_TotalHeight + h
	Next
	Dim margin As Float = Max(0, m_Properties.Margin)
	Dim requestedWidth As Float = m_Properties.Width
	If m_Motion.AutoWidth Then
		requestedWidth = Max(100dip, m_Motion.MinWidth)
		For Each item As AS_GlassMenu_Item In m_Items
			Dim leading As Float = TextLeading(item)
			Dim measured As Float = Max(cvs.MeasureText(item.Title, m_Properties.TitleFont).Width, cvs.MeasureText(item.Subtitle, m_Properties.SubtitleFont).Width)
			If item.Content.IsInitialized Then
				If item.ContentWidth <= 0 Then item.ContentWidth = item.Content.Width
				measured = item.ContentWidth
			End If
			requestedWidth = Max(requestedWidth, measured + leading + 24dip + m_Properties.Padding * 2)
		Next
		requestedWidth = Min(requestedWidth, Max(m_Motion.MinWidth, m_Motion.MaxWidth))
	End If
	Dim w As Float = Min(Max(100dip, requestedWidth), Max(1dip, m_Parent.Width - margin * 2))
	Dim h As Float = Min(m_TotalHeight + Max(0, m_Properties.Padding) * 2, Max(1dip, m_Parent.Height - margin * 2))
	Dim left As Float = m_Anchor.Right - w
	Select m_Alignment.ToLowerCase
		Case "start": left = m_Anchor.Left
		Case "center": left = m_Anchor.CenterX - w / 2
		Case "auto"
			If m_Anchor.CenterX < m_Parent.Width / 2 Then left = m_Anchor.Left
	End Select
	left = Max(margin, Min(left, m_Parent.Width - margin - w))
	Dim top As Float = m_Anchor.Bottom + m_Properties.Gap
	If top + h > m_Parent.Height - margin Then top = m_Anchor.Top - m_Properties.Gap - h
	top = Max(margin, Min(top, m_Parent.Height - margin - h))
	m_Bounds.Initialize(left, top, left + w, top + h)
	m_Glass.BeginUpdate
	m_Glass.mBase.SetLayoutAnimated(0, left, top, w, h)
	If m_Glass.ContentPanel.Width <> w Or m_Glass.ContentPanel.Height <> h Then m_Glass.Resize(w, h)
	If m_Glass.CornerRadius <> Max(0, m_Properties.CornerRadius) Then m_Glass.CornerRadius = Max(0, m_Properties.CornerRadius)
	If m_Glass.BlurRadius <> m_Properties.BlurRadius Then m_Glass.BlurRadius = m_Properties.BlurRadius
	If m_Glass.RefractionHeight <> m_Properties.RefractionHeight Then m_Glass.RefractionHeight = m_Properties.RefractionHeight
	If m_Glass.BevelWidth <> m_Properties.BevelWidth Then m_Glass.BevelWidth = m_Properties.BevelWidth
	If m_Glass.DispersionStrength <> m_Properties.DispersionStrength Then m_Glass.DispersionStrength = m_Properties.DispersionStrength
	If m_Glass.Saturation <> m_Properties.Saturation Then m_Glass.Saturation = m_Properties.Saturation
	If m_Glass.GlassTint <> m_Properties.GlassTint Then m_Glass.GlassTint = m_Properties.GlassTint
	If m_Glass.HighlightOpacity <> Max(0, Min(1, m_Motion.Shine * 0.7)) Then m_Glass.HighlightOpacity = Max(0, Min(1, m_Motion.Shine * 0.7))
	If m_Glass.RimOpacity <> Max(0, Min(1, m_Motion.Rim * 0.2)) Then m_Glass.RimOpacity = Max(0, Min(1, m_Motion.Rim * 0.2))
	Dim padding As Float = Min(Max(0, m_Properties.Padding), Min(w, h) / 3)
	xpnl_Input.SetLayoutAnimated(0, padding, padding, w - padding * 2, h - padding * 2)
	cvs.Resize(xpnl_Input.Width, xpnl_Input.Height)
	m_SelectedIndex = -1
	m_ScrollOffset = Max(0, Min(m_ScrollOffset, Max(0, m_TotalHeight - xpnl_Input.Height)))
	RefreshGlass
	m_Glass.EndUpdate
	MountCustomRows
	DrawRows
	If m_State = "Open" Then BuildAccessibleRows
End Sub

Private Sub RefreshGlass
	Dim key As String = m_BackdropRevision & ":" & m_Bounds.Left & ":" & m_Bounds.Top & ":" & m_Bounds.Width & ":" & m_Bounds.Height & ":" & m_Properties.CornerRadius & ":" & m_Properties.BlurRadius & ":" & m_Properties.RefractionHeight & ":" & m_Properties.BevelWidth & ":" & m_Properties.DispersionStrength & ":" & m_Properties.Saturation & ":" & m_Properties.GlassTint & ":" & m_Motion.Rim & ":" & m_Motion.Shine
	If key = m_MenuRenderKey Then Return
	m_MenuRenderKey = key
	If m_Backdrop.IsInitialized = False Then
		If m_ParentBackdrop.IsInitialized Then
			m_Glass.GlassVisible = True
			Dim sx As Float = m_ParentBackdrop.Width / m_Parent.Width
			Dim sy As Float = m_ParentBackdrop.Height / m_Parent.Height
			m_Glass.SetBackdrop(m_ParentBackdrop, m_Bounds.Left * sx, m_Bounds.Top * sy, m_Bounds.Width * sx, m_Bounds.Height * sy)
			Return
		End If
		m_Glass.GlassVisible = False
		m_Glass.mBase.SetColorAndBorder(IIf(ResolvedTheme = "Dark", 0xFF25272C, 0xFFF0F0F2), 0, 0, Max(0, m_Properties.CornerRadius))
		Return
	End If
	m_Glass.mBase.Color = xui.Color_Transparent
	m_Glass.GlassVisible = True
	Dim source As B4XRect = RelativeBounds(m_Backdrop)
	If source.Width > 0 Then m_Glass.SetBackdropView(m_Backdrop, m_Bounds.Left - source.Left, m_Bounds.Top - source.Top)
End Sub

Public Sub Refresh
	m_BackdropRevision = m_BackdropRevision + 1
	SampleSystemReduceMotion
	CaptureParentBackdrop
	RefreshTrigger
	If m_State = "Open" Then
		RefreshGlass
		DrawRows
	End If
End Sub

'Default backdrop capture excludes this trigger and popup. Explicit sources override it.
Private Sub CaptureParentBackdrop
	If m_AutoBackdrop = False Or m_Backdrop.IsInitialized Or m_Disposed Then Return
	If m_Trigger.IsInitialized = False Then Return
	If m_Parent.IsInitialized = False Or mBase.IsInitialized = False Then Return
	If m_Parent.Width < 1 Or m_Parent.Height < 1 Then Return
	Dim triggerVisible As Boolean = mBase.Visible
	Dim overlayVisible As Boolean
	If xpnl_Overlay.IsInitialized Then
		overlayVisible = xpnl_Overlay.Visible
		xpnl_Overlay.Visible = False
	End If
	mBase.Visible = False
	Try
		m_ParentBackdrop = m_Parent.Snapshot
		m_BackdropRevision = m_BackdropRevision + 1
	Catch
		Log("AS_GlassMenu: backdrop capture failed: " & LastException.Message)
	End Try
	mBase.Visible = triggerVisible
	If xpnl_Overlay.IsInitialized Then xpnl_Overlay.Visible = overlayVisible
End Sub

Private Sub RefreshTrigger
	If m_Trigger.IsInitialized = False Then Return
	m_TriggerLabel.Text = m_TriggerText
	m_TriggerLabel.TextColor = m_Properties.TextColor
	Dim source As B4XRect = RelativeBounds(m_Backdrop)
	Dim trigger As B4XRect = RelativeBounds(mBase)
	Dim key As String = m_BackdropRevision & ":" & source.Left & ":" & source.Top & ":" & trigger.Left & ":" & trigger.Top & ":" & mBase.Width & ":" & mBase.Height & ":" & m_TriggerProperties
	If key = m_TriggerRenderKey Then Return
	m_TriggerRenderKey = key
	m_Trigger.BeginUpdate
	m_Trigger.GlassTint = m_TriggerProperties.GlassTint
	m_Trigger.BlurRadius = m_TriggerProperties.BlurRadius
	m_Trigger.Saturation = m_TriggerProperties.Saturation
	m_Trigger.RefractionHeight = m_TriggerProperties.RefractionHeight
	m_Trigger.HighlightOpacity = Max(0, Min(1, m_TriggerProperties.Shine * 0.7))
	m_Trigger.RimOpacity = Max(0, Min(1, m_TriggerProperties.Rim * 0.2))
	m_Trigger.GlassVisible = m_TriggerProperties.Glass And (m_Backdrop.IsInitialized Or m_ParentBackdrop.IsInitialized)
	m_TriggerLabel.Visible = True
	m_Trigger.CornerRadius = IIf(m_TriggerProperties.CornerRadius < 0, Min(mBase.Width, mBase.Height) / 2, m_TriggerProperties.CornerRadius)
	If m_Backdrop.IsInitialized And m_TriggerProperties.Glass Then
		m_Trigger.mBase.Color = xui.Color_Transparent
		If source.Width > 0 And trigger.Width > 0 Then m_Trigger.SetBackdropView(m_Backdrop, trigger.Left - source.Left, trigger.Top - source.Top)
	Else
		If m_ParentBackdrop.IsInitialized And m_TriggerProperties.Glass Then
			m_Trigger.mBase.Color = xui.Color_Transparent
			Dim sx As Float = m_ParentBackdrop.Width / m_Parent.Width
			Dim sy As Float = m_ParentBackdrop.Height / m_Parent.Height
			m_Trigger.SetBackdrop(m_ParentBackdrop, trigger.Left * sx, trigger.Top * sy, mBase.Width * sx, mBase.Height * sy)
		Else
			m_Trigger.mBase.SetColorAndBorder(IIf(ResolvedTheme = "Dark", 0xFF25272C, 0xFFF0F0F2), 0, 0, m_Trigger.CornerRadius)
		End If
	End If
	If m_TriggerProperties.Glass = False Then m_Trigger.mBase.Color = xui.Color_Transparent
	m_Trigger.EndUpdate
	ConfigureTriggerAccessibility
End Sub

Private Sub DrawRows
	cvs.ClearRect(cvs.TargetRect)
	For i = 0 To m_Items.Size - 1
		Dim item As AS_GlassMenu_Item = m_Items.Get(i)
		Dim y As Float = m_RowTops.Get(i)
		y = y - m_ScrollOffset
		Dim h As Float = m_RowHeights.Get(i)
		If y + h <= 0 Or y >= xpnl_Input.Height Then Continue
		Dim rect As B4XRect
		rect.Initialize(0, y, xpnl_Input.Width, y + h)
		If item.Kind = "Separator" Then
			cvs.DrawLine(12dip, y + h / 2, xpnl_Input.Width - 12dip, y + h / 2, m_Properties.SeparatorColor, 1dip)
		Else If item.Kind = "Label" Then
			DrawText(item.Title, IIf(m_ReservesCheck, 38dip, 12dip), y, h, m_Properties.HeaderFont, m_Properties.SubtitleColor, xpnl_Input.Width - 50dip)
		Else
			If i = m_SelectedIndex Then
				Dim path As B4XPath
				path.InitializeRoundedRect(rect, 12dip)
				cvs.DrawPath(path, MultiplyAlpha(m_Properties.HighlightColor, m_Motion.HighlightOpacity), True, 0)
			End If
			Dim color As Int = IIf(item.Destructive, m_Properties.DestructiveColor, m_Properties.TextColor)
			If item.Enabled = False Then color = MultiplyAlpha(color, 0.4)
			If item.Checked Then DrawText(Chr(0xF00C), 8dip, y, h, m_CheckFont, color, 24dip)
			If item.Content.IsInitialized Then Continue
			Dim iconLeft As Float = IIf(m_ReservesCheck, 38dip, 12dip)
			Dim textLeft As Float = TextLeading(item)
			If item.IconView.IsInitialized = False And (item.IconName <> "" Or item.Icon.IsInitialized) Then
				If item.Icon.IsInitialized Then
					Dim iconRect As B4XRect
					iconRect.Initialize(iconLeft, y + (h - m_Properties.IconSize) / 2, iconLeft + m_Properties.IconSize, y + (h + m_Properties.IconSize) / 2)
					cvs.DrawBitmap(item.Icon, iconRect)
				Else
					DrawText(IconGlyph(item.IconName), iconLeft, y, h, m_IconFont, color, 25dip)
				End If
			End If
			Dim textWidth As Float = xpnl_Input.Width - textLeft - 12dip
			If item.Subtitle = "" Then
				DrawText(item.Title, textLeft, y, h, m_Properties.TitleFont, color, textWidth)
			Else
				DrawText(item.Title, textLeft, y + 6dip, h / 2 - 2dip, m_Properties.TitleFont, color, textWidth)
				DrawText(item.Subtitle, textLeft, y + h / 2 - 2dip, h / 2 - 4dip, m_Properties.SubtitleFont, m_Properties.SubtitleColor, textWidth)
			End If
		End If
	Next
	cvs.Invalidate
	PositionCustomRows
	PositionAccessibleRows
End Sub

Private Sub TextLeading(Item As AS_GlassMenu_Item) As Float
	Dim result As Float = IIf(m_ReservesCheck, 38dip, 12dip)
	If Item.IconName <> "" Or Item.Icon.IsInitialized Or Item.IconView.IsInitialized Then result = result + 32dip
	Return result
End Sub

Private Sub MultiplyAlpha(Color As Int, Factor As Float) As Int
	Return Bit.Or(Bit.And(Color, 0x00FFFFFF), Bit.ShiftLeft(Max(0, Min(255, Bit.UnsignedShiftRight(Color, 24) * Max(0, Factor))), 24))
End Sub

Private Sub DrawText(Text As String, X As Float, Y As Float, Height As Float, Font As B4XFont, Color As Int, Width As Float)
    If Width <= 0 Then Return
    Dim key As String = Font & ":" & Font.Size & ":" & Width & ":" & Text
    Dim cached() As Object
    If m_TextCache.ContainsKey(key) Then
        cached = m_TextCache.Get(key)
    Else
        Dim clipped As String = Text
        If cvs.MeasureText(Text, Font).Width > Width Then
            Dim ellipsis As String = Chr(8230)
            Dim low As Int = 0, high As Int = Text.Length
            Do While low < high
                Dim mid As Int = Ceil((low + high) / 2)
                If cvs.MeasureText(Text.SubString2(0, mid) & ellipsis, Font).Width <= Width Then
                    low = mid
                Else
                    high = mid - 1
                End If
            Loop
            clipped = Text.SubString2(0, low) & ellipsis
        End If
        Dim measured As B4XRect = cvs.MeasureText("Mg", Font)
        cached = Array As Object(clipped, -measured.Height / 2 - measured.Top)
        m_TextCache.Put(key, cached)
    End If
    Dim offset As Float = cached(1)
    cvs.DrawText(cached(0), X, Y + Height / 2 + offset, Font, Color, "LEFT")
End Sub

Private Sub IconGlyph(Name As String) As String
	Select Name.ToLowerCase
		Case "check": Return Chr(0xF00C)
		Case "grid": Return Chr(0xF009)
		Case "list": Return Chr(0xF03A)
		Case "plus": Return Chr(0xF067)
		Case "filter": Return Chr(0xF0B0)
		Case "ellipsis": Return Chr(0xF141)
		Case "trash": Return Chr(0xF1F8)
		Case "share": Return Chr(0xF1E0)
		Case "pencil": Return Chr(0xF040)
		Case "copy": Return Chr(0xF0C5)
		Case "heart": Return Chr(0xF004)
		Case "folder": Return Chr(0xF07B)
		Case "sort": Return Chr(0xF0DC)
		Case "clock": Return Chr(0xF017)
	End Select
	Return Name
End Sub

Private Sub HitTest(X As Float, Y As Float) As Int
	If X < 0 Or X > xpnl_Input.Width Or Y < 0 Or Y >= xpnl_Input.Height Then Return -1
	For i = 0 To m_Items.Size - 1
		Dim top As Float = m_RowTops.Get(i)
		Dim h As Float = m_RowHeights.Get(i)
		If Y + m_ScrollOffset >= top And Y + m_ScrollOffset < top + h Then
			Dim item As AS_GlassMenu_Item = m_Items.Get(i)
			If item.Kind = "Item" And item.Enabled Then Return i
			Return -1
		End If
	Next
	Return -1
End Sub

Private Sub Pointer(Action As Int, X As Float, Y As Float)
	If m_State <> "Open" Then Return
	If Action = 0 Then
		m_Dragging = True
		tmr_Scroll.Enabled = True
	End If
	m_PointerY = Y
	m_PointerX = X
	If m_Dragging And EffectiveReduceMotion = False Then
		m_TargetX = Max(-1, Min(1, (X / Max(1, xpnl_Input.Width) - 0.5) * 2)) * 7dip * Max(0, m_Motion.Jelly)
		m_TargetY = Max(-1, Min(1, (Y / Max(1, xpnl_Input.Height) - 0.5) * 2)) * 9dip * Max(0, m_Motion.Jelly)
		#If B4A
		Dim native As JavaObject = Me
		native.RunMethod("setNativeJelly", Array(m_Glass.mBase, m_TargetX, m_TargetY, m_Motion.Speed))
		#Else
		m_Physics.Interval = Max(8, 16 / Max(0.1, m_Motion.Speed))
		m_Physics.Enabled = True
		#End If
	End If
	Dim index As Int = HitTest(X, Y)
	If index <> m_SelectedIndex Then
		m_SelectedIndex = index
		If xui.SubExists(mCallBack, mEventName & "_ItemFocusChanged", 1) Then CallSub2(mCallBack, mEventName & "_ItemFocusChanged", index)
	End If
	DrawRows
	If Action = 1 Or Action = 3 Then
		Dim chooseItem As Boolean = Action = 1 And m_Dragging
		m_Dragging = False
		m_TargetX = 0
		m_TargetY = 0
		#If B4A
		Dim native As JavaObject = Me
		native.RunMethod("setNativeJelly", Array(m_Glass.mBase, m_TargetX, m_TargetY, m_Motion.Speed))
		#End If
		tmr_Scroll.Enabled = False
		DrawRows
		If chooseItem And index >= 0 Then SelectItem(index)
	End If
End Sub

#If B4J
Private Sub MenuInput_MousePressed(EventData As MouseEvent)
	EventData.Consume
	Pointer(0, EventData.X, EventData.Y)
End Sub
Private Sub MenuInput_MouseDragged(EventData As MouseEvent)
	EventData.Consume
	Pointer(2, EventData.X, EventData.Y)
End Sub
Private Sub MenuInput_MouseReleased(EventData As MouseEvent)
	EventData.Consume
	Pointer(1, EventData.X, EventData.Y)
End Sub
Private Sub MenuInput_MouseMoved(EventData As MouseEvent)
	Pointer(2, EventData.X, EventData.Y)
End Sub
Private Sub MenuInput_MouseClicked(EventData As MouseEvent)
	EventData.Consume
End Sub
Private Sub MenuInput_Scroll(EventData As ScrollEvent)
	EventData.Consume
	ScrollBy(-EventData.DeltaY)
End Sub
Private Sub Overlay_MouseClicked(EventData As MouseEvent)
	EventData.Consume
	If CloseOnOutsideTap Then Close
End Sub
Private Sub Overlay_KeyPressed(EventData As KeyEvent)
	If HandleKey(EventData.KeyCode) Then EventData.Consume
End Sub
#Else
Private Sub MenuInput_Touch(Action As Int, X As Float, Y As Float)
	Pointer(Action, X, Y)
End Sub
Private Sub Overlay_Click
	If CloseOnOutsideTap Then Close
End Sub
#End If

Private Sub tmr_Scroll_Tick
	If m_Dragging = False Or m_State <> "Open" Then
		tmr_Scroll.Enabled = False
		Return
	End If
	If m_PointerY < 22dip Then ScrollBy(-8dip)
	If m_PointerY > xpnl_Input.Height - 22dip Then ScrollBy(8dip)
End Sub

Public Sub ScrollBy(Delta As Float)
	If m_State <> "Open" Then Return
	m_ScrollOffset = Max(0, Min(Max(0, m_TotalHeight - xpnl_Input.Height), m_ScrollOffset + Delta))
	m_SelectedIndex = -1
	If m_Dragging Then m_SelectedIndex = HitTest(m_PointerX, m_PointerY)
	DrawRows
End Sub

'Selects enabled action rows only. Labels/separators count toward Index.
Public Sub SelectItem(Index As Int)
	If m_State <> "Open" Or Index < 0 Or Index >= m_Items.Size Then Return
	Dim item As AS_GlassMenu_Item = m_Items.Get(Index)
	If item.Kind <> "Item" Or item.Enabled = False Then Return
	If item.CheckBehavior = "Toggle" Then item.Checked = Not(item.Checked)
	If item.CheckBehavior = "Radio" Then
		For Each sibling As AS_GlassMenu_Item In m_Items
			If sibling.CheckBehavior = "Radio" And sibling.GroupId = item.GroupId Then sibling.Checked = sibling = item
		Next
	End If
	If item.CheckBehavior <> "" And item.KeepOpen Then RefreshMenu
	If item.KeepOpen = False Then Close
	If item.Callback <> Null And item.EventName <> "" Then
		If xui.SubExists(item.Callback, item.EventName, 2) Then CallSub3(item.Callback, item.EventName, Index, item)
	End If
	If xui.SubExists(mCallBack, mEventName & "_ItemClick", 2) Then CallSub3(mCallBack, mEventName & "_ItemClick", Index, item)
End Sub

'Host keyboard integration; B4J overlay handles these automatically.
Public Sub HandleKey(Key As String) As Boolean
	If m_State <> "Open" Then Return False
	Select Key.ToUpperCase
		Case "ESCAPE", "ESC", "BACK": Close
		Case "ENTER", "RETURN", "SPACE"
			If m_SelectedIndex >= 0 Then SelectItem(m_SelectedIndex)
		Case "UP", "DOWN", "HOME", "END"
			Dim stepValue As Int = IIf(Key.ToUpperCase = "UP" Or Key.ToUpperCase = "END", -1, 1)
			Dim nextIndex As Int = m_SelectedIndex + stepValue
			If Key.ToUpperCase = "HOME" Then nextIndex = 0
			If Key.ToUpperCase = "END" Or (m_SelectedIndex < 0 And stepValue = -1) Then nextIndex = m_Items.Size - 1
			Do While nextIndex >= 0 And nextIndex < m_Items.Size
				Dim item As AS_GlassMenu_Item = m_Items.Get(nextIndex)
				If item.Kind = "Item" And item.Enabled Then
					m_SelectedIndex = nextIndex
					Dim rowTop As Float = m_RowTops.Get(nextIndex)
					Dim rowHeight As Float = m_RowHeights.Get(nextIndex)
					If rowTop < m_ScrollOffset Then m_ScrollOffset = rowTop
					If rowTop + rowHeight > m_ScrollOffset + xpnl_Input.Height Then m_ScrollOffset = rowTop + rowHeight - xpnl_Input.Height
					DrawRows
					Exit
				End If
				nextIndex = nextIndex + stepValue
			Loop
		Case Else: Return False
	End Select
	Return True
End Sub

'For keyboard/back-button integration by the host page.
Public Sub HandleBack As Boolean
	If m_State = "Closed" Then Return False
	Close
	Return True
End Sub

Public Sub Close
	If m_State = "Closed" Or m_State = "Closing" Then Return
	If m_MorphReady = False Then
		CloseImmediately
		Return
	End If
	m_Token = m_Token + 1
	Dim token As Int = m_Token
	#If B4A
	Dim native As JavaObject = Me
	native.RunMethod("cancelNativeAnimations", Null)
	#End If
	tmr_Scroll.Enabled = False
	m_Dragging = False
	If m_State = "Open" Then SetMorphBitmap(m_Glass.mBase.Snapshot)
	m_State = "Closing"
	ApplyTransform(m_Glass.mBase, 1, 1, 0, 0)
	m_Glass.mBase.Visible = False
	xiv_Morph.Visible = True
	xiv_MorphBlur.Visible = True
	Wait For (AnimateMorph(False, m_MorphOrigin, token)) Complete (completed As Boolean)
	If completed = False Then Return
	If token <> m_Token Then Return
	CloseImmediately
End Sub

'Close immediately before parent resize or page navigation; cancels pending transitions.
Public Sub CloseImmediately
	m_Token = m_Token + 1
	#If B4A
	Dim native As JavaObject = Me
	native.RunMethod("cancelNativeAnimations", Null)
	#End If
	tmr_Scroll.Enabled = False
	m_Dragging = False
	m_Physics.Enabled = False
	m_TargetX = 0
	m_TargetY = 0
	m_OffsetX = 0
	m_OffsetY = 0
	m_VelocityX = 0
	m_VelocityY = 0
	DetachCustomRows
	m_AccessibleRows.Clear
	If xpnl_Overlay.IsInitialized Then
		cvs.Release
		m_Glass.Dispose
		xpnl_Overlay.RemoveViewFromParent
		Dim empty As B4XView
		xpnl_Overlay = empty
	End If
	If m_HideTrigger And mBase.IsInitialized Then mBase.Visible = m_TriggerWasVisible
	If m_OriginView.IsInitialized Then m_OriginView.Visible = m_OriginWasVisible
	Dim noOrigin As B4XView
	m_OriginView = noOrigin
	m_HideTrigger = False
	m_MorphReady = False
	m_State = "Closed"
	If m_OpenNotified Then
		m_OpenNotified = False
		NotifyOpenChanged(False)
	End If
End Sub

Private Sub SetMorphBitmap(Bitmap As B4XBitmap)
	Dim bc As BitmapCreator
	bc.Initialize(1, 1)
	bc.SetBitmapToImageView(Bitmap, xiv_Morph)
	If m_Motion.MorphBlur > 0 And EffectiveReduceMotion = False Then
		Dim renderer As AS_LiquidGlassRenderer
		renderer.Initialize
		Dim blurred As B4XBitmap = renderer.BlurBitmap(Bitmap.Resize(Max(1, Bitmap.Width / 3), Max(1, Bitmap.Height / 3), False), Min(12, Max(1, Round(m_Motion.MorphBlur * 3))))
		bc.SetBitmapToImageView(blurred, xiv_MorphBlur)
	Else
		bc.SetBitmapToImageView(Bitmap, xiv_MorphBlur)
	End If
	m_MorphReady = True
	xiv_Morph.SetLayoutAnimated(0, m_Bounds.Left, m_Bounds.Top, m_Bounds.Width, m_Bounds.Height)
End Sub

Private Sub NotifyOpenChanged(IsOpen As Boolean)
	If xui.SubExists(mCallBack, mEventName & "_OpenChanged", 1) Then CallSub2(mCallBack, mEventName & "_OpenChanged", IsOpen)
End Sub

Private Sub AnimateMorph(Opening As Boolean, Origin As B4XRect, Token As Int) As ResumableSub
	Dim duration As Int = IIf(Opening, AnimationDuration, m_TriggerProperties.AbsorbDuration)
	duration = Max(0, duration / Max(0.1, m_Motion.Speed))
	If EffectiveReduceMotion Then duration = 0
	#If B4A
	Dim native As JavaObject = Me
	Dim geometry() As Float = Array As Float(Origin.Left, Origin.Top, Origin.Width, Origin.Height, m_Bounds.Left, m_Bounds.Top, m_Bounds.Width, m_Bounds.Height, m_Anchor.Left, m_Anchor.Top, m_Anchor.Width, m_Anchor.Height)
	xiv_Morph.SetLayoutAnimated(0, m_Bounds.Left, m_Bounds.Top, m_Bounds.Width, m_Bounds.Height)
	xiv_MorphBlur.SetLayoutAnimated(0, m_Bounds.Left, m_Bounds.Top, m_Bounds.Width, m_Bounds.Height)
	xiv_TriggerMorph.SetLayoutAnimated(0, m_Anchor.Left, m_Anchor.Top, m_Anchor.Width, m_Anchor.Height)
	Dim waitDuration As Int = native.RunMethod("animateNativeMorph", Array(xiv_Morph, xiv_MorphBlur, xiv_TriggerMorph, geometry, Opening, duration, m_Motion.Damping, m_Motion.Jelly, m_TriggerProperties.ShrinkScale, m_TriggerProperties.ShrinkDuration, m_TriggerProperties.ShrinkDamping, m_Motion.MorphBlur, m_TriggerProperties.AbsorbDamping, m_Motion.Speed))
	Sleep(waitDuration)
	Return Token = m_Token
	#Else
	Dim startAmount As Float = IIf(Opening, 0, m_MorphAmount)
	Dim startTime As Long = DateTime.Now
	Dim progress As Float
	Do While Token = m_Token
		progress = IIf(duration = 0, 1, Min(1, (DateTime.Now - startTime) / Max(1, duration)))
		Dim damping As Float = IIf(Opening, m_Motion.Damping, m_TriggerProperties.AbsorbDamping)
		Dim spring As Float = SpringProgress(progress, damping)
		Dim eased As Float = 1 - Power(1 - progress, 3)
		spring = eased + (spring - eased) * Max(0, Min(2, m_Motion.Jelly))
		Dim amount As Float = IIf(Opening, spring, startAmount * (1 - CloseProgress(progress, m_TriggerProperties.AbsorbDamping)))
		m_MorphAmount = amount
		Dim w As Float = Max(1dip, Origin.Width + (m_Bounds.Width - Origin.Width) * amount)
		Dim h As Float = Max(1dip, Origin.Height + (m_Bounds.Height - Origin.Height) * amount)
		Dim cx As Float = Origin.CenterX + (m_Bounds.CenterX - Origin.CenterX) * amount
		Dim cy As Float = Origin.CenterY + (m_Bounds.CenterY - Origin.CenterY) * amount
		xiv_Morph.SetLayoutAnimated(0, cx - w / 2, cy - h / 2, w, h)
		xiv_MorphBlur.SetLayoutAnimated(0, cx - w / 2, cy - h / 2, w, h)
		Dim blurAmount As Float = IIf(EffectiveReduceMotion, 0, Max(0, Min(1, (1 - amount) * m_Motion.MorphBlur)))
		Dim visibility As Float = IIf(Opening, Max(0, Min(1, progress * 3)), Max(0, Min(1, (1 - progress) * 1.6)))
		SetViewOpacity(xiv_Morph, visibility * (1 - blurAmount))
		SetViewOpacity(xiv_MorphBlur, visibility * blurAmount)
		If Opening And xiv_TriggerMorph.IsInitialized Then
			Dim shrinkTime As Int = Max(1, m_TriggerProperties.ShrinkDuration / Max(0.1, m_Motion.Speed))
			Dim shrinkProgress As Float = Min(1, (DateTime.Now - startTime) / shrinkTime)
			If duration = 0 Then shrinkProgress = 1
			Dim shrink As Float = 1 - (1 - Max(0, Min(1, m_TriggerProperties.ShrinkScale))) * SpringProgress(shrinkProgress, m_TriggerProperties.ShrinkDamping)
			xiv_TriggerMorph.Visible = shrinkProgress < 1
			xiv_TriggerMorph.SetLayoutAnimated(0, m_Anchor.CenterX - m_Anchor.Width * shrink / 2, m_Anchor.CenterY - m_Anchor.Height * shrink / 2, Max(1dip, m_Anchor.Width * shrink), Max(1dip, m_Anchor.Height * shrink))
			SetViewOpacity(xiv_TriggerMorph, 1 - shrinkProgress)
		Else If Opening = False Then
			Dim reveal As Float = Max(0, Min(1, (progress - 0.25) / 0.75))
			xiv_TriggerMorph.Visible = True
			Dim scale As Float = m_TriggerProperties.ShrinkScale + (1 - m_TriggerProperties.ShrinkScale) * reveal
			xiv_TriggerMorph.SetLayoutAnimated(0, m_Anchor.CenterX - m_Anchor.Width * scale / 2, m_Anchor.CenterY - m_Anchor.Height * scale / 2, Max(1dip, m_Anchor.Width * scale), Max(1dip, m_Anchor.Height * scale))
			SetViewOpacity(xiv_TriggerMorph, reveal)
		End If
		If progress >= 1 Then Exit
		Sleep(16)
	Loop
	Return Token = m_Token
	#End If
End Sub

Private Sub CloseProgress(Progress As Float, Damping As Float) As Float
	Dim k As Float = 6 + 4 * Max(0.2, Min(1, Damping))
	Return (1 - Power(cE, -k * Progress) * (1 + k * Progress)) / (1 - Power(cE, -k) * (1 + k))
End Sub

Private Sub SpringProgress(Progress As Float, Damping As Float) As Float
	If Progress >= 1 Then Return 1
	If Progress <= 0 Then Return 0
	Dim d As Float = Max(0.2, Min(1, Damping))
	Dim frequency As Float = 10
	Dim decay As Float = Power(cE, -d * frequency * Progress)
	Dim oscillation As Float = Sqrt(Max(0.01, 1 - d * d))
	Return 1 - decay * (Cos(frequency * oscillation * Progress) + d / oscillation * Sin(frequency * oscillation * Progress))
End Sub

Private Sub Physics_Tick
	If m_State <> "Open" Or EffectiveReduceMotion Then
		m_Physics.Enabled = False
		If m_Glass.IsInitialized Then ApplyTransform(m_Glass.mBase, 1, 1, 0, 0)
		Return
	End If
	m_VelocityX = (m_VelocityX + (m_TargetX - m_OffsetX) * 0.18) * 0.72
	m_VelocityY = (m_VelocityY + (m_TargetY - m_OffsetY) * 0.18) * 0.72
	m_OffsetX = m_OffsetX + m_VelocityX
	m_OffsetY = m_OffsetY + m_VelocityY
	ApplyTransform(m_Glass.mBase, 1 + Abs(m_OffsetX) / Max(1, m_Bounds.Width), 1 + Abs(m_OffsetY) / Max(1, m_Bounds.Height), m_OffsetX, m_OffsetY)
	If m_Dragging = False And Abs(m_OffsetX) + Abs(m_OffsetY) + Abs(m_VelocityX) + Abs(m_VelocityY) < 0.05 Then
		ApplyTransform(m_Glass.mBase, 1, 1, 0, 0)
		m_Physics.Enabled = False
	End If
End Sub

Private Sub ApplyTransform(View As B4XView, SX As Float, SY As Float, TX As Float, TY As Float)
	#If B4A
	Dim native As JavaObject = View
	native.RunMethod("setScaleX", Array(SX))
	native.RunMethod("setScaleY", Array(SY))
	native.RunMethod("setTranslationX", Array(TX))
	native.RunMethod("setTranslationY", Array(TY))
	#Else If B4J
	Dim native As JavaObject = View
	native.RunMethod("setScaleX", Array(SX.As(Double)))
	native.RunMethod("setScaleY", Array(SY.As(Double)))
	native.RunMethod("setTranslateX", Array(TX.As(Double)))
	native.RunMethod("setTranslateY", Array(TY.As(Double)))
	#Else If B4i
	Dim native As NativeObject = Me
	native.RunMethod("glassTransform:sx:sy:tx:ty:", Array(View, SX, SY, TX, TY))
	#End If
End Sub

Private Sub SetViewOpacity(View As B4XView, Value As Float)
	#If B4A
	View.As(JavaObject).RunMethod("setAlpha", Array(Value))
	#Else If B4J
	View.As(JavaObject).RunMethod("setOpacity", Array(Value.As(Double)))
	#Else If B4i
	View.As(NativeObject).RunMethod("setAlpha:", Array(Value))
	#End If
End Sub

Private Sub EffectiveReduceMotion As Boolean
	Return m_Motion.ReduceMotion Or m_SystemReduceMotion
End Sub

Private Sub SampleSystemReduceMotion
	If mBase.IsInitialized = False Then Return
	#If B4A
	Dim native As JavaObject = Me
	m_SystemReduceMotion = native.RunMethod("systemReduceMotion", Array(mBase))
	#Else If B4i
	Dim native As NativeObject = Me
	m_SystemReduceMotion = native.RunMethod("glassReduceMotion", Null).AsBoolean
	#Else
	m_SystemReduceMotion = False
	#End If
End Sub

Private Sub MountCustomRows
	DetachCustomRows
	For i = 0 To m_Items.Size - 1
		Dim item As AS_GlassMenu_Item = m_Items.Get(i)
		If item.Content.IsInitialized Then
			item.Content.RemoveViewFromParent
			xpnl_Input.AddView(item.Content, TextLeading(item), 0, Max(1dip, xpnl_Input.Width - TextLeading(item) - 12dip), Max(1dip, item.ContentHeight))
			m_CustomRows.Put(i, item.Content)
			item.Content.Enabled = item.Enabled
			SetViewOpacity(item.Content, IIf(item.Enabled, 1, 0.4))
		End If
		If item.IconView.IsInitialized Then
			item.IconView.RemoveViewFromParent
			xpnl_Input.AddView(item.IconView, IIf(m_ReservesCheck, 38dip, 12dip), 0, m_Properties.IconSize, m_Properties.IconSize)
			m_CustomIcons.Put(i, item.IconView)
			SetViewOpacity(item.IconView, IIf(item.Enabled, 1, 0.4))
		End If
	Next
End Sub

Private Sub DetachCustomRows
	For Each panel As B4XView In m_CustomRows.Values
		panel.RemoveViewFromParent
	Next
	m_CustomRows.Clear
	For Each panel As B4XView In m_CustomIcons.Values
		panel.RemoveViewFromParent
	Next
	m_CustomIcons.Clear
End Sub

Private Sub PositionCustomRows
	For Each index As Int In m_CustomRows.Keys
		Dim panel As B4XView = m_CustomRows.Get(index)
		Dim y As Float = m_RowTops.Get(index)
		Dim h As Float = m_RowHeights.Get(index)
		y = y - m_ScrollOffset
		panel.Visible = y >= 0 And y + h <= xpnl_Input.Height
		panel.Top = y
	Next
	For Each index As Int In m_CustomIcons.Keys
		Dim panel As B4XView = m_CustomIcons.Get(index)
		Dim y As Float = m_RowTops.Get(index)
		Dim h As Float = m_RowHeights.Get(index)
		y = y - m_ScrollOffset + (h - panel.Height) / 2
		panel.Visible = y >= 0 And y + panel.Height <= xpnl_Input.Height
		panel.Top = y
	Next
End Sub

Private Sub ConfigureTriggerAccessibility
	#If B4A
	If xpnl_TriggerInput.IsInitialized = False Then Return
	Dim native As JavaObject = Me
	native.RunMethod("configureTriggerAccessibility", Array(xpnl_TriggerInput, m_TriggerProperties.AccessibilityLabel))
	#End If
End Sub

'Native Android accessibility proxies preserve touch/drag on the canvas below.
Private Sub BuildAccessibleRows
	For Each proxy As B4XView In m_AccessibleRows
		proxy.RemoveViewFromParent
	Next
	m_AccessibleRows.Clear
	#If B4A
	For i = 0 To m_Items.Size - 1
		Dim item As AS_GlassMenu_Item = m_Items.Get(i)
		If item.Kind <> "Item" Or item.Content.IsInitialized Then Continue
		Dim label As Label
		label.Initialize("")
		Dim proxy As B4XView = label
		proxy.Tag = i
		m_Glass.ContentPanel.AddView(proxy, xpnl_Input.Left, xpnl_Input.Top, xpnl_Input.Width, 1dip)
		Dim description As String = item.AccessibilityLabel
		If description = "" Then description = item.Title & IIf(item.Subtitle = "", "", ", " & item.Subtitle)
		Dim native As JavaObject = Me
		native.RunMethod("configureRowAccessibility", Array(proxy, description, i, item.Enabled, item.Checked, item.ShowCheck Or item.Checked))
		m_AccessibleRows.Add(proxy)
	Next
	#End If
	PositionAccessibleRows
End Sub

Private Sub PositionAccessibleRows
	For Each proxy As B4XView In m_AccessibleRows
		Dim index As Int = proxy.Tag
		Dim y As Float = m_RowTops.Get(index)
		Dim h As Float = m_RowHeights.Get(index)
		y = y - m_ScrollOffset
		proxy.Visible = y >= 0 And y + h <= xpnl_Input.Height
		proxy.SetLayoutAnimated(0, xpnl_Input.Left, xpnl_Input.Top + y, xpnl_Input.Width, h)
	Next
End Sub

Private Sub Native_AccessibleSelect(Index As Int)
	SelectItem(Index)
End Sub

'Android's window parent is not always a View and cannot be wrapped by B4XView.
Private Sub ParentViewOrEmpty(View As B4XView) As B4XView
	#If B4A
	Dim native As JavaObject = Me
	Return native.RunMethod("parentViewOrNull", Array(View))
	#Else
	Return View.Parent
	#End If
End Sub

#If B4A
#If Java
private android.animation.ValueAnimator nativeMorph;
private android.view.View jellyView;
private Runnable jellyFrame;
private float jellyX, jellyY, jellyVX, jellyVY, jellyTX, jellyTY, jellySpeed = 1f;
private long jellyTime;
private float morphAmount = 1f, morphTriggerScale = 1f, morphTriggerAlpha = 1f;
private static float clamp01(float value) { return Math.max(0f, Math.min(1f, value)); }
private static float nativeSpring(float progress, float damping) {
    if (progress >= 1f) return 1f;
    if (progress <= 0f) return 0f;
    float d = Math.max(.2f, Math.min(1f, damping));
    double f = Math.sqrt(Math.max(.01, 1 - d * d));
    return (float)(1 - Math.exp(-d * 10 * progress) * (Math.cos(10 * f * progress) + d / f * Math.sin(10 * f * progress)));
}
private static float nativeCloseProgress(float progress, float damping) {
    double k = 6 + 4 * Math.max(.2f, Math.min(1f, damping));
    return (float)((1 - Math.exp(-k * progress) * (1 + k * progress)) / (1 - Math.exp(-k) * (1 + k)));
}
private static void morphView(android.view.View view, float left, float top, float w, float h, float baseLeft, float baseTop, float baseW, float baseH) {
    view.setPivotX(0f); view.setPivotY(0f);
    view.setScaleX(Math.max(.001f, w / Math.max(1f, baseW)));
    view.setScaleY(Math.max(.001f, h / Math.max(1f, baseH)));
    view.setTranslationX(left - baseLeft); view.setTranslationY(top - baseTop);
}
public int animateNativeMorph(final android.view.View sharp, final android.view.View blurred, final android.view.View trigger,
    final float[] g, final boolean opening, final int duration, final float damping, final float jelly,
    final float shrinkScale, final int shrinkDuration, final float shrinkDamping, final float blurStrength,
    final float absorbDamping, final float speed) {
    if (nativeMorph != null) { nativeMorph.cancel(); nativeMorph.removeAllUpdateListeners(); }
    final float fromAmount = opening ? 0f : morphAmount;
    final float fromTriggerScale = opening ? 1f : morphTriggerScale;
    final float fromTriggerAlpha = opening ? 1f : morphTriggerAlpha;
    final android.animation.ValueAnimator animator = android.animation.ValueAnimator.ofFloat(0f, 1f);
    nativeMorph = animator;
    animator.setInterpolator(new android.view.animation.LinearInterpolator());
    animator.setDuration(Math.max(0, duration));
    final android.animation.ValueAnimator.AnimatorUpdateListener update = new android.animation.ValueAnimator.AnimatorUpdateListener() {
      @Override public void onAnimationUpdate(android.animation.ValueAnimator animation) {
        float p = (Float)animation.getAnimatedValue();
        float eased = 1f - (float)Math.pow(1f - p, 3);
        float spring = nativeSpring(p, opening ? damping : absorbDamping);
        spring = eased + (spring - eased) * Math.max(0f, Math.min(2f, jelly));
        float amount = opening ? spring : fromAmount * (1f - nativeCloseProgress(p, absorbDamping));
        morphAmount = amount;
        float w = Math.max(1f, g[2] + (g[6] - g[2]) * amount);
        float h = Math.max(1f, g[3] + (g[7] - g[3]) * amount);
        float cx = g[0] + g[2] / 2 + (g[4] + g[6] / 2 - g[0] - g[2] / 2) * amount;
        float cy = g[1] + g[3] / 2 + (g[5] + g[7] / 2 - g[1] - g[3] / 2) * amount;
        morphView(sharp, cx - w / 2, cy - h / 2, w, h, g[4], g[5], g[6], g[7]);
        morphView(blurred, cx - w / 2, cy - h / 2, w, h, g[4], g[5], g[6], g[7]);
        float blur = duration == 0 ? 0f : clamp01((1f - amount) * blurStrength);
        float visible = opening ? clamp01(p * 3f) : clamp01((1f - p) * 1.6f);
        sharp.setAlpha(visible * (1f - blur)); blurred.setAlpha(visible * blur);
        if (opening) {
            float sp = duration == 0 ? 1f : clamp01(p * duration / Math.max(1f, shrinkDuration / Math.max(.1f, speed)));
            float scale = 1f - (1f - clamp01(shrinkScale)) * nativeSpring(sp, shrinkDamping);
            morphView(trigger, g[8] + g[10] * (1f - scale) / 2, g[9] + g[11] * (1f - scale) / 2,
                g[10] * scale, g[11] * scale, g[8], g[9], g[10], g[11]);
            trigger.setAlpha(1f - sp);
            morphTriggerScale = scale; morphTriggerAlpha = 1f - sp;
            trigger.setVisibility(sp < 1f ? android.view.View.VISIBLE : android.view.View.INVISIBLE);
        } else {
            float reveal = clamp01((p - .25f) / .75f);
            reveal = reveal * reveal * (3f - 2f * reveal);
            float scale = fromTriggerScale + (1f - fromTriggerScale) * reveal;
            float alpha = fromTriggerAlpha + (1f - fromTriggerAlpha) * reveal;
            morphView(trigger, g[8] + g[10] * (1f - scale) / 2, g[9] + g[11] * (1f - scale) / 2,
                g[10] * scale, g[11] * scale, g[8], g[9], g[10], g[11]);
            trigger.setVisibility(android.view.View.VISIBLE); trigger.setAlpha(alpha);
            morphTriggerScale = scale; morphTriggerAlpha = alpha;
        }
      }
    };
    animator.addUpdateListener(update);
    animator.setCurrentPlayTime(0);
    animator.start();
    float systemScale = android.provider.Settings.Global.getFloat(sharp.getContext().getContentResolver(), android.provider.Settings.Global.ANIMATOR_DURATION_SCALE, 1f);
    return duration == 0 || systemScale == 0f ? 0 : Math.round(duration * systemScale) + 16;
}
public void setNativeJelly(final android.view.View view, float tx, float ty, float speed) {
    jellyTX = tx; jellyTY = ty; jellySpeed = Math.max(.1f, Math.min(3f, speed));
    if (jellyFrame != null && jellyView == view) return;
    if (jellyView != null && jellyFrame != null) jellyView.removeCallbacks(jellyFrame);
    jellyView = view; jellyTime = System.nanoTime();
    jellyFrame = new Runnable() {
      @Override public void run() {
        if (jellyView != view) return;
        long now = System.nanoTime();
        float dt = Math.max(.25f, Math.min(2f, (now - jellyTime) / 16000000f)) * jellySpeed;
        jellyTime = now;
        jellyVX = (jellyVX + (jellyTX - jellyX) * .18f * dt) * (float)Math.pow(.72f, dt);
        jellyVY = (jellyVY + (jellyTY - jellyY) * .18f * dt) * (float)Math.pow(.72f, dt);
        jellyX += jellyVX * dt; jellyY += jellyVY * dt;
        view.setScaleX(1f + Math.abs(jellyX) / Math.max(1, view.getWidth()));
        view.setScaleY(1f + Math.abs(jellyY) / Math.max(1, view.getHeight()));
        view.setTranslationX(jellyX); view.setTranslationY(jellyY);
        if (jellyTX == 0f && jellyTY == 0f && Math.abs(jellyX) + Math.abs(jellyY) + Math.abs(jellyVX) + Math.abs(jellyVY) < .05f) {
            view.setScaleX(1f); view.setScaleY(1f); view.setTranslationX(0f); view.setTranslationY(0f);
            jellyFrame = null; jellyView = null;
        } else view.postOnAnimation(this);
      }
    };
    view.postOnAnimation(jellyFrame);
}
public void cancelNativeAnimations() {
    if (nativeMorph != null) { nativeMorph.cancel(); nativeMorph.removeAllUpdateListeners(); nativeMorph = null; }
    if (jellyView != null) {
        if (jellyFrame != null) jellyView.removeCallbacks(jellyFrame);
        jellyView.setScaleX(1f); jellyView.setScaleY(1f); jellyView.setTranslationX(0f); jellyView.setTranslationY(0f);
    }
    jellyView = null; jellyFrame = null;
    jellyX = jellyY = jellyVX = jellyVY = jellyTX = jellyTY = 0f;
}

public Object parentViewOrNull(android.view.View view) {
    android.view.ViewParent parent = view.getParent();
    return parent instanceof android.view.View ? parent : null;
}
public boolean systemDark(android.view.View view) {
    return view != null && (view.getResources().getConfiguration().uiMode & 0x30) == 0x20;
}
public boolean systemReduceMotion(android.view.View view) {
    if (view == null) return false;
    return android.provider.Settings.Global.getFloat(view.getContext().getContentResolver(),
        android.provider.Settings.Global.ANIMATOR_DURATION_SCALE, 1f) == 0f;
}
public void configureTriggerAccessibility(final android.view.View view, String label) {
    view.setContentDescription(label);
    view.setImportantForAccessibility(android.view.View.IMPORTANT_FOR_ACCESSIBILITY_YES);
    view.setAccessibilityDelegate(new android.view.View.AccessibilityDelegate() {
        @Override public void onInitializeAccessibilityNodeInfo(android.view.View host, android.view.accessibility.AccessibilityNodeInfo info) {
            super.onInitializeAccessibilityNodeInfo(host, info);
            info.setClassName("android.widget.Button");
            info.setClickable(true);
            info.addAction(android.view.accessibility.AccessibilityNodeInfo.AccessibilityAction.ACTION_CLICK);
        }
        @Override public boolean performAccessibilityAction(android.view.View host, int action, android.os.Bundle args) {
            if (action == android.view.accessibility.AccessibilityNodeInfo.ACTION_CLICK) {
                ba.raiseEventFromUI(host, "native_accessibletrigger", host);
                return true;
            }
            return super.performAccessibilityAction(host, action, args);
        }
    });
}
public void configureRowAccessibility(android.view.View view, String label, final int index, final boolean enabled, final boolean checked, final boolean checkable) {
    view.setContentDescription(label);
    view.setImportantForAccessibility(android.view.View.IMPORTANT_FOR_ACCESSIBILITY_YES);
    view.setAccessibilityDelegate(new android.view.View.AccessibilityDelegate() {
        @Override public void onInitializeAccessibilityNodeInfo(android.view.View host, android.view.accessibility.AccessibilityNodeInfo info) {
            super.onInitializeAccessibilityNodeInfo(host, info);
            info.setClassName(checkable ? "android.widget.CheckedTextView" : "android.widget.Button");
            info.setEnabled(enabled);
            info.setCheckable(checkable);
            info.setChecked(checked);
            info.setClickable(enabled);
            if (enabled) info.addAction(android.view.accessibility.AccessibilityNodeInfo.AccessibilityAction.ACTION_CLICK);
        }
        @Override public boolean performAccessibilityAction(android.view.View host, int action, android.os.Bundle args) {
            if (enabled && action == android.view.accessibility.AccessibilityNodeInfo.ACTION_CLICK) {
                ba.raiseEventFromUI(host, "native_accessibleselect", index);
                return true;
            }
            return super.performAccessibilityAction(host, action, args);
        }
    });
}
public void configureOverlayKeys(android.view.View view) {
    view.setFocusableInTouchMode(true);
    view.requestFocus();
    view.setOnKeyListener(new android.view.View.OnKeyListener() {
      @Override public boolean onKey(android.view.View v, int code, android.view.KeyEvent event) {
        String key;
        switch (code) {
            case android.view.KeyEvent.KEYCODE_BACK: key = "BACK"; break;
            case android.view.KeyEvent.KEYCODE_ESCAPE: key = "ESCAPE"; break;
            case android.view.KeyEvent.KEYCODE_DPAD_UP: key = "UP"; break;
            case android.view.KeyEvent.KEYCODE_DPAD_DOWN: key = "DOWN"; break;
            case android.view.KeyEvent.KEYCODE_ENTER: case android.view.KeyEvent.KEYCODE_DPAD_CENTER: key = "ENTER"; break;
            case android.view.KeyEvent.KEYCODE_SPACE: key = "SPACE"; break;
            default: return false;
        }
        if (event.getAction() == android.view.KeyEvent.ACTION_UP) ba.raiseEventFromUI(v, "native_key", key);
        return true;
      }
    });
}
#End If
#End If

Private Sub Native_AccessibleTrigger(View As Object)
	Dim target As B4XView = View
	If target = xpnl_TriggerInput Then
		If m_OpenOnPress Then Show
	Else
		ShowOnView(target)
	End If
End Sub

Private Sub Native_Key(Key As String)
	If Key = "BACK" Or Key = "ESCAPE" Then
		HandleBack
	Else
		HandleKey(Key)
	End If
End Sub

#If OBJC
- (void)glassTransform:(UIView *)view sx:(NSNumber *)sx sy:(NSNumber *)sy tx:(NSNumber *)tx ty:(NSNumber *)ty {
    view.transform = CGAffineTransformMake([sx doubleValue], 0, 0, [sy doubleValue], [tx doubleValue], [ty doubleValue]);
}
- (BOOL)glassReduceMotion { return UIAccessibilityIsReduceMotionEnabled(); }
- (BOOL)glassSystemDark {
    if (@available(iOS 13.0, *)) return UIScreen.mainScreen.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    return NO;
}
#End If

Private Sub RelativeBounds(View As B4XView) As B4XRect
	Dim rect As B4XRect
	rect.Initialize(0, 0, 0, 0)
	If View.IsInitialized = False Or m_Parent.IsInitialized = False Then Return rect
	Dim current As B4XView = View
	Dim left As Float = 0, top As Float = 0
	Do While current.IsInitialized
		If current = m_Parent Then
			rect.Initialize(left, top, left + View.Width, top + View.Height)
			Return rect
		End If
		left = left + current.Left
		top = top + current.Top
		current = ParentViewOrEmpty(current)
	Loop
	Return rect
End Sub

Public Sub Dispose
	m_Disposed = True
	CloseImmediately
	If m_Trigger.IsInitialized Then m_Trigger.Dispose
	Dim empty As B4XView
	m_Backdrop = empty
	m_Items.Clear
	Dim emptyBitmap As B4XBitmap
	m_ParentBackdrop = emptyBitmap
End Sub

Public Sub getAutoBackdrop As Boolean
	Return m_AutoBackdrop
End Sub
Public Sub setAutoBackdrop(Value As Boolean)
	m_AutoBackdrop = Value
	If Value = False Then
		Dim empty As B4XBitmap
		m_ParentBackdrop = empty
	End If
	Refresh
End Sub

Public Sub getMenuProperties As AS_GlassMenu_MenuProperties
	Return m_Properties
End Sub
Public Sub getMotionProperties As AS_GlassMenu_MotionProperties
	Return m_Motion
End Sub
Public Sub getTriggerProperties As AS_GlassMenu_TriggerProperties
	Return m_TriggerProperties
End Sub
'Fallback supplied by the host on B4J; Android/iOS query their system appearance.
Public Sub setSystemTheme(Value As String)
	m_SystemTheme = IIf(Value.ToLowerCase = "light", "Light", "Dark")
	If m_Theme = "Auto" Then
		ApplyThemeColors
		Refresh
	End If
End Sub
Public Sub getItemCount As Int
	Return m_Items.Size
End Sub
Public Sub getIsOpen As Boolean
	Return m_State <> "Closed"
End Sub
Public Sub getTriggerContentPanel As B4XView
	Return m_Trigger.ContentPanel
End Sub
Public Sub getTriggerText As String
	Return m_TriggerText
End Sub
Public Sub setTriggerText(Value As String)
	m_TriggerText = Value
	RefreshTrigger
End Sub
Public Sub getAlignment As String
	Return m_Alignment
End Sub
'Auto picks the near screen edge; Start/Center/End are relative to the anchor.
Public Sub setAlignment(Value As String)
	Select Value.ToLowerCase
		Case "auto", "start", "center", "end": m_Alignment = Value
	End Select
End Sub
Public Sub getTheme As String
	Return m_Theme
End Sub
Public Sub getOpenOnPress As Boolean
	Return m_OpenOnPress
End Sub
Public Sub setOpenOnPress(Value As Boolean)
	m_OpenOnPress = Value
	If xpnl_TriggerInput.IsInitialized Then xpnl_TriggerInput.Visible = Value
End Sub
Public Sub setTheme(Value As String)
	Select Value.ToLowerCase
		Case "auto": m_Theme = "Auto"
		Case "light": m_Theme = "Light"
		Case Else: m_Theme = "Dark"
	End Select
	ApplyThemeColors
	Refresh
End Sub

Private Sub ResolvedTheme As String
	If m_Theme <> "Auto" Then Return m_Theme
	#If B4A
	If mBase.IsInitialized Then
		Dim native As JavaObject = Me
		Return IIf(native.RunMethod("systemDark", Array(mBase)), "Dark", "Light")
	End If
	#Else If B4i
	Dim native As NativeObject = Me
	Return IIf(native.RunMethod("glassSystemDark", Null).AsBoolean, "Dark", "Light")
	#End If
	Return m_SystemTheme
End Sub

Private Sub ApplyThemeColors
	m_AppliedTheme = ResolvedTheme
	If m_AppliedTheme = "Dark" Then
		m_Properties.GlassTint = 0xB3202228
		m_Properties.TextColor = 0xFFF8F8FA
		m_Properties.SubtitleColor = 0xFF9FA1A8
		m_Properties.SeparatorColor = 0x30FFFFFF
		m_Properties.HighlightColor = 0x28FFFFFF
	Else
		m_Properties.GlassTint = 0xA6FFFFFF
		m_Properties.TextColor = 0xFF202126
		m_Properties.SubtitleColor = 0xFF777A84
		m_Properties.SeparatorColor = 0x22000000
		m_Properties.HighlightColor = 0x18000000
	End If
	m_Properties.DestructiveColor = 0xFFFF453A
End Sub
