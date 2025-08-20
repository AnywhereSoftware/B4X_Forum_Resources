B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@
Sub Class_Globals
	Type HtmlNode (Name As String, Children As List, Attributes As List, Closed As Boolean, Parent As HtmlNode)	
	Type HtmlAttribute (Key As String, Value As String)
	Private Index As Int
	Private mHtml As String
	Private WhiteSpace As String = " " & TAB & Chr(10) & Chr(13)
	Private VoidTags As B4XSet
	Public NoNode As HtmlNode
	Public EscapedEntitiesMap As Map
End Sub

Public Sub Initialize
	VoidTags = B4XCollections.CreateSet2(Array("!DOCTYPE", "area", "base", "br", "col", _
		"embed", "hr", "img", "input", "link", "meta", "param", "source", "track", "wbr"))
	EscapedEntitiesMap = CreateMap("quot": $"""$, "amp": "&", "apos": "'", "lt": "<", "gt": ">", _
		"nbsp": " ")
End Sub

Public Sub Parse (Html As String) As HtmlNode
	Index = 0
	mHtml = Html
	Dim root As HtmlNode = CreateHtmlNode("root", NoNode)
	ParseImpl(root)
	Return root
End Sub

Private Sub ParseImpl (Parent As HtmlNode)
	Do While Index < mHtml.Length
		Dim WhiteSpaceIgnored As Boolean = IgnoreWhiteSpace
		If Index >= mHtml.Length Then Exit
		Dim c As String = GetNextChar
		If c = "<" Then
			If PeekNextChar = "/" Then
				CloseElement(Parent)
				If IsRoot(Parent) = False Then Return
			Else
				If WhiteSpaceIgnored Then
					Dim TextNode As HtmlNode = CreateHtmlNode("text", Parent)
					TextNode.Attributes.Add(CreateHtmlAttribute("value", " "))
					Parent.Children.Add(TextNode)
				End If
				Parent.Children.Add(ParseTagStart(Parent))
				If Parent.Closed And IsRoot(Parent) = False Then Return
			End If
		Else
			
			Parent.Children.Add(CreateTextNode(Parent, WhiteSpaceIgnored))
		End If
	Loop
End Sub

Public Sub IsRoot(n As HtmlNode) As Boolean
	Return n.Parent.IsInitialized = False
End Sub

Private Sub CloseElement (Parent As HtmlNode)
	Dim start As Int = Index + 1
	ReadUntil(">")
	Dim name As String = mHtml.SubString2(start, Index - 1).Trim
	Parent.Closed = True
	If name <> Parent.Name Then
		Dim CorrectParent As HtmlNode
		Dim p As HtmlNode = Parent.Parent
		Do While p.IsInitialized
			If p.Name = name Then
				CorrectParent = p
				Exit
			End If
			p = p.Parent
		Loop
		If CorrectParent.IsInitialized Then
			CorrectParent.Closed = True
			Dim p As HtmlNode = Parent.Parent
			Do While p <> CorrectParent
				p.Closed = True
				p = p.Parent
			Loop
		End If
	End If
End Sub

Private Sub CreateTextNode (Parent As HtmlNode, AddSpaceAtBeginning As Boolean) As HtmlNode
	Dim TextNode As HtmlNode = CreateHtmlNode("text", Parent)
	Dim start As Int = Index - 1
	ReadUntil("<")
	If Index < mHtml.Length Then
		Index = Index - 1
	End If
	Dim value As String = mHtml.SubString2(start, Index)
	If AddSpaceAtBeginning Then value = " " & value
	TextNode.Attributes.Add(CreateHtmlAttribute("value", value))
	Return TextNode
End Sub

Private Sub ParseRawTextNode(n As HtmlNode)
	Dim start As Int = Index
	ReadUntil($"</${n.Name}>"$)
	n.Attributes.Add(CreateHtmlAttribute("value", mHtml.SubString2(start, Index - 1)))
	ReadUntil(">")
End Sub

Private Sub ReadUntil (s As String)
	Dim i As Int = mHtml.IndexOf2(s, Index)
	If i = -1 Then
'		Log("not found: " & s)
		Index = mHtml.Length
	Else
		Index = i + 1
	End If
End Sub

Private Sub IgnoreWhiteSpace As Boolean
	Dim ignored As Boolean
	Do While Index < mHtml.Length
		Dim c As String = GetNextChar
		If WhiteSpace.IndexOf(c) = -1 Then 
			Index = Index - 1
			Return ignored
		End If
		ignored = True
	Loop
	Return ignored
End Sub

Private Sub IsWhiteSpace (c As String) As Boolean
	Return WhiteSpace.IndexOf(c) > -1
End Sub

Private Sub PeekPrevChar (offset As Int) As String
	Return mHtml.CharAt(Index - offset)
End Sub

Private Sub PeekNextChar As String
	If Index >= mHtml.Length Then Return ""
	Return mHtml.CharAt(Index)
End Sub

Private Sub GetNextChar As String
	Dim c As String = mHtml.CharAt(Index)
	Index = Index + 1
	Return c
End Sub

Private Sub ParseTagStart (Parent As HtmlNode) As HtmlNode
	Dim sb As StringBuilder
	sb.Initialize
	Dim node As HtmlNode = CreateHtmlNode("", Parent)
	Do While True
		Dim c As String = GetNextChar
		If c = ">" Then
			If PeekPrevChar(2) = "/" Then
				sb.Remove(sb.Length - 1, sb.Length)
				node.Closed = True
			End If
			node.Name = sb.ToString
			Exit
		Else If IsWhiteSpace(c) Then
			node.Name = sb.ToString
			If node.Name = "!--" Then
				ParseComment (node)
			Else
				ParseAttributes(node)
			End If
			Exit
		Else
			sb.Append(c)
		End If
	Loop
	If VoidTags.Contains(node.Name) Then node.Closed = True
	If node.Closed = False Then
		If node.Name = "script" Or node.Name = "style" Then
			ParseRawTextNode(node)
		Else
			ParseImpl(node)
		End If
	End If
	Return node
End Sub

Private Sub ParseComment (n As HtmlNode)
	n.Closed = True
	n.Name = "comment"
	Dim start As Int = Index
	ReadUntil("-->")
	n.Attributes.Add(CreateHtmlAttribute("value", mHtml.SubString2(start, Index - 1)))
	ReadUntil(">")
End Sub

Private Sub ParseAttributes (Parent As HtmlNode)
	Dim start As Int = Index
	ReadUntil(">")
	Dim s As String = mHtml.SubString2(start, Index - 1)
	For Each EscapeChar As String In Array("'", $"""$)
		Dim m As Matcher = Regex.Matcher($"([a-zA-Z0-9-]+)\s*=\s*\${EscapeChar}([^${EscapeChar}]+)\${EscapeChar}"$, s)
		Do While m.Find
			Parent.Attributes.Add(CreateHtmlAttribute(m.Group(1), m.Group(2)))
		Loop
	Next
End Sub

Private Sub CreateHtmlNode (Name As String, Parent As HtmlNode) As HtmlNode
	Dim t1 As HtmlNode
	t1.Initialize
	t1.Name = Name
	t1.Children.Initialize
	t1.Attributes.Initialize
	t1.Parent = Parent
	Return t1
End Sub

Public Sub CreateHtmlAttribute (Key As String, Value As String) As HtmlAttribute
	Dim t1 As HtmlAttribute
	t1.Initialize
	t1.Key = Key
	t1.Value = Value
	Return t1
End Sub

Public Sub PrintNode (node As HtmlNode)
	PrintNodeHelper(node, "")
End Sub

Private Sub PrintNodeHelper (node As HtmlNode, Indent As String)
	Log($"${Indent}*** ${node.Name} ***"$)
	For Each attribute As HtmlAttribute In node.Attributes
		Log($"${Indent}|${attribute.Key}: ${attribute.Value}|"$)
	Next
	For Each child As HtmlNode In node.Children
		PrintNodeHelper(child, Indent & " ")
	Next
End Sub

'Finds a child node with the given tag name and optionally given attribute.
Public Sub FindNode (Root As HtmlNode, TagName As String, Attribute As HtmlAttribute) As HtmlNode
	If IsNodeMatches(Root, TagName, Attribute) Then
		Return Root
	End If
	For Each child As HtmlNode In Root.Children
		Dim res As HtmlNode = FindNode(child, TagName, Attribute)
		If res.IsInitialized Then Return res
	Next
	Return NoNode
End Sub

'Finds all direct child nodes with the given tag name and optionally given attribute.
Public Sub FindDirectNodes (Root As HtmlNode, TagName As String, Attribute As HtmlAttribute) As List
	Dim res As List
	res.Initialize
	For Each child As HtmlNode In Root.Children
		If IsNodeMatches(child, TagName, Attribute) Then
			res.Add(child)
		End If
	Next
	Return res
End Sub

'Tests whether TagName and optionally the attribute matches the node.
Public Sub IsNodeMatches(Node As HtmlNode, TagName As String, Attribute As HtmlAttribute) As Boolean
	If Node.Name = TagName Then
		If Attribute <> Null And Attribute.IsInitialized Then
			For Each At As HtmlAttribute In Node.Attributes
				If At.Key = Attribute.Key And At.Value = Attribute.Value Then
					Return True
				End If
			Next
		Else
			Return True
		End If
	End If
	Return False
End Sub


'Returns the text value from a node.
Public Sub GetTextFromNode (Node As HtmlNode, ChildIndex As Int) As String
	Dim tn As HtmlNode = Node.Children.Get(ChildIndex)
	Dim at As HtmlAttribute = tn.Attributes.Get(0)
	Return UnescapeEntities(at.Value)
End Sub

Public Sub GetAttributeValue(Node As HtmlNode, Key As String, DefaultValue As String) As String
	For Each at As HtmlAttribute In Node.Attributes
		If at.Key = Key Then Return at.Value
	Next
	Return DefaultValue
End Sub

'Unescapes the XML entities and another few popular HTML entities. You can add more entities to EscapedEntitiesMap.
Public Sub UnescapeEntities(Input As String) As String
	If Input.Contains("&") = False Then Return Input
	Dim sb As StringBuilder
	sb.Initialize
	Dim lastMatchEnd As Int = 0
	Dim m As Matcher = Regex.Matcher("&([a-z0-9]+|#[0-9]{1,6}|#x[0-9a-f]{1,6});", Input)
	Do While m.Find 
		Dim capture As String = m.Group(1)
		Dim currentStart As Int = m.GetStart(0)
		sb.Append(Input.SubString2(lastMatchEnd, currentStart))
		lastMatchEnd = m.GetEnd(0)
		If EscapedEntitiesMap.ContainsKey(capture) Then
			sb.Append(EscapedEntitiesMap.Get(m.Group(1)))
		Else if capture.StartsWith("#x") Then
			sb.Append(Chr(Bit.ParseInt(capture.SubString(2), 16)))	
		Else if capture.StartsWith("#") Then
			sb.Append(Chr(capture.SubString(1)))
		Else
			Log("Missing entity: " & m.Group(1))
		End If
	Loop
	If lastMatchEnd < Input.Length Then sb.Append(Input.SubString(lastMatchEnd))
	Return sb.ToString
End Sub

