Type=Class
Version=1.8
B4J=true
@EndOfDesignText@
'Class module
Sub Class_Globals
	Type TreeItem (Children As List, Text As String)
	Private resMap As Map
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	resp.ContentType = "application/json"
	resMap.Initialize
	Try
		Dim data() As Byte = Bit.InputStreamToBytes(req.InputStream)
		Dim text As String = BytesToString(data, 0, data.Length, "UTF8")
		Dim parser As JSONParser
		parser.Initialize(text)
		Dim squareBracketFound As Boolean
		'check whether we need to call NextArray or NextObject
		For i = 0 To text.Length
			If text.CharAt(i) = "[" Then
				squareBracketFound = True
				Exit
			Else If text.CharAt(i) = "{" Then
				Exit
			End If
		Next
		Dim code As StringBuilder
		code.Initialize
		code.Append("Dim parser As JSONParser").Append(" <br/>")
		code.Append("parser.Initialize(").Append(EscapeXml("<text>)")).Append(")").Append(" <br/>")
		code.Append("Dim root As ")
		Dim root As TreeItem = CreateTreeItem ("")
		If squareBracketFound Then
			code.Append("List = parser.NextArray").Append(" <br/>")
			BuildTree(parser.NextArray, root, code, "root", "", False, "")
		Else
			code.Append("Map = parser.NextObject").Append(" <br/>")
			BuildTree(parser.NextObject, root, code, "root", "", False, "")
		End If
		Dim sb As StringBuilder
		sb.Initialize
		ConvertTreeToHtml(sb, root, True)
		resMap.Put("tree", sb.ToString)
		resMap.Put("success", True)
		resMap.Put("code", code.ToString)
	Catch
		resMap.Put("success", False)
		resMap.Put("error", "Error parsing string:" & CRLF & LastException.Message)
	End Try
	Dim jg As JSONGenerator
	jg.Initialize(resMap)
	resp.Write(jg.ToString)
End Sub

Sub BuildTree(element As Object, parent As TreeItem, code As StringBuilder, _
		parentName As String, GetFromMap As String, BuildList As Boolean, indent As String)
	code.Append(indent)
	If element Is Map Then
		indent = WriteCodeHelper("Map", code, parentName, GetFromMap, BuildList, indent)
		Dim m As Map = element
		For Each k As String In m.Keys
			Dim ti As TreeItem = CreateTreeItem(k)
			parent.Children.Add(ti)
			BuildTree(m.Get(k), ti, code, k, parentName & ".Get(""" & k & """)", False, indent)
		Next
	Else If element Is List Then
		indent = WriteCodeHelper("List", code, parentName, GetFromMap, BuildList, indent)
		Dim l As List = element
		Dim index As Int = 0
		For Each e As Object In l
			Dim ti As TreeItem = CreateTreeItem(index)
			parent.Children.Add(ti)
			Dim stubCode As StringBuilder
			'only write the code for the first item
			If index = 0 Then stubCode = code Else stubCode.Initialize
			BuildTree(e, ti, stubCode, "col" & parentName ,"", index = 0, indent)
			index = index + 1
		Next
	Else
		Dim objectType As String
		If element Is Int Then
			objectType = "Int"
		Else If element Is Double Then
			objectType = "Double"
		Else
			objectType = "String"
		End If
		indent = WriteCodeHelper(objectType, code, parentName, GetFromMap, BuildList, indent)
		parent.Text = parent.Text & ": " & element
	End If
	If BuildList Then
		code.Append(indent.SubString(6)).Append("Next").Append(" <br/>")
	End If
End Sub

Sub WriteCodeHelper (ObjectType As String, code As StringBuilder, _
	parentName As String, GetFromMap As String, BuildList As Boolean, indent As String) As String
	
	If GetFromMap.Length > 0 Then
		code.Append("Dim " & parentName & " As " & ObjectType & " = " & GetFromMap).Append(" <br/>")
	Else If BuildList Then
		code.Append("For Each " & parentName & " As " & ObjectType & " In " & parentName.SubString(3)).Append(" <br/>")
		indent = indent & "&emsp;"
	End If
	Return indent
End Sub

Private Sub ConvertTreeToHtml(sb As StringBuilder, parent As TreeItem, isRoot As Boolean)
	If isRoot = False Then sb.Append("<li>").Append(EscapeXml(parent.Text))
	If parent.Children.Size > 0 Then
		sb.Append("<ul>")
		For Each ti As TreeItem In parent.Children
			sb.Append(CRLF)
			ConvertTreeToHtml(sb, ti, False)
		Next
		sb.Append("</ul>")
	End If
	If isRoot = False Then sb.Append("</li>")
End Sub
Private Sub CreateTreeItem (text As String) As TreeItem
	Dim ti As TreeItem
	ti.Initialize
	ti.Children.Initialize
	ti.text = text
	Return ti
End Sub
Private Sub EscapeXml(Raw As String) As String
   Dim sb As StringBuilder
   sb.Initialize
   For i = 0 To Raw.Length - 1
     Dim C As Char = Raw.CharAt(i)
     Select C
       Case QUOTE
         sb.Append("&quot;")
       Case "'"
         sb.Append("&apos;")
       Case "<"
         sb.Append("&lt;")
       Case ">"
         sb.Append("&gt;")
       Case "&"
         sb.Append("&amp;")
       Case Else
         sb.Append(C)
     End Select
   Next
   Return sb.ToString
End Sub
