B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
#If B4J	
	Private fx As JFX
#End IF
	Private TextEngine1 As BCTextEngine
	Private BBCodeView1 As BBCodeView
End Sub

Public Sub Initialize
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")		'just a single BBCodeView filling the root space (no borders)
	TextEngine1.Initialize(Root)
#if B4J
	Dim tface1 As Object = fx.CreateFont("Arial", 10, False, True)
	Dim tface2 As Object = fx.CreateFont("Serif", 10, False, False)
#Else If B4A
	Dim tface1 As Object = Typeface.CreateNew(Typeface.DEFAULT, Typeface.STYLE_ITALIC)
	Dim tface2 As Object = Typeface.CreateNew(Typeface.SERIF, Typeface.STYLE_NORMAL)
#Else If B4i
	Dim tface1 As Object = Font.CreateNew2("Arial-ItalicMT", 10) '????? untested
	Dim tface2 As Object = Font.CreateNew2("Times", 10)          '????? untested
#End If
	TextEngine1.CustomFonts.Put("italic", xui.CreateFont(tface1, 10))
	TextEngine1.CustomFonts.Put("serif", xui.CreateFont(tface2, 10))
	TextEngine1.WordBoundaries = "&+-/<\' .,:{(" & TAB & CRLF & Chr(13)
	TextEngine1.WordBoundariesThatCanConnectToPrevWord = ".,:"
	BBCodeView1.TextEngine = TextEngine1
	
	Dim btn As Button
	btn.Initialize("btn")
	Dim xbtn As B4XView = btn
	xbtn.Text = "Click!"
	xbtn.SetLayoutAnimated(0, 0, 0, 100dip, 40dip)
	BBCodeView1.Views.Put("btn", btn)
	BBCodeView1.mBase.Visible = False
	BBCodeView1.Text = getDoc
	BBCodeView1.mBase.Visible = True
	BBCodeView1.mBase.RequestFocus
End Sub

Private Sub getDoc As String
	Dim docPages As List
	docPages.Initialize
	Dim s As String = $"[a="index"]
[alignment=center][textsize=20][color=blue]The BBCode Variant used by B4X BBCodeView/BCTextEngine[/color][/textsize][/alignment][/a]


BBCode is short for Bulletin Board Code. It is often used to format posts made on message boards), blogs and more.
The B4X Forum uses BBCodes. And so does the BCTextEngine used by BBCodeView in B4X.

While the basic BBCode tags are often very similar across many implementations, there are some variants.
This document itself is created with BBCodes in a BBCodeView. 
Its purpose is to describe the variant used by B4X BCTextEngine and BBCodeView.

[color=red]Note: in B4X tags are case-insensitive - in this document I use only lower case[/color]

The [b]prototype BBcode tag[/b] looks like this:

[plain][tagName specs]text affected[/tagName][/plain]

For example:

[plain][b]The One[/b] and [b]Only One[/b].[/plain]

Looks like this:

[indent=2][b]The One[/b] and [b]Only One[/b].[/indent]

[alignment=cnter][textsize=19][b]'How To' Sections (click to scroll to)[/b][/textsize][/alignment]

[list]
[url]Bold Text[/url]
[url]Underline Text[/url]
[url]Italicize Text[/url]
[url]Text Font[/url]
[url]Text Color[/url]
[url]Text Size[/url]
[url]Text Alignment (left, center, right)[/url]
[url]Indent Text[/url]
[url]Set Text Width ('span')[/url]
[url]Add an Icon[/url]
[url]Add a Complex Character[/url]
[url]Add an Image[/url]
[url]Add a Link[/url]
[url]Add an Anchor to Scroll to[/url]
[url]Add a List[/url]
[url]Add a Table[/url]
[url]Add any View (label, button, input, custom list, etc.)[/url]
[url]Keep tags as plain Text[/url]
[url]Center Text Vertically on BBCodeView[/url]
[url]Right To Left Languages[/url]
[url]How to Control Line Spacing[/url]
[url]How to Control Wordwrap and Chinese/Korean/Japanese[/url]
[/list]

______________________________________________________________

[a="Bold Text"][b]How to Bold Text[/b]   ([url=index]Back to Index [FontAwesome=0xF062/][/url])[/a]

[plain][b]The One[/b] and [b]Only One[/b].[/plain]

[indent=2][b]The One[/b] and [b]Only One[/b].[/indent]

______________________________________________________________

[a="Underline Text"][b]How to Underline Text[/b]   ([url=index]Back to Index [FontAwesome=0xF062/][/url])[/a]

[plain][u]The One[/u] and [u]Only One[/u].[/plain]

[indent=2][u]The One[/u] and [u]Only One[/u].[/indent]

It is possible to embed tags in other tags:

[plain][u]The One[/u] [b]and[/b] [u]Only One[/u].[/plain]

[indent=2][u]The One[/u] [b]and[/b] [u]Only One[/u].[/indent]


Underlines can be any color and custom thickness, default is same color as text and thickness=1

[plain][color=#00ff00][b][u color=magenta]Green[/u][/b][/color][/plain]

[indent=2][color=#00ff00][b][u color=magenta]Green[/u][/b][/color][/indent]

[plain][color=#0000ff][b][u color=darkgray Thickness=3]Blue[/u][/b][/color][/plain]

[indent=2][color=#0000ff][b][u color=darkgray Thickness=3]Blue[/u][/b][/color][/indent]

______________________________________________________________

[a="Italicize Text"][b]How to Italicize Text[/b]   ([url=index]Back to Index [FontAwesome=0xF062/][/url])[/a]

To make it work across platforms, italic style requires a two step process.

Step 1 (only once per app). Add an italic font to the TextEngine

[code]
'#if B4J
'	Dim tface1 As Object = fx.CreateFont("Arial", 10, False, True)
'#Else If B4A
'	Dim tface1 As Object = Typeface.CreateNew(Typeface.DEFAULT, Typeface.STYLE_ITALIC)
'#Else If B4i
'	Dim tface1 As Object = Font.CreateNew2("Arial-ItalicMT", 10)
'#End If
'	TextEngine1.CustomFonts.Put("italic", xui.CreateFont(tface1, 10))
[/code]

Step 2. Use the custom italic font

[plain][font=italic]The One[/font] And [font=italic]Only One[/font].[/plain]

[indent=2][font=italic]The One[/font] And [font=italic]Only One[/font].[/indent]

______________________________________________________________

[a="Text Font"][b]How to Make Custom Font[/b]   ([url=index]Back to Index [FontAwesome=0xF062/][/url])[/a]

As shown for italic fonts, this requires a two step process.

Step 1 (only once per app). Add a custom font to the TextEngine

[code]
'#if B4J
'	Dim tface2 As Object = fx.CreateFont("Serif", 10, False, True)
'#Else If B4A
'	Dim tface2 As Object = Typeface.CreateNew(Typeface.SERIF, Typeface.STYLE_NORMAL)
'#Else If B4i
'	Dim tface2 As Object = Font.CreateNew2("Serif", 10)
'#End If
'	TextEngine1.CustomFonts.Put("serif", xui.CreateFont(tface2, 10))
[/code]

Step 2. Use the custom italic font

[plain][font=serif size=22]The One[/font] and [font=serif size=22]Only One[/font].[/plain]

[indent=2][font=serif size=22]The One[/font] and [font=serif size=22]Only One[/font].[/indent]

______________________________________________________________

[a="Text Color"][b]How to Change Text Color[/b]   ([url=index]Back to Index [FontAwesome=0xF062/][/url])[/a]

Note: Named colors are supported. Same names as available with XUI.

[plain][color=blue]The One[/color] and [color=red]Only One[/color].[/plain]

[indent=2][color=blue]The One[/color] and [color=red]Only One[/color].[/indent]

OR

[plain][color=#00aa00]The One[/color] and [color=#aaaa00]Only One[/color].[/plain]

[indent=2][color=#00aa00]The One[/color] and [color=#aaaa00]Only One[/color].[/indent]

______________________________________________________________

[a="Text Size"][b]How to Change Text Size[/b]   ([url=index]Back to Index [FontAwesome=0xF062/][/url])[/a]

Note: sizes are in points, not pixels or dips.

[plain][textsize=20]The One[/textsize] and [textsize=12]Only One[/textsize].[/plain]

[indent=2][textsize=20]The One[/textsize] and [textsize=12]Only One[/textsize].[/indent]

______________________________________________________________

[a="Text Alignment (left, center, right)"][b]How to Change Text Alignment[/b]   ([url=index]Back to Index [FontAwesome=0xF062/][/url])[/a]

Note: Default is [plain][alignment=left][/plain]

[plain][alignment=left][b]The One and Only One[/b][/alignment].[/plain]

[indent=2][alignment=left][b]The One and Only One[/b][/alignment].[/indent]

[plain][alignment=center][b]The One and Only One[/b][/alignment].[/plain]

[indent=2][alignment=center][b]The One and Only One[/b][/alignment].[/indent]

[plain][alignment=right][b]The One and Only One[/b][/alignment].[/plain]

[indent=2][alignment=right][b]The One and Only One[/b][/alignment].[/indent]

______________________________________________________________

[a="Indent Text"][b]How to Indent Text[/b]   ([url=index]Back to Index [FontAwesome=0xF062/][/url])[/a]

Note: Indentation stays active until closed. One indent is equivalent to about four or five 16 pt characters.

[plain][Indent=1]The One and Only One[/indent].[/plain]

[Indent=3]The One and Only One[/indent].

[plain][Indent=2]The One and Only One[/indent].[/plain]

[Indent=4]The One and Only One[/indent].

[plain][Indent=0]The One and Only One[/indent].[/plain]

[Indent=2]The One and Only One[/indent].

______________________________________________________________

[a="Set Text Width ('span')"][b]How to Set Text Width ('span')[/b]   ([url=index]Back to Index [FontAwesome=0xF062/][/url])[/a]

Note: The width is in terms of pixels (can be set with %x units - where % is of the BBCodeView width). Alignment can be set optionally in tag - default is left.  Example should be read as one line.

[plain]|[span minwidth=30%x]The One[/span]|[span minwidth=10%x alignment=center]and[/span]|[span minwidth=35%x]Only One[/span]|[/plain]

[indent=2]|[span minwidth=30%x]The One[/span]|[span minwidth=10%x alignment=center]and[/span]|[span minwidth=35%x]Only One[/span]|[/indent]

______________________________________________________________

[a="Add an Icon"][b]How to Add an Icon[/b]   ([url=index]Back to Index [FontAwesome=0xF062/][/url])[/a]

Note: There are two types of icons: FontAwesome and MaterialIcons.  Check the B4X IDE tools dropdown for icon type and icon code

Note: Icon tags are self-closing, see '/' before [plain]']'[/plain]

[plain]Some text [fontawesome=0xF13D/] some more[/plain]

[indent=2]Some text [fontawesome=0xF13D/] some more[/indent]

[plain]Some text [materialicons=0xE859/] some more[/plain]

[indent=2]Some text [materialicons=0xE859/] some more[/indent]

______________________________________________________________

[a="Add a Complex Character"][b]How to Add a Complex Character[/b]   ([url=index]Back to Index [FontAwesome=0xF062/][/url])[/a]

Note: Complex characters are multiple characters that are interpreted as one complex character.  For example 🇨🇦 is the flag of Canada.

[plain]xxxx [e=🇨🇦/] aaaa [/plain]

[indent=2]xxxx [e=🇨🇦/] aaaa [/indent]

Note 1: Windows default font doesn't include emoji flags.

[url]https://answers.microsoft.com/en-us...ag-emoji/85b163bc-786a-4918-9042-763ccf4b6c05[/url]


Note 2: The flag emoji set is a dynamic set and older Android devices may not include all flags.


Other Emojis are combined WITHOUT the [plain][e=][/plain] tag, and require a joiner character.

The character 👨‍💻 is really two emojis. 

👨 Man, ‍ Zero Width Joiner and 💻 Laptop. Each emoji is 2 unicode characters - so the combination has 5 unicode characters.

The joiner is chr(8205).

[indent=2]👨‍💻[/indent]

______________________________________________________________

[a="Add an Image"][b]How To Add an Image[/b]   ([url=index]Back To Index [FontAwesome=0xF062/][/url])[/a]

There are two forms of image specs.

	[u]Local .png or .jpg files[/u]

[plain][img dir="dirName" filename="logo.png" width=50/][/plain]

The 'dir=' parameter should be omitted for Assets files.  If Width/Height are omitted, the image dimensions are used. 
If width/height are specified, the image is resized to those dimensions.
If only one of width/height is specified, the image is resized to that dimension, keeping aspect ratio.

[plain][img filename="logo.png" width=50/][/plain]

[indent=2][img filename="logo.png" width=50/][/indent]

	[u]Remote Web .png or .jpg files[/u]
	
Both width and height of remote image files need to be explicitly specified.

[plain][img url="https://...s/l/42/42649.jpg?1432374732" width=60 height=60/][/plain]

______________________________________________________________

[a="Add a Link"][b]How To Add a Link[/b]   ([url=index]Back To Index [FontAwesome=0xF062/][/url])[/a]

There are two forms of links.

	[u]Reference links[/u]

[plain][url=linkName]Click Me[/url][/plain]

[indent=2][url=alink]Click Me[/url][/indent]

Note 1: When a link is clicked, the BBCodeView1_LinkClicked (linkName As String)  event is fired.  You can handle the next action there.

Note 2: link names should conform to url string rules, even if they are not https:// links

Note 3: You can disable the roll-over underline by setting BBCodeView1.AutoUnderlineURLs=False

Note 4: To give the link a different color, put a color tag around the text INSIDE the url tags

[plain][url=linkName][color=red]Click Me[/color][/url][/plain]

[indent=2][url=alink][color=red]Click Me[/color][/url][/indent]


	[u]Web links[/u]

[plain][url=https://...]Click Me[/url][/plain]

Note: Web links do not automatically open a browser or show the web page.  You need to do that yourself in the BBCodeView1_LinkClicked (linkName As String) event handler.

______________________________________________________________

[a="Add an Anchor to Scroll to"][b]How To Add an Anchor To Scroll to[/b]   ([url=index]Back To Index [FontAwesome=0xF062/][/url])[/a]

[plain][a="anchorName"]text to scroll to[/a][/plain]

This tag is used to navigate scrollable BBCodeViews.  It is used extensively in this document, see the index page.

You can add a link to navigate to a section of text as follows:

[plain][url=index]Back To Index [FontAwesome=0xF062/][/url][/plain]

In the BBCodeView1_LinkClicked (linkName As String) event handler use this:

[code]
'Private Sub BBCodeView1_LinkClicked (anchorName As String)
'	BBCodeView1.ScrollToAnchor(linkName)
'End Sub
[/code]

Note that the anchor name is in quotes and can be any string of characters (unlike link names).

______________________________________________________________

[a="Add a List"][b]How To Add a List[/b]   ([url=index]Back To Index [FontAwesome=0xF062/][/url])[/a]

[code]
'[plain]
'[list]
'[*][Color=#ff0000][b][u]Red[/u][/b][/Color]
'[*][Color=#00ff00][b][u color=Magenta]Green[/u][/b][/Color]
'[*][Color=#0000ff][b][u color=DarkGray Thickness=3]Blue[/u][/b][/Color]
'[/list]
'[/plain]
[/code]

[code]
'[list]
'[*][Color=#ff0000][b][u]Red[/u][/b][/Color]
'[*][Color=#00ff00][b][u color=Magenta]Green[/u][/b][/Color]
'[*][Color=#0000ff][b][u color=DarkGray Thickness=3]Blue[/u][/b][/Color]
'[/list]
[/code]

The content of each row in the list can be anything. At the top of this document, the index is a list of urls.

Note 1: the bullet tag [plain][*][/plain] can be omitted if not needed - also note that is the only non-closing tag - no '/'

Note 2: if you specify style=ordered then the bullet tag [plain][*][/plain] becomes ordinals, starting at 1.

[code]
'[plain]
'[list style=ordered]
'[*]Item A
'[*]Item B
'[*]Item C
'[/list]
'[/plain]
[/code]

[code]
'[list style=ordered]
'[*]Item A
'[*]Item B
'[*]Item C
'[/list]
[/code]

______________________________________________________________

[a="Add a Table"][b]How To Add a Table[/b]   ([url=index]Back To Index [FontAwesome=0xF062/][/url])[/a]

A table is a set of rows, where each row has columns made with fixed width spans.

Because of the repetitive nature of rows and verbose specification of span tags, 
tables are usually implemented by creating a Sub to form each row.
The formed rows can then be embedded as a value in a smart string, either one at a time or all together.

[code]
	'${TableRow($"[plain][b]Column 1[/b][/plain]"$, $"[plain][b]Column 2[/b][/plain]"$, $"[plain][b]Column 3[/b][/plain]"$)}
	'${TableRow($"[plain][b]1000[/b][/plain]"$, "AAA1", "CCC1")}
	'${TableRow($"[plain][b]1001[/b][/plain]"$, "AAA2", "CCC2")}
	'${TableRow($"[plain][b]1002[/b][/plain]"$, "AAA3", "CCC3")}
	'${TableRow($"[plain][b]1003[/b][/plain]"$, "AAA4", "CCC4")}
[/code]

[code]
'Sub TableRow(Field1 As String, Field2 As String, Field3 As String) As String
'	Dim sb As stringbuilder
'	sb.Initialize
'	sb.Append("[plain][Span MinWidth=33%x Alignment=center][/plain]").Append(Field1).Append("[plain][/span][/plain]")
'	sb.Append("[plain][Span MinWidth=33%x Alignment=center][/plain]").Append(Field2).Append("[plain][/span][/plain]")
'	sb.Append("[plain][Span MinWidth=33%x Alignment=center][/plain]").Append(Field3).Append("[plain][/span][/plain]")
'	Return sb.toString
'End Sub
[/code]


${TableRowX("[b]Column 1[/b]", "[b]Column 2[/b]", "[b]Column 3[/b]")}
${TableRowX("[b]1000[/b]", "AAA1", "CCC1")}
${TableRowX("[b]1001[/b]", "AAA2", "CCC2")}
${TableRowX("[b]1002[/b]", "AAA3", "CCC3")}
${TableRowX("[b]1003[/b]", "AAA4", "CCC4")}

______________________________________________________________

[a="Add any View (label, button, input, custom list, etc.)"][b]How To Add any View (label, button, input, custom list, etc.)[/b]   ([url=index]Back To Index [FontAwesome=0xF062/][/url])[/a]

Adding any view is a two step process:

Step 1: Register the view using BBCodeView1.Views.Put("btnName", btn)

Step 2: Use the view in BBCode

[plain]Lets add a [Color=#ff0000][b]button:[/b][/color] [View=btnName Vertical=15/] and more text here[/plain]

[indent=2]Lets add a [Color=#ff0000][b]button:[/b][/color] [View=btn Vertical=15/] and more text here[/indent]

Note 1:  The vertical offset can be used to center a view on a lie of text. Positive offsets are down.

Note 2:  If you add a view that can have focus, the BBCodeView automatically scrolls to the focussed view.
This may not be desirable.  To prevent this add BBCodeView1.mBase.RequestFocus after BBCodeView1.text = ...

______________________________________________________________

[a="Keep tags as plain Text"][b]How To Keep tags As plain Text[/b]   ([url=index]Back To Index [FontAwesome=0xF062/][/url])[/a]

Surround the text with [plain][plain][/plain] tags

______________________________________________________________

[a="Center Text Vertically on BBCodeView"][b]How To Center Text Vertically on BBCodeView[/b]   ([url=index]Back To Index [FontAwesome=0xF062/][/url])[/a]

This is not really to do with BBCodes but is a common enough requirement.

See this solution:

[indent=2][url=https://www.b4x.com/android/forum/threads/solved-center-vertically-text-in-bbcodeview.113470/post-708069]Center Text Vertically[/url][/indent]

______________________________________________________________

[a="Right To Left Languages"][b]Right To Left Languages[/b]   ([url=index]Back To Index [FontAwesome=0xF062/][/url])[/a]

Version 1.93 of BCTextEngine requires B4A 11.0+, B4i 7.5+ or B4J 9.1+

Make sure to set BBCodeView1.RTL = True

See this:

[indent=2][url=https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-779309]Hebrew[/url][/indent]

And 
	
[indent=2][url=https://www.b4x.com/android/forum/threads/b4x-bctextengine-bbcodeview-text-engine-bbcode-parser-rich-text-view.106207/post-905713]Arabic[/url][/indent]


______________________________________________________________

[a="How to Control Line Spacing"][b]How To Control Line Spacing[/b]   ([url=index]Back To Index [FontAwesome=0xF062/][/url])[/a]

BBCodeView does not have fixed line spacing by design. 
One reason is that when a View is inserted or a word/phrase in the line is enlarged, the line spacing has to reflect that.
So in order to have a paragraph with consistent line spacing, we have to make sure all lines will fit our line spacing specification.
It is also important to remember that some letters are taller (capitals and accented letters) and some have tails (like y and g).

You have to experiment a bit.  What works most of the time for me is:

[code]
'Dim fs As Int = 35      'or whatever your font size of the paragraph is
'Textengine1.SpaceBetweenLines = 1.95 * cv.MeasureText("X", xui.CreateDefaultFont(fs)).Height
[/code]

______________________________________________________________

[a="How to Control Wordwrap and Chinese/Korean/Japanese"][b]How to Control Wordwrap and Chinese/Korean/Japanese[/b]   ([url=index]Back To Index [FontAwesome=0xF062/][/url])[/a]

We want to specify which characters are valid word separators for breaking a line into parts without breaking up words.
For example the ")" character should not go on the next line.

There are two parameters that are related to wordwrap.

[indent=2]TextEngine1.WordBoundaries = "&+-/<\' .,:{(" & TAB & CRLF & Chr(13)[/indent]
	
	AND
	
[indent=2]TextEngine1.WordBoundariesThatCanConnectToPrevWord = ".,:"[/indent]


Each character in Chinese/Korean/Japanese should be considered a word.
Therefore to work properly, all unique characters (including punctuation) used in the text should be added to the WordBoundaries list.

[indent=2]TextEngine.WordBoundaries="我和我的祖国。"[/indent]
	
	AND
	
[indent=2]TextEngine1.WordBoundariesThatCanConnectToPrevWord = ""[/indent]
	
[indent=2]BBCodeView1.Text="我和我的祖国China。"[/indent]

See:

[indent=2][url=https://www.b4x.com/android/forum/threads/bbcodeview-does-not-wrap-chinese-well.132673/post-837714]Solution by @xulihang[/url][/indent]

	"$

	'The above smart string needs some preprocessing to be valid BBCode.
	'To make the above more readable, I separated most lines in a paragraph by a single line feed (they need to be reconnected)
	'A double line feed indicates a new paragraph - but sometimes that empty line is not wanted - for example [List]
	'B4X BBCodeView does not have [code] tags and smart strings do not like some B4X code (for example End Sub).
	'By adding [code] tags in above and prefixing each code line with ' solves this problem.
	
	Dim sb As StringBuilder:
	sb.Initialize
	Dim inList As Boolean
	Dim inCode As Boolean
	For Each t As String In Regex.Split(CRLF, s)
		t = t.trim
		If t.toLowerCase = "[code]" Then
			inCode = True
			Continue
		Else If t.toLowerCase = "[/code]" Then 
			inCode = False
			Continue
		End If
		If t.toLowerCase = "[list]" Then
			If sb.Length > 1 Then sb.Remove(sb.Length - 1, sb.Length)
			inList = True
		Else If t.toLowerCase = "[/list]" Then 
			inList = False
		End If
		If inCode Then 
			sb.Append(TAB).Append(t.SubString(1)).Append(CRLF)
		Else If inList Then
			sb.Append(t).Append(CRLF)
		Else
			If t = "" Then sb.Append(CRLF).Append(CRLF) Else sb.Append(t).Append(" ")
		End If
	Next
	Return sb.tostring
End Sub

Private Sub BBCodeView1_LinkClicked (URL As String)
	If URL.StartsWith("https:") Then
#if b4j		
		fx.ShowExternalDocument(URL)
#else if b4a
		Dim p As PhoneIntents
		StartActivity(p.OpenBrowser(URL))
#end if
	Else if URL.StartsWith("alink") Then
		xui.MsgboxAsync("You clicked a URL", "Info")
	Else
		BBCodeView1.ScrollToAnchor(URL)
	End If
End Sub

Sub TableRow(Field1 As String, Field2 As String, Field3 As String) As String
	Dim prefix As String = "$" & "{TableRow("
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("[plain]")
	sb.Append(prefix)
	sb.Append(Field1.Replace("[plain]", "").Replace("[/plain]", "")).Append(", ")
	sb.Append(Field2.Replace("[plain]", "").Replace("[/plain]", "")).Append(", ")
	sb.Append(Field3.Replace("[plain]", "").Replace("[/plain]", ""))
	sb.Append(")}").Append("[/plain]")
	Return sb.toString
End Sub

Sub TableRowX(Field1 As String, Field2 As String, Field3 As String) As String
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("[Span MinWidth=33%x Alignment=center]").Append(Field1).Append("[/span]")
	sb.Append("[Span MinWidth=33%x Alignment=center]").Append(Field2).Append("[/span]")
	sb.Append("[Span MinWidth=33%x Alignment=center]").Append(Field3).Append("[/span]")
	Return sb.toString
End Sub

Sub btn_click
	xui.MsgboxAsync("You clicked a button", "Info")
End Sub