B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private TJO As JavaObject
	Private mModule As Object
	Private mEventName As String
	Private ReturnEventName As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Module As Object,EventName As String,TNode As Node)
	mModule = Module
	mEventName = EventName
	TJO.InitializeNewInstance("javafx.scene.control.CustomMenuItem",Array(TNode))
	Dim O As Object = TJO.CreateEventFromUI("javafx.event.EventHandler","Action",Null)
	TJO.RunMethod("setOnAction",Array(O))
End Sub

'Pass the menu action event to the calling module
Private Sub Action_Event (MethodName As String, Args() As Object) As Object										'Ignore
	If SubExists(mModule, mEventName & "_Action") Then CallSub(mModule,mEventName & "_Action")
End Sub

'Gets the value of the property content.
Public Sub GetContent As Node
	Return TJO.RunMethod("getContent",Null)
End Sub

'Gets the value of the property hideOnClick.
Public Sub IsHideOnClick As Boolean
	Return TJO.RunMethod("isHideOnClick",Null)
End Sub

'Sets the value of the property content.
Public Sub SetContent(Value As Node) As MenuCustomClass
	TJO.RunMethod("setContent",Array As Object(Value))
	Return Me
End Sub

'Sets the value of the property hideOnClick. Selecting MouseTransparent will make it non responsive to mouse hover and focus
Public Sub SetHideOnClick(Value As Boolean,MouseTransparent As Boolean) As MenuCustomClass
	TJO.RunMethod("setHideOnClick",Array As Object(Value))
	
	If Value Then
		RemoveStyle("mm-menucustom-hidden")
	Else
		If MouseTransparent Then AddStyle("mm-menucustom-hidden")
	End If
	
	Dim L As List = TJO.RunMethodJO("getStyleClass",Null)
	For Each S As String In  L
		Log(S)
	Next
	Return Me
End Sub



'Set a Graphic on this menu item
'Returns the menu item
Public Sub SetGraphic(Graphic As Node) As MenuCustomClass
	TJO.RunMethod("setGraphic",Array(Graphic))
	Return Me
End Sub

'Get the graphic set on this menu item
Public Sub GetGraphic As Node
	Return TJO.RunMethod("getGraphic",Null)
End Sub

'Set a shortcut key for this menu item
'Returns the menu item
Public Sub SetShortCutKey(Combination() As String) As MenuCustomClass
	Dim KC As JavaObject
	KC.InitializeStatic("javafx.scene.input.KeyCombination")
	Dim KCS As String
	For i = 0 To Combination.Length - 1
		If i > 0 Then KCS = KCS & "+"
		KCS = KCS & Combination(i)
	Next
	TJO.RunMethod("setAccelerator",Array(KC.RunMethod("keyCombination",Array(KCS))))
	Return Me
End Sub

'Set the enabled state for this menu item
'Returns the menu item
Public Sub SetEnabled(Enabled As Boolean) As MenuCustomClass
	TJO.RunMethod("setEnabled",Array(Enabled))
	Return Me
End Sub

'Get the enabled state for this menu item
Public Sub GetEnabled As Boolean
	Return TJO.RunMethod("getEnabled",Null)
End Sub

'Set an alternate event name for this menu item
'Returns the menu item
Public Sub SetEventName (Name As String) As MenuCustomClass
	ReturnEventName = Name
	Return Me
End Sub

'Get the alternate Event name for this menu item
Public Sub GetEventName As String
	Return ReturnEventName
End Sub

'Get / Set the text of the menu item
Sub getText As String
	Return TJO.RunMethod("getText",Null)
End Sub
Public Sub setText(Text As String)
	TJO.RunMethod("setText", Array(Text))
End Sub

'Get the list of style classes set on this menu item
Public Sub GetStyleClass As List
	Return TJO.RunMethod("getStyleClass",Null)
End Sub

'Set a style class for this menu item, checks it is not already added
'Returns the menu item
Public Sub SetStyleClass(Class As String) As MenuCustomClass
	Dim L As List = GetStyleClass
	Dim Pos As Int = L.IndexOf(Class)
	If Pos = -1 Then L.Add(Class)
	Return Me
End Sub

'Set a tag for this menu item
'Returns the menu item
Public Sub SetTag(TTag As Object) As MenuCustomClass
	TJO.RunMethod("setUserData",Array(TTag))
	Return Me
End Sub

'Get the tag for this menu item
Public Sub GetTag As Object
	Dim Tag As Object = TJO.RunMethod("getUserData",Null)
	If Tag = Null Then Tag = ""
	Return Tag
End Sub

'Get the native menu item as a Javaobject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub

'Get the native menu item as an object
Public Sub AsObject As Object
	Return TJO
End Sub

Private Sub AddStyle(Style As String)
	TJO.RunMethodJO("getStyleClass",Null).RunMethod("add",Array(Style))
	
End Sub

Private Sub RemoveStyle(Style As String)
	TJO.RunMethodJO("getStyleClass",Null).RunMethod("remove",Array(Style))
End Sub