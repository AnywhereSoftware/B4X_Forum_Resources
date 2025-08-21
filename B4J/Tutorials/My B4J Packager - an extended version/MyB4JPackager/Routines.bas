B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.3
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

Public Sub SetStyleProperty (Node As Node, Key As String, Value As String)
	Dim att As String = Key & ":" & Value & ";"
	Dim m As Matcher = Regex.Matcher($"${Key}:[^;]+;"$, Node.Style)
	Dim newStyle As String
	If m.Find Then
		newStyle = Node.Style.SubString2(0, m.GetStart(0))
		newStyle = newStyle & att & Node.Style.SubString(m.GetEnd(0))
	Else
		newStyle = Node.Style & att
	End If
	Node.Style = newStyle
End Sub

Public Sub SetTextColor(Node As Node, Color As Paint)
	SetStyleProperty(Node, "-fx-text-fill", ColorToRGBA(Color))
End Sub

'returns a string representing the Color as
'the Java function "rgba(r,g,b,a)" 
'NB: This is used when applying Style Properties.
Public Sub ColorToRGBA(Color As Paint) As String
	Dim c As Int  = fx.Colors.To32Bit(Color)
	Dim alpha As Int = Bit.UnsignedShiftRight(c, 24)
	Dim red As Int = Bit.And(Bit.UnsignedShiftRight(c, 16), 0xFF)
	Dim green As Int = Bit.And(Bit.UnsignedShiftRight(c, 8), 0xFF)
	Dim blue As Int = Bit.And(c, 0xFF)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("rgba(").Append(red).Append(",").Append(green).Append(",").Append(blue).Append(",")
	sb.Append(NumberFormat2(alpha / 255, 1, 2, 2, False)).Append(")")
	Return sb.ToString
End Sub

