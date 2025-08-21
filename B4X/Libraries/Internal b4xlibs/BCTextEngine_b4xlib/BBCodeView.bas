B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.33
@EndOfDesignText@
#DesignerProperty: Key: LazyLoading, DisplayName: Lazy Loading, FieldType: Boolean, DefaultValue: True
#DesignerProperty: Key: AutoUnderline, DisplayName: Auto Underline URLs, FieldType: Boolean, DefaultValue: True, Description: Add an underline to URLs when user presses on a URL.
#Event: LinkClicked (URL As String)
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private Runs As List
	Private xui As XUI
	Public Style As BCParagraphStyle
	Private mTextEngine As BCTextEngine
	Private mText As String
	Public ForegroundImageView As B4XView
	Public BackgroundImageView As B4XView
	Public Paragraph As BCParagraph
	Private TouchPanel As B4XView
	Public sv As B4XView
	Public Padding As B4XRect
	Public ParseData As BBCodeParseData
	Public Tag As Object
	Public LazyLoading As Boolean
	Private ImageViewsCache As List
	Private UsedImageViews As B4XOrderedMap
	Public ExternalRuns As List
	Public DisableAutomaticDrawingsInLazyMode As Boolean
	Type InternalBBViewURL (Lines As List)
	Public RTL As Boolean
	Private URLToLines As Map
	Public AutoUnderlineURLs As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	Dim iv As ImageView
	iv.Initialize("")
	ForegroundImageView = iv
	ParseData.Initialize
	ParseData.Views.Initialize
	ParseData.URLs.Initialize
	If xui.IsB4J Then
		Padding.Initialize(5dip, 5dip, 20dip, 5dip)
	Else
		Padding.Initialize(5dip, 5dip, 5dip, 5dip)
	End If
	ParseData.ImageCache.Initialize
	URLToLines.Initialize
End Sub

Public Sub getViews As Map
	Return ParseData.Views
End Sub

Public Sub setViews (m As Map)
	ParseData.Views = m
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	#if B4J
	Dim sp As ScrollPane
	sp.Initialize("sv")
	sp.SetHScrollVisibility("NEVER")
	#else if B4A
	Dim sp As ScrollView
	sp.Initialize2(50dip, "sv")
	#Else If B4i
	Dim sp As ScrollView
	sp.Initialize("sv", mBase.Width, 50dip)
	sp.Bounces = False
	#End If
	LazyLoading = Props.GetDefault("LazyLoading", True)
	AutoUnderlineURLs = Props.GetDefault("AutoUnderline", True)
	If LazyLoading Then
		ImageViewsCache.Initialize
		UsedImageViews = B4XCollections.CreateOrderedMap
	End If
	sv = sp
	sv.Color = mBase.Color
	sv.ScrollViewInnerPanel.Color = mBase.Color
	mBase.AddView(sv, 0, 0, mBase.Width, mBase.Height)
  	Dim xlbl As B4XView = Lbl
	mText = xlbl.Text
	ParseData.DefaultColor = xlbl.TextColor
	ParseData.DefaultFont = xlbl.Font
	ParseData.ViewsPanel = sv.ScrollViewInnerPanel
	If xui.SubExists(mCallBack, mEventName & "_linkclicked", 1) Then 
		TouchPanel = xui.CreatePanel("TouchPanel")
	End If
	#if B4J
	Dim fx As JFX
	ParseData.DefaultBoldFont = fx.CreateFont(Lbl.Font.FamilyName, ParseData.DefaultFont.Size, True, False)
	
	#Else If B4A
	ParseData.DefaultBoldFont = xui.CreateFont(Typeface.CreateNew(Lbl.Typeface, Typeface.STYLE_BOLD), xlbl.TextSize)
	#else if B4i
	ParseData.DefaultBoldFont = xui.CreateDefaultBoldFont(xlbl.TextSize)
	#End If
End Sub


Public Sub Base_Resize (Width As Double, Height As Double)
	sv.SetLayoutAnimated(0, 0, 0, Width, Height)
	sv.ScrollViewContentWidth = Width
	If DisableAutomaticDrawingsInLazyMode Then Return
	If Runs.IsInitialized Then
		If ParseData.NeedToReparseWhenResize Then
			ParseAndDraw
		Else
			Redraw
		End If
	End If
End Sub

Public Sub setTextEngine (b As BCTextEngine)
	mTextEngine = b
	#if B4J
	mTextEngine.TagParser.InternalSetMouseTransparent(ForegroundImageView)
	#End If
	If mText <> "" Then
		setText(mText)
	End If
End Sub

Public Sub getTextEngine As BCTextEngine
	Return mTextEngine
End Sub

Public Sub setText(t As String)
	mText = t
	ParseAndDraw
End Sub

Public Sub getText As String
	Return mText
End Sub

Private Sub DrawVisibleRegion
	If DisableAutomaticDrawingsInLazyMode Then Return
	UpdateVisibleRegion(sv.ScrollViewOffsetY * mTextEngine.mScale, sv.Height * mTextEngine.mScale)
End Sub

'This method should only be called in special cases where you want to update parts of the view.
Public Sub UpdateVisibleRegion (OffsetY As Int, Height As Int)
	Dim foundFirst As Boolean
	Dim Existing As List
	Existing.Initialize
	Existing.AddAll(UsedImageViews.Keys)
	CleanExistingImageViews(True, Existing, OffsetY, Height)
	For Each Line As BCTextLine In Paragraph.TextLines
		If LineIsVisible (Line, OffsetY, Height) Then
			foundFirst = True
			If UsedImageViews.ContainsKey(Line) Then
				Continue
			End If
			Dim xiv As B4XView
			If ImageViewsCache.Size = 0 Then
				Dim iv As ImageView
				iv.Initialize("")
				xiv = iv
			Else
				xiv = ImageViewsCache.Get(ImageViewsCache.Size - 1)
				ImageViewsCache.RemoveAt(ImageViewsCache.Size - 1)
			End If
			sv.ScrollViewInnerPanel.AddView(xiv, 0, 0, 0, 0)
			xiv.SendToBack
			mTextEngine.DrawSingleLine(Line, xiv, Paragraph)
			UsedImageViews.Put(Line, xiv)
		Else
			If foundFirst Then Exit
		End If
	Next
End Sub

Public Sub ScrollToAnchor(Anchor As String)
	Dim line As BCTextLine = GetAnchorLine(Anchor)
	If line <> Null Then
		Dim top As Int = line.BaselineY - line.MaxHeightAboveBaseLine
		#if B4i
	Dim nsv As ScrollView = sv
		top = Min(top / mTextEngine.mScale, nsv.Panel.Height - nsv.Height)
		
	nsv.ScrollTo(0, top, True)
	#else if B4J 
		sv.ScrollViewOffsetY = top
	#Else If B4A
	Dim nsv As ScrollView = sv
	nsv.ScrollPosition = top 
	#End If
	End If
End Sub

Private Sub GetAnchorLine (Anchor As String) As BCTextLine
	If Paragraph.Anchors.IsInitialized = False Then Return Null
	Return Paragraph.Anchors.Get(Anchor)
End Sub

Private Sub LineIsVisible(line As BCTextLine, offset As Int, height As Int) As Boolean
	Return line.BaselineY + line.MaxHeightBelowBaseLine >= offset And line.BaselineY - line.MaxHeightAboveBaseLine <= offset + height
End Sub

Private Sub CleanExistingImageViews (InvisibleOnly As Boolean, Existing As List, Offset As Int, Height As Int)
	For Each Line As BCTextLine In Existing
		If InvisibleOnly = False Or LineIsVisible(Line, Offset, Height) = False Then
			Dim xiv As B4XView = UsedImageViews.Get(Line)
			xiv.RemoveViewFromParent
			xiv.SetBitmap(Null)
			ImageViewsCache.Add(xiv)
			If InvisibleOnly = True Then UsedImageViews.Remove(Line)
		End If
	Next
End Sub


Public Sub ParseAndDraw
	ParseData.NeedToReparseWhenResize = False
	ParseData.Text = mText
	ParseData.URLs.Clear
	ParseData.Width = (mBase.Width - Padding.Left - Padding.Right)
	If RTL Then mTextEngine.RTLAware = True
	Dim pe As List = mTextEngine.TagParser.Parse(ParseData)
	sv.ScrollViewInnerPanel.RemoveAllViews
	If TouchPanel.IsInitialized Then
		sv.ScrollViewInnerPanel.AddView(TouchPanel, 0, 0, 0, 0)
	End If
	sv.ScrollViewInnerPanel.AddView(ForegroundImageView, 0, 0, 2dip, 2dip)
	If ExternalRuns.IsInitialized And ExternalRuns.Size > 0 Then
		Runs = ExternalRuns
	Else
		Runs = mTextEngine.TagParser.CreateRuns(pe, ParseData)
	End If
	
	Redraw
End Sub

Public Sub Redraw
	Dim Style As BCParagraphStyle = mTextEngine.CreateStyle
	Style.Padding = Padding
	Style.MaxWidth = mBase.Width
	Style.ResizeHeightAutomatically = True
	Style.RTL = RTL
	URLToLines.Clear
	If LazyLoading Then
		CleanExistingImageViews(False, UsedImageViews.Keys, 0, 0)
		UsedImageViews.Clear
		Paragraph = mTextEngine.PrepareForLazyDrawing(Runs, Style, sv)
		ForegroundImageView.SetLayoutAnimated(0, Style.Padding.Left, Style.Padding.Top, sv.ScrollViewContentWidth - Style.Padding.Width, sv.ScrollViewContentHeight - Style.Padding.Height)
		If AutoUnderlineURLs And ParseData.URLs.Size > 0 Then
			CollectURLs
		End If
		DrawVisibleRegion
	Else
		Paragraph = mTextEngine.DrawText(Runs, Style, ForegroundImageView, sv)
	End If
	If TouchPanel.IsInitialized Then
		TouchPanel.SetLayoutAnimated(0, ForegroundImageView.Left, ForegroundImageView.Top, ForegroundImageView.Width, ForegroundImageView.Height)
	End If
End Sub

Private Sub TouchPanel_Touch (Action As Int, X As Float, Y As Float)
	Dim run As BCTextRun = Null
	If URLToLines.Size > 0 Or Action = TouchPanel.TOUCH_ACTION_UP Then
		run = FindTouchedRun(X, Y)
	End If
	If run <> Null And ParseData.URLs.ContainsKey(run) Then
		If Action = TouchPanel.TOUCH_ACTION_UP Then
			Dim url As String = ParseData.Urls.Get(run)
			CallSubDelayed2(mCallBack, mEventName & "_LinkClicked", url)
			MarkURL(Null)
		Else If (xui.IsB4i And Action = 4) Or (xui.IsB4A And Action = 3) Then 'cancelled 
			MarkURL(Null)
		Else
			
			MarkURL(run)
		End If
		Return
	End If
	MarkURL(Null)
End Sub

#if B4J
Private Sub TouchPanel_MouseExited (EventData As MouseEvent)
	If URLToLines.Size > 0 Then
		MarkURL(Null)
	End If
End Sub
#End If

Private Sub FindTouchedRun(x As Float, y As Float) As BCTextRun
	For Each offsetx As Int In Array(0, -5dip, 5dip)
		For Each offsety As Int In Array(0, -3dip, 3dip)
			Dim single As BCSingleStyleSection = mTextEngine.FindSingleStyleSection(Paragraph, X + offsetx, Y + offsety)
			If single <> Null Then
				Return single.Run
			End If
		Next
	Next
	Return Null
End Sub

Private Sub MarkURL (Run As BCTextRun)
#if B4J
	Dim fx As JFX
	Dim n As Node = mBase
	If Run = Null Then
		n.MouseCursor = fx.Cursors.DEFAULT
	Else
		n.MouseCursor = fx.Cursors.HAND
	End If
#End If
	For Each r As BCTextRun In URLToLines.Keys
		If r.Underline <> (r = Run) Then
			r.Underline = r = Run
			Dim extra As InternalBBViewURL = URLToLines.Get(r)
			For Each line As BCTextLine In extra.Lines
				If UsedImageViews.ContainsKey(line) Then
					mTextEngine.DrawSingleLine(line, UsedImageViews.Get(line), Paragraph)
				End If
			Next
		End If
	Next
End Sub

Private Sub CollectURLs
	For Each line As BCTextLine In Paragraph.TextLines
		For Each un As BCUnbreakableText In line.Unbreakables
			For Each st As BCSingleStyleSection In un.SingleStyleSections
				If ParseData.URLs.ContainsKey(st.Run) Then
					Dim extra As InternalBBViewURL
					If URLToLines.ContainsKey(st.Run) = False Then
						extra = CreateBCURLExtraData
						URLToLines.Put(st.Run, extra)
					Else
						extra = URLToLines.Get(st.Run)
					End If
					If extra.Lines.IndexOf(line) = -1 Then
						extra.Lines.Add(line)
					End If
				End If
			Next
		Next
	Next
End Sub

Private Sub CreateBCURLExtraData  As InternalBBViewURL
	Dim t1 As InternalBBViewURL
	t1.Initialize
	t1.Lines.Initialize
	Return t1
End Sub



#if B4J
Private Sub sv_VScrollChanged (Position As Double)
	If LazyLoading Then DrawVisibleRegion
End Sub
#else if B4A
Private Sub sv_ScrollChanged(Position As Int)
	If LazyLoading Then DrawVisibleRegion
End Sub
#else if B4I
Sub sv_ScrollChanged (OffsetX As Int, OffsetY As Int)
	If LazyLoading Then DrawVisibleRegion
End Sub
#end if

	

