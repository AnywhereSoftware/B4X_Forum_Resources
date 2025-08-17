B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.51
@EndOfDesignText@
#IgnoreWarnings:12
#Event: Complete
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private TJO As JavaObject
	Private mModule As Object
	Private mEventName As String
	Private ListenerActive As Boolean
End Sub

'Initializes the object. You can add parameters to this method if needed.
'Documentation can be found at https://docs.oracle.com/javase/8/javafx/api/javafx/scene/media/AudioClip.html
Public Sub Initialize
	'Initialize the static sub so that field names will be updated.  If you don't use the standard naming conventions you will need to change the class name
End Sub

'Create an AudioClip loaded from the supplied source URL.
Public Sub Create(Source As String)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.scene.media.AudioClip",Array As Object(Source))
End Sub

'Create an AudioClip loaded from the supplied source Directory and filename.
Public Sub Create2(Folder As String, FileName As String)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.scene.media.AudioClip",Array As Object(File.GetUri(Folder,FileName)))
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub
'Get the default balance level for this clip.
Public Sub getBalance As Double
	Return TJO.RunMethod("getBalance",Null)
End Sub
'Get the default cycle count.
Public Sub getCycleCount As Int
	Return TJO.RunMethod("getCycleCount",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub
'Get the default pan value.
Public Sub getPan As Double
	Return TJO.RunMethod("getPan",Null)
End Sub
'Get the default playback priority.
Public Sub getPriority As Int
	Return TJO.RunMethod("getPriority",Null)
End Sub
'Get the default playback rate.
Public Sub getRate As Double
	Return TJO.RunMethod("getRate",Null)
End Sub
'Get the source URL used to create this AudioClip.
Public Sub getSource As String
	Return TJO.RunMethod("getSource",Null)
End Sub
'Get the default volume level.
Public Sub getVolume As Double
	Return TJO.RunMethod("getVolume",Null)
End Sub
'Indicate whether this AudioClip is playing.
Public Sub IsPlaying As Boolean
	Return TJO.RunMethod("isPlaying",Null)
End Sub
'Play the AudioClip using all the default parameters.
Public Sub Play
	StartListener
	TJO.RunMethod("play",Null)
End Sub
'Play the AudioClip using all the default parameters except volume.
'MISSING COMMENT FOR THIS LINE
Public Sub Play2(Volume As Double)
	StartListener
	TJO.RunMethod("play",Array As Object(Volume))
End Sub
'Set the default balance level.
Public Sub setBalance(Balance As Double)
	TJO.RunMethod("setBalance",Array As Object(Balance))
End Sub
'Set the default cycle count.
Public Sub setCycleCount(Count As Int)
	TJO.RunMethod("setCycleCount",Array As Object(Count))
End Sub
'Set the default pan value.
Public Sub setPan(Pan As Double)
	TJO.RunMethod("setPan",Array As Object(Pan))
End Sub
'Set the default playback priority.
Public Sub setPriority(Priority As Int)
	TJO.RunMethod("setPriority",Array As Object(Priority))
End Sub
'Set the default playback rate.
Public Sub setRate(Rate As Double)
	TJO.RunMethod("setRate",Array As Object(Rate))
End Sub
'Set the default volume level.
Public Sub setVolume(Value As Double)
	TJO.RunMethod("setVolume",Array As Object(Value))
End Sub
'Immediately stop all playback of this AudioClip.
Public Sub Stop
	TJO.RunMethod("stop",Null)
	If ListenerActive Then StopListener
End Sub
'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub setObject(Obj As Object)
	TJO = Obj
End Sub

Public Sub SetCompleteListener(Module As Object, EventName As String)
	mModule = Module
	mEventName = EventName
End Sub

Private Sub StartListener
	If mModule = Null Or mEventName = "" Or SubExists(mModule, mEventName & "_Complete") = False Then Return
	ListenerActive = True
	Do While ListenerActive
		Sleep(1000)
		If IsPlaying = False Then ListenerActive = False
	Loop
	
	CallSubDelayed(mModule, mEventName & "_Complete")
	
End Sub

Private Sub StopListener
	ListenerActive = False
End Sub