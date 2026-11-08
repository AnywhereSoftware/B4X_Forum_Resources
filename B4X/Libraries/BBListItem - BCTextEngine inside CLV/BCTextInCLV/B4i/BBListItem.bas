B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.95
@EndOfDesignText@
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
	Public Paragraph As BCParagraph
	Private TouchPanel As B4XView
	Public Padding As B4XRect
	Public ParseData As BBCodeParseData
	Public Tag As Object
	Private ImageViewsCache As List
	Private UsedImageViews As B4XOrderedMap
	Public RTL As Boolean
	Private URLToLines As Map
	Public AutoUnderlineURLs As Boolean
	Private UpdateOffsetY, UpdateHeight As Int
	Private UsedImageViews As B4XOrderedMap
	Private StubScrollView As B4XView
	Private RenderIndex As Int
	Public TextIndex As Int
	Private WaitingForDrawing As Boolean
	Public ExternalRuns As List
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	ParseData.Initialize
	ParseData.Views.Initialize
	ParseData.URLs.Initialize
	Padding.Initialize(0, 0, 0, 0)
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
	StubScrollView = sp
	AutoUnderlineURLs = Props.GetDefault("AutoUnderline", True)
	ImageViewsCache.Initialize
	UsedImageViews = B4XCollections.CreateOrderedMap
	Dim xlbl As B4XView = Lbl
	mText = xlbl.Text
	ParseData.DefaultColor = xlbl.TextColor
	ParseData.DefaultFont = xlbl.Font
	ParseData.ViewsPanel = mBase
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
	
End Sub

Public Sub setTextEngine (b As BCTextEngine)
	mTextEngine = b
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

Public Sub UpdateLastVisibleRegion
	UpdateVisibleRegion(UpdateOffsetY, UpdateHeight)
End Sub

Public Sub ParentScrolled(ScrollViewOffset As Int, CLVHeight As Int, OffsetInItem As Int)
	If Paragraph.IsInitialized And mBase.Parent.IsInitialized And mBase.Parent.Parent.IsInitialized Then
		Dim scale As Float = mTextEngine.mScale
		Dim ItemOffset As Int = mBase.Parent.Parent.Top + OffsetInItem
		Dim ItemHeight As Int = mBase.Height
		If ItemOffset > ScrollViewOffset + CLVHeight Or ItemOffset + ItemHeight < ScrollViewOffset Then
			Return
		End If
		Dim FixedItemOffset As Int = Max(0, ScrollViewOffset - ItemOffset)
		ItemHeight = Min(ItemHeight - FixedItemOffset, ScrollViewOffset + CLVHeight - ItemOffset)
		UpdateVisibleRegion(FixedItemOffset * scale, ItemHeight * scale)
	End If
End Sub

'This method should only be called in special cases where you want to update parts of the view.
Public Sub UpdateVisibleRegion (OffsetY As Int, Height As Int)
	UpdateOffsetY = OffsetY
	UpdateHeight = Height
	RenderIndex = RenderIndex + 1
	Dim MyRenderIndex As Int = RenderIndex
	Dim MyTextIndex As Int = TextIndex
	Do While WaitingForDrawing And MyRenderIndex = RenderIndex
		Sleep(10)
	Loop
	If MyRenderIndex <> RenderIndex Then Return
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
			Dim xiv As B4XView = GetImageView
			Dim bc As BitmapCreator = mTextEngine.DrawSingleLineAsync(Line, xiv, Paragraph, Me)
			If bc <> Null Then
				WaitingForDrawing = True
				Wait For BC_BitmapReady (bmp As B4XBitmap)
				WaitingForDrawing = False
				mTextEngine.ReleaseAsyncBC(bc)
				If MyTextIndex <> TextIndex Then
					xiv.RemoveViewFromParent
					xiv.SetBitmap(Null)
					ImageViewsCache.Add(xiv)
					Return
				End If
				If xui.IsB4J Then
					bmp = bc.Bitmap
				End If
				bmp = bmp.Crop(0, 0, bmp.Width, bmp.Height)
				bc.SetBitmapToImageView(bmp, xiv)
			End If
			UsedImageViews.Put(Line, xiv)
		Else
			If foundFirst Then Exit
		End If
	Next
End Sub

Private Sub GetImageView As B4XView
	Dim xiv As B4XView
	If ImageViewsCache.Size = 0 Then
		Dim iv As ImageView
		iv.Initialize("")
		xiv = iv
	Else
		xiv = ImageViewsCache.Get(ImageViewsCache.Size - 1)
		ImageViewsCache.RemoveAt(ImageViewsCache.Size - 1)
	End If
	mBase.AddView(xiv, 0, 0, 0, 0)
	xiv.SendToBack
	Return xiv
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
	TextIndex = TextIndex + 1
	ParseData.NeedToReparseWhenResize = False
	ParseData.Text = mText
	ParseData.URLs.Clear
	ParseData.Width = (mBase.Width - Padding.Left - Padding.Right)
	URLToLines.Clear
	Dim pe As List = mTextEngine.TagParser.Parse(ParseData)
	mBase.RemoveAllViews
	If TouchPanel.IsInitialized Then
		mBase.AddView(TouchPanel, 0, 0, 0, 0)
	End If
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
	CleanExistingImageViews(False, UsedImageViews.Keys, 0, 0)
	UsedImageViews.Clear
	Paragraph = mTextEngine.PrepareForLazyDrawing(Runs, Style, StubScrollView)
	mBase.SetLayoutAnimated(0, mBase.Left, mBase.Top, mBase.Width, Paragraph.Height / mTextEngine.mScale + 5dip)
	If AutoUnderlineURLs And ParseData.URLs.Size > 0 Then
		CollectURLs
		For Each r As BCTextRun In URLToLines.Keys
			r.Underline = False
		Next
	End If
	If TouchPanel.IsInitialized Then
		TouchPanel.SetLayoutAnimated(0, 0, 0, mBase.Width, mBase.Height)
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



	

