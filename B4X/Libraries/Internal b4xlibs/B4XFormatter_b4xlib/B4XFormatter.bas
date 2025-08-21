B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7
@EndOfDesignText@
Sub Class_Globals
	Type B4XFormatData (Prefix As String, Postfix As String, MinimumIntegers As Int, _
		MinimumFractions As Int, MaximumFractions As Int, GroupingCharacter As String, _
		DecimalPoint As String, TextColor As Int, FormatFont As B4XFont, RangeStart As Double, RangeEnd As Double, _
		RemoveMinusSign As Boolean, IntegerPaddingChar As String, FractionPaddingChar As String)
	Private formats As List
	Public Const MAX_VALUE = 0x7fffffff, MIN_VALUE = 0x80000000 As Int
	#if Not(B4J) OR UI
	Private xui As XUI
	#end if
End Sub

Public Sub Initialize
	formats.Initialize
	Dim d As B4XFormatData = CreateDefaultFormat
	AddFormatData(d, MIN_VALUE, MAX_VALUE, True)
End Sub

Private Sub CreateDefaultFormat As B4XFormatData
	Dim d As B4XFormatData
	d.Initialize
	d.GroupingCharacter = ","
	d.DecimalPoint = "."
	d.MaximumFractions = 3
	d.MinimumIntegers = 1
	d.IntegerPaddingChar = "0"
	d.FractionPaddingChar = "0"
	Return d
End Sub

'Returns a copy of the default format
Public Sub NewFormatData As B4XFormatData
	Return CopyFormatData(GetDefaultFormat)
End Sub

'Creates a copy of the given format data.
'This is useful if you want to create a similar format for a different range.
Public Sub CopyFormatData (Data As B4XFormatData) As B4XFormatData
	Dim d As B4XFormatData
	d.Initialize
	d.DecimalPoint = Data.DecimalPoint
	If Data.FormatFont.IsInitialized Then
		#if Not(B4J) OR UI
		d.FormatFont = xui.CreateFont(Data.FormatFont.ToNativeFont, Data.FormatFont.Size)
		#end if
	End If
	d.GroupingCharacter = Data.GroupingCharacter
	d.MaximumFractions = Data.MaximumFractions
	d.MinimumFractions = Data.MinimumFractions
	d.MinimumIntegers = Data.MinimumIntegers
	d.Postfix = Data.Postfix
	d.Prefix = Data.Prefix
	d.RangeEnd = Data.RangeEnd
	d.RangeStart = Data.RangeStart
	d.RemoveMinusSign = Data.RemoveMinusSign
	d.TextColor = Data.TextColor
	d.FractionPaddingChar = Data.FractionPaddingChar
	d.IntegerPaddingChar = Data.IntegerPaddingChar
	Return d
End Sub

'Adds a format data to the formatter. Note that each data object should be used for a single range. Use CopyFormatData to create copies.
'The format datas are stored in a list. When a number is formatted it looks for a data with a matching range. Datas added last will be checked first.
'IncludeEdges - Whether the range is inclusive or not.
Public Sub AddFormatData (Data As B4XFormatData, RangeStart As Double, RangeEnd As Double, IncludeEdges As Boolean)
	Dim factor As Double = Power(10, -Data.MaximumFractions)
	If IncludeEdges = False Then
		RangeStart = RangeStart + factor
		RangeEnd = RangeEnd - factor
	End If
	RangeStart = RangeStart - factor / 2
	RangeEnd = RangeEnd + factor / 2
	Data.RangeStart = RangeStart
	Data.RangeEnd = RangeEnd
	formats.Add(Data)
End Sub
'Returns the default format.
Public Sub GetDefaultFormat As B4XFormatData
	Return formats.Get(0)
End Sub

'Gets the format data that matches the passed number.
Public Sub GetFormatData (Number As Double) As B4XFormatData
	For i = formats.Size - 1 To 1 Step - 1
		Dim d As B4XFormatData = formats.Get(i)
		If Number <= d.RangeEnd And Number >= d.RangeStart Then Return d
	Next
	Return formats.Get(0)
End Sub

'Formats the number and returns the formatted string.
Public Sub Format (Number As Double) As String
	If Number < MIN_VALUE Or Number > MAX_VALUE Then Return "OVERFLOW"
	Dim data As B4XFormatData = GetFormatData (Number)
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append(data.Prefix)
	Dim NumberStartIndex As Int = sb.Length
	Dim factor As Double = Power(10, -data.MaximumFractions - 1) * 5
	If Number < -factor And data.RemoveMinusSign = False Then
		sb.Append("-")
		NumberStartIndex = NumberStartIndex + 1
	End If
	Number = Abs(Number) + factor
	Dim whole As Int = Number
	Dim frac As Double = Number - whole
	Dim g As Int
	Do While whole > 0
		If g > 0 And g Mod 3 = 0 And data.GroupingCharacter.Length > 0 Then
			sb.Insert(NumberStartIndex, data.GroupingCharacter)
		End If
		g = g + 1
		sb.Insert(NumberStartIndex, whole Mod 10)
		whole = whole / 10
	Loop
	Do While sb.Length - NumberStartIndex < data.MinimumIntegers
		sb.Insert(NumberStartIndex, data.IntegerPaddingChar)
	Loop
	If data.MaximumFractions > 0 And (data.MinimumFractions > 0 Or frac > 0) Then
		Dim FracStartIndex As Int = sb.Length
		Dim LastZeroCount As Int
		Dim Multipler As Int = 10
		Do While frac >= 2 * factor And sb.Length - FracStartIndex < data.MaximumFractions
			Dim w As Int = (frac * Multipler)
			w = w Mod 10
			If w = 0 Then LastZeroCount = LastZeroCount + 1 Else LastZeroCount = 0
			sb.Append(w)
			Multipler = Multipler * 10
		Loop
		If data.FractionPaddingChar <> "0" And LastZeroCount > 0 Then
			sb.Remove(sb.Length - LastZeroCount, sb.Length)
			LastZeroCount = 0
		End If
		Do While sb.Length - FracStartIndex < data.MinimumFractions
			sb.Append(data.FractionPaddingChar)
			LastZeroCount = 0
		Loop
		LastZeroCount = Min(LastZeroCount, sb.Length - FracStartIndex - data.MinimumFractions)
		If LastZeroCount > 0 Then
			sb.Remove(sb.Length - LastZeroCount, sb.Length)
		End If
		If sb.Length > FracStartIndex Then sb.Insert(FracStartIndex, data.DecimalPoint)
	End If
	sb.Append(data.Postfix)
	Return sb.ToString
End Sub

#if Not(B4J) OR UI
'Formats the number and sets it to the text field. Unlike Format, FormatLabel respects the format data font and text size properties.
Public Sub FormatLabel (Number As Double, Label As B4XView)
	Label.Text = Format(Number)
	Dim data As B4XFormatData = GetFormatData(Number)
	If data.TextColor <> 0 Then Label.TextColor = data.TextColor
	If data.FormatFont.IsInitialized Then Label.Font = data.FormatFont
End Sub
#end if
