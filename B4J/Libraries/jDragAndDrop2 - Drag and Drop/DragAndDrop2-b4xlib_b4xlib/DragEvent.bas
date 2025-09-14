B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Class Module
Sub Class_Globals
  'Private fx As JFX ' Uncomment if required. For B4j only
  Private TJO As JavaObject

End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
  
End Sub

'Accepts this DragEvent, choosing the transfer mode for the drop operation.
Public Sub AcceptTransferModes(Modes() As Object)
	TJO.RunMethod("acceptTransferModes",Array(Modes))
End Sub
'Gets transfer mode accepted by potential target.
Public Sub GetAcceptedTransferMode As Object
  Return TJO.RunMethod("getAcceptedTransferMode",Null)
End Sub
'The object that accepted the drag.
Public Sub GetAcceptingObject As Object
  Return TJO.RunMethod("getAcceptingObject",Null)
End Sub
Public Sub Consume
	TJO.RunMethod("consume",Null)
End Sub
'A dragboard that is available to transfer data.
Public Sub GetDragboard As Dragboard
	Dim DB As Dragboard
	DB.Initialize
	DB.SetObject(TJO.RunMethod("getDragboard",Null))
	Return DB
End Sub
'Gets the event type of this event.
Public Sub GetEventType As JavaObject
  Return TJO.RunMethod("getEventType",Null)
End Sub
'The source object of the drag and drop gesture.
Public Sub GetGestureSource As Object
  Return TJO.RunMethod("getGestureSource",Null)
End Sub
'The target object of the drag and drop gesture.
Public Sub GetGestureTarget As Object
  Return TJO.RunMethod("getGestureTarget",Null)
End Sub
Public Sub GetEventSource As Object
	Return TJO.RunMethod("getSource",Null)
End Sub
Public Sub GetEventTarget As Object
	Return TJO.RunMethod("getTarget",Null)
End Sub
'Returns information about the pick.
Public Sub GetPickResult As JavaObject
  Return TJO.RunMethod("getPickResult",Null)
End Sub
'Returns horizontal position of the event relative to the origin of the Scene that contains the DragEvent's source.
Public Sub GetSceneX As Double
  Return TJO.RunMethod("getSceneX",Null)
End Sub
'Returns vertical position of the event relative to the origin of the Scene that contains the DragEvent's source.
Public Sub GetSceneY As Double
  Return TJO.RunMethod("getSceneY",Null)
End Sub
'Returns absolute horizontal position of the event.
Public Sub GetScreenX As Double
  Return TJO.RunMethod("getScreenX",Null)
End Sub
'Returns absolute vertical position of the event.
Public Sub GetScreenY As Double
  Return TJO.RunMethod("getScreenY",Null)
End Sub
'Data transfer mode.
Public Sub GetTransferMode As JavaObject
  Return TJO.RunMethod("getTransferMode",Null)
End Sub
'Horizontal position of the event relative to the origin of the DragEvent's source.
Public Sub getX As Double
  Return TJO.RunMethod("getX",Null)
End Sub
'Vertical position of the event relative to the origin of the DragEvent's source.
Public Sub getY As Double
  Return TJO.RunMethod("getY",Null)
End Sub
'Depth position of the event relative to the origin of the MouseEvent's source.
Public Sub getZ As Double
  Return TJO.RunMethod("getZ",Null)
End Sub
'Indicates if this event has been accepted.
Public Sub IsAccepted As Boolean
  Return TJO.RunMethod("isAccepted",Null)
End Sub
'Whether setDropCompleted(true) has been called on this event.
Public Sub IsDropCompleted As Boolean
  Return TJO.RunMethod("isDropCompleted",Null)
End Sub
'Indicates that transfer handling of this DragEvent was completed successfully during a DRAG_DROPPED event handler.
Public Sub SetDropCompleted(IsTransferDone As Boolean)
  TJO.RunMethod("setDropCompleted",Array As Object(IsTransferDone))
End Sub

'Returns a String array of all the dataTypes available in the current dragboard
Public Sub GetDataIds As String()
	Dim ReflectArray As JavaObject
	ReflectArray.InitializeStatic("java.lang.reflect.Array")
	Dim DataFormat As JavaObject
	DataFormat.InitializeArray("javafx.scene.input.DataFormat",TJO.RunMethodJO("getDragboard",Null).RunMethodJO("getContentTypes",Null).RunMethod("toArray",Null))
	Dim Strings(ReflectArray.RunMethod("getLength",Array(DataFormat))) As String
	For i = 0  To Strings.Length - 1
		Dim S(1) As String
		Dim Strings2() As String = ReflectArray.RunMethodJO("get",Array(DataFormat,i)).RunMethodJO("getIdentifiers",Null).RunMethod("toArray",Array(S))
		Dim Str As String
		For j = 0 To Strings2.Length - 1
			Str = Str & Strings2(j) & ","
		Next
		Str = Str.SubString2(0,Str.Length - 1)
		Strings(i) = Str
	Next
	Return Strings
End Sub

'Returns a List of all the dataTypes available in the current dragboard
Public Sub GetDataIDsList As List
	Return GetDataIds
End Sub

'Get the data for the specified DataID contained in this Dragboard
Public Sub GetDataObjectForId(DataId As String) As Object
	Dim DataFormat As JavaObject
	DataFormat.InitializeStatic("javafx.scene.input.DataFormat")
	Dim LDF As JavaObject = DataFormat.RunMethod("lookupMimeType",Array(DataId))
	If LDF.IsInitialized = False Then LDF.InitializeNewInstance("javafx.scene.input.DataFormat",Array(Array As String(DataId)))
	Return TJO.RunMethodJO("getDragboard",Null).RunMethod("getContent",Array(LDF))
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
  Return TJO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
  Return TJO
End Sub
'Comment if not needed

'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
  TJO = Obj
End Sub

'Set the Tag for this object
Public Sub SetTag(Tag As Object)
  TJO.RunMethod("setUserData",Array(Tag))
End Sub

'Get the Tag for this object
Public Sub GetTag As Object
  Return TJO.RunMethod("getUserData",Null)
End Sub

