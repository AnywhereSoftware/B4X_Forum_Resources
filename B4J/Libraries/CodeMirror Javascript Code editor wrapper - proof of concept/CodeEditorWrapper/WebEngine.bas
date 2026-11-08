B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
#IgnoreWarnings:12
#Event: Event(Args() As Object)
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private TJO As JavaObject
	Private ListenersMap As Map
	'You may need to remove this if another class has already defined it.
	Type WE_ListenerType (Module As Object,EventName As String, Listener As Object)
	'You may need to remove this if another class has already defined it.
	Type FileType(FilePath As String,FileName As String)
	Type WECallbackType(CallBack As Object, EventName As String)
	Dim CallBackType As WECallbackType
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	ListenersMap.Initialize
End Sub

'Creates a new engine.
Public Sub Create
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.scene.web.WebEngine",Null)
End Sub

'Creates a new engine and loads a Web page into it.
Public Sub Create2(Url As String)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.scene.web.WebEngine",Array As Object(Url))
End Sub

'Executes a script in the context of the current page.
Public Sub ExecuteScript(Script As String) As Object
	Return TJO.RunMethod("executeScript",Array As Object(Script))
End Sub
'Returns the JavaScript confirm handler.
Public Sub GetConfirmHandler As JavaObject
	Return TJO.RunMethod("getConfirmHandler",Null)
End Sub
'Returns the JavaScript popup handler.
Public Sub GetCreatePopupHandler As JavaObject
	Return TJO.RunMethod("getCreatePopupHandler",Null)
End Sub
'Returns a Worker object that can be used to track loading progress.
Public Sub GetLoadWorker As Worker
	Dim Wrapper As Worker
	Wrapper.Initialize
	Wrapper.SetObject(TJO.RunMethod("getLoadWorker",Null))
	Return Wrapper
End Sub
'Returns URL of the current Web page.
Public Sub GetLocation As String
	Return TJO.RunMethod("getLocation",Null)
End Sub
'Returns the JavaScript alert handler.
Public Sub GetOnAlert As JavaObject
	Return TJO.RunMethod("getOnAlert",Null)
End Sub
'Gets the value of the property onError.
Public Sub GetOnError As JavaObject
	Return TJO.RunMethod("getOnError",Null)
End Sub
'Returns the JavaScript window resize handler.
Public Sub GetOnResized As JavaObject
	Return TJO.RunMethod("getOnResized",Null)
End Sub
'Returns the JavaScript status handler.
Public Sub GetOnStatusChanged As JavaObject
	Return TJO.RunMethod("getOnStatusChanged",Null)
End Sub
'Returns the JavaScript window visibility handler.
Public Sub GetOnVisibilityChanged As JavaObject
	Return TJO.RunMethod("getOnVisibilityChanged",Null)
End Sub
'Returns the JavaScript prompt handler.
Public Sub GetPromptHandler As JavaObject
	Return TJO.RunMethod("getPromptHandler",Null)
End Sub
'Returns title of the current Web page.
Public Sub GetTitle As String
	Return TJO.RunMethod("getTitle",Null)
End Sub
'Gets the value of the property userAgent.
Public Sub GetUserAgent As String
	Return TJO.RunMethod("getUserAgent",Null)
End Sub
'Gets the value of the property userDataDirectory.
Public Sub GetUserDataDirectory As FileType
	Dim FileObject As JavaObject =TJO.RunMethod("getUserDataDirectory",Null)
	Dim FT As FileType
	FT.Initialize
	FT.FilePath = FileObject.RunMethod("getPath",Null)
	FT.FileName = FileObject.RunMethod("getName",Null)
	Return FT
End Sub
'Gets the value of the property userStyleSheetLocation.
Public Sub GetUserStyleSheetLocation As String
	Return TJO.RunMethod("getUserStyleSheetLocation",Null)
End Sub
'Gets the value of the property javaScriptEnabled.
Public Sub IsJavaScriptEnabled As Boolean
	Return TJO.RunMethod("isJavaScriptEnabled",Null)
End Sub
'Loads a Web page into this engine.
Public Sub Load(Url As String)
	TJO.RunMethod("load",Array As Object(Url))
End Sub
'Loads the given HTML content directly.
Public Sub LoadContent(Content As String)
	TJO.RunMethod("loadContent",Array As Object(Content))
End Sub
'Loads the given content directly.
Public Sub LoadContent2(Content As String, ContentType As String)
	TJO.RunMethod("loadContent",Array As Object(Content, ContentType))
End Sub
'Prints the current Web page using the given printer job.
Public Sub Print(Job As JavaObject)
	If GetType(Job) = "com.stevel05.jfx8print.printerjob" Then
		TJO.RunMethod("print",Array As Object(Job.RunMethod("_getobject",Null)))
	Else
		TJO.RunMethod("print",Array As Object(Job))
	End If
End Sub
'Reloads the current page, whether loaded from URL or directly from a String in one of the loadContent methods.
Public Sub Reload
	TJO.RunMethod("reload",Null)
End Sub
'Sets the JavaScript confirm handler.
Public Sub SetConfirmHandler(Handler As JavaObject)
	TJO.RunMethod("setConfirmHandler",Array As Object(Handler))
End Sub
'Sets the JavaScript popup handler.
Public Sub SetCreatePopupHandler(Handler As JavaObject)
	TJO.RunMethod("setCreatePopupHandler",Array As Object(Handler))
End Sub
'Sets the value of the property javaScriptEnabled.
Public Sub SetJavaScriptEnabled(Value As Boolean)
	TJO.RunMethod("setJavaScriptEnabled",Array As Object(Value))
End Sub

'Add a load progress listener
Public Sub AddWorkerListener(CallBack As Object,EventName As String)
	
	If SubExists(CallBack,EventName & "_Event") Then
		CallBackType.Initialize
		CallBackType.CallBAck = CallBack
		CallBackType.EventName = EventName & "_Event"
	
	
		Dim SP As JavaObject = GetLoadWorker.StateProperty
		Dim O As Object = SP.CreateEventFromUI("javafx.beans.value.ChangeListener","LoadProgress",1)
		SP.RunMethod("addListener",Array(O))
	End If
	
End Sub

Private Sub LoadProgress_Event (MethodName As String, Args() As Object)
	Dim NewState As JavaObject = Args(2)
	CallSubDelayed2(CallBackType.CallBack,CallBackType.EventName,NewState.RunMethod("toString",Null))
End Sub

'Sets the JavaScript alert handler.
'Replace "FullClassName" with the full name of the listener class in B4a, or the EventHandler in B4j
Public Sub SetOnAlert(Module As Object, EventName As String) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.Get("SetOnAlert")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener0" ,Null)
		TJO.RunMethod("setOnAlert",Array As Object(EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And WE_ListenerType if they are not needed.
	Dim LT As WE_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("SetOnAlert",Listeners)
	Return EventObject
End Sub
Private Sub Listener0_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.Get("SetOnAlert")
	If Listeners.IsInitialized Then
		For Each LT As WE_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'Sets the value of the property onError.
Public Sub SetOnError(Module As Object, EventName As String) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.Get("SetOnError")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener1" ,Null)
		TJO.RunMethod("setOnError",Array As Object(EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And WE_ListenerType if they are not needed.
	Dim LT As WE_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("SetOnError",Listeners)
	Return EventObject
End Sub
Private Sub Listener1_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.Get("SetOnError")
	If Listeners.IsInitialized Then
		For Each LT As WE_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'Sets the JavaScript window resize handler.
Public Sub SetOnResized(Module As Object, EventName As String) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.Get("SetOnResized")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener2" ,Null)
		TJO.RunMethod("setOnResized",Array As Object(EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And WE_ListenerType if they are not needed.
	Dim LT As WE_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("SetOnResized",Listeners)
	Return EventObject
End Sub
Private Sub Listener2_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.Get("SetOnResized")
	If Listeners.IsInitialized Then
		For Each LT As WE_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'Sets the JavaScript status handler.
Public Sub SetOnStatusChanged(Module As Object, EventName As String) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.Get("SetOnStatusChanged")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener3" ,Null)
		TJO.RunMethod("setOnStatusChanged",Array As Object(EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And WE_ListenerType if they are not needed.
	Dim LT As WE_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("SetOnStatusChanged",Listeners)
	Return EventObject
End Sub
Private Sub Listener3_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.Get("SetOnStatusChanged")
	If Listeners.IsInitialized Then
		For Each LT As WE_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'Sets the JavaScript window visibility handler.
Public Sub SetOnVisibilityChanged(Module As Object, EventName As String) As Object
	Dim Listeners As List
	Listeners.Initialize
	Dim LL As List = ListenersMap.Get("SetOnVisibilityChanged")
	If LL.IsInitialized Then Listeners.AddAll(LL)
	If Listeners.Size = 0 Then
		Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener4" ,Null)
		TJO.RunMethod("setOnVisibilityChanged",Array As Object(EventObject))
	End If
	'Depending on the type of listener, this code may not be needed, but is left here just in case.
	'It is safe to delete this and references to ListenerMap And WE_ListenerType if they are not needed.
	Dim LT As WE_ListenerType
	LT.Initialize
	LT.Module = Module
	LT.EventName = EventName
	Listeners.Add(LT)
	ListenersMap.Put("SetOnVisibilityChanged",Listeners)
	Return EventObject
End Sub
Private Sub Listener4_Event(MethodName As String,Args() As Object)
	Dim Listeners As List = ListenersMap.Get("SetOnVisibilityChanged")
	If Listeners.IsInitialized Then
		For Each LT As WE_ListenerType In Listeners
			If SubExists(LT.Module, LT.EventName & "_Event") Then CallSub2(LT.Module, LT.EventName & "_Event",Args)
		Next
	End If
End Sub
'Sets the JavaScript prompt handler.
Public Sub SetPromptHandler(Handler As JavaObject)
	TJO.RunMethod("setPromptHandler",Array As Object(Handler))
End Sub
'Sets the value of the property userAgent.
Public Sub SetUserAgent(Value As String)
	TJO.RunMethod("setUserAgent",Array As Object(Value))
End Sub
'Sets the value of the property userDataDirectory.
Public Sub SetUserDataDirectory(DirName As String, FileName As String)
	'Code for File Object Creation
	Dim Value As JavaObject
	Value.InitializeNewInstance("java.io.File",Array(DirName,FileName))

	TJO.RunMethod("setUserDataDirectory",Array As Object(Value))
End Sub
'Sets the value of the property userStyleSheetLocation.
Public Sub SetUserStyleSheetLocation(Value As String)
	TJO.RunMethod("setUserStyleSheetLocation",Array As Object(Value))
End Sub
'JavaScript confirm handler property.
Public Sub ConfirmHandlerProperty As JavaObject
	Return TJO.RunMethod("confirmHandlerProperty",Null)
End Sub
'JavaScript popup handler property.
Public Sub CreatePopupHandlerProperty As JavaObject
	Return TJO.RunMethod("createPopupHandlerProperty",Null)
End Sub
'Document object for the current Web page.
Public Sub DocumentProperty As JavaObject
	Return TJO.RunMethod("documentProperty",Null)
End Sub
'Specifies whether JavaScript execution is enabled.
Public Sub JavaScriptEnabledProperty As JavaObject
	Return TJO.RunMethod("javaScriptEnabledProperty",Null)
End Sub
'URL of the current Web page.
Public Sub LocationProperty As JavaObject
	Return TJO.RunMethod("locationProperty",Null)
End Sub
'JavaScript alert handler property.
Public Sub OnAlertProperty As JavaObject
	Return TJO.RunMethod("onAlertProperty",Null)
End Sub
'The event handler called when an error occurs.
Public Sub OnErrorProperty As JavaObject
	Return TJO.RunMethod("onErrorProperty",Null)
End Sub
'JavaScript window resize handler property.
Public Sub OnResizedProperty As JavaObject
	Return TJO.RunMethod("onResizedProperty",Null)
End Sub
'JavaScript status handler property.
Public Sub OnStatusChangedProperty As JavaObject
	Return TJO.RunMethod("onStatusChangedProperty",Null)
End Sub
'JavaScript window visibility handler property.
Public Sub OnVisibilityChangedProperty As JavaObject
	Return TJO.RunMethod("onVisibilityChangedProperty",Null)
End Sub
'JavaScript prompt handler property.
Public Sub PromptHandlerProperty As JavaObject
	Return TJO.RunMethod("promptHandlerProperty",Null)
End Sub
'Title of the current Web page.
Public Sub TitleProperty As JavaObject
	Return TJO.RunMethod("titleProperty",Null)
End Sub
'Specifies user agent ID string.
Public Sub UserAgentProperty As JavaObject
	Return TJO.RunMethod("userAgentProperty",Null)
End Sub
'Specifies the directory to be used by this WebEngine to store local user data.
Public Sub UserDataDirectoryProperty As JavaObject
	Return TJO.RunMethod("userDataDirectoryProperty",Null)
End Sub
'Location of the user stylesheet as a string URL.
Public Sub UserStyleSheetLocationProperty As JavaObject
	Return TJO.RunMethod("userStyleSheetLocationProperty",Null)
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

'The following subs are here as a convienience and may not alwasy be appropriate for the type of listener added.
Private Sub FindChangeListener(Module As Object,EventName As String) As Map
	'An uninitialized list to return if not found
	Dim L As List
	Dim M As Map
	M.Initialize
	M.Put("List",L)
	M.Put("Index",-1)
	M.Put("SubName","")
	For Each K As Object In ListenersMap.Keys
		Dim Listeners As List = ListenersMap.Get(K)
		If Listeners.IsInitialized Then
			For  i = 0 To Listeners.Size - 1
				Dim LT As WE_ListenerType = Listeners.Get(i)
				If LT.Module = Module And LT.EventName = EventName Then
					M.Put("List",Listeners)
					M.Put("Index",i)
					M.Put("SubName",K)
					Return M
				End If
			Next
		End If
	Next
	Return M
End Sub
Public Sub RemoveChangeListener(Module As Object,EventName As String) As Boolean
	'It is not always possible to remove a listener, but this will try the default method.  This may need to be changed. or removed.
	Dim M As Map = FindChangeListener(Module,EventName)
	Dim Listeners As List = M.Get("List")
	If Listeners.IsInitialized Then
		Dim Pos As Int = M.Get("Index")
		If Pos > -1 Then
			Dim LT As WE_ListenerType = Listeners.Get(Pos)
			Listeners.RemoveAt(Pos)
			If Listeners.Size = 0 Then
				Dim SubName As String = M.GetDefault("SubName","")
				If SubName.Contains("Listener") Then
					Try
						TJO.RunMethod("removeListener",Array(LT.Listener))
					Catch
						Log(LastException)
					End Try
				End If
			End If
			Return True
		End If
	End If
	Return False
End Sub
Public Sub RemoveAllChangeListeners(Module As Object, EventName As String)
	Dim M As Map = FindChangeListener(Module,EventName)
	Dim Listeners As List = M.Get("List")
	If Listeners.IsInitialized Then
		Dim Pos As Int = M.Get("Index")
		If Pos > -1 Then
			Dim LT As WE_ListenerType = Listeners.Get(Pos)
			Try
				TJO.RunMethod("removeListener",Array(LT.Listener))
			Catch
				Log(LastException)
			End Try
		End If
	End If
	Listeners.clear
End Sub
