B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4.19
@EndOfDesignText@
'version: 1.10
#ExcludeFromLibrary: true
Sub Process_Globals
	Private fx As JFX
End Sub

Public Sub SetBackgroundColor(Node As Node, Color As Paint)
	SetStyleProperty(Node, "-fx-background-color", ColorToHex(Color))
End Sub

Public Sub SetBorder(Node As Node, Width As Double, Color As Paint, CornerRadius As Double)
	SetStyleProperty(Node, "-fx-border-color", ColorToHex(Color))
	SetStyleProperty(Node, "-fx-border-width", Width)
	SetStyleProperty(Node, "-fx-border-radius", CornerRadius)
	SetStyleProperty(Node, "-fx-background-radius", CornerRadius)
End Sub

Public Sub ColorToHex(Color As Paint) As String
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

Public Sub SetBackgroundImage(Node As Node, Dir As String, FileName As String)
	Dim uri As String = File.GetUri(Dir, FileName)
	SetStyleProperty(Node, "-fx-background-image", $"url(${uri})"$)
	SetStyleProperty(Node, "-fx-background-size", "stretch")
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

Public Sub GetStyleProperty (Node As Node, Key As String) As String
	Dim m As Matcher = Regex.Matcher($"${Key}([^;]+;):"$, Node.Style)
	If m.Find Then
		Return m.Group(1)
	Else
		Return ""
	End If
End Sub
