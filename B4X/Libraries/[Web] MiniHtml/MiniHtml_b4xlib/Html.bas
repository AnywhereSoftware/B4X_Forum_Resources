B4J=true
Group=Modules
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@

Private Sub Process_Globals
	Private Const tagname As String = "html"
End Sub

Public Sub init As Tag
	Return create(tagname)
End Sub

Public Sub create (newtag As String) As Tag
	Dim tag1 As Tag
	tag1.Initialize(newtag)
	Return tag1
End Sub

Public Sub attr (key As String, value As String) As Tag
	Return init.attr(key, value)
End Sub

Public Sub attr2 (keyvals As Map) As Tag
	Return init.attr2(keyvals)
End Sub

'code: <code>Html.lang("en")</code>
Public Sub lang (value As String) As Tag
	Return init.attr("lang", value)
End Sub

' Add comment on new line
Public Sub comment (value As String) As Tag
	Return create("").comment(value)
End Sub

' Add comment on same line
Public Sub comment2 (value As String) As Tag
	Return create("").comment2(value)
End Sub

Public Sub ConvertToTag (node1 As HtmlNode) As Tag
    Dim parent As Tag
    parent.Initialize(node1.Name)
    
    ' Handle class and style attributes first
	Dim parser As MiniHtmlParser
	parser.Initialize
    Dim class1 As String = parser.GetAttributeValue(node1, "class", "")
    Dim style1 As String = parser.GetAttributeValue(node1, "style", "")
    If class1 <> "" Then parent.addClass(class1)
    If style1 <> "" Then parent.addStyle(style1)

    For Each att As HtmlAttribute In node1.Attributes
        ' Skip class and style as we already handled them
        If att.Key = "class" Or att.Key = "style" Then Continue
        If att.Key = "value" And att.Value.Trim.Length > 0 Then
            If node1.Name = "input" Or node1.Name = "option" Then
                parent.attr(att.Key, att.Value.Trim)
            Else
                If att.Value.Trim.Length > 0 Then
                    parent.Text(att.Value.Trim)
                End If
            End If
        Else
            ' Handle boolean attributes (where key = value)
            If att.Key = att.Value Then
                parent.attr3(att.Key) ' boolean attribute
            Else
                parent.attr(att.Key, att.Value) ' regular attribute
            End If
        End If
    Next
    
    For Each child As HtmlNode In node1.Children
        Dim tag2 As Tag = ConvertToTag(child)
        If tag2.TagName = "text" Then
            If tag2.Attributes.ContainsKey("value") Then
                ' ignore text nodes with "value" attribute
            Else
                parent.add(tag2)
            End If
        Else
            parent.add(tag2)
        End If
    Next
    Return parent
End Sub

Public Sub Parse (HtmlText As String) As Tag
	Dim root1 As Tag
	Dim parser As MiniHtmlParser
	parser.Initialize
	Dim node1 As HtmlNode = parser.Parse(HtmlText)
	If node1.Children.Size = 1 Then
		root1 = ConvertToTag(node1.Children.Get(0))
	End If
	Return root1
End Sub