Type=StaticCode
Version=1.20
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim LL As LinkedList
	Dim L As List

End Sub

Sub LinkedListTest

	Dim A() As Int
	A = Array As Int(1, 8, 51, 5, 13, 36, 9)   
	
'	L.Initialize
'	L.Add(199)
'	L.Add(299)
'	L.Add(399)	
'	L.AddAllAt(2, A)
'	ShowL("AddAllAt")
	
	'LL.Initialize2(A)
	LL.Initialize
	LL.Add(45)
	LL.Add(16)
	LL.Add(23)
	
	LL.AddAllAt(2, A)
	ShowLL("AddAllAt")
	
	LL.SortCaseInsensitive(True)
	ShowLL("Sort lexographically")
	
	LL.Sort(True)	
	ShowLL("Sort")
	
	LL.Reverse	
	ShowLL("Reverse")	
	
	LL.Swap(0, LL.Size -1)
	ShowLL("Swap")
	
	LL.InsertAt(5, -1)
	ShowLL("InsertAt 5 -1")
	
	LL.RemoveAt(5)
	ShowLL("RemoveAt 5")
		
	LL.AddFirst(99)
	LL.AddLast(-99)
	ShowLL("Push")
	
	n1 = LL.RemoveFirst
	n2 = LL.RemoveLast
	ShowLL("Pop " & n1 & " " & n2)
	
	ShowLL("IndexOf 5 is " & LL.IndexOf(5))
	
	LL.Replace(LL.IndexOf(5), 55)
	ShowLL("Replace 5 with 55")

	msg = "First = " & LL.First & " : Last = " & LL.Last
	Msgbox(msg, "First and Last")
	
End Sub

Sub ShowLL(title As String)
	Dim msg As String
	For i = 0 To LL.Size - 1
		msg = msg & LL.Get(i) & " "
	Next
	Msgbox(msg, title)
End Sub

Sub ShowL(title As String)
	Dim msg As String
	For i = 0 To L.Size - 1
		msg = msg & L.Get(i) & " "
	Next
	Msgbox(msg, title)
End Sub

