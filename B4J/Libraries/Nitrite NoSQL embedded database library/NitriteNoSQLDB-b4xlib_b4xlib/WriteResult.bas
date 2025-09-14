B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
#Event: WriteResult (MethodName As String,Args() as Object) As Object
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only
	Private TJO As JavaObject
End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub
'Gets the count of affected document in the collection.
Public Sub GetAffectedCount As Int
	Return TJO.RunMethod("getAffectedCount",Null)
End Sub

Public Sub GetIterator As NitriteIterator
	Dim Wrapper As NitriteIterator
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("iterator",Null))
	Return Wrapper
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

'Returns a list of affected NitriteId's
Public Sub ToList As List
	Dim L As List
	L.Initialize
	Dim It As JavaObject = TJO.RunMethod("iterator",Null)
	Do While It.RunMethod("hasNext",Null)
		Dim NI As NitriteId
		NI.Initialize
		NI.SetObject(It.RunMethod("next",Null))
		L.Add(NI)
	Loop
	Return L
End Sub

Public Sub ToElementList(Collection As Object) As List
	Dim L As List
	L.Initialize
	Dim It As JavaObject = TJO.RunMethod("iterator",Null)
	Do While It.RunMethod("hasNext",Null)
		Dim NI As NitriteId
		NI.Initialize
		NI.SetObject(It.RunMethod("next",Null))
		Dim O As Object = CallSub2(Collection,"GetById",NI)
		
		If GetType(O) = "org.dizitart.no2.Document" Then
			Dim Wrapper As NitriteDocument
			Wrapper.Initialize
			Wrapper.SetObject(O)
			L.Add(Wrapper)
		Else If GetType(O) = "org.dizitart.no2.NitriteId" Then
			Dim IWrapper As NitriteId
			IWrapper.Initialize
			IWrapper.SetObject(O)
			L.Add(IWrapper)
		Else
			L.Add(O)
		End If
	Loop
	Return L
End Sub

