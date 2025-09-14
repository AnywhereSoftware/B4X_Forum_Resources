B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private TJO As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

'Instantiates an empty document.
Public Sub Create
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("org.dizitart.no2.Document",Null)
End Sub

Public Sub CreateDocument(Key As String,Value As String) As NitriteDocument
	Dim Wrapper As NitriteDocument
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("createDocument",Array(Key,Value)))
	Return Wrapper
End Sub

'Instantiates a new Document from a map.
Public Sub Create2(TMap As Map)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("org.dizitart.no2.Document",Array As Object(Nitrite_Utils.UnwrapMap(TMap)))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub

Public Sub ContainsKey(Key As String) As Boolean
	Return TJO.RunMethod("containsKey",Array As Object(Key))
End Sub

'Get object specified with the key.
Public Sub Get(Key As String) As Object
'	Return TJO.RunMethod("get",Array As Object(Key))
	Dim O As Object = TJO.RunMethod("get",Array As Object(Key))
	If O = Null Then Return O
	If O Is List Then Return WrapList(O)
	If GetType(O) = "org.dizitart.no2.Document" Then
		Dim Wrapper As NitriteDocument
		Wrapper.Initialize
		Wrapper.SetObject(O)
		Return Wrapper
	Else If GetType(O) = "org.dizitart.no2.NitriteId" Then
		Dim IWrapper As NitriteId
		IWrapper.Initialize
		IWrapper.SetObject(O)
		Return IWrapper
	Else
		Return O
	End If
End Sub

Public Sub GetRaw(Key As String) As Object
	Return TJO.RunMethod("get",Array As Object(Key))
End Sub

Public Sub GetDefault(Key As String,Default As Object) As Object
	Dim O As Object = TJO.RunMethod("getOrDefault",Array As Object(Key,Default))
	If O = Null Then Return O
	If O Is List Then Return WrapList(O)
	If GetType(O) = "org.dizitart.no2.Document" Then
		Dim Wrapper As NitriteDocument
		Wrapper.Initialize
		Wrapper.SetObject(O)
		Return Wrapper
	Else If GetType(O) = "org.dizitart.no2.NitriteId" Then
		Dim IWrapper As NitriteId
		IWrapper.Initialize
		IWrapper.SetObject(O)
		Return IWrapper
	Else
		Return O
	End If
	
End Sub

Public Sub GetRawDefault(Key As String,Default As Object) As Object
	Return TJO.RunMethod("getOrDefault",Array As Object(Key,Default))
End Sub

'Gets the _id field of the document.
Public Sub GetId As NitriteId
	Dim Wrapper As NitriteId
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getId",Null))
	Return Wrapper
End Sub

'Gets the last modified time of the documents.
Public Sub GetLastModifiedTime As Long
	Return TJO.RunMethod("getLastModifiedTime",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub
'Gets the document revision number.
Public Sub GetRevision As Int
	Return TJO.RunMethod("getRevision",Null)
End Sub
'Gets the source of the documents.
Public Sub GetSource As String
	Return TJO.RunMethod("getSource",Null)
End Sub

'Returns all keys as alist of strings
Public Sub Keys As List
	Dim Jo As JavaObject = TJO.RunMethod("keySet",Null)
	Dim L As List
	L.Initialize
	Dim It As JavaObject = Jo.RunMethod("iterator",Null)
	Do While It.RunMethod("hasNext",Null)
		L.Add(It.RunMethod("next",Null))
	Loop
	Return L
End Sub
'Append document with new key and value pair.
Public Sub Put(Key As String, Value As Object) As NitriteDocument
	If Value Is NitriteDocument Or Value Is NitriteId Then Value = CallSub(Value,"getObject")
	If Value Is List Then Value = Nitrite_Utils.UnwrapList(Value)
	Dim Wrapper As NitriteDocument
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("put",Array As Object(Key, Value)))
	Return Wrapper
End Sub

Public Sub PutRaw (Key As String, Value As Object) As NitriteDocument
	Dim Wrapper As NitriteDocument
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("put",Array As Object(Key, Value)))
	Return Wrapper
End Sub

Public Sub Remove(Key As String)
	TJO.RunMethod("remove",Array(Key))
End Sub

Public Sub ToString As String
	Return TJO.RunMethod("toString",Null)
End Sub

Private Sub WrapList(L As List) As List
	For i = 0 To L.Size - 1
		Dim O As Object = L.Get(i)
		If GetType(O) = "org.dizitart.no2.Document" Then
			Dim Wrapper As NitriteDocument
			Wrapper.Initialize
			Wrapper.SetObject(O)
			L.Set(i,Wrapper)
		Else If GetType(O) = "org.dizitart.no2.NitriteId" Then
			Dim IWrapper As NitriteId
			IWrapper.Initialize
			IWrapper.SetObject(O)
			L.Set(i,IWrapper)
		End If
	Next
	Return L
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

