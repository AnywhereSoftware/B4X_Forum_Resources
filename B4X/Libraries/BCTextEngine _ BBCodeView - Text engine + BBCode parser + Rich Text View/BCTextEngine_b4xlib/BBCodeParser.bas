B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Type BBCodeTextNode (Text As String, Tags As List)
	Type BBCodeTagNode (Tag As String, Extra As Map, CanHaveNestedTags As Boolean)
	Type BBCodeParseData (Text As String, URLs As Map, Width As Int, ViewsPanel As B4XView, Views As Map, NeedToReparseWhenResize As Boolean, _
		ImageCache As Map, DefaultBoldFont As B4XFont, DefaultFont As B4XFont, DefaultColor As Int, UrlColor As Int)
	Private AllowedTags As B4XSet
	Private Stack As List
	Private Start As Int
	Private mTextEngine As BCTextEngine
	Private xui As XUI
	Public UrlColor As Int = 0xFF003FFF
	Public ColorsMap As Map
	Public ErrorString As StringBuilder
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (TextEngine As BCTextEngine)
	AllowedTags = B4XCollections.CreateSet2(Array("b", "u", "url", "plain", "color", "img", "view", _
		"vertical", "textsize", "alignment", "span", "indent", "list", "*", "fontawesome", "materialicons", "e", "font", "direction", "a"))
	ColorsMap = CreateMap("black": xui.Color_Black, _
		"darkgray": xui.Color_DarkGray, _
		"gray": xui.Color_Gray, _
		"lightgray": xui.Color_LightGray, _
		"white": xui.Color_White, _
		"red": xui.Color_Red, _
		"green": xui.Color_Green, _
		"blue": xui.Color_Blue, _
		"yellow": xui.Color_Yellow, _
		"cyan": xui.Color_Cyan, _
		"magenta": xui.Color_Magenta, _
		"transparent": xui.Color_Transparent)
	mTextEngine = TextEngine
	ErrorString.Initialize
End Sub

Public Sub Parse (Data As BBCodeParseData) As List
	ErrorString.Initialize
	Dim ParsedElements As List
	ParsedElements.Initialize
	Stack.Initialize
	Stack.Add(CreateTagNode("noop"))
	Dim matcher As Matcher = Regex.Matcher("(?<!\[)\[[^\[\]]+\]", Data.Text)
	Dim LastMatchEnd As Int = 0
	Dim skipUntilEndTag As Boolean = False
	Do While matcher.Find
		Start = matcher.GetStart(0)
		If Start > LastMatchEnd And skipUntilEndTag = False Then
			ParsedElements.Add(CreateTextNode(Data.Text.SubString2(LastMatchEnd, Start)))
		End If
		Dim tag As String = matcher.Match.SubString2(1, matcher.Match.Length - 1)
		If tag.StartsWith("/") Then
			tag = tag.SubString(1).ToLowerCase
			If StackPeek.Tag <> tag Then
				If StackPeek.CanHaveNestedTags = False Then
					Continue
				End If
				Error("Closing tag does not match: " & tag)
				Return Null
			End If
			If skipUntilEndTag Then
				If Start > LastMatchEnd Then
					ParsedElements.Add(CreateTextNode(Data.Text.SubString2(LastMatchEnd, Start)))
				End If
			End If
			StackPop
			skipUntilEndTag = False
		Else
			If StackPeek.CanHaveNestedTags = False Then Continue
			Dim ClosedTag As Boolean
			If tag.EndsWith("/") Then
				ClosedTag = True
				tag = tag.SubString2(0, tag.Length - 1)
			Else If tag = "*" Then
				ClosedTag = True
			End If
			tag = tag.Trim
			Dim t As BBCodeTagNode = ParseTag(tag)
			If AllowedTags.Contains(t.Tag) = False Then
				Error("Invalid tag: " & tag)
				Return Null
			End If
			StackPush(t)
			If t.Tag = "plain" Then
				Dim n As BBCodeTagNode = StackPeek
				n.CanHaveNestedTags = False
				skipUntilEndTag = True
			End If
			If ClosedTag Then
				ParsedElements.Add(CreateTextNode(""))
				StackPop
			End If
		End If
		LastMatchEnd = matcher.GetEnd(0)
	Loop
	If Data.Text.Length > LastMatchEnd Then
		ParsedElements.Add(CreateTextNode(Data.Text.SubString2(LastMatchEnd, Data.Text.Length)))
	End If
	Return ParsedElements
End Sub

Private Sub ParseTag (tag As String) As BBCodeTagNode
	'[URL]
	'[URL=sdfsdf] or [URL="sdfsdf"]
	'[URL key1="value 1" key2=34]
	If tag.Contains("=") = False Then Return CreateTagNode(tag.ToLowerCase)
	Dim res As BBCodeTagNode = CreateTagNode("")
	res.Extra.Initialize
	Dim i As Int
	Dim last As Int = -1
	Do While i < tag.Length
		Dim c As String = tag.CharAt(i)
		If c = "=" Then
			Dim key As String = tag.SubString2(last + 1, i).ToLowerCase
			If res.tag = "" Then 'option #2
				res.Tag = key
			End If
			Dim i2 As Int
			If tag.CharAt(i + 1) = QUOTE Then
				i2 = tag.IndexOf2(QUOTE, i + 2)
				res.Extra.Put(key, tag.SubString2(i + 2, i2))
			Else
				i2 = tag.IndexOf2(" ", i + 2)
				If i2 = -1 Then i2 = tag.Length
				res.Extra.Put(key, tag.SubString2(i + 1, i2))
			End If
			i = i2
			last = i
		End If
		If c = " " Then
			If res.Extra.Size = 0 Then
				Dim key As String = tag.SubString2(0, i).ToLowerCase
				res.Tag = key
			End If
			last = i
		End If
		i = i + 1
	Loop
	Return res
End Sub

Private Sub StackPop
	Stack.RemoveAt(Stack.Size - 1)
End Sub

Private Sub StackPush (Tag As BBCodeTagNode)
	Stack.Add(Tag)
End Sub

Private Sub StackPeek As BBCodeTagNode
	Return Stack.Get(Stack.Size - 1)
End Sub

Private Sub Error (msg As String)
	Dim s As String = $"Error (position - ${Start}): ${msg}"$
	#if B4A or B4i
	LogColor(s, Colors.Red)
	#else
	LogError(s)
	#End If
	ErrorString.Append(s).Append(CRLF)
End Sub

Private Sub CreateTextNode(Text As String) As BBCodeTextNode
	Dim n As BBCodeTextNode
	n.Initialize
	n.Text = Text
	n.Tags.Initialize
	n.Tags.AddAll(Stack)
	Return n
End Sub


Private Sub CreateTagNode (Tag As String) As BBCodeTagNode
	Dim n As BBCodeTagNode
	n.Initialize
	n.Tag = Tag
	n.CanHaveNestedTags = True
	Return n
End Sub

Public Sub CreateRuns (Texts As List, Data As BBCodeParseData) As List
	Dim Runs As List
	Runs.Initialize
	For Each TextNode As BBCodeTextNode In Texts
		TextToRun(TextNode, Runs, Data)
	Next
	Return Runs
End Sub

Private Sub TextToRun (Text As BBCodeTextNode, RunsList As List, Data As BBCodeParseData)
	Dim list As List = RunsList
	Dim Run As BCTextRun = mTextEngine.CreateRun(Text.Text)
	Run.TextColor = Data.DefaultColor
	Run.TextFont = Data.DefaultFont
	Dim customfont As Boolean
	Dim FontSize As Int = Data.DefaultFont.Size
	Dim CurrentFont As B4XFont = Data.DefaultFont
	Dim IsListElement As Boolean
	For i = 0 To Text.Tags.Size - 1
		Dim tag As BBCodeTagNode = Text.Tags.Get(i)
		Select tag.Tag
			Case "u"
				Run.Underline = True
				If tag.Extra.IsInitialized Then
					Dim uu As BCStyledUnderline
					uu.Initialize
					uu.Style = tag.Extra.GetDefault("style", mTextEngine.DefaultUnderlineStyle.Style)
					uu.Style = uu.Style.ToLowerCase
					If tag.Extra.ContainsKey("color") Then uu.Clr = ParseColorString(tag.Extra.Get("color")) Else uu.Clr = 0
					uu.Thickness = DipToCurrent(tag.Extra.GetDefault("thickness", 1))
					If Run.Extra.IsInitialized = False Then Run.Extra.Initialize
					Run.Extra.Put(mTextEngine.EXTRA_STYLEDUNDERLINE, uu)
				End If
			Case "b"
				customfont = True
				CurrentFont = Data.DefaultBoldFont
			Case "url"
				Dim url As String
				If tag.Extra.IsInitialized Then
					url = tag.Extra.Get("url")
				Else
					url = Text.Text
					Run.TextDirection = mTextEngine.TextDirectionLTR
				End If
				If Data.URLs.IsInitialized Then Data.URLs.Put(Run, url)
				Run.AutoUnderline = True
				Run.TextColor = Bit.Or(0xff000000, UrlColor)
			Case "color"
				Dim clr As String = tag.Extra.Get("color")
				Run.TextColor = ParseColorString(clr)
			Case "img"
				SetImageView(tag, Run, Data)
				If tag.Extra.ContainsKey("vertical") Then
					Run.VerticalOffset = GetDimensionFromTag(tag, "vertical", Data)
				End If
				Data.ViewsPanel.AddView(Run.View, 0, 0, Run.View.Width, Run.View.Height)
			Case "view"
				Run.View = GetView(tag, Data)
				If tag.Extra.ContainsKey("vertical") Then Run.VerticalOffset = GetDimensionFromTag(tag, "vertical", Data)
				If tag.Extra.ContainsKey("width") Then Run.View.Width = GetDimensionFromTag(tag, "width", Data)
				If tag.Extra.ContainsKey("height") Then Run.View.Height = GetDimensionFromTag(tag, "height", Data)
				Data.ViewsPanel.AddView(Run.View, 0, 0, Run.View.Width, Run.View.Height)
			Case "vertical"
				Run.VerticalOffset = GetDimensionFromTag(tag, "vertical", Data)
			Case "textsize"
				FontSize = tag.Extra.Get("textsize")
			Case "font"
				customfont = True
				Dim name As String = tag.Extra.Get(tag.Tag)
				If mTextEngine.CustomFonts.ContainsKey(name) = False Then
					Log("Font missing from TextEngine.CustomFonts: " & name)
				Else
					Dim NewFont As B4XFont =  mTextEngine.CustomFonts.Get(name)
					CurrentFont = NewFont
					If tag.Extra.ContainsKey("size") Then FontSize = tag.Extra.Get("size")
				End If
			Case "alignment"
				Run.HorizontalAlignment = tag.Extra.Get("alignment")
			Case "span"
				If tag.Extra.ContainsKey("run") = False Then
					Dim parent As BCTextRun = mTextEngine.CreateConnectedParent
					Dim cr As BCConnectedRuns = parent.Extra.Get(mTextEngine.EXTRA_CONNECTEDRUNS)
					cr.ConnectedWidth = GetDimensionFromTag(tag, "minwidth", Data)
					cr.Alignment = tag.Extra.GetDefault("alignment", "left")
					RunsList.Add(parent)
					tag.Extra.Put("run", parent)
				End If
				Dim parent As BCTextRun = tag.Extra.Get("run")
				Dim cr As BCConnectedRuns = parent.Extra.Get(mTextEngine.EXTRA_CONNECTEDRUNS)
				list = cr.Runs
			Case "indent"
				Run.IndentLevel = tag.Extra.Get("indent")
			Case "list"
				Run.IndentLevel = Run.IndentLevel + 1
			Case "*"
				IsListElement = True
			Case "e"
				Run.TextChars = mTextEngine.CreateBCTextChars(Array As String(tag.Extra.Get(tag.Tag)), 0, 1)
				If tag.Extra.ContainsKey("vertical") Then Run.VerticalOffset = GetDimensionFromTag(tag, "vertical", Data)
			Case "direction"
				Dim dir As String = tag.Extra.Get("direction")
				Select dir.ToLowerCase
					Case "ltr"
						Run.TextDirection = mTextEngine.TextDirectionLTR
					Case "rtl"
						Run.TextDirection = mTextEngine.TextDirectionRTL
					Case "unknown"
						Run.TextDirection = mTextEngine.TextDirectionUnknown
				End Select
			Case "fontawesome", "materialicons"
				customfont = True
				If tag.Tag = "fontawesome" Then
					CurrentFont = xui.CreateFontAwesome(FontSize)
				Else
					CurrentFont = xui.CreateMaterialIcons(FontSize)
				End If
				Run.TextChars = mTextEngine.CreateBCTextCharsFromString(Chr(ParseCodepoint(tag.Extra.Get(tag.Tag))))
				If tag.Extra.ContainsKey("vertical") Then Run.VerticalOffset = GetDimensionFromTag(tag, "vertical", Data)
				If tag.Extra.ContainsKey("size") Then FontSize = tag.Extra.Get("size")
			Case "a"
				If Run.Extra.IsInitialized = False Then Run.Extra.Initialize
				Run.Extra.Put("a", tag.Extra.Get("a"))
		End Select
	Next
	If IsListElement Then
		Run = HandleListElement(Text, Run)
	End If
	If customfont Or FontSize <> Data.DefaultFont.Size Then
		#if B4i
		Dim NativeFont As Font = CurrentFont
		If NativeFont.Name.StartsWith(".SFUI") Then
			If NativeFont.Name.ToLowerCase.Contains("bold") Then
				Run.TextFont = xui.CreateDefaultBoldFont(FontSize)
			Else
				Run.TextFont = xui.CreateDefaultFont(FontSize)
			End If
		Else
			Run.TextFont = xui.CreateFont2(CurrentFont, FontSize)
		End If
		#else		
		Run.TextFont = xui.CreateFont2(CurrentFont, FontSize)
		#End If
	End If
	list.Add(Run)
End Sub

Private Sub ParseCodepoint (raw As String) As Int
	If raw.StartsWith("0x") Then raw = raw.SubString(2)
	Return Bit.ParseInt(raw, 16)
End Sub

Private Sub ParseColorString(clr As String) As Int
	clr = clr.ToLowerCase
	If clr.StartsWith("#") Then
		Return Bit.Or(0xff000000, Bit.ParseInt(clr.SubString(1), 16))
	Else If clr.StartsWith("0x") Then
		Return Bit.Or(0xff000000, Bit.ParseInt(clr.SubString(4), 16))
	Else If ColorsMap.ContainsKey(clr) Then
		Return ColorsMap.Get(clr)
	Else
		Error("Invalid color value: " & clr)
		Return xui.Color_Black
	End If
End Sub

Private Sub HandleListElement (Text As BBCodeTextNode, Run As BCTextRun) As BCTextRun
	For i = Text.Tags.Size - 1 To 0 Step -1
		Dim tag As BBCodeTagNode = Text.Tags.Get(i)
		If tag.Tag = "list" Then
			Dim liststyle As String
			If tag.extra.IsInitialized Then liststyle = tag.Extra.GetDefault("style", "unordered")
			If liststyle = "" Or liststyle.ToLowerCase = "unordered" Then
				Run.TextChars =  mTextEngine.CreateBCTextCharsFromString(Chr(0x2022) & " ")
			Else
				Dim count As Int = tag.Extra.GetDefault("count", 1)
				Dim parent As BCTextRun = mTextEngine.CreateConnectedParent
				Run.TextChars = mTextEngine.CreateBCTextCharsFromString((count) & ". ")
				Dim cr As BCConnectedRuns = parent.Extra.Get(mTextEngine.EXTRA_CONNECTEDRUNS)
				cr.Runs.Add(Run)
				cr.Alignment = "right"
				cr.ConnectedWidth = mTextEngine.GetFontMetrics(Run.TextFont, Run.TextColor).xWidth * 3 / mTextEngine.mScale
				parent.IndentLevel = Run.IndentLevel
				Run = parent
				count = count + 1
				tag.Extra.Put("count", count)
			End If
			Exit
		End If
	Next
	Return Run
End Sub

Private Sub GetDimensionFromTag (Tag As BBCodeTagNode, Key As String, Data As BBCodeParseData) As Int
	Dim s As String = Tag.Extra.GetDefault(Key, "")
	If s = "" Then Return -1
	Dim i As Int = s.IndexOf("%")
	If i > -1 Then
		Dim v As Float = s.SubString2(0, i) / 100
		If s.EndsWith("%x") Then
			Data.NeedToReparseWhenResize = True
			Return v * Data.Width
		End If
	End If
	Return DipToCurrent(s)
End Sub

#if B4J
Public Sub InternalSetMouseTransparent(v As B4XView)
	Dim jo As JavaObject = v
	jo.RunMethod("setMouseTransparent", Array(True))
End Sub
#End If

Private Sub SetImageView (Tag As BBCodeTagNode, run As BCTextRun, data As BBCodeParseData)
	Dim url As String = Tag.Extra.GetDefault("url", "")
	Dim dir As String = Tag.Extra.GetDefault("dir", File.DirAssets)
	Dim filename As String = Tag.Extra.GetDefault("filename", "")
	Dim width As Int = GetDimensionFromTag(Tag, "width", data)
	Dim height As Int = GetDimensionFromTag(Tag, "height", data)
	Dim iv As ImageView
	iv.Initialize("")
	#if B4J
	InternalSetMouseTransparent(iv)
	#End If
	Dim xiv As B4XView = iv
	run.View = xiv
	Dim bmp As B4XBitmap
	If url <> "" Then
		xiv.SetLayoutAnimated(0, 0, 0, width, height)
		If data.ImageCache.ContainsKey(url) Then
			xiv.SetBitmap(data.ImageCache.Get(url))
		Else
			Dim j As HttpJob
			j.Initialize("", Me)
			j.Download(url)
			Wait For (j) JobDone (j As HttpJob)
			If j.Success Then
				bmp = j.GetBitmap
				bmp = bmp.Resize(width, height, True)
				data.ImageCache.Put(url, bmp)
				xiv.SetBitmap(bmp)
			End If
			j.Release
		End If
	Else
		If width = -1 And height = -1 Then
			bmp = xui.LoadBitmap(dir, filename)
		Else if width > -1 And height > -1 Then
			bmp = xui.LoadBitmapResize(dir, filename, width, height, False)
		Else if width > -1 Then
			bmp = xui.LoadBitmapResize(dir, filename, width, 10000, True)
		Else
			bmp = xui.LoadBitmapResize(dir, filename, 10000, height, True)
		End If
		xiv.SetBitmap(bmp)
		xiv.SetLayoutAnimated(0, 0, 0, bmp.Width, bmp.Height)
	End If
End Sub

Private Sub GetView (Tag As BBCodeTagNode, Data As BBCodeParseData) As B4XView
	Dim id As String = Tag.Extra.Get("view")
	If Data.Views.ContainsKey(id) = False Then
		Error("Missing view: " & id)
	End If
	Dim v As B4XView = Data.Views.Get(id)
	Return v
End Sub


