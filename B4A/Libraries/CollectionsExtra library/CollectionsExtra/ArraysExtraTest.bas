Type=StaticCode
Version=1.20
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim Ax As ArraysExtra
	Dim ArrString() As String
	Dim ArrInt() As Int
	Dim ArrObj() As Object

End Sub

Sub ArrayTest

	ArrInt = Array As Int(1, 8, 51, 5, 13, 36, 9, 45, 16, 23)   
	ArrString = Array As String(1, 8, 51, 5, 13, 36, 9, 45, 16, 23)   
	
	Ax.SortNumericArray(ArrInt)
	ShowArrayI(ArrInt, "Sort Int")	
	
	ShowArrayI(ArrInt, "Search Int for 45 = " & Ax.BinarySearch(ArrInt, 45))
	
	Dim AInt1(5) As Int
	Ax.ArrayCopy(ArrInt, 2, AInt1, 0, 5)
	ShowArrayI(AInt1, "Copy Int")
	
	Dim AInt2() As Int
	AInt2 = Ax.Clone(ArrInt)
	ShowArrayI(AInt2, "Clone Int")
	
	Ax.Fill(ArrInt, 0, ArrInt.Length, 99)
	ShowArrayI(ArrInt, "Fill Int")	
	
	Msgbox(Ax.ToString(ArrInt), "ToString Int")

	Ax.SortStringArray(ArrString, Ax.SORTCASEINSENSITIVE)
	ShowArrayS(ArrString, "Sort String")	
	
	ShowArrayS(ArrString, "Search String for 45 = " & Ax.BinarySearch(ArrString, "45"))
	
	Dim AStr1(5) As String
	 Ax.ArrayCopy(ArrString, 2, AStr1, 0, 5)
	ShowArrayS(AStr1, "Copy String")

	Dim AStr2() As String
	AStr2 = Ax.Clone(ArrString)
	ShowArrayS(AStr2, "Clone String")

	Ax.Fill(ArrString, 0, ArrString.Length, "aa")
	ShowArrayS(ArrString, "Fill String")	
	
	Msgbox(Ax.ToString(ArrString), "ToString String")
	

End Sub

Sub ShowArrayS(Arr() As String, title As String)
	Dim msg As String
	For i = 0 To Arr.Length - 1
		msg = msg & Arr(i) & " "
	Next
	Msgbox(msg, title)
End Sub

Sub ShowArrayI(Arr() As Int, title As String)
	Dim msg As String
	For i = 0 To Arr.Length - 1
		msg = msg & Arr(i) & " "
	Next
	Msgbox(msg, title)
End Sub

Sub ShowArrayO(Arr() As Object, title As String)
	Dim msg As String
	For i = 0 To Arr.Length - 1
		msg = msg & Arr(i) & " "
	Next
	Msgbox(msg, title)
End Sub

