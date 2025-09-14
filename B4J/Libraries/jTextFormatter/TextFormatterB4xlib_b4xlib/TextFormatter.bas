B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.51
@EndOfDesignText@
#Event: TextValidator(Change As JavaObject) As JavaObject
#RaisesSynchronousEvents: TextFilter_Event

Sub Class_Globals
	Private fx As JFX
	Private mModule As Object
	Private mEventName As String
	Private mTextInput As JavaObject
End Sub

'Initializes the object.
'Module : the calling Module
'EventName : The callback sub prefix, you can use the same callback on multiple fields
'TextInput: Either a TextField or a TextArea
Public Sub Initialize(Module As Object,EventName As String,TextInput As JavaObject)
	mModule = Module
	mEventName = EventName
	mTextInput = TextInput
	If SubExists(mModule,mEventName & "_TextValidator") Then mTextInput.RunMethod("setTextFormatter",Array(GetTextFormatter))
End Sub

'Returns a new TextFormatter object and creates the callback sub
Private Sub GetTextFormatter As JavaObject
	Dim TextFormatter1 As JavaObject																	
	Dim Filter As Object = AsJO(mTextInput).CreateEvent("java.util.function.UnaryOperator","TextFilter",Null) 'ignore
	TextFormatter1.InitializeNewInstance("javafx.scene.control.TextFormatter",Array(Filter))
	Return TextFormatter1
End Sub

'Wrapper for the callback sub, calls Eventname_TextValidator sub in the calling module.
Private Sub TextFilter_Event(MethodName As String,Args() As Object) As Object
	Dim Change As TFChange
	Change.Initialize
	Change.SetObject(Args(0))
	If Change.isContentChange = False Then Return Change.GetObject
	Change = CallSub2(mModule,mEventName & "_TextValidator",Change)
	If Change = Null Then Return Null
	Return Change.GetObject
End Sub

Private Sub AsJO(JO As JavaObject) As JavaObject
	Return JO
End Sub