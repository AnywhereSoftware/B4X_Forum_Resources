B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.7
@EndOfDesignText@
'version 1.00
#RaisesSynchronousEvents: Parse
Sub Class_Globals
	Private parser As SaxParser
	Type XmlElement (Name As String, Children As List, Text As String, Attributes As Map)
	Private elements As List
	Private mStripNamespaces As Boolean
End Sub

Public Sub Initialize
	parser.Initialize
End Sub

'Gets or sets whether to remove namespaces from keys and attributes. This property affects B4J and B4i.
'Namespaces are kept by default in B4J in both keys and attributes. 
'Namespaces are kept by default in B4i attributes.
'Namespaces are always removed in B4A.
'It is recommended to set this property to True.
Public Sub getStripNamespaces As Boolean
	Return mStripNamespaces
End Sub

Public Sub setStripNamespaces (b As Boolean)
	mStripNamespaces = b
End Sub

Public Sub Parse(XML As String) As Map
	Dim in As InputStream
	Dim b() As Byte = XML.GetBytes("UTF8")
	in.InitializeFromBytesArray(b, 0, b.Length)
	Return Parse2(in)
End Sub

Public Sub Parse2(Input As InputStream) As Map
	elements.Initialize
	elements.Add(CreateElement("stub"))
	parser.Parse(Input, "parser")
	Dim m As Map = ElementToObject(elements.Get(0))
	Return m
End Sub

Private Sub ElementToObject (Element As XmlElement) As Object
	If Element.Children.Size = 0 And Element.Attributes.IsInitialized = False Then Return Element.Text
	Dim m As Map
	m.Initialize
	If Element.Attributes.IsInitialized Then m.Put("Attributes", Element.Attributes)
	If Element.Children.Size = 0 Then m.Put("Text", Element.Text)
	For Each child As XmlElement In Element.Children
		Dim childObject As Object = ElementToObject(child)
		If m.ContainsKey(child.Name) Then
			Dim currentItem As Object = m.Get(child.Name)
			Dim list As List
			If currentItem Is List Then
				list = currentItem
			Else
				list.Initialize
				list.Add(currentItem)
				m.Put(child.Name, list)
			End If
			list.Add(childObject)
		Else
			m.Put(child.Name, childObject)
		End If
	Next
	Return m
End Sub

Private Sub CreateElement (Name As String) As XmlElement
	Dim xe As XmlElement
	xe.Initialize
	xe.Children.Initialize
	xe.Name = Name
	#if B4J
	If mStripNamespaces Then
		xe.Name = StripNamespace(Name)
	End If
	#End If
	Return xe
End Sub

	
#if B4i
Private Sub Parser_StartElement (Uri As String, Name As String, Attributes As Map)
#Else
Private Sub Parser_StartElement (Uri As String, Name As String, Attributes As Attributes)
#End If
	Dim Element As XmlElement = CreateElement(Name)
	If Attributes.IsInitialized And Attributes.Size > 0 Then
		Dim att As Map
		#if B4i
		If mStripNamespaces Then
			att.Initialize
			For Each key As String In Attributes.Keys
				Dim value As Object = Attributes.Get(key)
				att.Put(StripNamespace(key), value)
			Next
		Else
			att = Attributes
		End If
		#Else
		att.Initialize
		For i = 0 To Attributes.Size - 1
			Dim key As String = Attributes.GetName(i)
			If mStripNamespaces Then key = StripNamespace(key)
			att.Put(key, Attributes.GetValue(i))
		Next
		#End If
		Element.Attributes = att
	End If
	GetLastElement.Children.Add(Element)
	elements.Add(Element)
End Sub

Private Sub StripNamespace(s As String) As String
	#if b4a
	Return s
	#Else
	Dim i As Int = s.IndexOf(":")
	If i > -1 Then
		Return s.SubString(i + 1)
	Else
		Return s
	End If
	#End If
End Sub

Private Sub GetLastElement As XmlElement
	Return elements.Get(elements.Size - 1)
End Sub

Private Sub Parser_EndElement (Uri As String, Name As String, Text As StringBuilder)
	Dim Element As XmlElement = GetLastElement
	Element.Text = Text.ToString
	elements.RemoveAt(elements.Size - 1)
End Sub