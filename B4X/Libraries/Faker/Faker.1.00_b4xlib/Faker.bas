B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
    Private names, surnames, domains, streets, cities, words As List
End Sub

Public Sub Initialize
	RndSeed(DateTime.Now)
	names = Array As String("John", "Alice", "Bob", "Oscar", "Tom", "Michael", "Emily", "David", "Emma", "Daniel", "Olivia")
	surnames = Array As String("Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Doe", "Simpson")
	domains = Array As String("example.com", "testmail.com", "sample.org", "fakedomain.net", "gmail.com")
	streets = Array As String("Main", "Maple", "Cedar", "Oak", "Pine", "Elm", "Washington", "Lake")
	cities = Array As String("New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "San Diego", "Dallas")
	words = Array As String("lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit", "sed", "do")
End Sub

Private Sub RandomItem (lst As List) As String
    Return lst.Get(Rnd(0, lst.Size))
End Sub

Public Sub FullName As String
    Return RandomItem(names) & " " & RandomItem(surnames)
End Sub

Public Sub Email As String
    Return RandomItem(names).ToLowerCase & "." & RandomItem(surnames).ToLowerCase & "@" & RandomItem(domains)
End Sub

Public Sub PhoneNumber As String
    Return "+1-" & Rnd(100, 999) & "-" & Rnd(1000000, 9999999)
End Sub

Public Sub Address As String
    Return Rnd(100, 9999) & " " & RandomItem(streets) & " St, " & RandomItem(cities)
End Sub

Public Sub Username As String
    Return RandomItem(names).ToLowerCase & Rnd(10, 99)
End Sub

Public Sub Password As String
    Return RandomItem(words) & Rnd(100, 999) & "!"
End Sub

Public Sub UUID As String
    Dim sb As StringBuilder
    sb.Initialize
    For Each group As Int In Array As Int(8, 4, 4, 4, 12)
        If sb.Length > 0 Then sb.Append("-")
        For i = 1 To group
            sb.Append(Bit.ToHexString(Rnd(0, 256)).ToLowerCase)
        Next
    Next
    Return sb.ToString
End Sub

Public Sub RandomDate (StartYear As Int, EndYear As Int) As String
    Dim year As Int = Rnd(StartYear, EndYear + 1)
    Dim month As Int = Rnd(1, 13)
    Dim day As Int = Rnd(1, 29)
    Return $"${year}-${NumberFormat(month, 2, 0)}-${NumberFormat(day, 2, 0)}"$
End Sub

Public Sub LoremSentence (WordsCount As Int) As String
    Dim sb As StringBuilder
    sb.Initialize
    For i = 0 To WordsCount - 1
        sb.Append(RandomItem(words)).Append(" ")
    Next
    Dim s As String = sb.ToString.Trim
    Return s.SubString2(0, 1).ToUpperCase & s.SubString(1) & "."
End Sub

Public Sub LoremParagraph (Sentences As Int) As String
    Dim sb As StringBuilder
    sb.Initialize
    For i = 0 To Sentences - 1
        sb.Append(LoremSentence(Rnd(6, 12))).Append(" ")
    Next
    Return sb.ToString.Trim
End Sub