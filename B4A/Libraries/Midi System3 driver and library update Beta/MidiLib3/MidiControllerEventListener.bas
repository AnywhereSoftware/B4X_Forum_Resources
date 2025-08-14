B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.3
@EndOfDesignText@
'Class module
#IgnoreWarnings: 12
Sub Class_Globals
	Private mModule As Object
	Private mEventName As String
	Private mControllers As Map
End Sub

'Initializes the object. Pass the required controller numbers as an Array of Ints to Controllers
Public Sub Initialize(Module As Object,EventName As String,Controllers() As Int)
	mModule = Module
	mEventName = EventName
	
	mControllers.Initialize
	AddControllers(Controllers)
End Sub
'@SLHide
Sub SendMessage(Event As MidiEvent)
	If SubExists(mModule,mEventName) Then CallSub2(mModule,mEventName,Event)
End Sub
'Get the list of currently listened to controllers
Sub getControllers As Int()
	Dim Controllers(mControllers.Size) As Int
	Dim i As Int = 0
	For Each Key As Int In mControllers.Keys
		Controllers(i) = Key
		i=i+1
	Next
	Return Controllers
End Sub
'Add an array of controllers to listen to
Sub AddControllers(Controllers() As Int)
	For i = 0 To Controllers.Length - 1
		mControllers.Put(Controllers(i),1)
	Next
End Sub
'Remove an Array of controller
Sub RemoveControllers(Controllers() As Int)
	For Each C As Int In Controllers
		mControllers.Remove(C)
	Next
End Sub