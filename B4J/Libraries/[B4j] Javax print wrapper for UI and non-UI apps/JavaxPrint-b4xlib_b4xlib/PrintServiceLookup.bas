B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Static code module
Sub Process_Globals
	

	Private Tjo As JavaObject
End Sub

'*
Public Sub Initialize
	
	
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub
'Locates services that can be positively confirmed to support the combination of attributes and DocFlavors specified.
Public Sub GetPrintServices(Flavor As Object , Atts As Object) As List
	If Flavor <> Null Then Flavor = CallSub(Flavor,"GetObject")
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
	Dim Tjo As JavaObject
	Tjo.InitializeStatic("javax.print.PrintServiceLookup")
	Dim Temp() As Object = Tjo.RunMethod("lookupPrintServices",Array As Object(Flavor, Atts))
	Dim L As List
	L.Initialize
	For i = 0 To Temp.Length - 1
		Dim Wrapper As PrintService
		Wrapper.Initialize
		Wrapper.SetObject(Temp(i))
		L.Add(Wrapper)
	Next
	Return L
End Sub
'Locates the default print service for this environment.
Public Sub LookupDefaultPrintService As PrintService
	Dim Wrapper As PrintService
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("javax.print.PrintServiceLookup")
	Dim Service As Object = Tjo1.RunMethod("lookupDefaultPrintService",Null)
	If Service = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(Service)
	Return Wrapper
End Sub
''Locates MultiDoc print Services capable of printing MultiDocs containing all the specified doc flavors.
'Public Sub LookupMultiDocPrintServices(Flavors() As Object, Atts As Object) As List
'	Dim Tjo1 As JavaObject
'	Tjo1.InitializeStatic("javax.print.PrintServiceLookup")
''	Return Tjo1.RunMethod("lookupMultiDocPrintServices",Array As Object( UnWrapTypedArray(Flavors, ""), atts))
'	If Flavors <> Null Then
'		Dim RawFlavors(Flavors.Length) As Object
'		For i = 0 To Flavors.Length - 1
'			Dim Flavor As DocFlavor = Flavors(i)
'			RawFlavors(i) = Flavor.GetObject
'		Next
'		Dim FlavorsArr As JavaObject
'		FlavorsArr.InitializeArray("javax.print.DocFlavor",RawFlavors)
'		Flavors = FlavorsArr
'	End If
'	
'	If Atts <> Null Then Atts =  If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
'	Dim Temp() As Object = Tjo1.RunMethod("lookupmultiDocPrintServices",Array As Object(Flavors, atts))
'	Dim L As List
'	L.Initialize
'	For i = 0 To Temp.Length - 1
'		Dim Wrapper As MultiDocPrintService
'		Wrapper.Initialize
'		Wrapper.SetObject(Temp(i))
'		L.Add(Wrapper)
'	Next
'	Return L
'End Sub
'Locates print services capable of printing the specified DocFlavor.
Public Sub LookupPrintServices(Flavor As Object, Atts As Object) As List
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("javax.print.PrintServiceLookup")
	If Flavor <> Null Then Flavor = CallSub(Flavor,"GetObject")
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
	Dim Temp() As Object = Tjo1.RunMethod("lookupPrintServices",Array As Object(Flavor, Atts))
	Dim L As List
	L.Initialize
	For i = 0 To Temp.Length - 1
		Dim Wrapper As PrintService
		Wrapper.Initialize
		Wrapper.SetObject(Temp(i))
		L.Add(Wrapper)
	Next
	Return L
End Sub
'Allows an application to directly register an instance of a class which implements a print service.
Public Sub RegisterService(Service As PrintService) As Boolean
	Dim Tjo1 As JavaObject
	Tjo1.InitializeStatic("javax.print.PrintServiceLookup")
	Return Tjo1.RunMethod("registerService",Array As Object(Service.GetObject))
End Sub
''Allows an application to explicitly register a class that implements lookup services.
'Public Sub RegisterServiceProvider(Sp As PrintServiceLookup) As Boolean
'	Dim Tjo1 As JavaObject
'	Tjo1.InitializeStatic("javax.print.PrintServiceLookup")
'	Return Tjo1.RunMethod("registerServiceProvider",Array As Object(Sp.GetObject))
'End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub

'UnWrap a Wrapped array . 
'Arr is an array of wrapped objects
Private Sub UnWrapTypedArray(Arr As Object,UnWrapType As String) As Object
	Dim P1 As JavaObject
	Dim ObjArr() As Object = Arr
	Dim ResultArr(ObjArr.Length) As Object
	For i = 0 To ObjArr.Length - 1
		ResultArr(i) = GetWrappedObject(ObjArr(i))
	Next
	If UnWrapType = "" Then UnWrapType = GetType(ResultArr(0))
	P1.InitializeArray(UnWrapType,ResultArr)
	Return P1
End Sub
'Gets a wrapped object from any wrapper class that has a AsObject Sub 
'without knowing it's type
Private Sub GetWrappedObject(jObj As JavaObject) As JavaObject
	Try
		'Unwrap JOLibs
    #if Debug
		Return jObj.RunMethod("_getobject",Array(jObj))
    #end if
    #if Release
    Return jObj.RunMethod("_getobject",Null)
    #End if
	Catch
		Try
			'Unwrap B4x objects
			Return jObj.RunMethod("getObject",Null)
		Catch
			Log(LastException)
			Log("Invalid type passed to Sub " & GetType(jObj))
		End Try
    
		Return Null
	End Try
End Sub