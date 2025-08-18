B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Type TSQLQuery(fSQL As String,fValues() As Object)
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

'return a string key,key.... 
private Sub FieldsNames(aFields As Map) As String
	Dim i As Int=0
	Dim sb As StringBuilder
	sb.Initialize
	For Each k As String In aFields.keys
		sb.Append(k)
		If i<aFields.Size-1 Then
			sb.Append(",")
		End If
		i=i+1
	Next
	Return sb.ToString
End Sub

'return a string key=? key=?.... separate by aSeaprator
private Sub FieldsNamesValues(aFields As Map,aSeparator As String,aOperator As String) As String
	Dim i As Int=0
	Dim sb As StringBuilder
	sb.Initialize
	For Each k As String In aFields.keys
		sb.Append(k)
		If (aOperator="")  Then
			sb.Append("=")
		Else
			sb.Append(aOperator)
		End If
		sb.Append("?")
		If (aSeparator<>"") And (i<aFields.Size-1) Then
			sb.Append(aSeparator)
		End If
		i=i+1
	Next
	Return sb.ToString
End Sub

'return a string ?,?...
private Sub questionsMarks(aFields As Map) As String
	Dim sb As StringBuilder
	sb.Initialize
	For i=0 To aFields.Size-1
		sb.Append("?")
		If i<aFields.Size-1 Then
			sb.Append(",")
		End If
	Next
	Return sb.ToString
End Sub

'return an array of object from the values of the map
private Sub values(aFields As Map) As Object()
	Dim l As List
	l.Initialize
	For Each k As String In aFields.Keys
		l.Add(aFields.Get(k))
	Next
	Return ListToArray(l)
End Sub

'return an array of object from the values of the 2 maps
private Sub valuesWhere(aFields As Map,aWhere As Map) As Object()
	Dim l As List
	l.Initialize
	For Each k As String In aFields.Keys
		l.Add(aFields.Get(k))
	Next
	For Each k As String In aWhere.Keys
		l.Add(aWhere.Get(k))
	Next
	Return ListToArray(l)
End Sub


'convert list to array of objects
Private Sub ListToArray (aList As List) As Object()
	Dim r(aList.Size) As Object
	For i = 0 To aList.Size-1
		r(i) = aList.Get(i)
	Next
	Return r
End Sub

public Sub insertSQL(aTableName As String,aFields As Map) As TSQLQuery
	Dim s As TSQLQuery
	s.Initialize
	s.fSQL=$"insert into ${aTableName} (${FieldsNames(aFields)}) values(${questionsMarks(aFields)})"$
	s.fValues=values(aFields)
	Return s
End Sub

public Sub updateSQL(aTableName As String,aFields As Map,aWhere As Map) As TSQLQuery
	Dim s As TSQLQuery
	s.Initialize
	s.fSQL=$"update ${aTableName} set ${FieldsNamesValues(aFields,",","=")} where ${FieldsNamesValues(aWhere," ","")}"$
	s.fValues=valuesWhere(aFields,aWhere)
	Return s
End Sub

public Sub deleteSQL(aTableName As String,aWhere As Map) As TSQLQuery
	Dim s As TSQLQuery
	s.Initialize
	s.fSQL=$"delete from ${aTableName} where ${FieldsNamesValues(aWhere," ","")}"$
	s.fValues=valuesWhere(CreateMap(),aWhere)
	Return s
End Sub