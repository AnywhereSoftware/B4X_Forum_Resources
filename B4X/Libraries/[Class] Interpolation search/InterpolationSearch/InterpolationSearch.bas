B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.45
@EndOfDesignText@
#Region VERSIONS 
'	1.0.0		12/04/2024
'	Author:	LucaMs
#End Region

Sub Class_Globals
	Public Const ISRC_EQUAL As String = "equal"
	Public Const ISRC_EQUAL_OR_LESS As String = "equalorless"
	Public Const ISRC_EQUAL_OR_GREATER As String = "equalorgreater"
End Sub

Public Sub Initialize
End Sub

'Mode: pass one of the constants provided by this class.
'Example:
'<code>
'	Dim ISearch As InterpolationSearch
'	ISearch.Initialize
'	Dim SortedList As List
'	SortedList.Initialize
'	For i = 1 To 20
'		SortedList.Add(i * 5) ' 5, 10, 15, ..., 100
'	Next
''	SortedList.Sort(True)
'	Dim ValueToFind As Double = 42
'	Dim Index As Int
'	Index = ISearch.Search(SortedList, ValueToFind, ISearch.ISRC_EQUAL_OR_LESS)
'	Log($"Equal or less - Index: ${Index}  Value: ${SortedList.Get(Index)}"$)
'</code>
Public Sub Search(OrderedList As List, SearchValue As Double, Mode As String) As Int
	If OrderedList.IsInitialized = False Or OrderedList.Size = 0 Then
		Return -1 ' Empty or uninitialized list.
	End If

	Dim Low As Int = 0
	Dim High As Int = OrderedList.Size - 1

	' Determines whether the list is sorted in ascending or descending order.
	Dim IsAscending As Boolean = OrderedList.Get(Low) < OrderedList.Get(High)

	Do While Low <= High
		Dim LowValue As Double = OrderedList.Get(Low)
		Dim HighValue As Double = OrderedList.Get(High)

		' Calculate the estimated position.
		Dim Pos As Int
		If HighValue <> LowValue Then
			If IsAscending Then
				Pos = Low + (SearchValue - LowValue) * (High - Low) / (HighValue - LowValue)
			Else
				Pos = Low + (LowValue - SearchValue) * (High - Low) / (LowValue - HighValue)
			End If
		Else
			Pos = (Low + High) / 2
		End If
		Pos = Max(Low, Min(Pos, High)) ' Pos must be within limits.

		Dim CurrentValue As Double = OrderedList.Get(Pos)

		If CurrentValue = SearchValue Then
			Return Pos ' Value found exactly.
		Else If (IsAscending And CurrentValue < SearchValue) Or (Not(IsAscending) And CurrentValue > SearchValue) Then
			Low = Pos + 1 ' Look in the top half.
		Else
			High = Pos - 1 ' Look in the lower half.
		End If
	Loop

	' Case not found: Returns a valid index based on Low and High.
	Select Case Mode
		Case ISRC_EQUAL_OR_LESS
			If Not(IsAscending) Then
				If Low < OrderedList.Size And OrderedList.Get(Low) <= SearchValue Then
					Return Low
				End If
				If High >= 0 And OrderedList.Get(High) <= SearchValue Then
					Return High
				End If
			Else
				If High >= 0 And OrderedList.Get(High) <= SearchValue Then
					Return High
				End If
				If Low < OrderedList.Size And OrderedList.Get(Low) <= SearchValue Then
					Return Low
				End If
			End If
			Return -1
		Case ISRC_EQUAL_OR_GREATER
			If Not(IsAscending) Then
				If High >= 0 And OrderedList.Get(High) >= SearchValue Then
					Return High
				End If
				If Low < OrderedList.Size And OrderedList.Get(Low) >= SearchValue Then
					Return Low
				End If
			Else
				If Low < OrderedList.Size And OrderedList.Get(Low) >= SearchValue Then
					Return Low
				End If
				If High >= 0 And OrderedList.Get(High) >= SearchValue Then
					Return High
				End If
			End If
			Return -1
		Case Else
			Return -1 ' Value not found in "equal" mode.
	End Select
End Sub
