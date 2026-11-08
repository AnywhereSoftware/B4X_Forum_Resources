B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Public XWPFDocument As JavaObject
	Private mWU As WordUtils 'ignore
	Private AllowedTags As B4XSet
	Private Stack As List
	Private Start As Int
	Public ErrorString As StringBuilder
	Type WordTagNode (Tag As String, Extra As Map, CanHaveNestedTags As Boolean)
	Type WordTextNode (Text As String, Tags As List)
	Type WordDocElement(Tag As String, Extra As Map, Children As List, JElement As JavaObject)
	Private ColorsMap As Map
	Private HighlightColorsMap As Map
	Public DebugLog As Boolean
	Private jme As JavaObject
End Sub

'Don't use. Call WordUtils.CreateDocument instead.
Public Sub Initialize (wu As WordUtils, Document As JavaObject)
	mWU = wu
	XWPFDocument = Document
	AllowedTags = B4XCollections.CreateSet2(Array("p", "b", "u", "embossed", "shadow", "plain", "color", "font", "textsize", "break", _
		"i", "strike", "img", "indentationleft", "header", "footer", "table", "row", "cell", "highlight", "url", "bookmark", "fieldcode"))
	ColorsMap = CreateMap("black": 0xFF000000, _
		"darkgray": 0xFF444444, _
		"gray": 0xFFCCCCCC, _
		"white": 0xFFFFFFFF, _
		"red": 0xFFFF0000, _
		"green": 0xFF00FF00, _
		"blue": 0xFF0000FF, _
		"yellow": 0xFFFFFF00, _
		"cyan": 0xFF00FFFF, _
		"darkblue": 0xFF000080, _
		"darkcyan": 0xFF008080, _
		"darkgreen": 0xFF008000, _
		"darkmagenta": 0xFF800080, _
		"darkred": 0xff800000, _
		"darkyellow": 0xff808000, _
		"magenta": 0xFFFF00FF)
	HighlightColorsMap = CreateMap("black": "black", _
		"blue": "blue", _
		"cyan": "cyan", _
		"green": "green", _
		"magenta": "magenta", _
		"red": "red", _
		"yellow": "yellow", _
		"white": "white", _
		"darkblue": "darkBlue", _
		"darkcyan": "darkCyan", _
		"darkgreen": "darkGreen", _
		"darkmagenta": "darkMagenta", _
		"darkred": "darkRed", _
		"darkyellow": "darkYellow", _
		"darkgray": "darkGray", _
		"gray": "lightGray")
	jme = Me
End Sub


Public Sub Append(BBText As String) As WordDocument
	Dim doc As WordDocElement = Parse(BBText)
	HandleElements(doc)
	Return Me
End Sub

Private Sub HandleElements(Parent As WordDocElement)
	For index = 0 To Parent.Children.Size - 1
		Dim child As WordDocElement = Parent.Children.Get(index)
		If DebugLog Then
			Log("Tag: " & child.Tag)
		End If
		Select child.Tag
			Case "p"
				Dim par As JavaObject
				Select Parent.Tag
					Case "doc"
						par = XWPFDocument.RunMethod("createParagraph", Null)
					Case "header", "footer"
						par = Parent.JElement.RunMethod("createParagraph", Null)
					Case "cell"
						If index = 0 Then
							Dim paragraphs As List
							paragraphs.Initialize
							Dim j As JavaObject = paragraphs
							j.RunMethod("addAll", Array(Parent.JElement.RunMethodJO("getParagraphs", Null)))
							If paragraphs.Size > 0 Then
								par = paragraphs.Get(0)
							End If
						End If
						If par.IsInitialized = False Then
							par = Parent.JElement.RunMethod("addParagraph", Null)
						End If
				End Select
				ConfigureParagraph(par, child)
				For Each node As WordTextNode In child.Children
					TextToRuns(par, node)
				Next
			Case "header"
				child.JElement = XWPFDocument.RunMethod("createHeader", Array("DEFAULT"))
				HandleElements(child)
			Case "footer"
				child.JElement = XWPFDocument.RunMethod("createFooter", Array("DEFAULT"))
				HandleElements(child)
			Case "table"
				Dim rows As Int = child.Extra.Get("rows")
				Dim cols As Int = child.Extra.Get("cols")
				child.JElement = XWPFDocument.RunMethod("createTable", Array(rows, cols))
				If child.Extra.ContainsKey("alignment") Then
					Dim alignment As String = ToUpper(child.Extra.Get("alignment"))
					'seems to be a bug in POI.
					Dim fixedMap As Map = CreateMap("LEFT": "RIGHT", "CENTER": "LEFT", "RIGHT": "CENTER")
					child.JElement.RunMethod("setTableAlignment", Array(fixedMap.Get(alignment)))
				End If
				HandleElements(child)
			Case "row"
				child.JElement = Parent.JElement.RunMethod("getRow", Array(index))
				If child.Extra.ContainsKey("height") Then child.JElement.RunMethod("setHeight", Array(To20thsPoint(child.Extra.Get("height"), False)))
				If child.Extra.ContainsKey("repeatheader") Then
					Dim rh As String = child.Extra.Get("repeatheader")
					child.JElement.RunMethod("setRepeatHeader", Array(rh.ToLowerCase = "true"))
				End If
				HandleElements(child)
			Case "cell"
				Dim CellOffset As Int = index + child.Extra.GetDefault("offset", 0)
				child.JElement = Parent.JElement.RunMethod("getCell", Array(CellOffset))
				If child.Extra.ContainsKey("color") Then child.JElement.RunMethod("setColor", Array(ParseColorString(child.Extra.Get("color"))))
				If child.Extra.ContainsKey("verticalalignment") Then child.JElement.RunMethod("setVerticalAlignment", Array(ToUpper(child.Extra.Get("verticalalignment"))))
				If child.Extra.ContainsKey("width") Then child.JElement.RunMethod("setWidth", Array(To20thsPoint(child.Extra.Get("width"), True)))
				If child.Extra.ContainsKey("colspan") Then
					Dim ColSpan As Int = child.Extra.Get("colspan")
					jme.RunMethod("MergeCellsHorizontal", Array(Parent.JElement, child.JElement, index, index + ColSpan - 1))
				End If
				If child.Extra.ContainsKey("rowspan") Then
					Dim RowSpan As Int = child.Extra.Get("rowspan")
					jme.RunMethod("MergeCellsVertical", Array(Parent.JElement, index, RowSpan))
				End If
				HandleElements(child)
		End Select
	Next
End Sub


Private Sub ToUpper(s As String) As String
	Return s.ToUpperCase
End Sub



Private Sub To20thsPoint(Points As Double, ToString As Boolean) As Object
	Dim i As Int = Round(Points * 20)
	If ToString Then
		Dim s As String = i
		Return s
	Else
		Return i
	End If
End Sub



'Saves a copy of the document. Returns the saved file name.
'RenameIfNeeded - If true the file will automatically be renamed if saving fails.
Public Sub SaveAs (Dir As String, FileName As String, RenameIfNeeded As Boolean) As String
	If RenameIfNeeded Then
		Dim orig As String = File.Combine(Dir, FileName)
		Dim extension As String
		Dim i As Int = orig.LastIndexOf(".")
		If i >-1 Then
			extension = orig.SubString(i)
			orig = orig.SubString2(0, i)
		End If
		For i = 0 To 10
			Dim f As String
			Try
				If i = 0 Then f = orig & extension Else f = orig & " (" & i & ")" & extension
				Dim out As OutputStream = File.OpenOutput(f, "", False)
				XWPFDocument.RunMethod("write", Array(out))
				out.Close
				Return f
			Catch
				Log("Failed: " & f)
			End Try
		Next
	End If
	Dim out As OutputStream = File.OpenOutput(Dir, FileName ,False)
	XWPFDocument.RunMethod("write", Array(out))
	out.Close
	Return File.Combine(Dir, FileName)
End Sub

Private Sub Parse (Text As String) As WordDocElement
	ErrorString.Initialize
	Dim ParsedElements As List
	ParsedElements.Initialize
	Stack.Initialize
	Stack.Add(CreateTagNode("noop"))
	Text = Text.Replace(CRLF, "[break/]")
	Dim matcher As Matcher = Regex.Matcher("(?<!\[)\[[^\[\]]+\]", Text)
	Dim LastMatchEnd As Int = 0
	Dim skipUntilEndTag As Boolean = False
	Do While matcher.Find
		Start = matcher.GetStart(0)
		If Start > LastMatchEnd And skipUntilEndTag = False Then
			ParsedElements.Add(CreateTextNode(Text.SubString2(LastMatchEnd, Start)))
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
					ParsedElements.Add(CreateTextNode(Text.SubString2(LastMatchEnd, Start)))
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
			Dim t As WordTagNode = ParseTag(tag)
			If AllowedTags.Contains(t.Tag) = False Then
				Error("Invalid tag: " & tag)
				Return Null
			End If
			StackPush(t)
			If t.Tag = "plain" Or t.Tag = "url" Then
				Dim n As WordTagNode = StackPeek
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
	If Text.Length > LastMatchEnd Then
		ParsedElements.Add(CreateTextNode(Text.SubString2(LastMatchEnd, Text.Length)))
	End If
	Return OrganizeElements( ParsedElements)
End Sub

Private Sub OrganizeElements (Nodes As List) As WordDocElement
	RemoveInvalidNodes(Nodes)
	Dim doc As WordDocElement = CreateWordDocElement("doc", CreateMap())
	Dim Elements As Map
	Elements.Initialize
	For Each node As WordTextNode In Nodes
		Dim CurrentElement As WordDocElement = doc
		For Each tag As WordTagNode In node.Tags
			If tag.Tag = "noop" Then Continue
			If Elements.ContainsKey(tag) Then
				CurrentElement = Elements.Get(tag)
			Else
				
				Dim NewElement As WordDocElement = CreateWordDocElement(tag.Tag, tag.Extra)
				CurrentElement.Children.Add(NewElement)
				Elements.Put(tag, NewElement)
				CurrentElement = NewElement
			End If
			If tag.Tag = "p" Then
				CurrentElement.Children.Add(node)
				Exit
			End If
		Next
	Next
	Return doc
End Sub

Private Sub RemoveInvalidNodes (Nodes As List)
	Dim ParagraphIndices() As Int = Array As Int(1, 2, 4)
	For i = Nodes.Size - 1 To 0 Step -1
		Dim n As WordTextNode = Nodes.Get(i)
		Dim valid As Boolean
		For Each p As Int In ParagraphIndices
			If n.Tags.Size > p Then
				Dim t As WordTagNode = n.Tags.Get(p)
				If t.Tag = "p" Then
					valid = True
					Exit
				End If
			End If
		Next
		If valid = False Then Nodes.RemoveAt(i)
	Next
End Sub



Private Sub ParseTag (tag As String) As WordTagNode
	'[URL]
	'[URL=sdfsdf] or [URL="sdfsdf"]
	'[URL key1="value 1" key2=34]
	If tag.Contains("=") = False Then Return CreateTagNode(tag.ToLowerCase)
	Dim res As WordTagNode = CreateTagNode("")
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

Private Sub StackPush (Tag As WordTagNode)
	Stack.Add(Tag)
End Sub

Private Sub StackPeek As WordTagNode
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

Private Sub CreateTextNode(Text As String) As WordTextNode
	Dim n As WordTextNode
	n.Initialize
	n.Text = Text
	n.Tags.Initialize
	n.Tags.AddAll(Stack)
	Return n
End Sub


Private Sub CreateTagNode (Tag As String) As WordTagNode
	Dim n As WordTagNode
	n.Initialize
	n.Tag = Tag
	n.CanHaveNestedTags = True
	Return n
End Sub

Private Sub ConfigureParagraph (Paragraph As JavaObject, Element As WordDocElement)
	Dim props As Map = Element.Extra
	Dim Alignment As String = props.GetDefault("alignment", "START")
	Paragraph.RunMethod("setAlignment", Array(Alignment.ToUpperCase))
	Dim indentationLeft As Int = props.GetDefault("indentationleft", 0)
	If GetBoolean(props.GetDefault("pagebreak", False)) = True Then
		Paragraph.RunMethod("setPageBreak", Array(True))
	End If
	If indentationLeft <> 0 Then Paragraph.RunMethod("setIndentationLeft", Array(indentationLeft * 20))
	If props.ContainsKey("bidi") Then
		jme.RunMethod("setBidi", Array(Paragraph, props.Get("bidi").As(Boolean)))
	End If
End Sub

Private Sub GetBoolean(s As String) As Boolean
	Return s.ToLowerCase = "true"
End Sub

Private Sub TextToRuns (Paragraph As JavaObject, Text As WordTextNode)
	Dim Run As JavaObject
	Dim LastTag As WordTagNode = Text.Tags.Get(Text.Tags.Size - 1)
	If LastTag.Tag = "url" Then
		Dim url As String = LastTag.Extra.Get("url")
		If url.StartsWith("bookmark://") Then
			Run = jme.RunMethod("CreateHyperlinkRunToAnchor", Array(Paragraph, url.SubString("bookmark://".Length)))
		Else
			Run = Paragraph.RunMethod("createHyperlinkRun", Array(url))
		End If
	Else
		Run = Paragraph.RunMethod("createRun", Null)
	End If
	Run.RunMethod("setText", Array(Text.Text))
	For i = 2 To Text.Tags.Size - 1
		Dim tag As WordTagNode = Text.Tags.Get(i)
		Select tag.Tag
			Case "b"
				Run.RunMethod("setBold", Array(True))
			Case "break"
				Run.RunMethod("addBreak", Null)
			Case "i"
				Run.RunMethod("setItalic", Array(True))
			Case "u"
				Dim UnderlinePattern As String = "SINGLE"
				If tag.Extra.IsInitialized Then
					UnderlinePattern = tag.Extra.GetDefault("pattern", UnderlinePattern)
					If tag.Extra.ContainsKey("color") Then
						Run.RunMethod("setUnderlineColor", Array(ParseColorString(tag.Extra.Get("color"))))
					End If
				End If
				Run.RunMethod("setUnderline", Array(UnderlinePattern.ToUpperCase))
			Case "img"
				Dim Dir As String = tag.Extra.Get("dir")
				If Dir = "assets" Then Dir = File.DirAssets
				Dim FileName As String = tag.Extra.Get("filename")
				Dim width As Int = tag.Extra.Get("width") * 12700
				Dim height As Int = tag.Extra.Get("height") * 12700
				Dim b() As Byte = File.ReadBytes(Dir, FileName)
				Dim in As InputStream
				in.InitializeFromBytesArray(b, 0, b.Length)
				Dim PictureType As Int
				Dim f As String = Dir & FileName
				If f.ToLowerCase.EndsWith(".png") Then PictureType = 6 Else PictureType = 5 'jpeg
				Run.RunMethod("addPicture", Array(in, PictureType, FileName, width, height))
			Case "color"
				Run.RunMethod("setColor", Array(ParseColorString(tag.Extra.Get("color"))))
			Case "textsize"
				Dim size As Int = tag.Extra.Get("textsize")
				Run.RunMethod("setFontSize", Array(size))
			Case "embossed"
				Run.RunMethod("setEmbossed", Array(True))
			Case "shadow"
				Run.RunMethod("setShadow", Array(True))
			Case "strike"
				Run.RunMethod("setStrikeThrough", Array(True))
			Case "font"
				Run.RunMethod("setFontFamily", Array(tag.Extra.Get("font")))
			Case "highlight"
				Dim color As String = tag.Extra.Get("highlight")
				Dim hc As String = HighlightColorsMap.GetDefault(color.ToLowerCase, "")
				If hc = "" Then Error("Invalid highlight color: " & color)
				Run.RunMethod("setTextHighlightColor", Array(hc))
			Case "bookmark"
				jme.RunMethod("createBookmark", Array(Paragraph, tag.Extra.Get("bookmark")))
			Case "fieldcode"
				jme.RunMethod("addFldSimple", Array(Paragraph, tag.Extra.Get("fieldcode")))
		End Select
	Next
End Sub

Private Sub ParseColorString(clr As String) As String
	clr = clr.ToLowerCase
	If clr.StartsWith("#") Then
		Return clr.SubString(1)
	Else If clr.StartsWith("0x") Then
		Return clr.SubString(4)
	Else If ColorsMap.ContainsKey(clr) Then
		Dim i As Int = Bit.And(0x00ffffff, ColorsMap.Get(clr))
		Dim s As String = Bit.ToHexString(i)
		Do While s.Length < 6
			s = "0" & s
		Loop
		Return s
	Else
		Error("Invalid color value: " & clr)
		Return "000000"
	End If
End Sub


Private Sub CreateWordDocElement (Tag As String, Extra As Map) As WordDocElement
	Dim t1 As WordDocElement
	t1.Initialize
	t1.Tag = Tag
	If Extra.IsInitialized = False Then Extra.Initialize
	t1.Extra = Extra
	t1.Children.Initialize
	Return t1
End Sub

#if XL_FULL
Public Sub SetLandscapeOrientation
	jme.RunMethod("SetLandscape", Array(XWPFDocument))
	jme.RunMethod("SetPageSize", Array(XWPFDocument, 15840, 12240))
End Sub

'Sets the page margins, measured in twips (1440 twips = 1 inch).
Public Sub SetMargins(Left As Int, Right As Int, Top As Int, Bottom As Int, Header As Int, Footer As Int, Gutter As Int)
	jme.RunMethod("SetMargins", Array(XWPFDocument, Left, Right, Top, Bottom, Footer, Header, Gutter))
End Sub
#End If

#if Java
import org.openxmlformats.schemas.wordprocessingml.x2006.main.*;
import org.apache.poi.xwpf.usermodel.*;
import java.math.*;
int BookmarksId;
public void MergeCellsHorizontal (XWPFTableRow row, XWPFTableCell cell, int fromCol, int toCol) {
	CTTcPr tcPr = cell.getCTTc().getTcPr();
  	if (tcPr == null) 
		tcPr = cell.getCTTc().addNewTcPr();
  	if (tcPr.isSetGridSpan()) {
   		tcPr.getGridSpan().setVal(BigInteger.valueOf(toCol-fromCol+1));
  } else {
  	tcPr.addNewGridSpan().setVal(BigInteger.valueOf(toCol-fromCol+1));
  }
  for(int colIndex = toCol; colIndex > fromCol; colIndex--) {
   row.removeCell(colIndex);
  }
}

public void MergeCellsVertical(XWPFTableRow row, int col, int rowSpan) {
	XWPFTable table = row.getTable();
	int fromRow = table.getRows().indexOf(row);
	int toRow = fromRow + rowSpan - 1;
  for(int rowIndex = fromRow; rowIndex <= toRow; rowIndex++) {
   XWPFTableCell cell = table.getRow(rowIndex).getCell(col);
   CTVMerge vmerge = CTVMerge.Factory.newInstance();
   if(rowIndex == fromRow){
    // The first merged cell is set with RESTART merge value
    vmerge.setVal(STMerge.RESTART);
   } else {
    // Cells which join (merge) the first one, are set with CONTINUE
    vmerge.setVal(STMerge.CONTINUE);
    // and the content should be removed
    for (int i = cell.getParagraphs().size(); i > 0; i--) {
     cell.removeParagraph(0);
    }
    cell.addParagraph();
   }
   // Try getting the TcPr. Not simply setting an new one every time.
   CTTcPr tcPr = cell.getCTTc().getTcPr();
   if (tcPr == null) tcPr = cell.getCTTc().addNewTcPr();
   tcPr.setVMerge(vmerge);
  }
 }
 
 public void createBookmark(XWPFParagraph paragraph, String anchor) {
  CTBookmark bookmark = paragraph.getCTP().addNewBookmarkStart();
  bookmark.setName(anchor);
  bookmark.setId(BigInteger.valueOf(++BookmarksId));
  paragraph.getCTP().addNewBookmarkEnd().setId(BigInteger.valueOf(BookmarksId));
 }
 public XWPFHyperlinkRun CreateHyperlinkRunToAnchor(XWPFParagraph paragraph, String anchor) throws Exception {
  CTHyperlink cthyperLink=paragraph.getCTP().addNewHyperlink();
  cthyperLink.setAnchor(anchor);
  cthyperLink.addNewR();
  return new XWPFHyperlinkRun(
    cthyperLink,
    cthyperLink.getRArray(0),
    paragraph
   );
 }
 public void addFldSimple(XWPFParagraph paragraph, String fldValue) {
 	paragraph.getCTP().addNewFldSimple().setInstr(fldValue);
 }
 public void setBidi (XWPFParagraph paragraph, boolean value) {
 	CTP ctp = paragraph.getCTP();
  CTPPr ctppr;
  if ((ctppr = ctp.getPPr()) == null) ctppr = ctp.addNewPPr();
  ctppr.addNewBidi().setVal(value);
 }
 
#End If

#if XL_FULL
#if Java

 public void SetLandscape(XWPFDocument doc) {
 	CTPageSz pageSize = getPageSize(doc);
	pageSize.setOrient(STPageOrientation.LANDSCAPE);
 }
 public void SetPageSize(XWPFDocument doc, int width, int height) {
 	CTPageSz pageSize = getPageSize(doc);
	pageSize.setW(BigInteger.valueOf(width));
	pageSize.setH(BigInteger.valueOf(height));
 }
 private CTPageSz getPageSize(XWPFDocument doc) {
 	CTDocument1 document = doc.getDocument();
	CTBody body = document.getBody();
	if (!body.isSetSectPr())
	     body.addNewSectPr();
	CTSectPr section = body.getSectPr();
	if(!section.isSetPgSz()) {
	    section.addNewPgSz();
	}
	return section.getPgSz();
 }
 public void SetMargins(XWPFDocument document, int left, int right, int top, int bottom, int footer, int header, int gutter) {
   CTSectPr sectPr = document.getDocument().getBody().getSectPr();
  if (sectPr == null) sectPr = document.getDocument().getBody().addNewSectPr();
  CTPageMar pageMar = sectPr.getPgMar();
  if (pageMar == null) pageMar = sectPr.addNewPgMar();
	  pageMar.setLeft(BigInteger.valueOf(left)); 
	  pageMar.setRight(BigInteger.valueOf(right));
	  pageMar.setTop(BigInteger.valueOf(top));
	  pageMar.setBottom(BigInteger.valueOf(bottom));
	  pageMar.setFooter(BigInteger.valueOf(footer));
	  pageMar.setHeader(BigInteger.valueOf(header));
	  pageMar.setGutter(BigInteger.valueOf(gutter));
 }
#End If
#End If