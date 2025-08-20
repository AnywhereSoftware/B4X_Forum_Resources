B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.31
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public cvs As B4XCanvas
	Type BCFontMetrics (Glyphs As Map, DefaultColorMetrics As BCFontMetrics, xWidth As Int, _
		Fnt As B4XFont, Clr As Int, KerningTable As Map)
	Type BCTextChars (Buffer() As String, StartIndex As Int, Length As Int)
	'input
	Type BCParagraphStyle (HorizontalAlignment As String, LineSpacingFactor As Float, MaxWidth As Int, Padding As B4XRect, WordWrap As Boolean, _
		ResizeHeightAutomatically As Boolean, RTL As Boolean)
	Type BCTextRun (TextFont As B4XFont, TextColor As Int, Text As String, TextChars As BCTextChars, CharacterSpacingFactor As Float, _
		VerticalOffset As Int, Underline As Boolean, AutoUnderline As Boolean, BackgroundColor As Int, _
		IndentLevel As Int, View As B4XView, HorizontalAlignment As String, Tag As Object, Extra As Map, TextDirection As Int)
	Type BCConnectedRuns (ConnectedWidth As Int, Runs As List, Alignment As String)
	Type BCStyledUnderline (Clr As Int, Style As String, Thickness As Float)
	Public const EXTRA_CONNECTEDRUNS = "ConnectedRuns", EXTRA_STYLEDUNDERLINE = "StyledUnderline" As String
	
	'output
	Type BCParagraph (TextLines As List, CurrentLine As BCTextLine, Style As BCParagraphStyle, _
		TwoLayers As Boolean, Width As Int, Height As Int, _
		Views As List, Anchors As Map)
	Type BCTextLine (StartX As Int, BaselineY As Int, Height As Int, Unbreakables As List, Width As Int, EndsWithSoftLineBreak As Boolean, _
		MaxHeightAboveBaseLine As Int, ParentParagraph As BCParagraph, MaxHeightBelowBaseLine As Int)
	Type BCUnbreakableText (Width As Int, StartX As Int, NotFullTextChars As BCTextChars, _
		IsMergable As Boolean, SingleStyleSections As List, ParentLine As BCTextLine, RTL As Boolean, Anchor As String)
	Type BCSingleStyleSection (AbsoluteStartX As Int, GlyphsAndOffsets As List, Run As BCTextRun, Width As Int, MaxHeightBelowBaseLine As Int, _
		MaxHeightAboveBaseLine As Int, ParentUN As BCUnbreakableText, fm As BCFontMetrics)
	Type BCGlyphAndOffset (Glyph As BCGlyph, SpaceBetweenThisAndNext As Int)
	Type BCGlyph (cbc As CompressedBC, baseline As Int, Width As Int, Emoji As Boolean, Empty As Boolean)
	Private CharBC As BitmapCreator
	Private cbccache As InternalCompressedBCCache
	Public DefaultUnderlineStyle As BCStyledUnderline
	Public mScale As Float = 1
	Private mSpaceBetweenCharacters As Float
	Private mSpaceBetweenLines As Int
	Private FontMetricsCache As Map
	Private ForegroundBC, BackgroundBC As BitmapCreator 'ignore
	Public DefaultColor As Int = xui.Color_Black
	Public WordBoundaries As String = "&*+-/.<>=\' ,:{}" & TAB & CRLF & Chr(13)
	Public WordBoundariesThatCanConnectToPrevWord As String = ".,:"
	Private Brushes As Map
	Public DefaultStyle As BCParagraphStyle
	Public DefaultFont As B4XFont
	Private mMinGapBetweenLines As Int = 5dip
	#if B4A
	Private stubForContext As Panel 'ignore
	#Else If B4J
	Private WritableImage As JavaObject
	Private sp As JavaObject
	#End If
	Private const TabWidthMeasuredInX As Int = 4
	Public TagParser As BBCodeParser
	Private EmptyTextChars As BCTextChars
	Private Emojis As B4XSet
	Public const Charset As String = "UTF-32LE"
	Public LookForComplexCharacters As Boolean = True
	Public CustomFonts As Map
	Public KerningEnabled As Boolean = True
	Private IndentWidth As Int
	Public VowelsCodePoints As B4XSet
	Private AsyncBCs As B4XOrderedMap
	Private AsyncBC As BitmapCreator
	Private AsyncTasks As List
	Private AsyncMode As Boolean
	Private RTLChars As B4XSet
	Public Const TextDirectionLTR = 1, TextDirectionUnknown = 0, TextDirectionRTL = -1 As Int
	Private ArabicMap As Map
	Private ArabicNonLinkedLetters As B4XSet
	Private ArabicCharsConnectedPrev As B4XSet
	Private PMDefaultColor As PremultipliedColor
	Public RTLAware As Boolean
End Sub

'Call this after the layout is created. This way the BBCodeViews and BBLabels will be set properly.
Public Sub Initialize (Parent As B4XView)
	CustomFonts.Initialize
	VowelsCodePoints.Initialize
	EmptyTextChars = CreateBCTextCharsFromString("")
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 2dip, 2dip)
	#if B4i
	mScale = GetDeviceLayoutValues.NonnormalizedScale
	#Else If B4J
	Try
		Dim fx As JFX
		Dim jo As JavaObject = fx.PrimaryScreen
		mScale = Ceil(jo.RunMethod("getOutputScaleX", Null))
	Catch
		mScale = 1
	End Try
	'Log("BCText scale: " & mScale)
	#end if
	setSpaceBetweenCharacters(100dip / 100)
	setSpaceBetweenLines(20dip)
	cvs.Initialize(p)
	ResizeCharBC(50dip * mScale, 50dip * mScale)
	Brushes.Initialize
	ResizeLayers(200dip * mScale, 100dip * mScale)
	cbccache.Initialize
	cbccache.ColorsMap.Initialize
	FontMetricsCache.Initialize
	Dim b(CharBC.SAME_COLOR_LENGTH_FOR_CACHE * 4 * CharBC.MAX_SAME_COLOR_SIZE + 4) As Byte
	cbccache.mBuffer = b
	DefaultFont = xui.CreateDefaultFont(16)
	DefaultStyle = CreateStyle
	TagParser.Initialize (Me)
	DefaultUnderlineStyle.Initialize
	DefaultUnderlineStyle.Clr = 0
	DefaultUnderlineStyle.Style = "line"
	DefaultUnderlineStyle.Thickness = 1dip
	For Each v As B4XView In Parent.GetAllViewsRecursive
		If v.Tag Is BBCodeView Or v.Tag Is BBLabel Then
			CallSub2(v.Tag, "setTextEngine", Me)
		End If
	Next
	
End Sub

Private Sub ResizeLayers (Width As Int, Height As Int)
	Width = Max(Width, 2 * mScale)
	Height = Max(Height, 2 * mScale)
	If ForegroundBC.IsInitialized = False Or Width > ForegroundBC.mWidth Or Height > ForegroundBC.mHeight Then
		If ForegroundBC.IsInitialized Then
			Width = Max(Width, ForegroundBC.mWidth)
			Height = Max(Height, ForegroundBC.mHeight)
		End If
		#if BCTEXT_DEBUG
		Log("(BCTextEngine) Resize layers: " & Width & " x " & Height)
		#end if
		Brushes.Clear
		ForegroundBC.Initialize(Width, Height)
	Else
		ForegroundBC.DrawRect2(ForegroundBC.TargetRect, GetBrush(xui.Color_Transparent), True, 0)
	End If
End Sub

Public Sub CreateStyle As BCParagraphStyle
	Dim s As BCParagraphStyle
	s.Initialize
	s.LineSpacingFactor = 1
	s.HorizontalAlignment = "Left"
	s.MaxWidth = 300dip
	s.Padding.Initialize(5dip, 5dip, 5dip, 5dip)
	s.WordWrap = True
	Return s
End Sub

Public Sub CreateRun (Text As String) As BCTextRun
	Dim r As BCTextRun
	r.Initialize
	r.BackgroundColor = 0
	r.CharacterSpacingFactor = 1
	r.TextFont = DefaultFont
	r.TextChars = CreateBCTextCharsFromString(Text)
	r.Text = Text
	r.TextColor = DefaultColor
	Return r
End Sub

Public Sub CreateConnectedParent As BCTextRun
	Dim connected As BCConnectedRuns
	connected.Initialize
	connected.Runs.Initialize
	Dim parent As BCTextRun = CreateRun("")
	parent.Extra.Initialize
	parent.Extra.Put(EXTRA_CONNECTEDRUNS, connected)
	Return parent
End Sub

Private Sub Prepare (Runs As List, Style As BCParagraphStyle) As BCParagraph
	Dim par As BCParagraph
	par.Initialize
	par.TextLines.Initialize
	par.Style = Style
	IndentWidth = GetFontMetrics(DefaultFont, DefaultColor).xWidth * TabWidthMeasuredInX
	Dim unbreakeables As List
	unbreakeables.Initialize
	For Each run As BCTextRun In Runs
		If run.Extra.IsInitialized And run.Extra.ContainsKey(EXTRA_CONNECTEDRUNS) Then
			HandleConnectedTextRuns(run, unbreakeables, Style)
		Else
			HandleTextRun(run, unbreakeables, Style)
		End If
	Next
	CreateLine(par)
	OrganizeUnbreakables(par, unbreakeables)
	OrganizeLines(par)
	OrganizeSingleStyles(par)
	If par.Style.RTL Then OrganizeRTLParagraph(par)
	Return par
End Sub

Public Sub PrepareForLazyDrawing (Runs As List, Style As BCParagraphStyle, sv As B4XView) As BCParagraph
	Dim par As BCParagraph = Prepare(Runs, Style)
	sv.ScrollViewContentHeight = Max(sv.Height - 2dip, par.Style.Padding.Top + par.Style.Padding.Bottom + par.Height / mScale)
	Dim MaxHeight As Int
	For Each line As BCTextLine In par.TextLines
		MaxHeight = Max(MaxHeight, line.MaxHeightAboveBaseLine + line.MaxHeightBelowBaseLine)
	Next
	ResizeLayers(par.Width, MaxHeight)
	AddParagraphViews(par)
	Return par
End Sub

Public Sub DrawText (Runs As List, Style As BCParagraphStyle, ForegroundImageView As B4XView, sv As B4XView) As BCParagraph
	'layout
	Dim par As BCParagraph = Prepare(Runs, Style)
	'draw
	ResizeLayers(par.Width, par.Height)
	DrawParagraph(par)
	If par.Width > 0 And par.Height > 0 Then
		ResizeImageView(ForegroundBC, par, ForegroundImageView, par.Style.ResizeHeightAutomatically)
	End If
	If par.Style.ResizeHeightAutomatically And sv.IsInitialized Then
		sv.ScrollViewContentHeight = Max(sv.Height - 2dip, ForegroundImageView.Height + par.Style.Padding.Top + par.Style.Padding.Bottom)
	End If
	AddParagraphViews(par)
	Return par
End Sub

Public Sub AddParagraphViews (par As BCParagraph)
	If par.Views.IsInitialized Then
		For Each v As B4XView In par.Views
			v.SetLayoutAnimated(0, par.Style.Padding.Left + v.Left, par.Style.Padding.Top + v.Top, v.Width, v.Height)
		Next
	End If
End Sub

Private Sub ResizeImageView (bc As BitmapCreator, par As BCParagraph, iv As B4XView, ResizeHeight As Boolean)
	Dim bmp As B4XBitmap = bc.Bitmap
	Dim ivHeight As Int = Ceil(par.Height / mScale)
	If ResizeHeight = False Then ivHeight = Min(ivHeight, iv.Parent.Height - par.Style.Padding.Top - par.Style.Padding.Bottom)
	iv.SetLayoutAnimated(0, par.Style.Padding.Left, par.Style.Padding.Top, Ceil(par.Width / mScale), ivHeight)
	bc.SetBitmapToImageView(bmp.Crop(0, 0, iv.Width * mScale, iv.Height * mScale), iv)
End Sub


Private Sub OrganizeLines (p As BCParagraph)
	Dim ParAlignment As String = p.Style.HorizontalAlignment.ToLowerCase
	Dim count As Int
	Dim PrevLineBelowBaselineHeight As Int
	For Each line As BCTextLine In p.TextLines
		p.Width = Max(p.Width, line.Width)
		For Each un As BCUnbreakableText In line.Unbreakables
			For Each single As BCSingleStyleSection In un.SingleStyleSections
				line.MaxHeightAboveBaseLine = Max(single.MaxHeightAboveBaseLine, line.MaxHeightAboveBaseLine)
				line.MaxHeightBelowBaseLine = Max(single.MaxHeightBelowBaseLine, line.MaxHeightBelowBaseLine)
			Next
		Next
		If count = 0 Then
			line.Height = line.MaxHeightAboveBaseLine
		Else
			line.Height =  Max(line.MaxHeightAboveBaseLine + PrevLineBelowBaselineHeight + mMinGapBetweenLines * mScale, mSpaceBetweenLines * p.Style.LineSpacingFactor)
		End If
		p.Height = p.Height + line.Height
		line.BaselineY = p.Height
		PrevLineBelowBaselineHeight = line.MaxHeightBelowBaseLine
		count = count + 1
	Next
	Dim MaxWidth As Int = (p.Style.MaxWidth - p.Style.Padding.Left - p.Style.Padding.Right) * mScale
	p.Width = Min(MaxWidth, p.Width)
	p.Height = p.Height + line.MaxHeightBelowBaseLine
	Dim alignment As String
	For Each line As BCTextLine In p.TextLines
		If line.Unbreakables.Size = 0 Then Continue
		Dim linestyle As BCSingleStyleSection = GetFirstSingleStyle(line)
		If linestyle.Run.HorizontalAlignment = "" Then alignment = ParAlignment Else alignment = linestyle.Run.HorizontalAlignment.ToLowerCase
		If alignment = "left" Then 
			If linestyle.Run.IndentLevel > 0 Then
				line.StartX = IndentWidth * linestyle.Run.IndentLevel
				p.Width = Max(p.Width, Min(MaxWidth, line.Width + line.StartX))
			End If
		Else
			p.Width = MaxWidth
		End If
		Select alignment
			Case "center"
				line.StartX = p.Width / 2 - line.Width / 2
			Case "right"
				line.StartX = p.Width - line.Width
			Case "justify"
				If line.EndsWithSoftLineBreak Then
					Dim last As BCUnbreakableText = line.Unbreakables.Get(line.Unbreakables.Size - 1)
					If IsSpace(last.NotFullTextChars) Then
						line.Unbreakables.RemoveAt(line.Unbreakables.Size - 1)
						line.Width = line.Width - last.Width
					End If
					Dim NumberOfGaps As Int = line.Unbreakables.Size - 1
					If NumberOfGaps > 0 Then
						Dim delta As Float = (p.Width - line.Width) / NumberOfGaps
						Dim accumalated As Float = 0
						For Each un As BCUnbreakableText In line.Unbreakables
							un.StartX = un.StartX + accumalated
							accumalated = accumalated + delta
						Next
					End If
				End If
		End Select
	Next
End Sub

Private Sub OrganizeRTLParagraph (par As BCParagraph)
	Dim LTRList As List
	LTRList.Initialize
	
	For Each line As BCTextLine In par.TextLines
		Dim NewList As List
		NewList.Initialize
'		For Each un As BCUnbreakableText In line.Unbreakables
'			PrintTextChars(un.NotFullTextChars)
'		Next
		For Each un As BCUnbreakableText In line.Unbreakables
			If un.RTL Then
				AddLTRItems(LTRList, NewList)
				NewList.Add(un)
			Else
				LTRList.InsertAt(0, un)
			End If
		Next
		AddLTRItems(LTRList, NewList)
		line.Unbreakables = NewList
'		Log("after")
'		For Each un As BCUnbreakableText In line.Unbreakables
'			PrintTextChars(un.NotFullTextChars)
'		Next
		For Each un As BCUnbreakableText In line.Unbreakables
			un.StartX = line.Width - un.StartX
			Dim x As Int = line.StartX + un.StartX
			For Each single As BCSingleStyleSection In un.SingleStyleSections
				x = x - single.Width
				single.AbsoluteStartX = x
				x = x - mSpaceBetweenCharacters
				If single.Run.View.IsInitialized Then
					Dim v As B4XView = single.Run.View
					v.Left = (x + mSpaceBetweenCharacters) / mScale
				End If
			Next
		Next
	Next
End Sub

Private Sub AddLTRItems (LTRList As List, NewList As List)
	If LTRList.Size = 0 Then Return
	NewList.AddAll(LTRList)
	If LTRList.Size > 1 Then
		Dim StartIndex As Int = 1
		If IsUNSeparator(LTRList.Get(0)) Then
			StartIndex = 2
		End If
		Dim LastIndex As Int = LTRList.Size - 1
		If LastIndex > StartIndex Then
			If IsUNSeparator(LTRList.Get(LastIndex)) Then
				LastIndex = LastIndex - 1
			End If
		End If
		If LastIndex > StartIndex Then
			Dim lastun As BCUnbreakableText = LTRList.Get(LastIndex)
			Dim prev As BCUnbreakableText = LTRList.Get(StartIndex - 1)
			prev.StartX = lastun.StartX
			For i = StartIndex To LastIndex
				Dim un As BCUnbreakableText = LTRList.Get(i)
				un.StartX = prev.StartX + prev.Width + mSpaceBetweenCharacters
				prev = un
			Next
		End If
	End If
	LTRList.Clear
End Sub

Private Sub IsUNSeparator (un As BCUnbreakableText) As Boolean
	If un.NotFullTextChars.Length = 0 Then Return False
	Return WordBoundaries.Contains(un.NotFullTextChars.Buffer(un.NotFullTextChars.StartIndex))
End Sub

Private Sub OrganizeSingleStyles (p As BCParagraph)
	For Each line As BCTextLine In p.TextLines
		For Each un As BCUnbreakableText In line.Unbreakables
			Dim x As Int = line.StartX + un.StartX
			For Each single As BCSingleStyleSection In un.SingleStyleSections
				single.AbsoluteStartX = x
				If single.GlyphsAndOffsets.Size = 0 And single.Run.View.IsInitialized Then
					Dim v As B4XView = single.Run.View
					Dim par As BCParagraph = single.ParentUN.ParentLine.ParentParagraph
					If par.Views.IsInitialized = False Then par.Views.Initialize
					v.Left = (x + mSpaceBetweenCharacters) / mScale
					v.Top = line.BaselineY / mScale - v.Height + single.Run.VerticalOffset
					par.Views.Add(v)
				End If
				x = x + single.Width + mSpaceBetweenCharacters
			Next
		Next
	Next
End Sub

Private Sub GetFirstSingleStyle (Line As BCTextLine) As BCSingleStyleSection
	Dim FirstUN As BCUnbreakableText = Line.Unbreakables.Get(0)
	Return FirstUN.SingleStyleSections.Get(0)
End Sub

Private Sub CreateLine(p As BCParagraph)
	Dim line As BCTextLine
	line.Initialize
	line.Unbreakables.Initialize
	line.ParentParagraph = p
	p.TextLines.Add(line)
	p.CurrentLine = line
End Sub

Private Sub HandleConnectedTextRuns (Run As BCTextRun, Unbreakables As List, Style As BCParagraphStyle)
	Dim children As List
	children.Initialize
	Dim cr As BCConnectedRuns = Run.EXTRA.Get(EXTRA_CONNECTEDRUNS)
	For Each r As BCTextRun In cr.Runs
		HandleTextRun(r, children, Style)
	Next
	Dim width As Int
	For Each un As BCUnbreakableText In children
		un.IsMergable = True
		width = width + un.Width
	Next
	Dim fm As BCFontMetrics = GetFontMetrics(Run.TextFont, Run.TextColor)
	Dim ConnectedWidth As Int = cr.ConnectedWidth * mScale
	
	Dim u As BCUnbreakableText = children.Get(0)
	For i = 1 To children.Size - 1
		MergeUnbreakables(u, children.Get(i))
	Next
	If width < ConnectedWidth Then
		Dim leftOffset As Int
		Select cr.Alignment.ToLowerCase
			Case "center"
				leftOffset = (ConnectedWidth - u.Width) / 2
			Case "right"
				leftOffset = ConnectedWidth - u.Width - mSpaceBetweenCharacters
		End Select
		u.Width = ConnectedWidth
		If leftOffset > 0 Then
			Dim single As BCSingleStyleSection = CreateSingleSection(Run, EmptyTextChars, fm)
			single.Width = leftOffset
			u.SingleStyleSections.InsertAt(0, single)
		End If
	End If
	u.IsMergable = False
	Unbreakables.Add(u)
End Sub

Private Sub HandleTextRun (Run As BCTextRun, Unbreakables As List, style As BCParagraphStyle)
	Dim fm As BCFontMetrics = GetFontMetrics(Run.TextFont, Run.TextColor)
	Dim i1 As Int
	For i = 0 To Run.TextChars.Length - 1
		Dim c As String = Run.TextChars.Buffer(Run.TextChars.StartIndex + i)
		If WordBoundaries.Contains(c) Then
			Dim SeparatorGoesTogetherWithText As Boolean
			If i >= i1 + 1 Then
				Dim offset As Int
				If WordBoundariesThatCanConnectToPrevWord.IndexOf(c) > -1 Then
					offset = 1
					SeparatorGoesTogetherWithText = True
				End If
				Unbreakables.Add(CreateUnbreakable(Run, TextCharsSubstring(Run.TextChars, i1, i + offset), fm, True, style))
			End If
			If SeparatorGoesTogetherWithText = False Then
				Unbreakables.Add(CreateUnbreakable(Run, TextCharsSubstring(Run.TextChars,i, i + 1), fm, True, style))
			Else
				Unbreakables.Add(CreateUnbreakable(Run, EmptyTextChars, fm, True, style))
			End If
			i1 = i + 1
		Else If c = Chr(13) Then
			Continue
		End If
	Next
	If i1 < Run.TextChars.Length Then Unbreakables.Add(CreateUnbreakable(Run, TextCharsSubstring(Run.TextChars, i1, Run.TextChars.Length), fm, False, style))
	If Run.View.IsInitialized Then
		Unbreakables.Add(CreateUnbreakable(Run, EmptyTextChars, fm, False, style))
	End If
End Sub

Private Sub CreateUnbreakable (Run As BCTextRun, TextChars As BCTextChars, FontMetrics As BCFontMetrics, IsSeparator As Boolean, style As BCParagraphStyle) As BCUnbreakableText
	Dim unbreakable As BCUnbreakableText
	unbreakable.Initialize
	unbreakable.SingleStyleSections.Initialize
	unbreakable.IsMergable = Not(IsSeparator) And Not(Run.View.IsInitialized)
	Dim single As BCSingleStyleSection = CreateSingleSection(Run, TextChars, FontMetrics)
	single.ParentUN = unbreakable
	unbreakable.SingleStyleSections.Add(single)
	unbreakable.Width = single.Width
	unbreakable.NotFullTextChars = TextChars
	If style.RTL Then
		unbreakable.RTL = Run.TextDirection = TextDirectionRTL Or (Run.TextDirection = TextDirectionUnknown And DetectRTL(unbreakable) = True)
	End If
	unbreakable.Anchor = GetRunAnchorIfCurrentNotSet(Run, "")
	Return unbreakable
End Sub

Private Sub DetectRTL (un As BCUnbreakableText) As Boolean
	If un.NotFullTextChars.Length = 0 Then 
		Return True
	End If
	If RTLChars.IsInitialized = False Then 
		LoadData(RTLChars, "rtl-data.txt")
	End If
	Dim firstChar As String = un.NotFullTextChars.Buffer(un.NotFullTextChars.StartIndex)
	Dim cp As Int = BytesToInt(firstChar.GetBytes(Charset), 0)
	Return RTLChars.Contains(cp)
End Sub

Private Sub OrganizeUnbreakables (p As BCParagraph, unbreakables As List)
	If unbreakables.Size = 0 Then Return
	Dim un As BCUnbreakableText = unbreakables.Get(0)
	Dim i As Int = 1
	Do While i < unbreakables.Size
		Dim NextUn As BCUnbreakableText = unbreakables.Get(i)
		If un.IsMergable = True And NextUn.IsMergable = True And un.RTL = NextUn.RTL Then
			MergeUnbreakables(un, NextUn)
			unbreakables.RemoveAt(i)
			i = i - 1
		Else
			un = NextUn
		End If
		i = i + 1
	Loop
	For Each un As BCUnbreakableText In unbreakables
		If TextCharEquals(un.NotFullTextChars, Chr(13)) Then Continue
		If TextCharEquals(un.NotFullTextChars, Chr(10)) Then
			CreateLine(p)
			Continue
		End If
		If p.CurrentLine.Unbreakables.Size > 0 And p.Style.WordWrap Then
			Dim SingleStyle As BCSingleStyleSection = un.SingleStyleSections.Get(0)
			Dim indent As Int = IndentWidth * SingleStyle.Run.IndentLevel
			If p.CurrentLine.Width + mSpaceBetweenCharacters + un.Width + indent > (p.Style.MaxWidth - p.Style.Padding.Left - p.Style.Padding.Right) * mScale Then
				p.CurrentLine.EndsWithSoftLineBreak = True
				CreateLine(p)
			End If
		End If
		p.CurrentLine.Unbreakables.Add(un)
		un.ParentLine = p.CurrentLine
		If un.Anchor <> "" Then 
			If p.Anchors.IsInitialized = False Then p.Anchors.Initialize
			p.Anchors.Put(un.Anchor, p.CurrentLine)
		End If
		If IsSpace(un.NotFullTextChars) And p.CurrentLine.Unbreakables.Size = 1 Then
			un.Width = 0
		End If
		If p.CurrentLine.Unbreakables.Size > 0 Then p.CurrentLine.Width = p.CurrentLine.Width + mSpaceBetweenCharacters
		un.StartX = p.CurrentLine.Width
		p.CurrentLine.Width = p.CurrentLine.Width + un.Width
	Next
End Sub

Private Sub MergeUnbreakables (un1 As BCUnbreakableText, un2 As BCUnbreakableText)
	un1.Width = un1.Width + un2.Width + mSpaceBetweenCharacters
	For Each single As BCSingleStyleSection In un2.SingleStyleSections
		single.ParentUN = un1
		un1.Anchor = GetRunAnchorIfCurrentNotSet(single.Run, un1.Anchor)
	Next
	un1.SingleStyleSections.AddAll(un2.SingleStyleSections)
	If un1.NotFullTextChars.Length = 0 Then un1.NotFullTextChars = un2.NotFullTextChars
End Sub

Private Sub GetRunAnchorIfCurrentNotSet(TextRun As BCTextRun, Current As String) As String
	If Current <> "" Then Return Current
	If TextRun.Extra.IsInitialized = False Then Return ""
	Return TextRun.Extra.GetDefault("a", "")
End Sub



Private Sub CreateSingleSection (Run As BCTextRun, TextChars As BCTextChars, FontMetrics As BCFontMetrics) As BCSingleStyleSection
	Dim single As BCSingleStyleSection
	single.Initialize
	single.GlyphsAndOffsets.Initialize
	single.Run = Run
	single.fm = FontMetrics
	Dim PrevChar As String
	Dim PrevGO As BCGlyphAndOffset
	For i = 0 To TextChars.Length - 1
		Dim s As String = TextChars.Buffer(i + TextChars.StartIndex)
		Dim go As BCGlyphAndOffset
		Dim g As BCGlyph = CreateGlyph(s, FontMetrics, False)
		If i > 0 Then
			If KerningEnabled Then
				PrevGO.SpaceBetweenThisAndNext = GetKernSpaceBetweenChars (FontMetrics, PrevChar, s, PrevGO.Glyph, g)
			Else
				PrevGO.SpaceBetweenThisAndNext = mSpaceBetweenCharacters
			End If
		End If
		go.Glyph = g		
		single.GlyphsAndOffsets.Add(go)
		If g.cbc.IsInitialized Then
			single.MaxHeightAboveBaseLine = Max(single.MaxHeightAboveBaseLine, g.baseline - Run.VerticalOffset * mScale)
			single.MaxHeightBelowBaseLine = Max(single.MaxHeightBelowBaseLine, g.cbc.mHeight - g.baseline + Run.VerticalOffset * mScale)
		End If
		single.Width = single.Width + g.Width
		If i > 0 Then single.Width = single.Width + PrevGO.SpaceBetweenThisAndNext * Run.CharacterSpacingFactor
		If Run.Underline Or Run.AutoUnderline Then 
			Dim u As BCStyledUnderline = GetUnderlineStyle(Run)
			single.MaxHeightBelowBaseLine = Max((u.Thickness + 2) * mScale + Run.VerticalOffset * mScale, single.MaxHeightBelowBaseLine)
		End If
		PrevGO = go
		PrevChar = s
	Next
	If i > 0 Then single.Width = single.Width + PrevGO.SpaceBetweenThisAndNext * Run.CharacterSpacingFactor
	If TextChars.Length = 0 And Run.View.IsInitialized Then
		Run.View.Left = 0
		Run.View.Top = 0
		single.Width = Run.View.Width * mScale + mSpaceBetweenCharacters * 2 'extra spaces
		single.MaxHeightAboveBaseLine = (Run.View.Height - Run.VerticalOffset) * mScale
		single.MaxHeightBelowBaseLine = Run.View.Height * mScale - single.MaxHeightAboveBaseLine
	End If
	
	Return single
End Sub

Private Sub GetKernSpaceBetweenChars (fm As BCFontMetrics, PrevChar As String, ThisChar As String, PrevGlyph As BCGlyph, ThisGlyph As BCGlyph) As Int
	Dim together As String = PrevChar & ThisChar
	Dim Space As Int = fm.KerningTable.GetDefault(together, -1000)
	If Space > -1000 Then Return Space
	Dim res As Int
	If ThisGlyph.Empty Or PrevGlyph.Empty Then
		res = mSpaceBetweenCharacters
	Else
		Dim w As Int = CreateGlyph(together, fm, True).Width
		res = w - PrevGlyph.Width - ThisGlyph.Width
	End If
	fm.KerningTable.Put(together, res)
	Return res
End Sub

Private Sub DrawParagraph (Paragraph As BCParagraph)
	For Each line As BCTextLine In Paragraph.TextLines
		DrawLine(line, line.BaselineY)
	Next
End Sub

Public Sub DrawSingleLine (line As BCTextLine, iv As B4XView, par As BCParagraph) 
	Dim r As B4XRect = DrawSingleLineShared(line, iv, par)
	If r.Width > 0 And r.Height > 0 Then
		ForegroundBC.DrawRect2(r, GetBrush(xui.Color_Transparent), True, 0)
		DrawLine(line, line.MaxHeightAboveBaseLine)
		ForegroundBC.SetBitmapToImageView(ForegroundBC.Bitmap.Crop(0, 0, r.Width, r.Height), iv)
	End If
End Sub

Private Sub DrawSingleLineShared (line As BCTextLine, iv As B4XView, par As BCParagraph) As B4XRect
	Dim r As B4XRect
	r.Initialize(0, 0, ForegroundBC.mWidth, line.MaxHeightAboveBaseLine + line.MaxHeightBelowBaseLine)
	iv.SetLayoutAnimated(0,  par.Style.Padding.Left, par.Style.Padding.Top + (line.BaselineY - line.MaxHeightAboveBaseLine) / mScale, _
		Ceil(r.Width / mScale), Ceil(r.Height / mScale))
	Return r
End Sub

Public Sub DrawSingleLineAsync (line As BCTextLine, iv As B4XView, par As BCParagraph, Target As Object) As BitmapCreator
	Dim r As B4XRect = DrawSingleLineShared(line, iv, par)
	If r.Width > 0 And r.Height > 0 Then
		AsyncMode = True
		If AsyncBCs.IsInitialized = False Then AsyncBCs.Initialize
		Dim AsyncTasks As List
		AsyncTasks.Initialize
		AsyncBC = FindAsyncBC (r.Width, r.Height)
		AsyncTasks.Add(AsyncBC.AsyncDrawRect(r, GetBrush(xui.Color_Transparent), True, 0))
		DrawLine(line, line.MaxHeightAboveBaseLine)
		AsyncBC.DrawBitmapCreatorsAsync(Target, "BC", AsyncTasks)
		AsyncMode = False
		Return AsyncBC
	End If
	Return Null
End Sub

Private Sub FindAsyncBC (Width As Int, Height As Int) As BitmapCreator
	For Each bc As BitmapCreator In AsyncBCs.Keys
		If bc.mWidth = Width And bc.mHeight = Height Then
			Dim Used As Boolean = AsyncBCs.Get(bc)
			If Used = False Then
				AsyncBCs.Put(bc, True)
				Return bc
			End If
		End If
	Next
	Dim bc As BitmapCreator
	bc.Initialize(Width, Height)
	AsyncBCs.Put(bc, True)
	Dim i As Int
	For Each b As Boolean In AsyncBCs.Values
		If b Then i = i + 1
	Next
	Return bc
End Sub

Public Sub ReleaseAsyncBC(bc As BitmapCreator)
	AsyncBCs.Put(bc, False)
End Sub



Private Sub DrawLine(line As BCTextLine, OffsetY As Int)
	For Each un As BCUnbreakableText In line.Unbreakables
		DrawUnbreakable(un, OffsetY)
	Next
End Sub

Private Sub DrawUnbreakable (un As BCUnbreakableText, OffsetY As Int)
	For Each single As BCSingleStyleSection In un.SingleStyleSections
		DrawSingleStyleSection(single, OffsetY)
	Next
End Sub

Private Sub DrawSingleStyleSection (single As BCSingleStyleSection, OffsetY As Int)
	Dim OffsetX As Int = single.AbsoluteStartX
	Dim rtl As Boolean = single.ParentUN.RTL
	If rtl Then OffsetX = single.AbsoluteStartX + single.Width
	For Each go As BCGlyphAndOffset In single.GlyphsAndOffsets
		Dim g As BCGlyph = go.Glyph
		#if B4A and DEBUG
		If g = Null Then Continue
		#End If
		Dim x As Int = OffsetX
		If rtl Then x = x - g.cbc.mWidth
		If g.cbc.IsInitialized Then
			If AsyncMode Then
				Dim dt As DrawTask = AsyncBC.CreateDrawTask(g.cbc, g.cbc.TargetRect, x, OffsetY - g.baseline + single.Run.VerticalOffset * mScale, True)
				dt.IsCompressedSource = True
				AsyncTasks.Add(dt)
			Else
				ForegroundBC.DrawCompressedBitmap(g.cbc, g.cbc.TargetRect, x, OffsetY - g.baseline + single.Run.VerticalOffset * mScale)
			End If
		End If
		If single.Run.Underline Then
			Dim u As BCStyledUnderline = GetUnderlineStyle(single.Run)
			Dim clr As Int = u.Clr
			If clr = 0 Then clr = single.Run.TextColor
			Dim r As B4XRect
			r.Initialize(x, single.Run.VerticalOffset * mScale + OffsetY + mScale, x + g.Width + mSpaceBetweenCharacters + go.SpaceBetweenThisAndNext * single.Run.CharacterSpacingFactor,  _
				OffsetY + mScale + u.Thickness * mScale + single.Run.VerticalOffset * mScale)
			If AsyncMode Then
				AsyncTasks.Add(AsyncBC.AsyncDrawRect(r, GetBrush(clr), True, 0))
			Else
				ForegroundBC.DrawRect2(r, GetBrush(clr), True, 0)
			End If
		End If
		If rtl Then
			OffsetX = OffsetX - g.Width - go.SpaceBetweenThisAndNext * single.Run.CharacterSpacingFactor
		Else
			OffsetX = OffsetX + g.Width + go.SpaceBetweenThisAndNext * single.Run.CharacterSpacingFactor
		End If
	Next
End Sub

Private Sub GetUnderlineStyle(run As BCTextRun) As BCStyledUnderline
	If run.Extra.IsInitialized = False Then Return DefaultUnderlineStyle
	Return run.Extra.GetDefault(EXTRA_STYLEDUNDERLINE, DefaultUnderlineStyle)
End Sub

Private Sub ResizeCharBC(width As Int, height As Int)
	Dim ScaledWidth As Int = (width + 5) / mScale
	Dim ScaledHeight As Int = (height + 5) / mScale
	CharBC.Initialize(ScaledWidth * mScale, ScaledHeight * mScale)
	CharBC.MAX_SAME_COLOR_SIZE = 0
	CharBC.AlphaThresholdForCBCExtraction = 0
	cvs.Resize(ScaledWidth, ScaledHeight)
	#if b4J
	Dim w As Int = mScale * cvs.TargetRect.Width
	Dim h As Int = mScale * cvs.TargetRect.Height
	WritableImage.InitializeNewInstance("javafx.scene.image.WritableImage", Array(w, h))
	Dim sp As JavaObject
	sp.InitializeNewInstance("javafx.scene.SnapshotParameters", Null)
	Dim fx As JFX
	sp.RunMethod("setFill", Array(fx.Colors.Transparent))
	Dim transform As JavaObject
	transform.InitializeStatic("javafx.scene.transform.Transform")
	Dim scale As Double = mScale
	sp.RunMethod("setTransform", Array(transform.RunMethod("scale", Array(scale, scale))))
	#End If
End Sub

Public Sub FindSingleStyleSection (Paragraph As BCParagraph, X As Int, Y As Int) As BCSingleStyleSection
	x = x * mScale
	y = y * mScale
	For Each line As BCTextLine In Paragraph.TextLines
		
		If line.BaseLineY - line.MaxHeightAboveBaseLine <= y And line.BaseLineY + line.MaxHeightBelowBaseLine >= y Then
			For Each un As BCUnbreakableText In line.Unbreakables
				If (Paragraph.Style.RTL = False And line.StartX + un.StartX <= x And line.StartX + un.StartX + un.Width >= x) Or _
					(Paragraph.Style.RTL And line.BaseLineY - line.MaxHeightAboveBaseLine <= y And line.BaseLineY + line.MaxHeightBelowBaseLine >= y) Then
					For Each s As BCSingleStyleSection In un.SingleStyleSections
						If s.AbsoluteStartX <= x And s.AbsoluteStartX + s.Width >= x Then Return s
					Next
				End If
			Next
		End If
	Next
	Return Null
End Sub

Private Sub IsSpace(TC As BCTextChars) As Boolean
	Return TextCharEquals(TC, " ")
End Sub

Private Sub GetBrush(clr As Int) As BCBrush
	If Brushes.ContainsKey(clr) Then Return Brushes.Get(clr)
	Dim b As BCBrush = ForegroundBC.CreateBrushFromColor(clr)
	Brushes.Put(clr, b)
	Return b
End Sub


Public Sub GetFontMetrics(Fnt As B4XFont, clr As Int) As BCFontMetrics
	Dim key As String = FontToKey(Fnt, clr)
	If FontMetricsCache.ContainsKey(key) Then Return FontMetricsCache.Get(key)
	Dim fm As BCFontMetrics
	fm.Initialize
	fm.Glyphs.Initialize
	fm.Clr = clr
	fm.Fnt = Fnt
	If clr = DefaultColor Then
		fm.KerningTable.Initialize
		fm.DefaultColorMetrics = fm
		fm.xWidth = CreateGlyph("x", fm, False).Width
	Else
		fm.DefaultColorMetrics = GetFontMetrics(Fnt, DefaultColor)
		fm.xWidth = fm.DefaultColorMetrics.xWidth
		fm.KerningTable = fm.DefaultColorMetrics.KerningTable
	End If
	FontMetricsCache.Put(key, fm)
	Return fm
End Sub

Private Sub CreateGlyph (c As String, FontMetrics As BCFontMetrics, JustMeasure As Boolean) As BCGlyph
	Dim g As BCGlyph = FontMetrics.Glyphs.Get(c)
	If g <> Null Then Return g
	If FontMetrics.clr <> DefaultColor Then
		Return CreateGlyphFromDefaultColor(c, FontMetrics.DefaultColorMetrics, FontMetrics.Clr)
	Else
		cvs.ClearRect(cvs.TargetRect)
		Dim r As B4XRect = cvs.MeasureText(c, FontMetrics.Fnt)
		Dim BaseLine As Int = -r.Top + 5
		r.Left = r.Left * mScale
		r.Top = r.Top * mScale
		r.Right = r.Right * mScale
		r.Bottom = r.Bottom * mScale
		If CharBC.mWidth < r.Width + 20 * mScale Or CharBC.mHeight < r.Height + 20 * mScale Then
			ResizeCharBC(r.Width + 30 * mScale, r.Height + 30 * mScale)
		End If
'	cvs.DrawRect(cvs.TargetRect, xui.Color_Yellow, True, 0)
		Dim leftOffset As Int = 5
		cvs.DrawText(c, leftOffset, BaseLine, FontMetrics.Fnt, FontMetrics.clr, "LEFT")
		#if B4A		
		Dim bmp As B4XBitmap = cvs.CreateBitmap
		#else if B4J
		Dim jo As JavaObject = cvs
		Dim bmp As B4XBitmap = jo.GetFieldJO("cvs").RunMethodJO("getObject", Null).RunMethod("snapshot", Array(sp, WritableImage))
		#else if B4i
		Dim bmp As B4XBitmap = cvs.CreateBitmap
		Dim cg As NativeObject = bmp
		Dim uiimg As NativeObject
		bmp = uiimg.Initialize("UIImage").RunMethod("imageWithCGImage:scale:orientation:", Array(cg.RunMethod("CGImage", Null), 1, _
			cg.GetField("imageOrientation")))
		#End If
		CharBC.CopyPixelsFromBitmap(bmp)
		Dim r2 As B4XRect = FindMinRect(leftOffset + r.Right + 20 * mScale, r.Height + 20 * mScale)
		
		Dim g As BCGlyph
		g.Initialize
		g.baseline = BaseLine * mScale - r2.Top
		If r2.Width > 0 Then
			r2.Left = Floor(r2.Left)
			r2.Right = Ceil(r2.Right)
			If RTLAware Then RecolorEdgesOfConnectedCharacters(c, r2)
'			If c = "lk" Or c = "k" Then
'				Dim out As OutputStream = File.OpenOutput("C:\Users\H\Downloads", c & ".png", False)
'				bmp.WriteToStream(out, 100, "PNG")
'				out.Close
'			End If
			Dim cbc As CompressedBC = CharBC.ExtractCompressedBC(r2, cbccache)
			g.cbc = cbc
			g.width = cbc.mWidth
		Else
			g.Empty = True
			If c = TAB Then
				g.Width = FontMetrics.xWidth * TabWidthMeasuredInX
			Else if c = " " Then
				g.width = CreateGlyph("x x", FontMetrics, True).Width - FontMetrics.xWidth * 2
			Else If c = "x" Then
				g = CreateGlyph("X", FontMetrics, True)
			Else If c = "x x" Then
				g = CreateGlyph("X X", FontMetrics, True)
			Else
				g.Width = CreateGlyph(" ", FontMetrics, False).Width
			End If
		End If
		If xui.IsB4J = False And MightBeAnEmoji(c) Then
			If Emojis.IsInitialized = False Then LoadData(Emojis, "emoji-data.txt")
			g.Emoji = Emojis.Contains(BytesToInt(c.GetBytes(Charset), 0))
		End If
		If JustMeasure = False Then
			FontMetrics.Glyphs.Put(c, g)
		End If
		Return g
	End If
End Sub

Private Sub RecolorEdgesOfConnectedCharacters(c As String, r2 As B4XRect)
	If ArabicCharsConnectedPrev.Contains(c) Then
		Dim First As Boolean = True
		For y = r2.Top To r2.Bottom - 1
			For x = r2.Right - 1 To Max(r2.Left, r2.Right - 5) Step - 1
				If CharBC.IsTransparent(x, y) = False Then
					If First Then
						First = False
					Else
						CharBC.SetPremultipliedColor(x, y, PMDefaultColor)
					End If
					Exit
				End If
			Next
		Next
	End If
End Sub

Private Sub BytesToInt (Bytes() As Byte, StartIndex As Int) As Int
	Dim cp As Int
	For i = 0 To 3
		cp = Bit.Or(cp, Bit.ShiftLeft(Bit.And(0xff, Bytes(i + StartIndex)), 8 * i))
	Next
	Return cp
End Sub

Private Sub MightBeAnEmoji(c As String) As Boolean
	Dim cp As Int = Asc(c)
	Return cp >= 0x231A Or c.Length > 1
End Sub


Private Sub CreateGlyphFromDefaultColor(c As String, DefaultColorMetrics As BCFontMetrics, clr As Int) As BCGlyph
	Dim BlackGlyph As BCGlyph = CreateGlyph(c, DefaultColorMetrics, False)
	If BlackGlyph.cbc.IsInitialized = False Or BlackGlyph.Emoji Then Return BlackGlyph
	Dim g As BCGlyph
	g.Initialize
	g.baseline = BlackGlyph.baseline
	g.width = BlackGlyph.width
	g.cbc.Initialize
	g.cbc.Cache = BlackGlyph.cbc.Cache
	g.cbc.mHeight = BlackGlyph.cbc.mHeight
	g.cbc.mWidth = BlackGlyph.cbc.mWidth
	g.cbc.Rows = BlackGlyph.cbc.Rows
	g.cbc.TargetRect = BlackGlyph.cbc.TargetRect
	Dim buffer(BlackGlyph.cbc.mBuffer.Length) As Byte
	Dim argb As ARGBColor
	CharBC.ColorToARGB(clr, argb)
	Dim ai, ri, gi, bi As Int
	#if B4A or B4i
	ai = 3
	ri = 0
	gi = 1
	bi = 2
	#else if B4J
	ai = 3
	ri = 2
	gi = 1
	bi = 0
	#end if
	For i = 0 To buffer.Length - 1 Step 4
		#if B4i
		Dim a As Int = Bit.FastArrayGetByte(BlackGlyph.cbc.mBuffer, i + ai)
		Dim af As Float = a / 255
		Bit.FastArraySetByte(buffer, i + ri, argb.r * af)
		Bit.FastArraySetByte(buffer, i + gi, argb.g * af)
		Bit.FastArraySetByte(buffer, i + bi, argb.b * af)
		Bit.FastArraySetByte(buffer, i + ai, a)
#Else
		Dim a As Int = Bit.And(0xff, BlackGlyph.cbc.mBuffer(i + ai))
		Dim af As Float = a / 255
		buffer(i + ai) = a
		buffer(i + ri) = argb.r * af
		buffer(i + gi) = argb.g * af
		buffer(i + bi) = argb.b * af
#End If
	Next
	g.cbc.mBuffer = buffer
	Return g
End Sub


Private Sub FindMinRect (width As Int, height As Int) As B4XRect
	Dim r As B4XRect
	r.Initialize(width / 2, -1, -1, 0)
	For y = 0 To height - 1
		For x = 0 To width - 1
			If CharBC.IsTransparent(x, y) = False Then
				r.Left = Min(r.Left, x)
				Exit
			End If
		Next
		If x < width Then
			If r.Top = -1 Then
				r.Top = y
			Else
				r.Bottom = y + 1
			End If
			For x = width - 1 To 0 Step -1
				If CharBC.IsTransparent(x, y) = False Then
					r.Right = Max(r.Right, x + 1)
					Exit
				End If
			Next
		End If
	Next
	r.Bottom = Max(r.Bottom, r.Top + 1)
	Return r
End Sub

Private Sub FontToKey (fnt As B4XFont, Clr As Int) As String
	#if B4J or B4A
	Dim jo As JavaObject = fnt.ToNativeFont
	Return Clr + jo.RunMethod("hashCode", Null) + fnt.Size
	#Else
	Dim no As NativeObject = fnt.ToNativeFont
	Dim n As Long = no.GetField("hash").AsNumber
	Return NumberFormat2(Bit.Xor(Clr + fnt.Size, n), 0, 0, 0, False)
	#End If
End Sub

'Don't change.
Public Sub getSpaceBetweenCharacters As Float
	Return mSpaceBetweenCharacters / mScale
End Sub

Public Sub setSpaceBetweenCharacters(f As Float)
	mSpaceBetweenCharacters = f * mScale
End Sub

'Gets or sets the default (minimum) space between lines. Default value is 20dip.
Public Sub getSpaceBetweenLines As Float
	Return mSpaceBetweenLines / mScale
End Sub

Public Sub setSpaceBetweenLines(f As Float)
	mSpaceBetweenLines = f * mScale
End Sub

'Gets or sets the minimum gap between two lines. Default value: 5dip.
Public Sub setMinGapBetweenLines(i As Int)
	mMinGapBetweenLines = i
End Sub

Public Sub getMinGapBetweenLines As Int
	Return mMinGapBetweenLines
End Sub



Public Sub CreateBCTextCharsFromString (s As String) As BCTextChars
	If RTLAware Then LoadArabicData
	Dim b() As Byte = s.GetBytes(Charset)
	Dim chars(b.Length / 4) As String
	Dim i, bi As Int = 0
	Dim ShouldAddToPrevChar As Boolean
	Dim ThereAreVowels As Boolean = VowelsCodePoints.Size > 0
	Do While bi <= chars.Length - 1
		chars(i) = BytesToString(b, bi * 4, 4, Charset)
		If LookForComplexCharacters Then
			Dim cp As Int = BytesToInt(b, bi * 4)
			If i > 0 And (cp = 0x200d Or (cp >= 0xFE00 And cp <= 0xFE0F)) Then
				chars(i - 1) = chars(i - 1) & chars(i)
				i = i - 1
				ShouldAddToPrevChar = True
			Else If i > 0 And (cp >= 0x1F3FB And cp <= 0x1F3FF) Then 'FITZPATRICK
				chars(i - 1) = chars(i - 1) & chars(i)
				i = i - 1
				ShouldAddToPrevChar = False
			Else If i > 0 And (ThereAreVowels And VowelsCodePoints.Contains(cp)) Then
				chars(i - 1) = chars(i - 1) & chars(i)
				i = i - 1
				ShouldAddToPrevChar = False
			Else If RTLAware And i > 0 And chars(i - 1) = "ل" And (cp = 0x622 Or cp = 0x623 Or cp = 0x625 Or cp = 0x627) Then
				Select cp
					Case 0x622
						chars(i - 1) = Chr(0xFEF5)	
					Case 0x623
						chars(i - 1) = Chr(0xFEF7)
					Case 0x625
						chars(i - 1) = Chr(0xFEF9)
					Case 0x627
						chars(i - 1) = Chr(0xFEFB)
				End Select
				i = i - 1
				ShouldAddToPrevChar = False
			Else If i > 0 And ShouldAddToPrevChar Then
				chars(i - 1) = chars(i - 1) & chars(i)
				i = i - 1
				ShouldAddToPrevChar = False
			Else
				ShouldAddToPrevChar = False
			End If
		End If
		i = i + 1
		bi = bi + 1
	Loop
	If RTLAware Then
		PreprocessArabic(chars, i)
	End If
	Return CreateBCTextChars(chars, 0, i)
End Sub

Public Sub CreateBCTextChars (Buffer() As String, StartIndex As Int, Length As Int) As BCTextChars
	Dim t1 As BCTextChars
	t1.Initialize
	t1.Buffer = Buffer
	t1.StartIndex = StartIndex
	t1.Length = Length
	Return t1
End Sub

Private Sub TextCharsSubstring(TC As BCTextChars, StartIndex As Int, EndIndex As Int) As BCTextChars
	Return CreateBCTextChars(TC.Buffer, StartIndex + TC.StartIndex, EndIndex - StartIndex)
End Sub

Private Sub TextCharEquals (TC As BCTextChars, s As String) As Boolean
	If TC.Length <> s.Length Then Return False
	For i = 0 To TC.Length - 1
		If TC.Buffer(i + TC.StartIndex) <> s.CharAt(i) Then Return False
	Next
	Return True
End Sub

Private Sub LoadArabicData
	If ArabicMap.IsInitialized = False Then
		ArabicMap.Initialize
		ArabicNonLinkedLetters.Initialize
		ArabicCharsConnectedPrev.Initialize
		Dim a As ARGBColor
		CharBC.ColorToARGB(DefaultColor, a)
		CharBC.ARGBToPremultipliedColor(a, PMDefaultColor)
		For Each line As String In File.ReadList(File.DirAssets, "arabic_mapping.txt")
			Dim split() As String = Regex.Split(",", line)
			If split.Length = 2 And split(1) = "0" Then
				VowelsCodePoints.Add(Bit.ParseInt(split(0), 16))
			Else
				ArabicMap.Put(Chr(Bit.ParseInt(split(0), 16)).As(String), Bit.ParseInt(split(1), 16))
				If 2 = split(2) Then
					ArabicNonLinkedLetters.Add(Chr(Bit.ParseInt(split(0), 16)).As(String))
				End If
			End If
		Next
	End If
End Sub

Public Sub PreprocessArabic(chars() As String, Length As Int)
	LoadArabicData
	Dim ArabicChars, ArabicNonLinked As B4XBitSet
	Dim FullChars(Length) As String
	Dim Found As Boolean
	For i = 0 To Length - 1
		If ArabicMap.ContainsKey(chars(i).CharAt(0).As(String)) Then
			If chars(i).Length > 1 Then
				FullChars(i) = chars(i).SubString(1)
				chars(i) = chars(i).CharAt(0).As(String)
			End If
			If Found = False Then
				Found = True
				ArabicChars.Initialize(Length)
				ArabicNonLinked.Initialize(Length)
			End If
			ArabicChars.Set(i, True)
			If ArabicNonLinkedLetters.Contains(chars(i)) Then
				ArabicNonLinked.Set(i, True)
			End If
		End If
	Next
	If Found = False Then Return
	For i = 0 To Length - 1
		If ArabicChars.Get(i) Then
			Dim ConnectToPrev As Boolean = i > 0 And ArabicChars.Get(i - 1) And ArabicNonLinked.Get(i - 1) = False
			Dim ConnectToNext As Boolean = i < Length - 1 And ArabicChars.Get(i + 1) And ArabicNonLinked.Get(i) = False
			If ConnectToNext = False And ConnectToPrev = False Then Continue
			Dim offset As Int = IIf(ConnectToPrev And ConnectToNext, 3, IIf(ConnectToPrev, 1, 2))
			Dim TargetCP As Int = ArabicMap.Get(chars(i))
			If TargetCP = Asc(chars(i)) Then
				offset = 0
			End If
			TargetCP = TargetCP + offset
			chars(i) = Chr(TargetCP)
			If FullChars(i).Length > 0 Then chars(i) = chars(i) & FullChars(i)
			If ConnectToPrev Then ArabicCharsConnectedPrev.Add(chars(i))
		End If
	Next
End Sub


'debug sub
Public Sub PrintTextChars(TC As BCTextChars)
	Dim sb As StringBuilder
	sb.Initialize
	For i = TC.StartIndex To TC.StartIndex + TC.Length - 1
		sb.Append(TC.Buffer(i))
	Next
	Log(sb.ToString)
End Sub

Private Sub LoadData(Set As B4XSet, FileName As String)
	Set.Initialize
	For Each line As String In File.ReadList(File.DirAssets, FileName) 'ignore
		line = line.Trim
		Dim i As Int = line.IndexOf(".")
		If i = -1 Then
			Set.Add(Bit.ParseInt(line, 16))
		Else
			For a = Bit.ParseInt(line.SubString2(0, i), 16) To Bit.ParseInt(line.SubString(i + 2), 16)
				Set.Add(a)
			Next
		End If
	Next
End Sub
