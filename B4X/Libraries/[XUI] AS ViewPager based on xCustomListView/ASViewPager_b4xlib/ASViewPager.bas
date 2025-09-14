B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'ASViewPager
'Author: Alexander Stolte
'Version: V1.19
#If Documentation
Changelog:
V1.00
	-Release
V1.01
	-Base_Resize is now public
	-NextPage and PreviousPage Bug Fix
	-setCurrentIndex Bug Fix
	-PageChangedEvent Bug Fix
V1.02
	-B4I Bug Fixes
	-NextPage and PreviousPage Bug Fix
V1.03
	-Resize BugFix
V1.04
	-B4I Page-Height BugFix
	-B4I Page-Swipe BugFix
V1.05
	-BugFix
V1.06
	-Add Designer Property "Orientation" - Vertical is now supported
V1.07
	-BugFix getCurrentIndex
	-BugFix PageChanged event is now only firing if the index is changed
	-Add setIgnorePageChangedEvent Property
	-Add TouchBegin Event
	-Add TouchEnd Event
	-BugFix PageChanged is now firing if you press on a emulator, for example the arrow up or down keys on yor keyboard
V1.08
	-Add Tag Property 
		https://www.b4x.com/android/forum/threads/b4x-how-to-get-custom-view-here-from-clv-or-any-other-container.117992/#content
	-Add Clear - clears the list and sets the index to 0
	-BugFix xCustomListview Top was always 0
V1.09
	-B4I BugFixes for Release Mode - swiping is now better
V1.10
	-Add AddPageAt (experimental it works for my need, if you have issuses, then tell me) - Adds an page at a special position
	-Add set CurrentIndex2 - sets the current index - jumps to the item
	-Better resize handling
V1.11
	-RemovePage Bugfixes
	-B4J ScrollPane under the hood is now Transparent
	-Add NextPage2 -Jump to next page
	-Add PrevoiusPage2 - Jump to previous page
V1.12
	-[BETA] Add DesignerProperty Carousel - infinite swipe
		-On B4I Bounce Effect is disabled
	-B4I ScrollView Paging is now activated, this can improve the handling
V1.13
	-Add PageClick Event
V1.14
	-B4I only Add Scroll - enable or disable scroll with finger
V1.15
	-Intern Function IIF renamed to iif2
V1.16
	-set Scroll is now B4X - disable the swipe/scroll
		-In B4J the arrow keys (Left/Right/Up/Down) are disabled if you deactivate the swipe/scroll
	-New property isScrollEnabled - checks if the swipe/scroll is enabled or disabled
	-Intern Function iif2 removed and the core iif is now used
		-B4A V9.10+ - B4J V9.10+ - B4I V7.50+
V1.18
	-PageChanged Event is now firing in some cases with a delay, because of a scroll animation
	-BugFix B4A setScroll - Events from other views are now no longer blocked
V1.19
	-BugFix on NextPage and PreviousPage
V1.20
	-Add Event PageChange - This event is triggered immediately after the page is changed, no delay because of animations
	-Add setIgnorePageChangeEvent - prevents the PageChange event from being triggered
V1.21
	-BugFixing
V1.22
	-B4I Scroll = False BugFix
V1.24
	-BugFix AddPageAt is now working better on B4A
V1.25
	-Add Scroll2Value - sets the current index by the value - smooth scrolls to the item
		-from the AddPage and AddPageAt function the "Value" property
		-must be a string to be found
	-Add Scroll2Value2 - sets the current index by the value - jump to the item
V1.26
	-Add Designer Property LazyLoading - activates lazy loading
		-Default: False
	-Add Designer Property LazyLoadingExtraSize - How many pages to load in advance
		-Default: 5
	-Add Event LazyLoadingAddContent - Add here your layout or views
V1.27
	-Add get and set LazyLoadingExtraSize
V1.28
	-Important LazyLoading improvments
V1.29
	-Add Commit - Triggers the LazyLoadingAddContent event
		-Call this after you have filled the list
	-LazyLoading BugFixes
V1.30
	-Add ResetLazyloadingIndex - when you call "commit" afterwards, it is guaranteed to check if there are empty panels in the lazy loading range, if so, the LazyLoading event is triggered
V1.31
	-important resize improvments
	-Add Loading Panel if Base_Resize is calling
	-Add Designer Property LoadingPanelColor
	-Add set IgnoreLazyLoading - If True, the Lazy Loading event is not triggered
	-Add ResetLazyLoadingPanels - Removes all child views from all visible pages
	-LazyLoading Improvments
V1.32
	-Carousel works now in Vertical mode
V1.33
	-B4I Native paging is now used
		-The paging feels smoother now
		-In debug mode, the swiping should now also run better
V1.34
	-B4I The GestureRecognizer is no longer needed
V1.35
	-Add Designer Proeprty BackGestureGap - Only for B4I. If you use the ViewPager on a 2nd page and still want to close the page with the swipe gesture then set the checkbox to true
		-Default: False
V2.00
	-New dependency in B4J: jPager
	-Removed dependency  in B4J: xCustomListView
	-Add GetPanel
	-Add GetValue
	-In B4J, the jPager is now used instead of the xCustomListView
		-Better performance
		-No more unwanted scrolling with the mouse
V2.01
	-BugFixes and Improvements
	-Add Event PageChanged2
V2.02
	-Add set LoadingPanelHideDuration - The duration of how quickly the loading panel is hidden
		-Default: 500
V2.03
	-B4I BugFix - Prevents vertical scrolling when in horizontal mode and vice versa
V2.04
	-B4I BugFix - The safe area is no longer observed
		-Fixes unwanted behavior when the viewpager is in the safe area
V2.05
	-BugFix - by setting the set CurrentIndex or set CurrentIndex2, the PageChange and PageChanged event have been triggered multiple times
V2.06
	-B4A BugFix
V2.07
	-B4I BugFix
V2.08
	-B4I - PageChange event is now triggered as soon as you lift your finger when changing pages, just like in B4A
	-Add AllowNext
		-Default: True
		-If False: Prevents the user from moving to the next page
			-The NextPage function will not work
			-The CurrentIndex property can be used without restrictions
	-Add AllowBack
		-Default: True
		-If False: Prevents the user from moving to the previous page
			-The PreviousPage function will not work
			-The CurrentIndex property can be used without restrictions
		
-Add SwipeOnEndOfPage Event - triggers when the user scrolls even though he is already at the end of the list. Or if the user is on the 1st page and scrolls to the wrong direction
#End If

#DesignerProperty: Key: Orientation, DisplayName: Orientation, FieldType: String, DefaultValue: Horizontal, List: Horizontal|Vertical
#DesignerProperty: Key: Carousel, DisplayName: Carousel, FieldType: Boolean, DefaultValue: False, Description: infinite swipe
#DesignerProperty: Key: LazyLoading, DisplayName: Lazy Loading, FieldType: Boolean, DefaultValue: False, Description: activates lazy loading
#DesignerProperty: Key: LazyLoadingExtraSize, DisplayName: Lazy Loading Extra Size, FieldType: Int, DefaultValue: 5, MinRange: 0
#DesignerProperty: Key: LoadingPanelColor, DisplayName: Loading Panel Color, FieldType: Color, DefaultValue: 0xFF000000, Description: The color of the Loading panel if Base_Resize is executed
#DesignerProperty: Key: BackGestureGap, DisplayName: BackGestureGap, FieldType: Boolean, DefaultValue: False, Description: Only for B4I. If you use the ViewPager on a 2nd page and still want to close the page with the swipe gesture then set the checkbox to true

#Event: PageChange(Index As Int)
#Event: PageChanged(Index As Int)
#Event: PageChanged2(NewIndex As Int, OldIndex As Int)
#Event: ScrollChanged(Offset As Int)
#Event: ReachEnd
#Event: TouchBegin
#Event: TouchEnd
#Event: PageClick (Index As Int, Value As Object)
#Event: LazyLoadingAddContent(Parent As B4XView, Value As Object)
'#Event: SwipeOnEndOfPage

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	
	'Private tmr_main As Timer

	'Views
	#If B4A or B4I
	Private xclv_main As CustomListView
	#Else
	Private jp_Main As jPager
	#End If
	Private xpnl_Loading As B4XView
	
	'Variables etc...
	Private m_CurrentIndex As Int = 0'ignore
	'Private lazyloading_index As Int = -1'ignore
	#If B4A or B4I
	Private g_x,g_y,g_dv,g_ad As Float
	Private g_ms As Long
	Private  isfirstmove As Boolean = False
	#end if
	#If B4I 
	Private xpnl_BackGestureGap As B4XView
	Private nome As NativeObject=Me
	'Private tmp As GestureRecognizer
	Private mView As View
	#end if
	Private m_Ignore As Boolean = False'Ignore
	Private g_ignorepagechangedevent As Boolean = False
	Private g_ignorepagechangeevent As Boolean = False
	Private m_Orientation As String
	Private m_Carousel As Boolean
	Private m_LazyLoading As Boolean
	Private m_LazyLoadingExtraSize As Int
	Private m_LoadingPanelColor As Int
	Private m_BackGestureGap As Boolean 'Ignore
	Private m_AllowNext As Boolean = True
	Private m_AllowBack As Boolean = True
	Private m_MaxOffset As Int = 0'Ignore
	
	Private ismoving As Boolean = False'Ignore
	Private g_isScrollEnabled As Boolean = True
	Private m_IgnoreLazyLoading As Boolean = False'Ignore

	Public Tag As Object
	Private isLazyLoadingReady As Boolean = False
	Private isHidding As Boolean = False
	'Private SwipeOnEndOfPage_OnlyOnce As Boolean = True
	Private OldIndex As Int = 0
	Private m_LoadingPanelHideDuration As Int = 500
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	
	xpnl_Loading = xui.CreatePanel("")
	mBase.AddView(xpnl_Loading,0,0,mBase.Width,mBase.Height)
	xpnl_Loading.Color = xui.Color_Black
	xpnl_Loading.BringToFront
	
	m_Orientation = Props.GetDefault("Orientation","Horizontal")
	m_Carousel = Props.GetDefault("Carousel",False)
	m_LazyLoading = Props.GetDefault("LazyLoading",False)
	m_LazyLoadingExtraSize = Props.GetDefault("LazyLoadingExtraSize",5)
	m_LoadingPanelColor = xui.PaintOrColorToColor(Props.GetDefault("LoadingPanelColor",xui.Color_Black))
	xpnl_Loading.Color = m_LoadingPanelColor
	m_BackGestureGap = Props.GetDefault("BackGestureGap",False)
	
	#If B4A or B4I
	If xclv_main.IsInitialized = False Then
		ini_xclv
	End If
	#Else
	If jp_Main.IsInitialized = False Then
		IniPager
	End If
	#End If
	
	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#Else IF B4I
	Dim sv As ScrollView = xclv_main.sv
	If m_Carousel = True Then
		sv.Bounces = False
	End If
	sv.PagingEnabled = True
	
	xpnl_BackGestureGap = xui.CreatePanel("")
	xpnl_BackGestureGap.Color = xui.Color_Transparent
	If m_BackGestureGap Then mBase.AddView(xpnl_BackGestureGap,0,0,30dip,mBase.Height)
	#End If
	
'	Dim xpnl_LeftTopGap As B4XView = xui.CreatePanel("")
'	xpnl_LeftTopGap.SetLayoutAnimated(0dip,0,0,200dip,mBase.Height)
'	xpnl_LeftTopGap.Color = xui.Color_Red
'	AddPage(xpnl_LeftTopGap,"Gap")
	
End Sub

#If B4A or B4I
Private Sub ini_xclv
	Dim tmplbl As Label
	tmplbl.Initialize("")
 
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("DividerColor",0x00FFFFFF)
	tmpmap.Put("DividerHeight",0)
	tmpmap.Put("PressedColor",0x00FFFFFF)
	tmpmap.Put("InsertAnimationDuration",0)
	tmpmap.Put("ListOrientation",m_Orientation)
	tmpmap.Put("ShowScrollBar",False)
	xclv_main.Initialize(Me,"xclv_main")
	xclv_main.DesignerCreateView(mBase,tmplbl,tmpmap)
	#IF B4A
	Private objPages As Reflector
	objPages.Target = xclv_main.sv
	objPages.SetOnTouchListener("xpnl_PageArea2_Touch")
	xclv_main.AsView.SetLayoutAnimated(0,xclv_main.AsView.Left,xclv_main.AsView.Top,mBase.Width,mBase.Height)
	xclv_main.Base_Resize(mBase.Width,mBase.Height)
	#Else IF B4I	

	'xclv_main.sv.As(NativeObject).SetField("directionalLockEnabled", True)
	xclv_main.sv.As(NativeObject).SetField("contentInsetAdjustmentBehavior", 2) 'Never

	mView=xclv_main.GetBase
	'nome.RunMethod("grLongPress::::",Array(0,1,0,mView))
	nome.RunMethod("grPan:::",Array(mView,1,1))
	
	'tmp.Initialize("tmp",Me,xclv_main.GetBase)'.sv)
	'tmp.AddLongPressGesture(0,1,0)
	'tmp.AddPanGesture(1,1)

	#End if
	
	#If B4I
	Do While xclv_main.sv.IsInitialized = False
	'Sleep(0)
	Loop
	Dim sv As ScrollView = xclv_main.sv
	sv.Color = xui.Color_Transparent'xui.Color_ARGB(255,32, 33, 37)
	#End If
	
End Sub

#Else

Private Sub IniPager
	
	Dim tmplbl As Label
	tmplbl.Initialize("")
	
	Dim tmpmap As Map
	tmpmap.Initialize
	tmpmap.Put("Orientation",m_Orientation)
	tmpmap.Put("Carousel",m_Carousel)
	tmpmap.Put("LazyLoading",m_LazyLoading)
	tmpmap.Put("LazyLoadingExtraSize",m_LazyLoadingExtraSize)
	
	jp_Main.Initialize(Me,"jp_Main")
	jp_Main.DesignerCreateView(mBase,tmplbl,tmpmap)
	
End Sub

#End If

Public Sub Base_Resize (Width As Double, Height As Double)
	#IF B4I
	m_Ignore = True
	#End if
	
	#If B4J
	xpnl_Loading.BringToFront
	xpnl_Loading.SetLayoutAnimated(0,0,0,Width + 1000dip,Height + 1000dip)
	xpnl_Loading.SetVisibleAnimated(0,True)
	
	mBase.Width = Width
	mBase.Height = Height
	Sleep(0)
	
	#If B4A or B4I
	
	xclv_main.AsView.SetLayoutAnimated(0,xclv_main.AsView.Left,xclv_main.AsView.Top,mBase.Width,mBase.Height)
	xclv_main.Base_Resize(mBase.Width,mBase.Height)
		
		For i = 0 To xclv_main.Size -1
			If m_Orientation = "Horizontal" Then
			xclv_main.ResizeItem(i,mBase.Width)
			Else
			xclv_main.ResizeItem(i,mBase.Height)
			End If	
		xpnl_Loading.SetVisibleAnimated(0,True)
		Next
	xpnl_Loading.SetVisibleAnimated(0,True)

	Sleep(0)

	xclv_main.JumpToItem(m_CurrentIndex)
	
	#Else
	
	jp_Main.Base_Resize(mBase.Width,mBase.Height)
	
	#End If
	
	Sleep(0)
	LoadingPanelHandling
	#Else
	xpnl_Loading.BringToFront
	xpnl_Loading.SetLayoutAnimated(0,0,0,Width + 1000dip,Height + 1000dip)
	xpnl_Loading.SetVisibleAnimated(0,True)
	
	mBase.Width = Width
	mBase.Height = Height
	Sleep(0)
	xclv_main.AsView.SetLayoutAnimated(0,xclv_main.AsView.Left,xclv_main.AsView.Top,Width,Height)
	xclv_main.Base_Resize(Width,Height)
	
	'If change_widthorheight = True Then
	For i = 0 To xclv_main.Size -1
		If m_Orientation = "Horizontal" Then
			xclv_main.ResizeItem(i,mBase.Width)
		Else
			xclv_main.ResizeItem(i,mBase.Height)
		End If
	Next

	'End If
	'Sleep(0)
	If xclv_main.Size > 0 Then xclv_main.JumpToItem(m_CurrentIndex)
	Sleep(250)
	LoadingPanelHandling
	#End If
	
	#IF B4I
	m_Ignore = False
	#End if
End Sub

Private Sub LoadingPanelHandling
	If isHidding = False Then
		isHidding = True
		'xpnl_Loading.Visible = False
		xpnl_Loading.SetVisibleAnimated(m_LoadingPanelHideDuration,False)
		Sleep(m_LoadingPanelHideDuration + 50)
		isHidding = False
	End If
	Sleep(0)
	CheckLoadingPanelVisiblity
End Sub

Private Sub CheckLoadingPanelVisiblity
	
	Sleep(250)
	If xpnl_Loading.Visible = True And isHidding = False Then 
		isHidding = True
		xpnl_Loading.SetVisibleAnimated(m_LoadingPanelHideDuration,False)
		Sleep(m_LoadingPanelHideDuration + 50)
		isHidding = False
	End If
	
End Sub

Public Sub setLoadingPanelHideDuration(Duration As Int)
	m_LoadingPanelHideDuration = Duration
End Sub

Public Sub getBase As B4XView
	Return mBase
End Sub

Public Sub AddPage(LayoutPanel As B4XView,Value As Object)	
	
	#If B4J
	jp_Main.AddPage(LayoutPanel,Value)
	#Else
	xclv_main.Add(LayoutPanel,Value)
	#End If
End Sub


'Adds an page at a special position
Public Sub AddPageAt(index As Int,LayoutPanel As B4XView,Value As Object)

	If index <= m_CurrentIndex Then
		m_CurrentIndex = m_CurrentIndex +1
	End If
	
	#If B4J
	jp_Main.AddPageAt(index,LayoutPanel,Value)
	#Else
		xclv_main.InsertAt(index,LayoutPanel,Value)
	#End If

	#If B4I
	If m_Orientation = "Horizontal" Then
		xclv_main.sv.ScrollViewOffsetX = xclv_main.sv.ScrollViewOffsetX + mBase.Width
	else If m_Orientation = "Vertical" Then
		xclv_main.sv.ScrollViewOffsetY = xclv_main.sv.ScrollViewOffsetY + mBase.Height
	End If
	#Else If B4A
	xclv_main.JumpToItem(m_CurrentIndex)
	#Else If B4J
	jp_Main.Index = m_CurrentIndex
	#End If

End Sub

Public Sub RemovePage(index As Int)
	#If B4A or B4I
	xclv_main.RemoveAt(index)
	If m_Orientation = "Horizontal" Then
		m_CurrentIndex = xclv_main.FindIndexFromOffset(xclv_main.sv.ScrollViewOffsetX)
		Else
		m_CurrentIndex = xclv_main.FindIndexFromOffset(xclv_main.sv.ScrollViewOffsetY)
	End If
	#Else
	jp_Main.RemovePageAt(index)
	#End If
End Sub

Public Sub PreviousPage	
	If m_AllowBack = False Then Return
		#If B4J
		jp_Main.PreviousPage
		#Else
	If (m_CurrentIndex -1) > -1 Then
		xclv_main.ScrollToItem(m_CurrentIndex -1)
		
		PageChangedEvent(m_CurrentIndex -1,True)
	Else If m_Carousel = True Then
		CheckCarousel
	End If
			#End If
End Sub
'jump to previous page
Public Sub PreviousPage2
	If m_AllowBack = False Then Return
			#If B4J
		jp_Main.PreviousPage
		#Else
	If (m_CurrentIndex -1) > -1 Then
		xclv_main.JumpToItem(m_CurrentIndex -1)
		PageChangedEvent(m_CurrentIndex -1,False)
	Else If m_Carousel = True Then
		CheckCarousel
	End If
			#End If	
End Sub

Public Sub NextPage
	If m_AllowNext = False Then Return
			#If B4J
		jp_Main.NextPage
		#ELse
	If (m_CurrentIndex +1) < xclv_main.Size Then
		xclv_main.ScrollToItem(m_CurrentIndex +1)
		PageChangedEvent(m_CurrentIndex +1,True)
	Else If m_Carousel = True Then
		CheckCarousel
	End If
			#End If
End Sub
'Jump to next page
Public Sub NextPage2
	If m_AllowNext = False Then Return
	#If B4J
	jp_Main.NextPage
	#Else
	If (m_CurrentIndex +1) < xclv_main.Size Then
	'PageChangeEvent(m_CurrentIndex +1)
		xclv_main.JumpToItem(m_CurrentIndex +1)
		PageChangedEvent(m_CurrentIndex +1,False)
	Else If m_Carousel = True Then
		CheckCarousel
	End If
		#End If
End Sub

Public Sub Commit
	isLazyLoadingReady = True
	#If B4J
	jp_Main.Commit
	#Else
	xclv_main.Refresh
	#End If
	
End Sub

'If False: Prevents the user from moving to the next page
'	-The NextPage function will not work
'	-The CurrentIndex property can be used without restrictions
Public Sub AllowNext(Allow As Boolean)
	m_AllowNext = Allow
	#If B4I
	setScroll(m_AllowBack Or m_AllowNext)
	#Else If B4J
	jp_Main.AllowNext(Allow)
	#End If
End Sub

'If False: Prevents the user from moving to the previous page
'	-The PreviousPage function will not work
'	-The CurrentIndex property can be used without restrictions
Public Sub AllowBack(Allow As Boolean)
	m_AllowBack = Allow
		#If B4I
	setScroll(m_AllowBack Or m_AllowNext)
		#Else If B4J
	jp_Main.AllowBack(Allow)
	#End If
End Sub

#Region Properties
'The color of the Loading panel if Base_Resize is executed
Public Sub setLoadingPanelColor(Color As Int)
	m_LoadingPanelColor = Color
	xpnl_Loading.Color = Color
End Sub

Public Sub getLoadingPanelColor As Int
	Return m_LoadingPanelColor
End Sub

Public Sub setLazyLoading(Enabled As Boolean)
	m_LazyLoading = Enabled
	#If B4J
	jp_Main.LazyLoading = Enabled
	#End If
End Sub

Public Sub getLazyLoading As Boolean
	Return m_LazyLoading
End Sub

Public Sub setLazyLoadingExtraSize(ExtraSize As Int)
	m_LazyLoadingExtraSize = ExtraSize
	#If B4J
	jp_Main.LazyLoadingExtraSize = ExtraSize
	#End If
End Sub

Public Sub getLazyLoadingExtraSize As Int
	Return m_LazyLoadingExtraSize
End Sub
'B4I and B4A only
'enabled - False the scroll is deactivated
Public Sub setScroll(enabled As Boolean)
	g_isScrollEnabled = enabled
	#IF B4I
	Dim sv As ScrollView = xclv_main.sv
	sv.ScrollEnabled = enabled
	#End If
End Sub
'Checks if the swipe/scroll is enabled or disabled
Public Sub getisScrollEnabled As Boolean
	Return g_isScrollEnabled
End Sub

Public Sub setIgnorePageChangedEvent(ignore As Boolean)
	g_ignorepagechangedevent = ignore
End Sub
Public Sub setIgnorePageChangeEvent(ignore As Boolean)
	g_ignorepagechangeevent = ignore
End Sub
'sets the current index by the value - smooth scrolls to the item
Public Sub Scroll2Value(Value As String)
	#If B4J
	For i = 0 To jp_Main.Size -1
		If jp_Main.GetValue(i) Is String And Value = jp_Main.GetValue(i) Then
			setCurrentIndex(i)
			Exit
		End If
	Next
	#Else
		For i = 0 To xclv_main.Size -1
		If xclv_main.GetValue(i) Is String And Value = xclv_main.GetValue(i) Then
			setCurrentIndex(i)
			Exit
		End If
	Next
	#End If
End Sub
'sets the current index by the value - jumps to the item
Public Sub Scroll2Value2(Value As String)
#If B4J
	For i = 0 To jp_Main.Size -1
		If jp_Main.GetValue(i) Is String And Value = jp_Main.GetValue(i) Then
			setCurrentIndex2(i)
			Exit
		End If
	Next
	#Else
		For i = 0 To xclv_main.Size -1
		If xclv_main.GetValue(i) Is String And Value = xclv_main.GetValue(i) Then
			setCurrentIndex2(i)
			Exit
		End If
	Next
#End If
End Sub

Public Sub getCurrentIndex As Int	
	#If B4J
	Return jp_Main.Index
	#Else
	Return m_CurrentIndex
	#End If	
End Sub

Public Sub setCurrentIndex(index As Int)
	#If B4J
	jp_Main.Index = index
	#Else
	PageChangedEvent(index,True)
	m_Ignore = True
	xclv_main.ScrollToItem(index)
	Sleep(250)
	m_Ignore = False
	#End If
End Sub
'sets the current index - jumps to the item
Public Sub setCurrentIndex2(index As Int)
		#If B4J
	jp_Main.Index = index
	#Else
	m_Ignore = True
	PageChangedEvent(index,False)
	xclv_main.JumpToItem(index)
	Sleep(250)
	m_Ignore = False
	#End If
End Sub

Public Sub getSize As Int
		#If B4J
	Return jp_Main.Size
	#Else
	Return xclv_main.Size
	#End If
End Sub

#If B4A or B4I
Public Sub getCustomListView As CustomListView
	Return xclv_main
End Sub
#Else
Public Sub getjPager As jPager
	Return jp_Main
End Sub
#End If

Public Sub GetValue(Index As Int) As Object
	#If B4J
	Return jp_Main.GetValue(Index)
	#Else
	Return xclv_main.GetValue(Index)
	#End If
End Sub

Public Sub GetPanel(Index As Int) As B4XView
	#If B4J
	Return jp_Main.GetPanel(Index)
	#Else
	Return xclv_main.GetPanel(Index)
	#End If
End Sub

Public Sub Clear
	#If B4A or B4I
	xclv_main.Clear
	m_CurrentIndex = 0
	#Else
	jp_Main.Clear
	#End If
End Sub
'Removes all child views from all visible pages
'Usage:
'<code>	
'xASVP_Horizontal.ResetLazyLoadingPanels
'Sleep(0)
'xASVP_Horizontal.ResetLazyloadingIndex
'xASVP_Horizontal.Commit</code>
Public Sub ResetLazyLoadingPanels
#If B4J
	For i = 0 To jp_Main.Size - 1
		Dim p As B4XView = jp_Main.GetPanel(i)
		'not visible
		If p.NumberOfViews > 0 Then
			p.RemoveAllViews '<--- remove the layout
		End If
	Next
#Else
	For i = 0 To xclv_main.Size - 1
		Dim p As B4XView = xclv_main.GetPanel(i)
	'not visible
		If p.NumberOfViews > 0 Then
			p.RemoveAllViews '<--- remove the layout
		End If
	Next
#End If
End Sub

#End Region

#Region Swipe

#If B4A or B4I

Private Sub ff(x As Float,y As Float)
	isfirstmove = True
	g_ms=DateTime.Now
	g_x=X
	g_y=Y
	If m_Orientation = "Horizontal" Then
	g_dv = (mBase.Width)/2
	Else
	g_dv = (mBase.Height)/2
	End If
	g_ad = 0
End Sub
#If B4A
Private Sub HandleTouch(Action As Int,x As Float,y As Float) As Boolean
#Else If B4I
Private Sub HandleTouch(Action As Int,x As Float,y As Float) As ResumableSub'ignore
	'Sleep(0)
#End If

	Select Action
		Case 2
			TouchBeginEvent
			ismoving = True
			If isfirstmove = False Then
				'SwipeOnEndOfPage_OnlyOnce = True
				ff(X,y)
			Else

			End If
				
		Case 1
			
			TouchEndEvent
			ismoving = False
			isfirstmove = False

			If m_Orientation = "Horizontal" Then
				If ((DateTime.Now-g_ms)<300) And (Abs(X - g_x) > (1dip)) Then

					g_dv =1dip

					If X < g_x Then g_ad = 1

				End If
			Else
				If ((DateTime.Now-g_ms)<300)  And (Abs(y - g_y) > (1dip)) Then
					g_dv =1dip
				
					If y < g_y Then g_ad = 1
	
				End If
			End If

			For i = 0 To xclv_main.Size -1
				If m_Orientation = "Horizontal" Then
					If (((i+1)*mBase.Width) - xclv_main.sv.ScrollViewOffsetX) > (g_dv) Then

						If (i+g_ad) > (xclv_main.Size -1) Or xclv_main.sv.ScrollViewOffsetX <= 0 Then
							CheckCarousel
							Return False
						End If
						#If B4A or B4J
						If isNumberOneCloserToZero(g_x - x,g_y - y) = False Then
							xclv_main.ScrollToItem(m_CurrentIndex)
							Return True
						End If
						xclv_main.ScrollToItem(i+g_ad)
						If m_CurrentIndex <> (i+g_ad) Then PageChangedEvent(i+g_ad,True)
						#Else If B4I
						If m_CurrentIndex <> (i+g_ad) Then PageChangedEvent(i+g_ad,True)
						#End If
						Return True
					End If
				Else
					
					If (((i+1)*mBase.Height) - xclv_main.sv.ScrollViewOffsetY) > (g_dv) Then
						
						If (i+g_ad) > xclv_main.Size-1 Or  xclv_main.sv.ScrollViewOffsetY <= 0 Then
							CheckCarousel
							Return False
						End If
						#If B4A or B4J
						If isNumberOneCloserToZero(g_y - y,g_x - x) = False Then
							xclv_main.ScrollToItem(m_CurrentIndex)
							Return True
						End If
						xclv_main.ScrollToItem(i+g_ad)
						If m_CurrentIndex <> (i+g_ad) Then PageChangedEvent(i+g_ad,True)
						#Else If B4I
						If m_CurrentIndex <> (i+g_ad) Then PageChangedEvent(i+g_ad,True)
						#End if
						Return True
					End If
				End If
			Next
	End Select
	Return False
End Sub

#End If
#If B4A or B4I
Private Sub CheckCarousel
	If m_Carousel = True Then
		Sleep(0)
		If m_CurrentIndex = xclv_main.Size -1 Then
			setCurrentIndex2(0)
		Else If m_CurrentIndex = 0 Then
			setCurrentIndex2(xclv_main.Size -1)
		End If
	End If
End Sub
#End If
#If B4A

Private Sub xpnl_PageArea2_Touch(ViewTag As Object, Action As Int, X As Float, y As Float, MotionEvent As Object) As Boolean
	If g_isScrollEnabled = False Or (m_AllowBack = False And m_AllowNext = False) Then Return True
	'Log(X)

	If m_AllowNext = False Or m_AllowBack = False Then
		
		Dim SkipCheck As Boolean = False
		If Action = 1 Then
			isfirstmove = False
			SkipCheck = True
		End If
		
		If isfirstmove = False And SkipCheck = False Then
			'xclv_main.sv.ScrollViewOffsetX = m_MaxOffset
			ff(X,y)
			'Log("isfirstmove")
			Return True
		End If
		
		If m_AllowNext = False And x < g_x Then
			xclv_main.sv.ScrollViewOffsetX = m_MaxOffset
			'Log("xclv_main.sv.ScrollViewOffsetX = m_MaxOffset")
			Return True
		else If m_AllowBack = False And x > g_x Then
			xclv_main.sv.ScrollViewOffsetX = m_MaxOffset
			'Log("xclv_main.sv.ScrollViewOffsetX = m_MaxOffset")
			Return True
		End If
		
	End If

'Log("luuul")
	
	
	Return HandleTouch(Action,x,y)
End Sub

#Else If B4I

Private Sub CheckAllow(Action As Int,x As Float,y As Float) As Boolean
	If m_AllowNext = False Or m_AllowBack = False Then
		
		Dim SkipCheck As Boolean = False
		If Action = 3 Then
			isfirstmove = False
			SkipCheck = True
		End If
		
		If isfirstmove = False And SkipCheck = False Then
			'xclv_main.sv.ScrollViewOffsetX = m_MaxOffset
			ff(X,y)
			'Log("isfirstmove")
			Return True
		End If
		
		If m_AllowNext = False And x < g_x Then
			xclv_main.sv.As(ScrollView).ScrollEnabled = False
			xclv_main.sv.ScrollViewOffsetX = m_MaxOffset
			'Log("xclv_main.sv.ScrollViewOffsetX = m_MaxOffset")
			xclv_main.sv.As(ScrollView).ScrollEnabled = True
			Return True
		else If m_AllowBack = False And x > g_x Then
			xclv_main.sv.As(ScrollView).ScrollEnabled = False
			xclv_main.sv.ScrollViewOffsetX = m_MaxOffset
			'Log("xclv_main.sv.ScrollViewOffsetX = m_MaxOffset")
			xclv_main.sv.As(ScrollView).ScrollEnabled = True
			Return True
		End If
		
	End If
	Return False
End Sub

Private Sub uigesture_longpress(state As Int,numtouch As Int, Numtaps As Int, x As Float, y As Float, obj As Object)

	If g_isScrollEnabled = False Or (m_AllowBack = False And m_AllowNext = False) Then Return
	
	If CheckAllow(state,x,y) Then Return
	
	If state = 1 Then'tmp.STATE_Begin Then
		HandleTouch(2,x,y)
		'	Log("longpress")
		'TouchEndEvent
	End If

End Sub

Private Sub uigesture_pan(state As Int,x As Float, y As Float, obj As Object)

	If g_isScrollEnabled = False Or (m_AllowBack = False And m_AllowNext = False) Then Return
	
	If CheckAllow(state,x,y) Then Return
	
	'Log("att.X: " & att.X)
	Select state
		Case 2 'STATE_Changed
			'TouchBeginEvent
			HandleTouch(2,x,y)
			'Log("pan")
		Case 3 'STATE_End			
			HandleTouch(1,x,y)
	End Select
	
End Sub


'Private Sub tmp_longpress(state As Int, att As LongPress_Attributes)
'	If g_isScrollEnabled = False Then Return
'	If state = 1 Then'tmp.STATE_Begin Then
'		HandleTouch(2,att.X,att.Y)
'		'TouchEndEvent
'	End If
'End Sub
'
'Private Sub tmp_pan(state As Int, att As Pan_Attributes)
'	If g_isScrollEnabled = False Then Return
'	'Log("att.X: " & att.X)
'	Select state
'		Case 2 'STATE_Changed
'			'TouchBeginEvent
'			HandleTouch(2,att.X,att.Y)
'		Case 3 'STATE_End
'			HandleTouch(1,att.X,att.Y)
'	End Select
'End Sub

#End If

#End Region

#Region Events

#If B4A or B4I
Private Sub xclv_main_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
'	#IF B4I
'	If m_Ignore = False Then
'		If FirstIndex < m_CurrentIndex Then
'			PageChangedEvent(LastIndex,False)
'		Else
'			PageChangedEvent(FirstIndex,False)
'		End If
'	End If
'	#End If
	
	If m_LazyLoading = False Or m_IgnoreLazyLoading = True Then Return
	
	'Log(lazyloading_index)
	'Log(xclv_main.FindIndexFromOffset(IIf(m_orientation = "Vertical",xclv_main.sv.ScrollViewOffsety,xclv_main.sv.ScrollViewOffsetx)))
	
	'Log(IIf(m_orientation = "Vertical",xclv_main.sv.ScrollViewOffsety,xclv_main.sv.ScrollViewOffsetx).As(Int))
	'Log(IIf(m_orientation = "Vertical",mBase.Height,mBase.Width) * xclv_main.FindIndexFromOffset(IIf(m_orientation = "Vertical",xclv_main.sv.ScrollViewOffsety,xclv_main.sv.ScrollViewOffsetx)).As(Int))
	
	'Log(xclv_main.FindIndexFromOffset(IIf(m_orientation = "Vertical",xclv_main.sv.ScrollViewOffsety,xclv_main.sv.ScrollViewOffsetx)).As(Int))
	
	'If lazyloading_index = m_CurrentIndex And xclv_main.GetPanel(m_CurrentIndex).NumberOfViews = 0 Then lazyloading_index = -1
	
	'If lazyloading_index <> m_CurrentIndex Then
	'If isLazyLoadingReady = True Then	lazyloading_index = xclv_main.FindIndexFromOffset(IIf(m_Orientation = "Vertical",xclv_main.sv.ScrollViewOffsety,xclv_main.sv.ScrollViewOffsetx))
	For i = 0 To xclv_main.Size - 1
		Dim p As B4XView = xclv_main.GetPanel(i)
		If i > FirstIndex - m_LazyLoadingExtraSize And i < LastIndex + m_LazyLoadingExtraSize Then
			'visible+
			If p.NumberOfViews = 0 Then
				LazyLoadingAddContent(p,xclv_main.GetValue(i))
			End If
		Else
			
			If i > m_CurrentIndex - m_LazyLoadingExtraSize And i < m_CurrentIndex + m_LazyLoadingExtraSize Then
				
				Else
				'not visible
				If p.NumberOfViews > 0 Then
					p.RemoveAllViews '<--- remove the layout
				End If
			End If
			
		End If
	Next
	'End If
End Sub

#End If

Public Sub ResetLazyloadingIndex
	'lazyloading_index = -1
End Sub
'If True, the Lazy Loading event is not triggered
Public Sub setIgnoreLazyLoading(Ignore As Boolean)
	m_IgnoreLazyLoading = Ignore
End Sub

#If B4A or B4I

Private Sub xclv_main_ScrollChanged (Offset As Int)
	
'	#If B4I
'	If m_AllowNext = False And Offset > m_MaxOffset Then
'		xclv_main.sv.ScrollViewOffsetX = m_MaxOffset
'		Return
'	End If
'	If m_AllowBack = False And Offset < m_MaxOffset Then
'		xclv_main.sv.ScrollViewOffsetX = m_MaxOffset
'		Return
'	End If
'	#End If
	
'	#If B4I
'	If m_Orientation = "Horizontal" Then
'		xclv_main.sv.ScrollViewOffsetY = 0
'	else If m_Orientation = "Vertical" Then
'		xclv_main.sv.ScrollViewOffsetX = 0
'	End If
'	#End If
	If xclv_main.FindIndexFromOffset(Offset) <> m_CurrentIndex And Offset = IIf(m_Orientation = "Vertical",mBase.Height,mBase.Width) * xclv_main.FindIndexFromOffset(Offset) And m_Ignore = False Then
		PageChangedEvent(xclv_main.FindIndexFromOffset(Offset),False)
	End If

	If xui.SubExists(mCallBack, mEventName & "_ScrollChanged", 1) Then
		CallSub2(mCallBack, mEventName & "_ScrollChanged",Offset)
	End If
End Sub

#Else

Private Sub jp_Main_LazyLoadingAddContent(Parent As B4XView, Value As Object)
	LazyLoadingAddContent(Parent,Value)
End Sub

Private Sub jp_Main_PageChanged(Index As Int)
	PageChangedEvent(Index,False)
End Sub

#End If

Private Sub xclv_main_ReachEnd
	If xui.SubExists(mCallBack, mEventName & "_ReachEnd", 0) Then
		CallSub(mCallBack, mEventName & "_ReachEnd")
	End If
End Sub

'Private Sub PageChangeEvent(index As Int)
'	If m_CurrentIndex = index Then Return
'	m_CurrentIndex = index
'	If g_ignorepagechangeevent = False And xui.SubExists(mCallBack, mEventName & "_PageChange", 1) Then
'		CallSub2(mCallBack, mEventName & "_PageChange",index)
'	End If
'End Sub

Private Sub LazyLoadingAddContent(Parent As B4XView,Value As Object)
	If isLazyLoadingReady = True And xui.SubExists(mCallBack, mEventName & "_LazyLoadingAddContent", 2) Then	
		CallSub3(mCallBack, mEventName & "_LazyLoadingAddContent",Parent,Value)
	End If
End Sub

Private Sub PageChangedEvent(index As Int,delayed As Boolean)
	If m_CurrentIndex = index Then Return
	m_CurrentIndex = index
	If g_ignorepagechangeevent = False And xui.SubExists(mCallBack, mEventName & "_PageChange", 1) Then
		CallSub2(mCallBack, mEventName & "_PageChange",index)
	End If
	#If B4A or B4I
	m_MaxOffset = xclv_main.GetRawListItem(index).Offset
	#End If
	If delayed = True Then Sleep(300)
		#If B4A or B4I
	m_MaxOffset = xclv_main.GetRawListItem(index).Offset
	#End If
	If g_ignorepagechangedevent = False And xui.SubExists(mCallBack, mEventName & "_PageChanged", 1) Then
		CallSub2(mCallBack, mEventName & "_PageChanged",index)
	End If
	If g_ignorepagechangedevent = False And xui.SubExists(mCallBack, mEventName & "_PageChanged2", 2) Then
		CallSub3(mCallBack, mEventName & "_PageChanged2",index,OldIndex)
	End If
	OldIndex = index
End Sub
#IF B4A or B4I
Private Sub TouchBeginEvent
	If ismoving = False Then
	If xui.SubExists(mCallBack, mEventName & "_TouchBegin", 0) Then
		CallSub(mCallBack, mEventName & "_TouchBegin")
	End If
	End If
End Sub

Private Sub TouchEndEvent
	If xui.SubExists(mCallBack, mEventName & "_TouchEnd", 0) Then
		CallSub(mCallBack, mEventName & "_TouchEnd")
	End If
End Sub
#End If

Private Sub xclv_main_ItemClick (Index As Int, Value As Object)
	If xui.SubExists(mCallBack, mEventName & "_PageClick", 2) Then
		CallSub3(mCallBack, mEventName & "_PageClick",Index,Value)
	End If
End Sub

'Private Sub SwipeOnEndOfPage
'	SwipeOnEndOfPage_OnlyOnce = False
'	If xui.SubExists(mCallBack, mEventName & "_SwipeOnEndOfPage", 0) Then
'		CallSub(mCallBack, mEventName & "_SwipeOnEndOfPage")
'	End If
'End Sub

Private Sub isNumberOneCloserToZero (numberOne As Int, numberTwo As Int) As Boolean 'ignore
	Return (Abs(numberOne) >= Abs(numberTwo))
End Sub

#End Region


#Region GestureRecongnizer

#If OBJC
/////////TAP//////////

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
     return TRUE;
}

-(void)grTap: (int)numtaps :(int)numtouch :(UIView*)v
{
UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
Tap.delegate=self;
[Tap setNumberOfTapsRequired:numtaps];
[Tap setNumberOfTouchesRequired:numtouch];


[v addGestureRecognizer:Tap];
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {  

float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;


	int st =gestureRecognizer.state;
    int numtouch =gestureRecognizer.numberOfTouchesRequired;
    int numtap =gestureRecognizer.numberOfTapsRequired;
    [self.bi raiseEvent:nil event:@"uigesture_tap::::::" params:@[@((int)st),@((int)numtap),@((int)numtouch),@((float)x),@((float)y),(gestureRecognizer)]];

  }  


////////////PINCH/////////////

-(void)grPinch :(UIView*)v
{
UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self  action:@selector(handlePinch:)];
 pinch.delegate=self;
 [v addGestureRecognizer:pinch];

}

- (void)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer 
{  

float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

	float sc=gestureRecognizer.scale;
	float vl=gestureRecognizer.velocity;
	int st =gestureRecognizer.state;
    [self.bi raiseEvent:nil event:@"uigesture_pinch::::::" params:@[@((float)sc),@((float)vl),@((int)st),@((float)x),@((float)y),(gestureRecognizer)]];


  }  
  

  
  
//////// ROTATION /////////////

-(void)grRotation :(UIView*)v
{
UIRotationGestureRecognizer *Rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self  action:@selector(handleRotation:)];
 Rotation.delegate=self;
 [v addGestureRecognizer:Rotation];

}

- (void)handleRotation:(UIRotationGestureRecognizer *)gestureRecognizer 
{  

float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

	float rt=gestureRecognizer.rotation;
	float vl=gestureRecognizer.velocity;
	int st =gestureRecognizer.state;
    [self.bi raiseEvent:nil event:@"uigesture_rotation::::::" params:@[@((float)rt),@((float)vl),@((int)st),@((float)x),@((float)y),(gestureRecognizer)]];


  }  
  
  
///////////// SWIPE //////////////

-(void)grSwipe :(UIView*)v :(int)numtouch :(int)dir
{
UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(handleSwipe:)];
 
// if (dir==1)
// {
  [swipe setDirection:dir];

// }
 
 
 [swipe setNumberOfTouchesRequired:numtouch];
  swipe.delegate=self;
 [v addGestureRecognizer:swipe];

}


- (void)handleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {  

float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

	int st =gestureRecognizer.state;
	int dir=gestureRecognizer.direction;

    [self.bi raiseEvent:nil event:@"uigesture_swipe:::::" params:@[@((int)st),@((int)dir),@((float)x),@((float)y),(gestureRecognizer)]];

  }  

/////////// PAN ///////////

-(void)grPan :(UIView*)v :(int)mintouch :(int)maxtouch
{
UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self  action:@selector(handlePan:)];
 
 [pan setMaximumNumberOfTouches:maxtouch];
 [pan setMinimumNumberOfTouches:mintouch];
pan.delegate=self;
 [v addGestureRecognizer:pan];

}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {  

	int st =gestureRecognizer.state;
float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

    [self.bi raiseEvent:nil event:@"uigesture_pan::::" params:@[@((int)st),@((float)x),@((float)y),(gestureRecognizer)]];

  }  

///////////// SCREEN EDGE ///////////

-(void)grScreenEdge :(UIView*)v :(int)dir 
{
UIScreenEdgePanGestureRecognizer *panEdge = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self  action:@selector(handlePanEdge:)];
 
 [panEdge setEdges:dir];
 [v addGestureRecognizer:panEdge];

}

- (void)handlePanEdge:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer {  

float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

	int st =gestureRecognizer.state;
	int ed =[gestureRecognizer edges];
    [self.bi raiseEvent:nil event:@"uigesture_screenedgepan:::::" params:@[@((int)st),@((int)ed),@((float)x),@((float)y),(gestureRecognizer)]];

  }  
  
  
  
///////////LONG PRESS////////


-(void)grLongPress: (int)numtaps :(int)numtouch :(float)interval :(UIView*)v
{
UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];

[longpress setNumberOfTapsRequired:numtaps];
[longpress setNumberOfTouchesRequired:numtouch];
[longpress setMinimumPressDuration:interval];
longpress.delegate=self;
[v addGestureRecognizer:longpress];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {  

float x= [gestureRecognizer locationInView:(self._mview).object].x;
float y= [gestureRecognizer locationInView:(self._mview).object].y;

	int st =gestureRecognizer.state;
	int numtouch =gestureRecognizer.numberOfTouchesRequired;
    int numtap =gestureRecognizer.numberOfTapsRequired;
    [self.bi raiseEvent:nil event:@"uigesture_longpress::::::" params:@[@((int)st),@((int)numtouch),@((int)numtap),@((float)x),@((float)y),(gestureRecognizer)]];
  }  

#End If

#End Region
