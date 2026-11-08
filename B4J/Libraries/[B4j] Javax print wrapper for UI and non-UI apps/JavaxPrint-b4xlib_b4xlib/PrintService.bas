B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
#Event: Event(Args())
'Class Module
Sub Class_Globals
	Private Tjo As JavaObject
	Private ListenersMap As Map
	Private PrintServiceAttributeEventObject As Object
	'You may need to remove this if another class has already defined it.
	Type ListenerType (Module As Object,EventName As String, Listener As Object)
End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	ListenersMap.Initialize
End Sub

'Registers a listener for events on this PrintService.
'Replace "FullClassName" with the full name of the listener class in B4a, or the EventHandler in B4j
Public Sub AddPrintServiceAttributeListener(Module As Object, EventName As String)
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.Get("PrintServiceAttributeListener")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		PrintServiceAttributeEventObject = Tjo.CreateEventFromUI("FullClassName", "Listener0" ,Null)
		Tjo.RunMethod("addPrintServiceAttributeListener",Array As Object(PrintServiceAttributeEventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And Listenertype if they are not needed.
	Dim LT As ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("PrintServiceAttributeListener",Listeners)
End Sub
Private Sub Listener0_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.Get("PrintServiceAttributeListener")
	If Listeners.IsInitialized Then
		For Each LT As ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Creates and returns a PrintJob capable of handling data from any of the supported document flavors.
Public Sub CreatePrintJob As DocPrintJob
	Dim Wrapper As DocPrintJob
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("createPrintJob",Null))
	Return Wrapper
End Sub
'Determines if two services are referring to the same underlying service.
'*
Public Sub Equals(Obj As Object) As Boolean
	Return Tjo.RunMethod("equals",Array As Object(Obj))
End Sub

'Gets the value of the single specified service attribute.
'Pass one of the PrintServiceAttribute_Classes class values
Public Sub GetAttribute(Category As Class_Wrapper) As Attribute
	Dim Wrapper As Attribute
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("getAttribute",Array As Object(Category.GetObject)))
	Return Wrapper
End Sub

'Obtains this print service's set of printer description attributes giving this Print Service's status.
Public Sub GetAttributes As PrintServiceAttributeSet
	Dim O As Object = Tjo.RunMethod("getAttributes",Null)
	Dim Wrapper As PrintServiceAttributeSet
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Determines this print service's default printing attribute value in the given category.
'Public Sub GetDefaultAttributeValue( category As Class) As Object
'	Return Tjo.RunMethod("getDefaultAttributeValue",Array As Object( category.GetObject))
'End Sub
'Returns a String name for this print service which may be used by applications to request a particular print service.
Public Sub GetName As String
	Return Tjo.RunMethod("getName",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Try
		Return Tjo
	Catch
		Return Null
	End Try
End Sub
'Returns a factory for UI components which allow users to interact with the service in various roles.
Public Sub GetServiceUIFactory As JavaObject
	Return Tjo.RunMethod("getServiceUIFactory",Null)
End Sub
'Determines the printing attribute categories a client can specify when setting up a job for this print service.
Public Sub GetSupportedAttributeCategories As Map
	Dim M As Map
	M.Initialize
	Dim arr() As Object = Tjo.RunMethod("getSupportedAttributeCategories",Null)
	For Each JO As JavaObject In arr
		Dim Class As JavaObject = JO.RunMethod("getClass",Null)
		Dim Method As JavaObject = Class.RunMethod("getMethod",Array("getSimpleName",Null))
		Dim SimpleName As String = Method.RunMethod("invoke",Array(JO,Null))
		Dim Method As JavaObject = Class.RunMethod("getMethod",Array("getName",Null))
		Dim Name As String = Method.RunMethod("invoke",Array(JO,Null))
		
		M.put(SimpleName,Name)
	Next
	Return M
End Sub
'Determines the printing attribute values a client can specify in the given category when setting up a job For this print service.
Public Sub GetSupportedAttributeValues(Category As Class_Wrapper, Flavor As DocFlavor, Atts As PrintServiceAttributeSet) As Object
	Return Tjo.RunMethod("getSupportedAttributeValues",Array As Object(Category.GetObject, Flavor.GetObject, Atts.GetObject))
End Sub
'Determines the print data formats a client can specify when setting up a job for this PrintService.
Public Sub GetSupportedDocFlavors As List
	Dim Temp() As Object = Tjo.RunMethod("getSupportedDocFlavors",Null)
	Dim L As List
	L.Initialize
	For i = 0 To Temp.Length - 1
		Dim Wrapper As DocFlavor
		Wrapper.Initialize
		Wrapper.SetObject(Temp(i))
		L.Add(Wrapper)
	Next
	Return L
End Sub
'Identifies the attributes that are unsupported for a print request in the context of a particular DocFlavor.
Public Sub GetUnsupportedAttributes(Flavor As DocFlavor, Atts As Map) As Map
	Return Tjo.RunMethod("getUnsupportedAttributes",Array As Object(Flavor.GetObject, Atts))
End Sub
'This method should be implemented consistently with equals(Object).
Public Sub HashCode As Int
	Return Tjo.RunMethod("hashCode",Null)
End Sub
'Determines whether a client can specify the given printing attribute category when setting up a job for this print service.
'Public Sub IsAttributeCategorySupported( category As Class) As Boolean
'	Return Tjo.RunMethod("isAttributeCategorySupported",Array As Object( category.GetObject))
'End Sub
'Determines whether a client can specify the given printing attribute value when setting up a job for this Print Service.
Public Sub IsAttributeValueSupported(Attrval As JavaObject, Flavor As DocFlavor, Atts As Map) As Boolean
	Return Tjo.RunMethod("isAttributeValueSupported",Array As Object(Attrval, Flavor.GetObject, Atts))
End Sub
'Determines if this print service supports a specific DocFlavor.
Public Sub IsDocFlavorSupported(Flavor As DocFlavor) As Boolean
	Return Tjo.RunMethod("isDocFlavorSupported",Array As Object(Flavor.GetObject))
End Sub
'Removes the print-service listener from this print service.
Public Sub RemovePrintServiceAttributeListener(Module As Object, EventName As String)
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.Get("PrintServiceAttributeListener")
	If LL.IsInitialized Then
		For Each LT As ListenerType In LL
			If LT.Module = Module And LT.EventName = EventName Then
				LL.RemoveAt(LL.IndexOf(LT))
				Exit
			End If
		Next
		If LL.Size = 0 Then
			Tjo.RunMethod("removePrintServiceAttributeListener",Array(PrintServiceAttributeEventObject))
			ListenersMap.Remove("PrintServiceAttributeListener")
		End If
	End If
End Sub


'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub



