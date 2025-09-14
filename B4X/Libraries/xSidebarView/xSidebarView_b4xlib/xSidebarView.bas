B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'xSidebarView 1.0
'based on
'xCustomListView v1.72
#Event: ItemClick (Value As String)
#Event: ItemLongClick (Value As String)
#Event: ReachEnd
#Event: VisibleRangeChanged (FirstIndex As Int, LastIndex as Int)
#Event: ScrollChanged (Offset As Int)
#DesignerProperty: Key: BackgroundColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: HeadlineColor, DisplayName: Headline Text Color, FieldType: Color, DefaultValue: 0xFF434343
#DesignerProperty: Key: SeperatorColor, DisplayName: Seperator Color, FieldType: Color, DefaultValue: 0xFF484848
#DesignerProperty: Key: ItemTextColor, DisplayName: Item Text Color, FieldType: Color, DefaultValue: 0xFF484848
#DesignerProperty: Key: Itemheight, DisplayName: Item Height, FieldType: Int, DefaultValue: 60
#DesignerProperty: Key: ItemTextSize, DisplayName: Item Text Size, FieldType: Int, DefaultValue: 22
#DesignerProperty: Key: IconSize, DisplayName: Icon Size, FieldType: Int, DefaultValue: 25
#DesignerProperty: Key: HeadlineSize, DisplayName: Headline Text Size, FieldType: Int, DefaultValue: 22
#DesignerProperty: Key: ShowScrollBar, DisplayName: Show Scroll Bar, FieldType: Boolean, DefaultValue: True, Description: Whether to show the scrollbar (when needed).
#DesignerProperty: Key: IconTypeface, DisplayName: Icon Typeface, FieldType: String, List: FontAwesome|Material Icons, DefaultValue: FontAwesome
#DesignerProperty: Key: Animated, DisplayName: Animated Highlight, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: AnimationSpeed, DisplayName: Animation Speed, FieldType: Int, DefaultValue: 500

Sub Class_Globals
	Private mBase As B4XView
	Public sv As B4XView
	Type SBItem(Panel As B4XView, Size As Int, Value As Object, _
		Color As Int, TextItem As Boolean, Offset As Int,Clickable As Boolean, hasBitmap As Boolean)
	Private items As List
	Private mDividerSize As Float
	Private EventName As String
	Private CallBack As Object
	Private LastReachEndEvent As Long
	Private xui As XUI
	Public HeadlineColor As Int
	Public ItemHeight As Int
	Public BackgroundColor As Int
	Public SeperatorColor As Int
	Public HeadlineSize As Int
	Public ItemTextSize As Int
	Public ItemTextColor As Int
	Public HeaderPanel As B4XView
	Public mIconTypeface As Typeface = Typeface.FONTAWESOME
	Private IconSize As Int
	Public Animated As Boolean
	public AnimationSpeed as int
#if B4J
	Private fx As JFX
#else if B4A
'	Private su As StringUtils
#else if B4i
	Private FeedbackGenerator As NativeObject
#end if
	Private mFirstVisibleIndex, mLastVisibleIndex As Int
	Private MonitorVisibleRange As Boolean
	Private FireScrollChanged As Boolean
	Private ScrollBarsVisible As Boolean
End Sub

Public Sub Initialize (vCallBack As Object, vEventName As String)
	EventName = vEventName
	CallBack = vCallBack
	items.Initialize
	MonitorVisibleRange = xui.SubExists(CallBack, EventName & "_VisibleRangeChanged", 2)
	FireScrollChanged = xui.SubExists(CallBack, EventName & "_ScrollChanged", 1)
	#if B4I
FeedbackGenerator.Initialize("UIImpactFeedbackGenerator")
If FeedbackGenerator.IsInitialized Then
	FeedbackGenerator = FeedbackGenerator.RunMethod("alloc", Null).RunMethod("initWithStyle:", Array(0)) 'light
End If
	#End If
	ResetVisibles
End Sub

Private Sub ResetVisibles
	mFirstVisibleIndex = -1
	mLastVisibleIndex = 0x7FFFFFFF
End Sub

'Causes the VisibleRangeChanged event to be raised
Public Sub Refresh
	ResetVisibles
	UpdateVisibleRange
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	sv = CreateScrollView
	mBase.AddView(sv, 0, 0, mBase.Width, mBase.Height)
	
	mDividerSize = 0
	ItemHeight=DipToCurrent(Props.GetDefault("Itemheight", 60))
	ItemTextSize=Props.Get("ItemTextSize")
	BackgroundColor=xui.PaintOrColorToColor(Props.Get("BackgroundColor"))
	HeadlineColor=xui.PaintOrColorToColor(Props.Get("HeadlineColor"))
	ItemTextColor=xui.PaintOrColorToColor(Props.Get("ItemTextColor"))
	SeperatorColor=xui.PaintOrColorToColor(Props.Get("SeperatorColor"))
	Animated=Props.Get("Animated")
	sv.Color=BackgroundColor
	HeadlineSize=Props.GetDefault("HeadlineSize", 22)
	IconSize=Props.GetDefault("HeadlineSize", 24)
	AnimationSpeed=Props.GetDefault("AnimationSpeed", 500)
	
	If Props.Get("IconTypeface") = "Material Icons" Then
		mIconTypeface=Typeface.MATERIALICONS
	End If
	
	ScrollBarsVisible = Props.GetDefault("ShowScrollBar", True)
	If ScrollBarsVisible = False Then
		#if B4J
		Dim nsv As ScrollPane = sv
		nsv.SetHScrollVisibility("NEVER")
		nsv.SetVScrollVisibility("NEVER")
		#else if B4A
		Dim jsv As JavaObject = sv
		
		jsv.RunMethod("setVerticalScrollBarEnabled", Array(False))
		
		#else if B4i
		Dim no As NativeObject = sv
		no.RunMethod("setShowsHorizontalScrollIndicator:", Array(False))
		no.RunMethod("setShowsVerticalScrollIndicator:", Array(False))
		#End If
	End If
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Public Sub Base_Resize (Width As Double, Height As Double)
	sv.SetLayoutAnimated(0, 0, 0, Width, Height)
	Dim scrollbar As Int
	If xui.IsB4J And ScrollBarsVisible Then scrollbar = 20
	

	sv.ScrollViewContentWidth = Width - scrollbar
	For Each it As SBItem In items
		it.Panel.Width = sv.ScrollViewContentWidth
		it.Panel.GetView(0).Width = it.Panel.Width
		If it.TextItem Then
			Dim lbl As B4XView = it.Panel.GetView(0).GetView(0)
			lbl.SetLayoutAnimated(0, lbl.Left, lbl.Top, it.Panel.Width - lbl.Left, lbl.Height)
		End If
	Next
	
	If items.Size > 0 Then UpdateVisibleRange
End Sub

Public Sub AsView As B4XView
	Return mBase
End Sub

'Clears all items.
Public Sub Clear
	items.Clear
	sv.ScrollViewInnerPanel.RemoveAllViews
	SetScrollViewContentSize(0)
	ResetVisibles
End Sub

Public Sub GetBase As B4XView
	Return mBase
End Sub

'Returns the number of items.
Public Sub getSize As Int
	Return items.Size
End Sub

'Returns the SBItem. Should not be used in most cases.
Public Sub GetRawListItem(Index As Int) As SBItem
	Return items.Get(Index)
End Sub

'Returns the Panel stored at the specified index.
Public Sub GetPanel(Index As Int) As B4XView
	Return GetRawListItem(Index).Panel.GetView(0)
End Sub

'Returns the value stored at the specified index.
Public Sub GetValue(Index As Int) As Object
	Return GetRawListItem(Index).Value
End Sub

'Removes the item at the specified index.
'Public Sub RemoveAt(Index As Int)
'	If getSize <= 1 Then
'		Clear
'		Return
'	End If
'	Dim RemoveItem As SBItem = items.Get(Index)
'	Dim p As B4XView
'	For i = Index + 1 To items.Size - 1
'		Dim item As SBItem = items.Get(i)
'		p = item.Panel
'		p.Tag = i - 1
'		Dim NewOffset As Int = item.Offset - RemoveItem.Size - mDividerSize
'		SetItemOffset(item, NewOffset)
'	Next
'	SetScrollViewContentSize(GetScrollViewContentSize - RemoveItem.Size - mDividerSize)
'	items.RemoveAt(Index)
'	RemoveItem.Panel.RemoveViewFromParent
'End Sub


'Adds a text item. The item height will be adjusted based on the text.
'Public Sub AddTextItem(Text As Object, Value As Object)
'	InsertAtTextItem(items.Size, Text, Value)
'End Sub

'Inserts a text item at the specified index.
'Public Sub InsertAtTextItem(Index As Int, Text As Object, Value As Object)
'	Dim pnl As B4XView = CreatePanel("")
'	Dim lbl As B4XView = CreateLabel(Text)
'	lbl.Height = Max(50dip, lbl.Height)
'	pnl.AddView(lbl, 5dip, 2dip, sv.ScrollViewContentWidth - 10dip, lbl.Height)
'	If xui.IsB4i = False Then
'		lbl.TextColor = DefaultTextColor
'	End If
'	pnl.Color = DefaultTextBackgroundColor
'	pnl.Height = lbl.Height + 2dip
'	InsertAt(Index, pnl, Value)
'	Dim item As SBItem = GetRawListItem(Index)
'	item.TextItem = True
'End Sub

'
'private Sub InsertAt(Index As Int, pnl As B4XView, Value As Object)
'	Dim size As Float
'	
'	size = pnl.Height
'	
'	InsertAtImpl(Index, pnl, size, Value, 0)
'End Sub

	
Private Sub Insert(newitem As SBItem)
	'create another panel to handle the click event
	Dim p As B4XView = CreatePanel("Panel")

	
	
	p.AddView(newitem.Panel, 0, 0, sv.ScrollViewContentWidth, newitem.Panel.Height)
	
	p.Tag = items.Size
	Dim IncludeDividierHeight As Int
	IncludeDividierHeight = mDividerSize

	If items.Size = items.Size  Then
		items.Add(newitem)
		Dim offset As Int
		If items.Size = 0 Then
			offset = mDividerSize
		Else
			offset = GetScrollViewContentSize
		End If
		newitem.Offset = offset
		
		sv.ScrollViewInnerPanel.AddView(p, 0, offset, sv.Width, newitem.Panel.Height)
	
	Else
		Dim offset As Int
		If items.Size = 0 Then
			offset = mDividerSize
		Else
			Dim PrevItem As SBItem = items.Get(items.Size - 1)
			offset = PrevItem.Offset + PrevItem.Size + mDividerSize
		End If
		For i = items.Size To items.Size - 1
			Dim It As SBItem = items.Get(i)
			Dim NewOffset As Int = It.Offset + newitem.Panel.Height - 0 + IncludeDividierHeight
			If Min(NewOffset, It.Offset) - GetScrollViewOffset < GetScrollViewVisibleSize Then
				It.Offset = NewOffset
				
				It.Panel.SetLayoutAnimated(0, 0, NewOffset, It.Panel.Width, It.Size)
				
			Else
				SetItemOffset(It, NewOffset)
			End If
			It.Panel.Tag = i + 1
		Next
		items.InsertAt(items.Size, newitem)
		newitem.Offset = offset
	
		sv.ScrollViewInnerPanel.AddView(p, 0, offset, sv.Width, 0)
		p.SetLayoutAnimated(0, 0, offset, p.Width, newitem.Panel.Height)
		
	End If
	SetScrollViewContentSize(GetScrollViewContentSize + newitem.Panel.Height + IncludeDividierHeight)
	If items.Size = 1 And items.Size = 0 Then SetScrollViewContentSize(newitem.Panel.Height + mDividerSize * 2)
	If items.Size < mLastVisibleIndex Or GetRawListItem(mLastVisibleIndex).Offset + _
			GetRawListItem(mLastVisibleIndex).Size + mDividerSize < GetScrollViewVisibleSize Then
		UpdateVisibleRange
	End If
End Sub

Private Sub UpdateVisibleRange
	If MonitorVisibleRange = False Or getSize = 0 Then Return
	Dim first As Int = getFirstVisibleIndex
	Dim last As Int = getLastVisibleIndex
	If first <> mFirstVisibleIndex Or last <> mLastVisibleIndex Then
		mFirstVisibleIndex = first
		mLastVisibleIndex = last
		CallSubDelayed3(CallBack, EventName & "_VisibleRangeChanged", mFirstVisibleIndex, mLastVisibleIndex)
	End If
End Sub

Private Sub GetScrollViewVisibleSize As Float

	Return sv.Height

End Sub

Private Sub GetScrollViewOffset As Float
	
	Return sv.ScrollViewOffsetY
	
End Sub

Private Sub SetScrollViewOffset(offset As Float)
	
	sv.ScrollViewOffsetY = offset

End Sub

Private Sub GetScrollViewContentSize As Float
	
	Return sv.ScrollViewContentHeight
	
End Sub

Private Sub SetScrollViewContentSize(f As Float)
	
	sv.ScrollViewContentHeight = f

End Sub

Private Sub SetItemOffset (item As SBItem, offset As Float)
	item.Offset = offset
	item.Panel.Top = offset
End Sub

'Changes the height of an existing item.
'Public Sub ResizeItem(Index As Int, ItemSize As Int)
'	Dim p As B4XView = GetPanel(Index)
'	Dim value As Object = GetValue(Index)
'	Dim parent As B4XView = p.Parent
'	p.Color = parent.Color
'	p.RemoveViewFromParent
'	ReplaceAt(Index, p, ItemSize, value)
'End Sub


'Replaces the item at the specified index with a new item.
'ItemSize - Item's height for vertical orientation and width for horizontal orientation.
'Public Sub ReplaceAt(Index As Int, pnl As B4XView, ItemSize As Int, Value As Object)
'	Dim RemoveItem As SBItem = items.Get(Index)
'	items.RemoveAt(Index)
'	RemoveItem.Panel.RemoveViewFromParent
'	InsertAtImpl(Index, pnl, ItemSize, Value, RemoveItem.Size)
'End Sub



'Adds a custom item.
'Public Sub Add(Pnl As B4XView, Value As Object)
'	InsertAt(items.Size, Pnl, Value)
'End Sub

'Scrolls the list to the specified item (without animating the scroll).
Public Sub JumpToItem(Index As Int)
	SetScrollViewOffset(Min(GetMaxScrollOffset, FindItemOffset(Index)))
End Sub

Private Sub GetMaxScrollOffset As Float
	Return GetScrollViewContentSize - GetScrollViewVisibleSize
End Sub

'Smoothly scrolls the list to the specified item.
Public Sub ScrollToItem(Index As Int)
	Dim offset As Float = Min(GetMaxScrollOffset, FindItemOffset(Index)) 'ignore
	#if B4i
	Dim nsv As ScrollView = sv
	If horizontal Then
		nsv.ScrollTo(offset, 0, True)
	Else
		nsv.ScrollTo(0, offset, True)
	End If
	#else if B4J 
	JumpToItem(Index)
	#Else If B4A
	
	Dim nsv As ScrollView = sv
	nsv.ScrollPosition = offset
	#End If
End Sub

Private Sub FindItemOffset(Index As Int) As Int
	Return GetRawListItem(Index).Offset
End Sub

'Finds the index of the item (+ divider) based on the offset
Public Sub FindIndexFromOffset(Offset As Int) As Int
	If items.Size = 0 Then Return -1
	'the next divider is added to the current item
	Dim Position As Int = items.Size / 2
	Dim StepSize As Int = Ceil(Position / 2)
	Do While True
		Dim CurrentItem As SBItem = items.Get(Position)
		Dim NextOffset As Int
		If Position < items.Size - 1 Then
			NextOffset = GetRawListItem(Position + 1).Offset - 1
		Else
			NextOffset = 0x7FFFFFFF
		End If
		Dim PrevOffset As Int
		If Position = 0 Then
			PrevOffset = 0x80000000
		Else
			PrevOffset = CurrentItem.Offset
		End If
		If Offset > NextOffset Then
			Position = Min(Position + StepSize, items.Size - 1)
		Else if Offset < PrevOffset Then
			Position = Max(Position - StepSize, 0)
		Else
			Return Position
		End If
		StepSize = Ceil(StepSize / 2)
	Loop
	Return -1
End Sub

'Gets the index of the first visible item.
Public Sub getFirstVisibleIndex As Int
	Return FindIndexFromOffset(GetScrollViewOffset + mDividerSize)
End Sub

'Gets the index of the last visible item.
Public Sub getLastVisibleIndex As Int
	Return FindIndexFromOffset(GetScrollViewOffset + GetScrollViewVisibleSize)
End Sub


Private Sub PanelLongClickHandler(SenderPanel As B4XView)
	
	Dim item As SBItem = GetRawListItem(SenderPanel.Tag)
	If item.Clickable Then
		removeSelected
		CreateSelectedPanel(item)
		If xui.SubExists(CallBack, EventName & "_ItemLongClick", 2) Then
		#if B4i
		If FeedbackGenerator.IsInitialized Then
			FeedbackGenerator.RunMethod("impactOccurred", Null)
		End If
		#End If
			CallSub2(CallBack, EventName & "_ItemLongClick", item.Panel.GetView(1).Text)
		End If
	End If
End Sub

Private Sub PanelClickHandler(SenderPanel As B4XView)
	Dim item As SBItem = GetRawListItem(SenderPanel.Tag)
	If item.Clickable Then
		removeSelected
		CreateSelectedPanel(item)
		If xui.SubExists(CallBack, EventName & "_ItemClick", 2) Then
			CallSub2(CallBack, EventName & "_ItemClick", item.Panel.GetView(1).Text)
		End If
	End If
End Sub

'Returns the index of the item that holds the given view.
Public Sub GetItemFromView(v As B4XView) As Int
	Dim parent = v As Object, current As B4XView
	Do While sv.ScrollViewInnerPanel <> parent
		current = parent
		parent = current.Parent
	Loop
	v = current
	Return v.Tag
End Sub

Private Sub ScrollHandler
	If items.Size = 0 Then Return
	Dim position As Int = GetScrollViewOffset
	If position + GetScrollViewVisibleSize >= GetScrollViewContentSize - 5dip And DateTime.Now > LastReachEndEvent + 100 Then
		If xui.SubExists(CallBack, EventName & "_ReachEnd", 0) Then
			LastReachEndEvent = DateTime.Now
			CallSubDelayed(CallBack, EventName & "_ReachEnd")
		Else
			LastReachEndEvent = DateTime.Now + 1000 * DateTime.TicksPerDay 'disable
		End If
	End If
	UpdateVisibleRange
	If FireScrollChanged Then
		CallSub2(CallBack, EventName & "_ScrollChanged", position)
	End If
End Sub

Private Sub CreatePanel (PanelEventName As String) As B4XView
	Return xui.CreatePanel(PanelEventName)
End Sub

Public Sub getDividerSize As Float
	Return mDividerSize
End Sub


'******************************* platform specific ***************************************************
#if B4A or B4i
Private Sub Panel_Click
	PanelClickHandler(Sender)
End Sub

Private Sub Panel_LongClick
	PanelLongClickHandler(Sender)
End Sub
#End If

#If B4A

Private Sub CreateScrollView As B4XView
	Dim nsv As ScrollView
	nsv.Initialize2(0, "sv")
	Return nsv
End Sub

Private Sub sv_ScrollChanged(Position As Int)
	ScrollHandler
End Sub


#else If B4i

Private Sub CreateScrollView As B4XView
	Dim nsv As ScrollView
	nsv.Initialize("sv", 0, 0)
	Return nsv
End Sub



Sub sv_ScrollChanged (OffsetX As Int, OffsetY As Int)
	ScrollHandler
End Sub

Private Sub CreateLabel(txt As Object) As B4XView
	Dim lbl As Label
	lbl.Initialize("")
	lbl.TextAlignment = DesignerLabel.TextAlignment
	lbl.Font = DesignerLabel.Font
	lbl.Multiline = True
	lbl.TextColor = DefaultTextColor
	If txt Is AttributedString Then
		lbl.AttributedText = txt
	Else
		lbl.Text = txt
	End If
	lbl.Width = sv.ScrollViewContentWidth - 10dip
	lbl.SizeToFit
	Return lbl
End Sub

#else If B4J
Private Sub CreateScrollView As B4XView
	Dim nsv As ScrollPane
	nsv.Initialize("sv")
	If horizontal Then
		nsv.SetVScrollVisibility("NEVER")
	Else
		nsv.SetHScrollVisibility("NEVER")
	End If
	Return nsv
End Sub

Private Sub Panel_MouseClicked (EventData As MouseEvent)
	If EventData.SecondaryButtonPressed Then
		PanelLongClickHandler(Sender)
	Else
		PanelClickHandler(Sender)
	End If
	EventData.Consume
End Sub

Private Sub sv_VScrollChanged (Position As Double)
	ScrollHandler
End Sub

Private Sub sv_HScrollChanged (Position As Double)
	ScrollHandler
End Sub


Private Sub CreateLabel(txt As String) As B4XView
	Dim lbl As Label
	lbl.Initialize("")
	lbl.Alignment = DesignerLabel.Alignment
	lbl.Style = DesignerLabel.Style
	lbl.Font = DesignerLabel.Font
	lbl.WrapText = True
	lbl.Text = txt
	Dim jo As JavaObject = Me
	Dim width As Double = sv.ScrollViewContentWidth - 10
	lbl.PrefHeight = 10dip + Round(jo.RunMethod("MeasureMultilineTextHeight", Array(lbl.Font, txt, width)))
	Return lbl
End Sub


#if Java

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import javafx.scene.text.Font;
import javafx.scene.text.TextBoundsType;
public double MeasureMultilineTextHeight(Font f, String text, double width) throws Exception {
		Method m = Class.forName("com.sun.javafx.scene.control.skin.Utils").getDeclaredMethod("computeTextHeight",
				Font.class, String.class, double.class, TextBoundsType.class);
		m.setAccessible(true);
		return (Double)m.invoke(null, f, text, width, TextBoundsType.LOGICAL_VERTICAL_CENTER);
	}
#End If

#End If

Public Sub CreateItem(Icon As Object, Text As String, color As Int)
	
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, AsView.Width, ItemHeight)
	Dim hasBitmap As Boolean
	
	If Icon Is Char  Then
		p.Color=BackgroundColor
		Dim IconLBL As Label
		IconLBL.Initialize("")
		IconLBL.Typeface=mIconTypeface
		IconLBL.Text=Icon
		IconLBL.TextSize=IconSize
		IconLBL.TextColor=ItemTextColor
		IconLBL.Gravity=Gravity.CENTER
		p.AddView(IconLBL,0,0,AsView.Width*0.25,ItemHeight)
	Else
		Dim iv As ImageView
		iv.Initialize("")
		iv.Bitmap=Icon.As(B4XBitmap).Resize(IconSize*1.5,IconSize*1.5,True)
		iv.Gravity=Gravity.CENTER
		p.AddView(iv,0,0,AsView.Width*0.25,ItemHeight)
		hasBitmap=True
	End If
	
	Dim TextLBL As Label
	TextLBL.Initialize("")
	TextLBL.Text=Text
	TextLBL.TextSize=ItemTextSize
	TextLBL.TextColor=ItemTextColor
	TextLBL.Typeface=Typeface.DEFAULT
	TextLBL.Gravity=Bit.Or(Gravity.LEFT,Gravity.CENTER_VERTICAL)
	p.AddView(TextLBL,AsView.Width*0.25,0,AsView.Width*0.75,ItemHeight)
	
	Dim NewItem As SBItem
	NewItem.Panel = p
	NewItem.Size = p.Height
	NewItem.Clickable=True
	NewItem.Color = color
	NewItem.hasBitmap = hasBitmap
	
	Insert(NewItem)
End Sub

Public Sub CreateHeader(Height As Int)
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, AsView.Width, Height)
	Dim sepLabel As Label
	sepLabel.Initialize("")
	sepLabel.Color=BackgroundColor
	p.AddView(sepLabel,0,0,AsView.Width,Height)
	Dim NewItem As SBItem
	NewItem.Panel = p
	NewItem.Size = p.Height
	NewItem.Clickable=False
	NewItem.Color = p.Color
	NewItem.hasBitmap = False
	Insert(NewItem)
	HeaderPanel=p
End Sub

Public Sub getHeader As B4XView
	Return HeaderPanel.GetView(0)
End Sub

Public Sub CreateSeperator
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, AsView.Width, 1dip)
	Dim sepLabel As Label
	sepLabel.Initialize("")
	sepLabel.Color=SeperatorColor
	p.AddView(sepLabel,5dip,0,AsView.Width,1dip)
	
	Dim NewItem As SBItem
	NewItem.Panel = p
	NewItem.Size = p.Height
	NewItem.Clickable=False
	NewItem.Color = p.Color
	NewItem.hasBitmap = False
	Insert(NewItem)
End Sub

Public Sub CreateHeadline(Text As String)
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, AsView.Width, ItemHeight)
	p.Color=BackgroundColor
	Dim TextLBL As Label
	TextLBL.Initialize("")
	TextLBL.Text=Text
	TextLBL.TextSize=HeadlineSize
	TextLBL.TextColor=HeadlineColor
	TextLBL.Typeface=Typeface.DEFAULT_BOLD
	TextLBL.Gravity=Bit.Or(Gravity.LEFT,Gravity.CENTER_VERTICAL)
	p.AddView(TextLBL,10dip,0,AsView.Width,ItemHeight)
	
	Dim NewItem As SBItem
	NewItem.Panel = p
	NewItem.Size = p.Height
	NewItem.Value = Text
	NewItem.Clickable=False
	NewItem.Color = p.Color
	NewItem.hasBitmap = False
	
	Insert(NewItem)
End Sub

Private Sub CreateSelectedPanel(target As SBItem)
	
	If Animated Then
		CreateHaloEffect(target.Panel,-5,target.Panel.Height/2,target.Color)
	Else
		target.Panel.Color=target.Color
	End If

	target.Panel.Color=ShadeColor(target.Color)
	
	If target.hasBitmap= False Then
		target.Panel.GetView(0).TextColor=target.Color
	End If
	
	Dim l2 As Label
	l2.Initialize("")
	l2.Tag="selector"
	l2.Color=target.Color
	target.Panel.AddView(l2,0,0,5dip,ItemHeight)
End Sub


public Sub HighlightItem(index As Int)
	Dim item As SBItem  = items.Get(index)
	If item.Clickable Then
		removeSelected
		CreateSelectedPanel(item)
	Else
		Log("Item cannot be highlighted")
	End If
End Sub

Private Sub removeSelected
	For Each o As SBItem In items
		For Each n As View In o.Panel.GetAllViewsRecursive
			If n.tag <> Null Then
				If n.Tag="selector" Then
					n.RemoveView
					o.Panel.Color=BackgroundColor
					If o.hasBitmap=False Then
						o.Panel.GetView(0).TextColor=ItemTextColor
					End If
					Return
				End If
			End If
		Next
	Next
End Sub

Private Sub ShadeColor(clr As Int) As Int
	Dim argb() As Int = GetARGB(clr)
	Dim factor As Float = 0.7
	Return xui.Color_ARGB(70,argb(1) * factor, argb(2) * factor, argb(3) * factor)
End Sub

Private Sub GetARGB(Color As Int) As Int()
	Private res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

Sub CreateHaloEffect (Parent As B4XView, x As Int, y As Int, clr As Int)
	Dim cvs As B4XCanvas
	Dim p As B4XView = xui.CreatePanel("")
	Dim radius As Int = Parent.Parent.Width
	p.SetLayoutAnimated(0, 0, 0, radius * 2, radius * 2)
	cvs.Initialize(p)
	cvs.DrawCircle(cvs.TargetRect.CenterX, cvs.TargetRect.CenterY, cvs.TargetRect.Width / 2, clr, True, 0)
	Dim bmp As B4XBitmap = cvs.CreateBitmap
	CreateHaloEffectHelper(Parent,bmp, x, y, radius)
End Sub

Sub CreateHaloEffectHelper (Parent As B4XView,bmp As B4XBitmap, x As Int, y As Int, radius As Int)
	Dim iv As ImageView
	iv.Initialize("")
	Dim p As B4XView = iv
	p.SetBitmap(bmp)
	Parent.AddView(p, x, y, 0, 0)
	Dim duration As Int = AnimationSpeed
	p.SetLayoutAnimated(duration, x - radius, y - radius, 2 * radius, 2 * radius)
	p.SetVisibleAnimated(duration, False)
	Sleep(duration)
	p.RemoveViewFromParent
End Sub
