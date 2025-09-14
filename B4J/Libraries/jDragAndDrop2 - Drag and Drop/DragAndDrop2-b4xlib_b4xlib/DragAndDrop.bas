B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
#IgnoreWarnings: 2
#Event: DragDetected(e As MouseEvent)
#Event: DragDone(e As DragEvent)
#Event: DragEntered(e As DragEvent)
#Event: DragExited(e As DragEvent)
#Event: DragOver(e As DragEvent)
#Event: DragDropped(e As DragEvent)

Sub Class_Globals
	Private fx As JFX
	Private Mode As Object
	Private DataID() As String
	Private DataObject() As Object
	Private DragboardImg As Image
	Private DragboardImgOffsetX,DragboardImgOffsetY As Double
	Private StartDrag,DragFiles As Boolean
	Private CallBack As Object
	Private sEventName,tEventName As String
	Private DE As DragEvent
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(vCallBack As Object)
	CallBack = vCallBack
	TransferMode.Initialize
End Sub

'Makes the specified node a drag source by adding the DragDetected And DragDone events To it.
'The DragDetected event Sub receives a MouseEvent object. A DragEvent object is passed to the DragDone event.
'The DragDetected event Sub should call SetDragModeAndData if it wants to start a drag and drop operation.
'
'DragId Is a string identifying the Type of data being dragged. 
'DragObject Is the data To be transferred which must be a serializable object.
'TransferMode can be one of
'COPY Indicates copying of data Is supported Or intended.
'LINK Indicates linking of data Is supported Or intended.
'MOVE Indicates moving of data Is supported Or intended.
'
'Once the drag And drop operation Is complete the DragDone event Is Is sent To the gesture source
'To inform the source about how the gesture finished. In the DragDone event handler, obtain the
'transfer Mode by calling the GetTransferMode method on the event. If the transfer Mode Is Null that
'means the data transfer did Not happen. If the Mode Is MOVE, Then clear the data on the gesture source.
Public Sub MakeDragSource(pNode As Node, vEventName As String)
	sEventName = vEventName
	If SubExists(CallBack,sEventName & "_DragDetected") Then
		Dim Event As Object = AsJO(pNode).CreateEvent("javafx.event.EventHandler","DragDetected",Null)
		AsJO(pNode).RunMethod("setOnDragDetected",Array(Event))
	End If
	
	If SubExists(CallBack,sEventName & "_DragDone") Then
		Dim Event As Object = AsJO(pNode).CreateEvent("javafx.event.EventHandler","DragDone",Null)
		AsJO(pNode).RunMethod("setOnDragDone",Array(Event))
	End If
	
End Sub


#Region Source field event handlers

Private Sub DragDetected_Event(MethodName As String,Args() As Object) As Object
		
	CallSub2(CallBack,sEventName & "_DragDetected",AsMouseEvent(Args(0)))
		
	If StartDrag Then
		If DragFiles Then
			Dim DB As Dragboard
			DB.Initialize
			DB.SetObject(AsJO(Args(0)).RunMethodJO("getSource",Null).RunMethod("startDragAndDrop",Array(Mode)))
			Dim ClipboardContent As JavaObject
			ClipboardContent.InitializeNewInstance("javafx.scene.input.ClipboardContent",Null)
			Dim L As List = DataObject
			ClipboardContent.RunMethod("putFiles",Array(L))
			DB.SetContent(ClipboardContent)
		Else
			Dim DataFormat As JavaObject
			DataFormat.InitializeStatic("javafx.scene.input.DataFormat")
			Dim DB As Dragboard
			DB.Initialize
			DB.SetObject(AsJO(Args(0)).RunMethodJO("getSource",Null).RunMethod("startDragAndDrop",Array(Mode)))
			For i = 0 To DataID.Length - 1
				Dim LDF As JavaObject = DataFormat.RunMethod("lookupMimeType",Array(DataID(i)))
				If LDF.IsInitialized = False Then LDF.InitializeNewInstance("javafx.scene.input.DataFormat",Array(Array As String(DataID(i))))
				If DragboardImg.IsInitialized Then DB.SetDragView(DragboardImg, DragboardImgOffsetX, DragboardImgOffsetY)
				Dim ClipboardContent As JavaObject
				ClipboardContent.InitializeNewInstance("javafx.scene.input.ClipboardContent",Null)
				If DataObject(i) Is Image Then
					ClipboardContent.RunMethod("putImage",Array(DataObject(i)))
				Else
					ClipboardContent.RunMethod("put",Array(LDF,DataObject(i)))
				End If
				DB.setContent(ClipboardContent)
			Next
		End If
	End If
End Sub

	Private Sub DragDone_Event(MethodName As String,Args() As Object) As Object
		Dim DE As DragEvent
		DE.Initialize
		DE.SetObject(Args(0))
		CallSub2(CallBack,sEventName & "_DragDone",DE)
	End Sub

#End Region Source field event handlers

Public Sub SetDragModeAndFiles(tMode As Object,FilePaths() As String)
	Mode = tMode
	DragFiles = True
	DataID = Array As String("")
	Dim DataObject(FilePaths.Length) As Object
	Dim I As Int
	For Each FP As String In FilePaths
		Dim F As JavaObject
		DataObject (i) = F.InitializeNewInstance("java.io.File",Array(FP))
		I=I+1
	Next
	StartDrag = True
	DragboardImg = Null
	DragboardImgOffsetX = 0
	DragboardImgOffsetY = 0
End Sub

'Set the drag And drop operation parameters.
'
'TransferMode can be one of
'COPY Indicates copying of data Is supported Or intended.
'LINK Indicates linking of data Is supported Or intended.
'MOVE Indicates moving of data Is supported Or intended.

'DataIDs is an array that identifies the type of data to be dropped in this process.
'This could be a mime type if drag/dropping data to/from outside a B4j application, or an arbitrary string to
'identify the data as specific to this app.
'There may be more than one version of the data on the clipboard, an application could pass a plaintext version('text/plain') and an html version('text/html')
'you can choose which version you want to use by calling e.GetDataObjectForId(DataId) specifying the appropriate DataId.
'
'DataObjects Is the array of objects (relating to the DataID's that will be dragged And dropped.
Public Sub SetDragModeAndData(tMode As Object,DataIDs() As String,DataObjects() As Object)
	Mode = tMode
	DragFiles = False
	DataID = DataIDs
	DataObject = DataObjects
	StartDrag = True
	DragboardImg = Null
	DragboardImgOffsetX = 0
	DragboardImgOffsetY = 0
End Sub

'Set the drag And drop operation parameters.
'
'TransferMode can be one of
'COPY Indicates copying of data Is supported Or intended.
'LINK Indicates linking of data Is supported Or intended.
'MOVE Indicates moving of data Is supported Or intended.

'DataIDs is an array that identifies the type of data to be dropped in this process.
'This could be a mime type if drag/dropping data to/from outside a B4j application, or an arbitrary string to
'identify the data as specific to this app.
'There may be more than one version of the data on the clipboard, an application could pass a plaintext version('text/plain') and an html version('text/html')
'you can choose which version you want to use by calling e.GetDataObjectForId(DataId) specifying the appropriate DataId.
'
'DataObjects Is the array of objects (relating to the DataID's that will be dragged And dropped.
'DragboardImage will be displayed with the mouse cursor while the drag is taking place, pass Null for no Image. 
'If you attach an image, an additional DataID and Object is automatically added to the Dragboard contents.
Public Sub SetDragModeAndData2(tMode As Object,DataIDs() As String,DataObjects() As Object,DragboardImage As Image)
	Mode = tMode
	DragFiles = False
	DataID = DataIDs
	DataObject = DataObjects
	StartDrag = True
	DragboardImg = DragboardImage
	DragboardImgOffsetX = 0
	DragboardImgOffsetY = 0
End Sub

'Set the drag And drop operation parameters.
'
'TransferMode can be one of
'COPY Indicates copying of data Is supported Or intended.
'LINK Indicates linking of data Is supported Or intended.
'MOVE Indicates moving of data Is supported Or intended.

'DataIDs is an array that identifies the type of data to be dropped in this process.
'This could be a mime type if drag/dropping data to/from outside a B4j application, or an arbitrary string to
'identify the data as specific to this app.
'There may be more than one version of the data on the clipboard, an application could pass a plaintext version('text/plain') and an html version('text/html')
'you can choose which version you want to use by calling e.GetDataObjectForId(DataId) specifying the appropriate DataId.
'
'DataObjects : the array of objects (relating to the DataID's that will be dragged And dropped.
'DragboardImage : will be displayed with the mouse cursor while the drag is taking place, pass Null for no Image. 
'If you attach an image, an additional DataID and Object is automatically added to the Dragboard contents.
'ImageOffsetX : The Xoffset for the image
'ImageOffsetY : The Yoffset for the image
Public Sub SetDragModeAndData3(tMode As Object,DataIDs() As String,DataObjects() As Object,DragboardImage As Image,ImageOffsetX As Double,ImageOffsetY As Double)
	Mode = tMode
	DragFiles = False
	DataID = DataIDs
	DataObject = DataObjects
	StartDrag = True
	DragboardImg = DragboardImage
	DragboardImgOffsetX = ImageOffsetX
	DragboardImgOffsetY = ImageOffsetY
End Sub

'Makes the specified node a drag target by adding the DragEntered, DragExited, DragOver And DragDrop events To it.
'
'After the drag-And-drop gesture Is started, any node Or scene that the mouse Is dragged over Is a potential target
'To drop the data. You specify which object accepts the data by implementing the DragOver event handler.
'
'For a successful drag-And-drop operation, you must implement the DragOver event handler, which calls the
'AcceptTransferModes(TransferMode) method of the event, passing the transfer modes that the target intends To
'accept. If none of the passed transfer modes are supported by the gesture source, the potential target does Not fit
'the given drag-And-drop gesture.
'
'When the mouse button Is released on the gesture target, which accepted previous DragOver events with a transfer Mode
'supported by the gesture source, Then the DragDropped event Is sent To the gesture target.
'
'In the DragDropped event handler, you must complete the drag-And-drop gesture by calling the SetDropCompleted(Boolean)
'method on the event otherwise the gesture Is considered unsuccessful.
'
'When the drag gesture enters the boundaries of a potential gesture target, the target receives a DragEntered event.
'When the drag gesture leaves the potential targets boundaries, the target receives a DragExited event. 
'You can use the DragEntered And DragExited event handlers To change the targets appearance in order To provide visual
'feedback To the user. You should verify the DataID of the object And only change appearance If it Is an appropriate DataID.
Public Sub MakeDragTarget(pNode As Node, vEventName As String)
	tEventName = vEventName
	If SubExists(CallBack,tEventName & "_DragOver") Then
		Dim Event As Object = AsJO(pNode).CreateEvent("javafx.event.EventHandler","DragOver",Null)
		AsJO(pNode).RunMethod("setOnDragOver",Array(Event))
	End If
	If SubExists(CallBack,tEventName & "_DragEntered") Then
		Dim Event As Object = AsJO(pNode).CreateEvent("javafx.event.EventHandler","DragEntered",Null)
		AsJO(pNode).RunMethod("setOnDragEntered",Array(Event))
	End If
	If SubExists(CallBack,tEventName & "_DragExited") Then
		Dim Event As Object = AsJO(pNode).CreateEvent("javafx.event.EventHandler","DragExited",Null)
		AsJO(pNode).RunMethod("setOnDragExited",Array(Event))
	End If
	If SubExists(CallBack,tEventName & "_DragDropped") Then
		Dim Event As Object = AsJO(pNode).CreateEvent("javafx.event.EventHandler","DragDropped",Null)
		AsJO(pNode).RunMethod("setOnDragDropped",Array(Event))
	End If
End Sub

#Region Target field event handlers

	Private Sub DragOver_Event(MethodName As String,Args() As Object) As Object
		Dim DE As DragEvent
		DE.Initialize
		DE.SetObject(Args(0))
		CallSub2(CallBack,tEventName & "_DragOver",DE)
	End Sub

	Private Sub DragEntered_Event(MethodName As String,Args() As Object) As Object
		Dim DE As DragEvent
		DE.Initialize
		DE.SetObject(Args(0))
		CallSub2(CallBack,tEventName & "_DragEntered",DE)
	End Sub

	Private Sub DragExited_Event(MethodName As String,Args() As Object) As Object
		Dim DE As DragEvent
		DE.Initialize
		DE.SetObject(Args(0))
		CallSub2(CallBack,tEventName & "_DragExited",DE)
	End Sub

	Private Sub DragDropped_Event(MethodName As String,Args() As Object) As Object
		Dim DE As DragEvent
		DE.Initialize
		DE.SetObject(Args(0))
		CallSub2(CallBack,tEventName & "_DragDropped",DE)
	End Sub

#End Region Target field event handlers

Private Sub AsMouseEvent(M As MouseEvent) As MouseEvent
	Return M
End Sub
Private Sub AsJO(JO As JavaObject) As JavaObject
	Return JO
End Sub

Public Sub CurrentDragEvent As DragEvent
	Return DE
End Sub