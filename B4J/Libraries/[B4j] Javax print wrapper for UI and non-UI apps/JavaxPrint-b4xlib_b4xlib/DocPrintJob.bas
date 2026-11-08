B4J=true
Group=PrintJobs
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
#Event: PrintJobEvent(MethodName as String, Event as PrintJobEvent)
#Event: PrintJobAttributeEvent(Event As PrintJobAttributeEvent)
#Event: PrintJob_Complete
'Class Module
Sub Class_Globals
	
	Private Tjo As JavaObject
	Private ListenersMap As Map
	Private PrintJobEventObject As Object
	Private PrintJobAttributeEventObject As Object
	Private mCallBack As Object
	Private TH As Thread		'ignore
	Private ExceptionMessage As String
End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	ListenersMap.Initialize
	Tjo.InitializeStatic("javax.print.DocPrintJob")
	TH.Initialise("TH")
End Sub

'Registers a listener for changes in the specified attributes.
Public Sub AddPrintJobAttributeListener(Module As Object, EventName As String, Atts As JavaObject)
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.Get("PrintJobAttributeListener")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		PrintJobAttributeEventObject = Tjo.CreateEventFromUI("javax.print.event.PrintJobAttributeListener", "Listener0" ,Null)
		Tjo.RunMethod("addPrintJobAttributeListener",Array As Object(PrintJobAttributeEventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And Listenertype if they are not needed.
	Dim LT As ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("PrintJobAttributeListener",Listeners)
End Sub
Private Sub Listener0_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.Get("PrintJobAttributeListener")
	If Listeners.IsInitialized Then
		Dim Event As PrintJobAttributeEvent
		Event.Initialize
		Event.SetObject(Args(0))
		For Each LT As ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_PrintJobAttributeEvent") Then CallSub2(LT.Module, LT.EventName & "_PrintJobAttributeEvent",Event)
		Next
	End If
End Sub
'Registers a listener for event occurring during this print job.
Public Sub AddPrintJobListener(Module As Object, EventName As String)
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.Get("PrintJobListener")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		PrintJobEventObject = Tjo.CreateEventFromUI("javax.print.event.PrintJobListener", "Listener1" ,Null)
		Tjo.RunMethod("addPrintJobListener",Array As Object(PrintJobEventObject))
	End If
	Dim LT As ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("PrintJobListener",Listeners)
End Sub
Private Sub Listener1_Event(MethodName As String,Args() As Object)
	Dim PJE As PrintJobEvent
	PJE.Initialize
	PJE.SetObject(Args(0))
	Dim Listeners As List = ListenersMap.Get("PrintJobListener")
	If Listeners.IsInitialized Then
		For Each LT As ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_PrintJobEvent") Then CallSub3(LT.Module, LT.EventName & "_PrintJobEvent",MethodName,PJE)
		Next
	End If
End Sub
'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return Tjo
End Sub
'Obtains this Print Job's set of printing attributes.
Public Sub GetAttributes As PrintJobAttributeSet
	Dim O As Object = Tjo.RunMethod("getAttributes",Null)
	Dim Wrapper As PrintJobAttributeSet
	If O = Null Then Return Wrapper
	Wrapper.Initialize
	Wrapper.SetObject(O)
	Return Wrapper
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return Tjo
End Sub

'Returns the service (printer) for this printer job.
Public Sub GetPrintService As PrintService
	Dim Wrapper As PrintService
	Wrapper.Initialize
	Wrapper.SetObject(Tjo.RunMethod("getPrintService",Null))
	Return Wrapper
End Sub

Public Sub Print_NoThread(Doc As Object, Atts As Object) As String
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
	If JavaxPrint_Utils.IsPackageObject(Doc) Then Doc = CallSub(Doc,"GetObject")
	Try
		Tjo.RunMethod("print",Array As Object(Doc, Atts))
		Return "OK"
	Catch
		Return "Print Failed"
	End Try
End Sub


'Prints a document with the specified job PrintRequestAttributes.
Public Sub Print(CallBack As Object,Doc As Object, Atts As Object)
	#If Debug
	Dim Tw As Throwables
	Tw.Initialize
	Tw.Throw(Tw.NewIllegalStateException("Printable and Threading cannot be used in debug mode"))
	#End If
	
	mCallBack = CallBack
	ExceptionMessage = ""
	
	TH.Start(Me,"PrintDo",Array(Doc,Atts))
	Wait For Print_Complete(Result As String)
	
	If ListenersMap.ContainsKey("PrintJobListener") = False Or ExceptionMessage <> "" Then
		CallSub2(mCallBack,"Print_Complete",IIf(ExceptionMessage = "", "OK", ExceptionMessage))
	End If
	
End Sub

Private Sub PrintDo(Doc As Object, Atts As Object)
	If JavaxPrint_Utils.IsPackageObject(Doc) Then Doc = CallSub(Doc,"GetObject")
	If Atts <> Null Then Atts = CallSub(Atts,"GetObject")
	Try
		'Null for attribtues is acceptable here.
		Tjo.RunMethod("print",Array As Object(Doc, Atts))
	Catch
		ExceptionMessage = LastException.Message
	End Try
End Sub

Private Sub TH_Ended(endedOK As Boolean, error As String) 'The thread has terminated. If endedOK is False error holds the reason for failure
	CallSub2(Me,"Print_Complete",ExceptionMessage)
End Sub

'Removes an attribute listener from this print job.
Public Sub RemovePrintJobAttributeListener(Module As Object, EventName As String)
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.Get("PrintJobAttributeListener")
	If LL.IsInitialized Then
		For Each LT As ListenerType In LL
			If LT.Module = Module And LT.EventName = EventName Then
				LL.RemoveAt(LL.IndexOf(LT))
				Exit	
			End If
		Next
		If LL.Size = 0 Then
			Tjo.RunMethod("removePrintJobAttributeListener",Array(PrintJobAttributeEventObject))
			ListenersMap.Remove("PrintJobAttributeListener")
		End If
	End If
End Sub
'Removes a listener from this print job.
Public Sub RemovePrintJobListener(Module As Object, EventName As String)
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.Get("PrintJobListener")
	If LL.IsInitialized Then
		For Each LT As ListenerType In LL
			If LT.Module = Module And LT.EventName = EventName Then
				LL.RemoveAt(LL.IndexOf(LT))
				Exit
			End If
		Next
		If LL.Size = 0 Then
			Tjo.RunMethod("removePrintJobListener",Array(PrintJobEventObject))
			ListenersMap.Remove("PrintJobListener")
		End If
	End If
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	Tjo = Obj
End Sub