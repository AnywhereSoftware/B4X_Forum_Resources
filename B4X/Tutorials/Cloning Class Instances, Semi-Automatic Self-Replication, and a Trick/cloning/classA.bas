B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private xui As XUI
	Private ser As B4XSerializator

	'Properties	and variables for cloning
	Private mNames() As String
	Private mAge, mHeight As Int
	Private mChildren As List
	Private mBox As B4XView
	Public OnState As Boolean
	Private i = 0, j = 2, k = 5 As Int												'ignore
	Private txt = "test" As String, value = 1.05 As Double, flag = False As Boolean 'ignore
	
	'Smart string version
	Private propsToClone As String = $"
	Private mNames() As String
	Private mAge, mHeight As Int
	Private mChildren As List
	Private mBox As B4XView
	Public OnState As Boolean
	Private i = 0, j = 2, k = 5 As Int												'ignore
	Private txt = "test" As String, value = 1.05 As Double, flag = False As Boolean 'ignore
	"$
End Sub

Public Sub Initialize(FirstName As String, LastName As String)
	mChildren.Initialize
	mNames = Array As String(FirstName, LastName)
	OnState = True
End Sub

Public Sub Clone As classA
	CloningCodeToClipboard	'The Smart string version is parsed and code is generated and placed on clipboard.
	Dim newInstance As classA
	newInstance.Initialize(mNames(0), mNames(1))
	
	'After 1st attempt at cloning, paste clipboard contents below. 
	'_____________________________
	newInstance.mNames = copyStringArray(mNames)
	newInstance.mAge = mAge
	newInstance.mHeight = mHeight
	newInstance.mChildren = copyStructure(mChildren)
	newInstance.mBox = copyPanel(mBox)
	newInstance.OnState = OnState
	newInstance.i = i
	newInstance.j = j
	newInstance.k = k
	newInstance.txt = txt
	newInstance.value = value
	newInstance.flag = flag
	'_____________________________

	Return newInstance
End Sub

#Region Getters and Setters

Public Sub setNames(ar() As String)
	mNames = ar
End Sub

Public Sub setAge(age_ As Int)
	mAge = age_
End Sub

Public Sub setHeight(height_ As Int)
	mHeight = height_
End Sub

Public Sub AddChild(name_ As String)
	mChildren.add(name_)
End Sub

Public Sub MakeBox
	mBox = xui.createPanel("")
	mBox.Color = xui.Color_Blue
	mBox.SetLayoutAnimated(0, 50, 100, 300, 25)
	mBox.Tag = "X"
End Sub

Public Sub getNames As String()
	Return mNames
End Sub

Public Sub getAge As Int
	Return mAge
End Sub

Public Sub getHeight As Int
	Return mHeight
End Sub

Public Sub getBox As B4XView
	Return mBox
End Sub

Public Sub getChildren As List
	Return mChildren
End Sub

#End Region

#Region Cloning Helpers

'This simple parser is effective for single line declarative expressions
'It can't handle multiline statements separated by : since it can't distinguish between : and ":" in a declarative String assignment
'It is uncommon to see such multiline statements Class_Globals. To handle this it would need to track quoted strings.
'This is possible, but would make the parser a lot more (and unecessarily) complicated.
'Solution: Separate the multiline : statements after pasting in the propsToClone smart string. 
Private Sub CloningCodeToClipboard
	If propsToClone.Length = 0 Then Return
	propsToClone = propsToClone.Replace(TAB, " ")
	Do While propsToClone.Contains(" " & CRLF)
		propsToClone = propsToClone.Replace(" " & CRLF, CRLF)
	Loop
	propsToClone = propsToClone.Replace("_" & CRLF, " ")
	Dim result As StringBuilder
	result.Initialize
	Dim lines() As String = Regex.Split(CRLF, propsToClone)
	For Each line As String In lines
		line = line.Replace(" as ", " As ").replace(" AS ", " As ")
		Do While line.Contains("  ")
			line = line.replace("  ", " ")
		Loop
		line = line.trim
		If line.Length = 0 Then Continue
		If line.StartsWith("'") Then Continue
		Dim commentIndex As Int = line.LastIndexOf("'")
		If commentIndex > - 1 And line.SubString(commentIndex).Contains(QUOTE) = False Then line = line.SubString2(0, commentIndex)
		Dim bigParts() As String = Regex.Split(" As ", line)
		For j = 0 To bigParts.length - 2
			Dim part2 As String = bigParts(j+1).Replace(",", " ") & " "
			Dim typ As String = part2.substring2(0, part2.IndexOf(" ")).ToLowerCase.trim
			Dim vars() As String = Regex.Split(",", bigParts(j).SubString(bigParts(j).IndexOf(" ") + 1).Trim)
			For Each s As String In vars
				s = s.replace("=", " ").trim
				Dim typx As String = typ
				Dim q As String
				Dim m As Int = s.IndexOf("(")
				If m > -1 Then
					typx = typ & "Array"
					typx = typx.SubString2(0,1).ToUpperCase & typx.SubString(1)
					s = s.SubString2(0, m)
					If s.Contains(" ") Then s = s.SubString2(0, s.IndexOf(" "))
					q = $"newInstance.${s} = copy${typx}(${s})"$
				Else
					If s.Contains(" ") Then s = s.SubString2(0, s.IndexOf(" "))
					Select typ
						Case "int", "float", "double", "long", "short", "byte", "boolean", "char", "string"
							q = $"newInstance.${s} = ${s}"$
						Case "b4xview"
							q = $"newInstance.${s} = copyPanel(${s})"$
						Case Else
							q = $"newInstance.${s} = copyStructure(${s})"$
					End Select
				End If
				result.Append(q).append(CRLF)
			Next
		Next
	Next
	propsToClone = ""
	fx.Clipboard.SetString(result.ToString)
End Sub

Private Sub copyStringArray(ar() As String) As String()
	Dim arx(ar.length) As String
	For i = 0 To ar.Length - 1
		arx(i) = ar(i)
	Next
	Return arx
End Sub

Private Sub copyIntArray(ar() As Int) As Int()
	Dim arx(ar.length) As Int
	For i = 0 To ar.Length - 1
		arx(i) = ar(i)
	Next
	Return arx
End Sub

Private Sub copyFloatArray(ar() As Float) As Float()
	Dim arx(ar.length) As Float
	For i = 0 To ar.Length - 1
		arx(i) = ar(i)
	Next
	Return arx
End Sub

Private Sub copyDoubleArray(ar() As Double) As Double()
	Dim arx(ar.length) As Double
	For i = 0 To ar.Length - 1
		arx(i) = ar(i)
	Next
	Return arx
End Sub

Private Sub copyShortArray(ar() As Short) As Short()
	Dim arx(ar.length) As Short
	For i = 0 To ar.Length - 1
		arx(i) = ar(i)
	Next
	Return arx
End Sub

Private Sub copyLongArray(ar() As Long) As Long()
	Dim arx(ar.length) As Long
	For i = 0 To ar.Length - 1
		arx(i) = ar(i)
	Next
	Return arx
End Sub

Private Sub copyCharArray(ar() As Char) As Char()
	Dim arx(ar.length) As Char
	For i = 0 To ar.Length - 1
		arx(i) = ar(i)
	Next
	Return arx
End Sub

Private Sub copyByteArray(ar() As Byte) As Byte()
	Dim arx(ar.length) As Byte
	For i = 0 To ar.Length - 1
		arx(i) = ar(i)
	Next
	Return arx
End Sub

Private Sub copyStructure(obj As Object) As Object
	Return ser.ConvertBytesToObject(ser.ConvertObjectToBytes(obj))
End Sub

Private Sub copyPanel(pnl As B4XView) As B4XView
	'Views are complex structures that can't be copied - but copies can be loaded from the original layout file
	'  Layout files can be loaded into panels - for example a BBCodeview in its own layout file with filling anchors
	'  can be loaded into a copied panel and that panel can be added to the root of a page

	'Panels can be copied - but not event names, and not border and other properties not listed below
	'A copied panel needs more work - added to root etc.
	Dim copybx As B4XView = xui.CreatePanel("")
	copybx.Left = pnl.Left
	copybx.Top = pnl.Top
	copybx.Width = pnl.Width
	copybx.Height = pnl.Height
	copybx.Color = pnl.Color
	copybx.Visible = pnl.Visible
	copybx.Color = pnl.Color
	copybx.Tag = pnl.Tag
	Return copybx
	
End Sub

#End Region